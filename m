From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ymfpci: make joystick port a module parameter
Date: Mon, 15 Sep 2003 19:58:51 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309151956590.27268-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


This removes the joystick enable/address card controls and makes
them a module option instead.


Index: alsa-kernel/include/ymfpci.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/ymfpci.h,v
retrieving revision 1.10
diff -u -r1.10 ymfpci.h
--- alsa-kernel/include/ymfpci.h	16 Jun 2003 07:31:38 -0000	1.10
+++ alsa-kernel/include/ymfpci.h	15 Sep 2003 17:52:47 -0000
@@ -311,8 +311,6 @@

 	unsigned short old_legacy_ctrl;
 #if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
-	unsigned int joystick_port;
-	struct semaphore joystick_mutex;
 	struct resource *joystick_res;
 	struct gameport gameport;
 #endif
@@ -389,9 +387,6 @@
 int snd_ymfpci_pcm_spdif(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
 int snd_ymfpci_pcm_4ch(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
 int snd_ymfpci_mixer(ymfpci_t *chip, int rear_switch);
-#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
-int snd_ymfpci_joystick(ymfpci_t *chip);
-#endif

 int snd_ymfpci_voice_alloc(ymfpci_t *chip, ymfpci_voice_type_t type, int pair, ymfpci_voice_t **rvoice);
 int snd_ymfpci_voice_free(ymfpci_t *chip, ymfpci_voice_t *pvoice);
Index: alsa-kernel/pci/ymfpci/ymfpci.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci.c,v
retrieving revision 1.26
diff -u -r1.26 ymfpci.c
--- alsa-kernel/pci/ymfpci/ymfpci.c	12 Aug 2003 14:10:16 -0000	1.26
+++ alsa-kernel/pci/ymfpci/ymfpci.c	15 Sep 2003 17:52:47 -0000
@@ -46,6 +46,9 @@
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
 static long fm_port[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -1};
 static long mpu_port[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -1};
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+static long joystick_port[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -1};
+#endif
 static int rear_switch[SNDRV_CARDS];

 MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
@@ -63,6 +66,11 @@
 MODULE_PARM(fm_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
 MODULE_PARM_DESC(fm_port, "FM OPL-3 Port.");
 MODULE_PARM_SYNTAX(fm_port, SNDRV_ENABLED);
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+MODULE_PARM(joystick_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
+MODULE_PARM_DESC(joystick_port, "Joystick port address");
+MODULE_PARM_SYNTAX(joystick_port, SNDRV_ENABLED);
+#endif
 MODULE_PARM(rear_switch, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(rear_switch, "Enable shared rear/line-in switch");
 MODULE_PARM_SYNTAX(rear_switch, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
@@ -86,6 +94,9 @@
 	snd_card_t *card;
 	struct resource *fm_res = NULL;
 	struct resource *mpu_res = NULL;
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+	struct resource *joystick_res = NULL;
+#endif
 	ymfpci_t *chip;
 	opl3_t *opl3;
 	char *str;
@@ -133,6 +144,16 @@
 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
 			pci_write_config_word(pci, PCIR_DSXG_MPU401BASE, mpu_port[dev]);
 		}
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+		if (joystick_port[dev] < 0) {
+			joystick_port[dev] = pci_resource_start(pci, 2);
+		}
+		if (joystick_port[dev] >= 0 &&
+		    (joystick_res = request_region(joystick_port[dev], 1, "YMFPCI gameport")) != NULL) {
+			legacy_ctrl |= YMFPCI_LEGACY_JPEN;
+			pci_write_config_word(pci, PCIR_DSXG_JOYBASE, joystick_port[dev]);
+		}
+#endif
 	} else {
 		switch (fm_port[dev]) {
 		case 0x388: legacy_ctrl2 |= 0; break;
@@ -162,6 +183,22 @@
 			legacy_ctrl2 &= ~YMFPCI_LEGACY2_MPUIO;
 			mpu_port[dev] = -1;
 		}
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+		switch (joystick_port[dev]) {
+		case 0x201: legacy_ctrl2 |= 0 << 6; break;
+		case 0x202: legacy_ctrl2 |= 1 << 6; break;
+		case 0x204: legacy_ctrl2 |= 2 << 6; break;
+		case 0x205: legacy_ctrl2 |= 3 << 6; break;
+		default: joystick_port[dev] = -1; break;
+		}
+		if (joystick_port[dev] > 0 &&
+		    (joystick_res = request_region(joystick_port[dev], 1, "YMFPCI gameport")) != NULL) {
+			legacy_ctrl |= YMFPCI_LEGACY_JPEN;
+		} else {
+			legacy_ctrl2 &= ~YMFPCI_LEGACY2_JSIO;
+			joystick_port[dev] = -1;
+		}
+#endif
 	}
 	if (mpu_res) {
 		legacy_ctrl |= YMFPCI_LEGACY_MIEN;
@@ -182,10 +219,19 @@
 			release_resource(fm_res);
 			kfree_nocheck(fm_res);
 		}
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+		if (joystick_res) {
+			release_resource(joystick_res);
+			kfree_nocheck(joystick_res);
+		}
+#endif
 		return err;
 	}
 	chip->fm_res = fm_res;
 	chip->mpu_res = mpu_res;
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+	chip->joystick_res = joystick_res;
+#endif
 	if ((err = snd_ymfpci_pcm(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -230,8 +276,9 @@
 		}
 	}
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	if ((err = snd_ymfpci_joystick(chip)) < 0) {
-		printk(KERN_WARNING "ymfpci: cannot initialize joystick, skipping...\n");
+	if (chip->joystick_res) {
+		chip->gameport.io = joystick_port[dev];
+		gameport_register_port(&chip->gameport);
 	}
 #endif
 	strcpy(card->driver, str);
Index: alsa-kernel/pci/ymfpci/ymfpci_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci_main.c,v
retrieving revision 1.41
diff -u -r1.41 ymfpci_main.c
--- alsa-kernel/pci/ymfpci/ymfpci_main.c	14 Aug 2003 11:05:38 -0000	1.41
+++ alsa-kernel/pci/ymfpci/ymfpci_main.c	15 Sep 2003 17:52:48 -0000
@@ -1703,177 +1703,6 @@


 /*
- * joystick support
- */
-
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-static int ymfpci_joystick_ports[4] = {
-	0x201, 0x202, 0x204, 0x205
-};
-
-static int snd_ymfpci_get_joystick_port(ymfpci_t *chip, int index)
-{
-	if (index < 4)
-		return ymfpci_joystick_ports[index];
-	else
-		return pci_resource_start(chip->pci, 2);
-}
-
-static void setup_joystick_base(ymfpci_t *chip)
-{
-	if (chip->device_id >= 0x0010) /* YMF 744/754 */
-		pci_write_config_word(chip->pci, PCIR_DSXG_JOYBASE,
-				      snd_ymfpci_get_joystick_port(chip, chip->joystick_port));
-	else {
-		u16 legacy_ctrl2;
-		pci_read_config_word(chip->pci, PCIR_DSXG_ELEGACY, &legacy_ctrl2);
-		legacy_ctrl2 &= ~YMFPCI_LEGACY2_JSIO;
-		legacy_ctrl2 |= chip->joystick_port << 6;
-		pci_write_config_word(chip->pci, PCIR_DSXG_ELEGACY, legacy_ctrl2);
-	}
-}
-
-static int snd_ymfpci_enable_joystick(ymfpci_t *chip)
-{
-	u16 val;
-
-	chip->gameport.io = snd_ymfpci_get_joystick_port(chip, chip->joystick_port);
-	chip->joystick_res = request_region(chip->gameport.io, 1, "YMFPCI gameport");
-	if (!chip->joystick_res) {
-		snd_printk(KERN_WARNING "gameport port %#x in use\n", chip->gameport.io);
-		return 0;
-	}
-	setup_joystick_base(chip);
-	pci_read_config_word(chip->pci, PCIR_DSXG_LEGACY, &val);
-	val |= YMFPCI_LEGACY_JPEN;
-	pci_write_config_word(chip->pci, PCIR_DSXG_LEGACY, val);
-	gameport_register_port(&chip->gameport);
-	return 1;
-}
-
-static int snd_ymfpci_disable_joystick(ymfpci_t *chip)
-{
-	u16 val;
-
-	gameport_unregister_port(&chip->gameport);
-	pci_read_config_word(chip->pci, PCIR_DSXG_LEGACY, &val);
-	val &= ~YMFPCI_LEGACY_JPEN;
-	pci_write_config_word(chip->pci, PCIR_DSXG_LEGACY, val);
-	release_resource(chip->joystick_res);
-	kfree_nocheck(chip->joystick_res);
-	chip->joystick_res = NULL;
-	return 1;
-}
-
-static int snd_ymfpci_joystick_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 1;
-	return 0;
-}
-
-static int snd_ymfpci_joystick_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
-{
-	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
-	u16 val;
-
-	pci_read_config_word(chip->pci, PCIR_DSXG_LEGACY, &val);
-	ucontrol->value.integer.value[0] = (val & YMFPCI_LEGACY_JPEN) ? 1 : 0;
-	return 0;
-}
-
-static int snd_ymfpci_joystick_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
-{
-	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
-	int enabled, change;
-
-	down(&chip->joystick_mutex);
-	enabled = chip->joystick_res != NULL;
-	change = enabled != !! ucontrol->value.integer.value[0];
-	if (change) {
-		if (!enabled)
-			change = snd_ymfpci_enable_joystick(chip);
-		else
-			change = snd_ymfpci_disable_joystick(chip);
-	}
-	up(&chip->joystick_mutex);
-	return change;
-}
-
-static int snd_ymfpci_joystick_addr_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
-{
-	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
-	int ports = chip->device_id >= 0x0010 ? 5 : 4;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = ports;
-	if (uinfo->value.enumerated.item >= ports)
-		uinfo->value.enumerated.item = ports - 1;
-	sprintf(uinfo->value.enumerated.name, "port 0x%x",
-		snd_ymfpci_get_joystick_port(chip, uinfo->value.enumerated.item));
-	return 0;
-}
-
-static int snd_ymfpci_joystick_addr_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
-{
-	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
-	ucontrol->value.enumerated.item[0] = chip->joystick_port;
-	return 0;
-}
-
-static int snd_ymfpci_joystick_addr_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
-{
-	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
-	int change, enabled;
-
-	down(&chip->joystick_mutex);
-	change = ucontrol->value.enumerated.item[0] != chip->joystick_port;
-	if (change) {
-		enabled = chip->joystick_res != NULL;
-		if (enabled)
-			snd_ymfpci_disable_joystick(chip);
-		chip->joystick_port = ucontrol->value.enumerated.item[0];
-		if (enabled)
-			snd_ymfpci_enable_joystick(chip);
-	}
-	up(&chip->joystick_mutex);
-	return change;
-}
-
-static snd_kcontrol_new_t snd_ymfpci_control_joystick __devinitdata = {
-	.name = "Joystick",
-	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
-	.info = snd_ymfpci_joystick_info,
-	.get = snd_ymfpci_joystick_get,
-	.put = snd_ymfpci_joystick_put,
-};
-
-static snd_kcontrol_new_t snd_ymfpci_control_joystick_addr __devinitdata = {
-	.name = "Joystick Address",
-	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
-	.info = snd_ymfpci_joystick_addr_info,
-	.get = snd_ymfpci_joystick_addr_get,
-	.put = snd_ymfpci_joystick_addr_put,
-};
-
-int __devinit snd_ymfpci_joystick(ymfpci_t *chip)
-{
-	int err;
-
-	chip->joystick_port = 0; /* default */
-	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_ymfpci_control_joystick, chip))) < 0)
-		return err;
-	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_ymfpci_control_joystick_addr, chip))) < 0)
-		return err;
-	return 0;
-}
-#endif /* CONFIG_GAMEPORT */
-
-
-/*
  *  proc interface
  */

@@ -2123,8 +1952,12 @@
 		kfree_nocheck(chip->fm_res);
 	}
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	if (chip->joystick_res)
-		snd_ymfpci_disable_joystick(chip);
+	if (chip->joystick_res) {
+		if (chip->gameport.io)
+			gameport_unregister_port(&chip->gameport);
+		release_resource(chip->joystick_res);
+		kfree_nocheck(chip->joystick_res);
+	}
 #endif
 	if (chip->reg_area_virt)
 		iounmap((void *)chip->reg_area_virt);
@@ -2275,9 +2108,6 @@
 	spin_lock_init(&chip->voice_lock);
 	init_waitqueue_head(&chip->interrupt_sleep);
 	atomic_set(&chip->interrupt_sleep_count, 0);
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	init_MUTEX(&chip->joystick_mutex);
-#endif
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
Index: alsa-kernel/Documentation/ALSA-Configuration.txt
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/Documentation/ALSA-Configuration.txt,v
retrieving revision 1.17
diff -u -r1.17 ALSA-Configuration.txt
--- alsa-kernel/Documentation/ALSA-Configuration.txt	28 Aug 2003 15:07:26 -0000	1.17
+++ alsa-kernel/Documentation/ALSA-Configuration.txt	15 Sep 2003 17:52:59 -0000
@@ -1103,11 +1103,15 @@

     Module for Yamaha PCI chips (YMF72x, YMF74x & YMF75x).

-    mpu_port	- 0x300,0x330,0x332,0x334, -1 (disable) by default
-    fm_port	- 0x388,0x398,0x3a0,0x3a8, -1 (disable) by default
-    rear_switch - enable shared rear/line-in switch (bool)
+    mpu_port      - 0x300,0x330,0x332,0x334, -1 (disable) by default
+    fm_port       - 0x388,0x398,0x3a0,0x3a8, -1 (disable) by default
+    joystick_port - 0x201,0x202,0x204,0x205, -1 (disable) by default
+    rear_switch   - enable shared rear/line-in switch (bool)

     Module supports autoprobe and multiple chips (max 8).
+
+    With YMF744/754 chips, the MPU401/FM/joystick port addresses are
+    chosen automatically, and enabled by default.

     The power-management is supported.





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
