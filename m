From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ymfpci: make joystick port a module parameter
Date: Mon, 22 Sep 2003 10:09:11 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309220959530.4822-100000@studcom.urz.uni-halle.de>
References: <s5hznh37lua.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hznh37lua.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > This removes the joystick enable/address card controls and makes
> > them a module option instead.
>
> i'm getting to agree with this, as it was before on 0.5.x, to use the
> module parameters for confinguring joysticks.
> changing the hardware ports on the control API would be dangerous.
>
> but anyway, if we do change this, we should fix all corresponding
> drivers, not only ymfpci.

ACK. Below is a patch for ENS1370/1. It compiles, but isn't tested.

There are three other drivers (cmipci, es1968, via82xx) using card
controls to enable the gameport, but those don't bother to call
gameport_register_port, so I'll have to look at the datasheets for the
I/O address ranges.

(There are quite a few other drivers not calling
gameport_register_port, either.)


Regards,
Clemens


-- 

Index: alsa-kernel/Documentation/ALSA-Configuration.txt
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/Documentation/ALSA-Configuration.txt,v
retrieving revision 1.18
diff -u -r1.18 ALSA-Configuration.txt
--- alsa-kernel/Documentation/ALSA-Configuration.txt	17 Sep 2003 13:34:33 -0000	1.18
+++ alsa-kernel/Documentation/ALSA-Configuration.txt	22 Sep 2003 07:53:04 -0000
@@ -377,6 +377,8 @@
 			* SoundBlaster PCI 64
 			* SoundBlaster PCI 128

+    joystick_port	- port # for joystick (0x200), -1 = disable (default)
+
     Module supports up to 8 cards and autoprobe.

   Module snd-ens1371
@@ -387,6 +389,9 @@
 			* SoundBlaster PCI 128
 			* SoundBlaster Vibra PCI

+    joystick_port	- port # for joystick (0x200,0x208,0x210,0x218),
+			  -1 = disable (default)
+
     Module supports up to 8 cards and autoprobe.

   Module snd-es968
Index: alsa-kernel/pci/ens1370.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ens1370.c,v
retrieving revision 1.49
diff -u -r1.49 ens1370.c
--- alsa-kernel/pci/ens1370.c	15 Sep 2003 07:38:00 -0000	1.49
+++ alsa-kernel/pci/ens1370.c	22 Sep 2003 07:53:04 -0000
@@ -68,6 +68,9 @@
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable switches */
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+static int joystick_port[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -1};
+#endif

 MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(index, "Index value for Ensoniq AudioPCI soundcard.");
@@ -78,6 +81,15 @@
 MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(enable, "Enable Ensoniq AudioPCI soundcard.");
 MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+MODULE_PARM(joystick_port, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(joystick_port, "Joystick port address");
+#ifdef CHIP1371
+MODULE_PARM_SYNTAX(joystick_port, SNDRV_ENABLED ",allows:{{0},{0x200},{0x208},{0x210},{0x218}},dialog:list");
+#else
+MODULE_PARM_SYNTAX(joystick_port, SNDRV_ENABLED ",allows:{{0},{0x200}},dialog:list");
+#endif
+#endif

 #ifndef PCI_DEVICE_ID_ENSONIQ_CT5880
 #define PCI_DEVICE_ID_ENSONIQ_CT5880    0x5880
@@ -411,7 +423,6 @@

 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
 	struct gameport gameport;
-	struct semaphore joy_sem;	// gameport configuration semaphore
 #endif
 };

@@ -1558,8 +1569,8 @@

 #endif /* CHIP1371 */

-/* generic control callbacks for ens1370 and for joystick */
-#if defined(CHIP1370) || defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+/* generic control callbacks for ens1370 */
+#ifdef CHIP1370
 #define ENSONIQ_CONTROL(xname, mask) \
 { .iface = SNDRV_CTL_ELEM_IFACE_CARD, .name = xname, .info = snd_ensoniq_control_info, \
   .get = snd_ensoniq_control_get, .put = snd_ensoniq_control_put, \
@@ -1586,7 +1597,6 @@
 	return 0;
 }

-#ifdef CHIP1370
 static int snd_ensoniq_control_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ensoniq_t *ensoniq = snd_kcontrol_chip(kcontrol);
@@ -1604,14 +1614,11 @@
 	spin_unlock_irqrestore(&ensoniq->reg_lock, flags);
 	return change;
 }
-#endif /* CHIP1370 */
-#endif /* CHIP1370 || GAMEPORT */

 /*
  * ENS1370 mixer
  */

-#ifdef CHIP1370
 static snd_kcontrol_new_t snd_es1370_controls[2] __devinitdata = {
 ENSONIQ_CONTROL("PCM 0 Output also on Line-In Jack", ES_1370_XCTL0),
 ENSONIQ_CONTROL("Mic +5V bias", ES_1370_XCTL1)
@@ -1653,128 +1660,33 @@

 #endif /* CHIP1370 */

-/*
- *  General Switches...
- */
-
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
 /* MQ: gameport driver connectivity */
-#define ENSONIQ_JOY_CONTROL(xname, mask) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_CARD, .name = xname, .info = snd_ensoniq_control_info, \
-  .get = snd_ensoniq_control_get, .put = snd_ensoniq_joy_control_put, \
-  .private_value = mask }

-static int snd_ensoniq_joy_enable(ensoniq_t *ensoniq)
+static int snd_ensoniq_joystick(ensoniq_t *ensoniq, int joystick_port)
 {
-	static unsigned long last_jiffies = 0;
-	unsigned long flags;
-
+	ensoniq->gameport.io = joystick_port;
 	if (!request_region(ensoniq->gameport.io, 8, "ens137x: gameport")) {
-#define ES___GAMEPORT_LOG_DELAY (30*HZ)
-		// avoid log pollution: limit to 2 infos per minute
-		if (time_after(jiffies, last_jiffies + ES___GAMEPORT_LOG_DELAY)) {
-			last_jiffies = jiffies;
-			snd_printk("gameport io port 0x%03x in use", ensoniq->gameport.io);
-		}
-		return 0;
+		snd_printk(KERN_ERR "gameport port %#x in use\n", ensoniq->gameport.io);
+		return -EBUSY;
 	}
-	spin_lock_irqsave(&ensoniq->reg_lock, flags);
 	ensoniq->ctrl |= ES_JYSTK_EN;
+#ifdef CHIP1371
+	ensoniq->ctrl |= ES_1371_JOY_ASEL((ensoniq->gameport.io - 0x200) / 8);
+#endif
 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	spin_unlock_irqrestore(&ensoniq->reg_lock, flags);
 	gameport_register_port(&ensoniq->gameport);
-	return 1;
+	return 0;
 }

-static int snd_ensoniq_joy_disable(ensoniq_t *ensoniq)
+static void snd_ensoniq_joystick_free(ensoniq_t *ensoniq)
 {
-	unsigned long flags;
-
 	gameport_unregister_port(&ensoniq->gameport);
-	spin_lock_irqsave(&ensoniq->reg_lock, flags);
 	ensoniq->ctrl &= ~ES_JYSTK_EN;
 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	spin_unlock_irqrestore(&ensoniq->reg_lock, flags);
 	release_region(ensoniq->gameport.io, 8);
-	return 1;
-}
-
-static int snd_ensoniq_joy_control_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	ensoniq_t *ensoniq = snd_kcontrol_chip(kcontrol);
-	unsigned int nval;
-	int change;
-
-	down(&ensoniq->joy_sem);
-	nval = ucontrol->value.integer.value[0] ? ES_JYSTK_EN : 0;
-	change = (ensoniq->ctrl & ES_JYSTK_EN) != nval;	// spinlock shouldn't be needed because of joy_sem
-	if (change) {
-		if (nval)	// enable
-			change = snd_ensoniq_joy_enable(ensoniq);
-		else	change = snd_ensoniq_joy_disable(ensoniq);
-	}
-	up(&ensoniq->joy_sem);
-	return change;
 }

-static snd_kcontrol_new_t snd_ensoniq_control_joystick __devinitdata =
-ENSONIQ_JOY_CONTROL("Joystick Enable", ES_JYSTK_EN);
-
-#ifdef CHIP1371
-
-#define ES1371_JOYSTICK_ADDR(xname) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_CARD, .name = xname, .info = snd_es1371_joystick_addr_info, \
-  .get = snd_es1371_joystick_addr_get, .put = snd_es1371_joystick_addr_put }
-
-static int snd_es1371_joystick_addr_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
-{
-        uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-        uinfo->count = 1;
-        uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item >= 4)
-		uinfo->value.enumerated.item = 3;
-	sprintf(uinfo->value.enumerated.name, "port 0x%x", (uinfo->value.enumerated.item * 8) + 0x200);
-        return 0;
-}
-
-static int snd_es1371_joystick_addr_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	ensoniq_t *ensoniq = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
-
-	spin_lock_irqsave(&ensoniq->reg_lock, flags);
-	ucontrol->value.enumerated.item[0] = ES_1371_JOY_ASELI(ensoniq->ctrl);
-	spin_unlock_irqrestore(&ensoniq->reg_lock, flags);
-	return 0;
-}
-
-static int snd_es1371_joystick_addr_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	ensoniq_t *ensoniq = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
-	unsigned int nval;
-	int change;
-
-	down(&ensoniq->joy_sem);
-	nval = ES_1371_JOY_ASEL(ucontrol->value.integer.value[0]);
-	spin_lock_irqsave(&ensoniq->reg_lock, flags);
-	if (!(change = !(ensoniq->ctrl & ES_JYSTK_EN)))
-		goto no_change;	// FIXME: now we allow change only when joystick is disabled
-	change = (ensoniq->ctrl & ES_1371_JOY_ASELM) != nval;
-	ensoniq->ctrl &= ~ES_1371_JOY_ASELM;
-	ensoniq->ctrl |= nval;
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	ensoniq->gameport.io = 0x200 + ES_1371_JOY_ASELI(nval) * 8;
-no_change:
-	spin_unlock_irqrestore(&ensoniq->reg_lock, flags);
-	up(&ensoniq->joy_sem);
-	return change;
-}
-
-static snd_kcontrol_new_t snd_es1371_joystick_addr __devinitdata =
-ES1371_JOYSTICK_ADDR("Joystick Address");
-
-#endif /* CHIP1371 */
 #endif /* CONFIG_GAMEPORT */

 /*
@@ -1816,7 +1728,7 @@
 {
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
 	if (ensoniq->ctrl & ES_JYSTK_EN)
-		snd_ensoniq_joy_disable(ensoniq);
+		snd_ensoniq_joystick_free(ensoniq);
 #endif
 	if (ensoniq->irq < 0)
 		goto __hw_end;
@@ -2012,14 +1924,6 @@
 	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL));
 	outb(0x00, ES_REG(ensoniq, UART_RES));
 	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	init_MUTEX(&ensoniq->joy_sem);
-#ifdef CHIP1371
-	snd_ctl_add(card, snd_ctl_new1(&snd_es1371_joystick_addr, ensoniq));
-#endif
-	snd_ctl_add(card, snd_ctl_new1(&snd_ensoniq_control_joystick, ensoniq));
-	ensoniq->gameport.io = 0x200;	// FIXME: is ES1371 configured like this above ?
-#endif
 	synchronize_irq(ensoniq->irq);

 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ensoniq, &ops)) < 0) {
@@ -2324,6 +2228,18 @@
 		snd_card_free(card);
 		return err;
 	}
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+	switch (joystick_port[dev]) {
+	case 0x200:
+#ifdef CHIP1371
+	case 0x208:
+	case 0x210:
+	case 0x218:
+#endif
+		snd_ensoniq_joystick(ensoniq, joystick_port[dev]);
+		break;
+	}
+#endif
 #ifdef CHIP1370
 	strcpy(card->driver, "ENS1370");
 #endif




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
