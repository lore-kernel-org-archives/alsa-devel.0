From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: cs4248 / thinkpad 755 / 755c , patch suggestions [PATCH]]
Date: Mon, 7 Jul 2003 15:53:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030707205357.GQ5013@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


Hi Takashi,

On Thu, Jul 03, 2003 at 02:29:01PM +0200, Takashi Iwai wrote:
> At Wed, 2 Jul 2003 15:29:55 -0500,
> Ryan Underwood wrote:
> > 
> > 1) What is ALSA's policy on module options?  For example, would it be
> > okay to add an option like "thinkpad" to the ad1848 module, so that
> > inserting it with "thinkpad=1" would cause the necessary ports to be
> > prodded?
> 
> this looks like a feasible solution.
> 
> > 2) Since the chip's power mode can be controlled through a write to that
> > port (bit 2 on, cs4248 power on; bit 2 off, cs4248 power off), would it
> > be a good idea to add the _suspend, _resume, and _set_power_state
> > functions within a #ifdef CONFIG_PM block, like in other drivers?
> 
> yep.  we haven't done that just becase of lack of hardware.
> if you can write and test it, it would be greatly appreciated.

I have attached a patch against the ALSA 0.94.  ad1848.c, ad1848_lib.c,
and ad1848.h have changed.

I tested the module against 2.4.21 on a Debian system, gcc 3.3 and it
works fine; simply set the proper resources and thinkpad=1 and the
thinkpad works.

One issue is to note, I don't know if this is a problem with the ad1848
driver in general or what; if I cat a 11025hz mono 8-bit file to
/dev/dsp, the sound comes out verrrrry slllloooowwwllly.   But using
aplay, it works fine.

I am not sure the best way to test the power managmeent code -- it
doesn't crash the machine at least. ;)

I added a note to the ALSA wiki about this option.  I tried to fix the
OSS driver too but it does some other weird things like not allowing a
IRQ > 7 to be used.  (It thinks the CS4248 is an 8bit card or
something).  So this will have to be an alsa-only fix for now at least.

Let me know if the patch is ok,

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="cs4248_thinkpad.diff"

diff -ur alsa-driver/alsa-kernel/include/ad1848.h alsanew/alsa-kernel/include/ad1848.h
--- alsa-driver/alsa-kernel/include/ad1848.h	2003-04-23 05:01:29.000000000 -0500
+++ alsanew/alsa-kernel/include/ad1848.h	2003-07-03 20:29:59.000000000 -0500
@@ -121,6 +121,11 @@
 #define AD1848_HW_CS4248	0x0003	/* CS4248 chip */
 #define AD1848_HW_CMI8330	0x0004	/* CMI8330 chip */
 
+/* IBM Thinkpad specific stuff */
+#define AD1848_THINKPAD_CTL_PORT1		0x15e8
+#define AD1848_THINKPAD_CTL_PORT2		0x15e9
+#define AD1848_THINKPAD_CS4248_ENABLE_BIT	0x02
+
 struct _snd_ad1848 {
 	unsigned long port;		/* i/o port */
 	struct resource *res_port;
@@ -140,6 +145,10 @@
 	int mce_bit;
 	int calibrate_mute;
 	int dma_size;
+	int thinkpad_flag;		/* Thinkpad CS4248 needs some extra help */
+#ifdef CONFIG_PM
+	struct pm_dev *thinkpad_pmstate;
+#endif
 
 	spinlock_t reg_lock;
 	struct semaphore open_mutex;
@@ -157,7 +166,7 @@
 
 int snd_ad1848_create(snd_card_t * card,
 		      unsigned long port,
-		      int irq, int dma,
+		      int irq, int dma, int thinkpad,
 		      unsigned short hardware,
 		      ad1848_t ** chip);
 
diff -ur alsa-driver/alsa-kernel/isa/ad1848/ad1848.c alsanew/alsa-kernel/isa/ad1848/ad1848.c
--- alsa-driver/alsa-kernel/isa/ad1848/ad1848.c	2002-10-21 13:28:21.000000000 -0500
+++ alsanew/alsa-kernel/isa/ad1848/ad1848.c	2003-07-07 13:11:55.000000000 -0500
@@ -46,6 +46,7 @@
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
 static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5,7,9,11,12,15 */
 static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3,5,6,7 */
+static int thinkpad[SNDRV_CARDS];			/* Thinkpad special case */
 
 MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(index, "Index value for AD1848 soundcard.");
@@ -65,6 +66,9 @@
 MODULE_PARM(dma1, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(dma1, "DMA1 # for AD1848 driver.");
 MODULE_PARM_SYNTAX(dma1, SNDRV_DMA_DESC);
+MODULE_PARM(thinkpad, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(thinkpad, "Enable only for the onboard CS4248 of IBM Thinkpad 360/750/755 series.");
+MODULE_PARM_SYNTAX(thinkpad,  SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
 
 static snd_card_t *snd_ad1848_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 
@@ -96,6 +100,7 @@
 	if ((err = snd_ad1848_create(card, port[dev],
 				     irq[dev],
 				     dma1[dev],
+				     thinkpad[dev],
 				     AD1848_HW_DETECT,
 				     &chip)) < 0) {
 		snd_card_free(card);
@@ -116,6 +121,10 @@
 	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
 		pcm->name, chip->port, irq[dev], dma1[dev]);
 
+	if (thinkpad[dev]) {
+		strcat(card->longname, " [Thinkpad]");
+	}
+
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -168,7 +177,8 @@
 	       get_id(&str,&id[nr_dev]) == 2 &&
 	       get_option(&str,(int *)&port[nr_dev]) == 2 &&
 	       get_option(&str,&irq[nr_dev]) == 2 &&
-	       get_option(&str,&dma1[nr_dev]) == 2);
+	       get_option(&str,&dma1[nr_dev]) == 2 &&
+	       get_option(&str,&thinkpad[nr_dev]) == 2);
 	nr_dev++;
 	return 1;
 }
diff -ur alsa-driver/alsa-kernel/isa/ad1848/ad1848_lib.c alsanew/alsa-kernel/isa/ad1848/ad1848_lib.c
--- alsa-driver/alsa-kernel/isa/ad1848/ad1848_lib.c	2003-05-30 07:28:34.000000000 -0500
+++ alsanew/alsa-kernel/isa/ad1848/ad1848_lib.c	2003-07-03 20:25:21.000000000 -0500
@@ -625,6 +625,92 @@
 
  */
 
+static void snd_ad1848_thinkpad_twiddle(ad1848_t *chip, int on) {
+
+	int tmp;
+
+	if (!chip->thinkpad_flag) return;
+
+	outb(0x1c, AD1848_THINKPAD_CTL_PORT1);
+	tmp = inb(AD1848_THINKPAD_CTL_PORT2);
+
+	switch (on) {
+		case 0:  /* turn it off */
+			tmp &= ~AD1848_THINKPAD_CS4248_ENABLE_BIT;
+		default: /* turn it on */
+			tmp |= AD1848_THINKPAD_CS4248_ENABLE_BIT;
+	}
+
+	outb(tmp, AD1848_THINKPAD_CTL_PORT2);
+
+}
+
+#ifdef CONFIG_PM
+static void snd_ad1848_suspend(ad1848_t *chip) {
+
+	snd_card_t *card = chip->card;
+
+	if (card->power_state == SNDRV_CTL_POWER_D3hot)
+		return;
+
+	if (chip->thinkpad_flag) {
+		snd_pcm_suspend_all(chip->pcm);
+		snd_ad1848_thinkpad_twiddle(chip, 0);
+		snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	}
+
+}
+
+static void snd_ad1848_resume(ad1848_t *chip) {
+
+	snd_card_t *card = chip->card;
+
+	if (card->power_state == SNDRV_CTL_POWER_D0)
+		return;
+
+	if (chip->thinkpad_flag) {
+		snd_ad1848_thinkpad_twiddle(chip, 1);
+		snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	}
+}
+
+/* callback for control API */
+static int snd_ad1848_set_power_state(snd_card_t *card, unsigned int power_state)
+{
+	ad1848_t *chip = (ad1848_t *) card->power_state_private_data;
+	switch (power_state) {
+	case SNDRV_CTL_POWER_D0:
+	case SNDRV_CTL_POWER_D1:
+	case SNDRV_CTL_POWER_D2:
+		snd_ad1848_resume(chip);
+		break;
+	case SNDRV_CTL_POWER_D3hot:
+	case SNDRV_CTL_POWER_D3cold:
+		snd_ad1848_suspend(chip);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int snd_ad1848_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+{
+	ad1848_t *chip = snd_magic_cast(ad1848_t, dev->data, return 0);
+
+	switch (rqst) {
+	case PM_SUSPEND:
+		snd_ad1848_suspend(chip);
+		break;
+	case PM_RESUME:
+		snd_ad1848_resume(chip);
+		break;
+	}
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 static int snd_ad1848_probe(ad1848_t * chip)
 {
 	unsigned long flags;
@@ -799,6 +885,10 @@
 
 static int snd_ad1848_free(ad1848_t *chip)
 {
+#ifdef CONFIG_PM
+        if (chip->thinkpad_flag && chip->thinkpad_pmstate)
+                pm_unregister(chip->thinkpad_pmstate);
+#endif
 	if (chip->res_port) {
 		release_resource(chip->res_port);
 		kfree_nocheck(chip->res_port);
@@ -832,7 +922,7 @@
 
 int snd_ad1848_create(snd_card_t * card,
 		      unsigned long port,
-		      int irq, int dma,
+		      int irq, int dma, int thinkpad,
 		      unsigned short hardware,
 		      ad1848_t ** rchip)
 {
@@ -870,6 +960,22 @@
 	}
 	chip->dma = dma;
 
+	if (thinkpad) {
+		chip->thinkpad_flag = 1;
+		snd_ad1848_thinkpad_twiddle(chip, 1);
+#ifdef CONFIG_PM
+		chip->thinkpad_pmstate = pm_register(PM_ISA_DEV, 0, snd_ad1848_pm_callback);
+		if (chip->thinkpad_pmstate) {
+			chip->thinkpad_pmstate->data = chip;
+			card->set_power_state = snd_ad1848_set_power_state; /* callback */
+			card->power_state_private_data = chip;
+		}
+#endif
+	}
+	else {
+		chip->thinkpad_flag = 0;
+	}
+
 	if (snd_ad1848_probe(chip) < 0) {
 		snd_ad1848_free(chip);
 		return -ENODEV;


--f2QGlHpHGjS2mn6Y--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
