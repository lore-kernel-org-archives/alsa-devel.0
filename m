From: Pavel Machek <pavel@suse.cz>
Subject: driver model type fixes for ALSA
Date: Fri, 28 Jan 2005 19:35:59 +0100
Message-ID: <20050128183559.GA9199@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from amd.ucw.cz (gprs213-105.eurotel.cz [160.218.213.105])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9FB1C206
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2005 19:36:24 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz, alsa-devel@alsa-project.org, linux-pm@osdl.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi!

suspend() routines no longer get u32 as their parameter (they get
pm_message_t, which is u32 for now, but will change in 2.6.12 or
so). This fixes ALSA to notice this, and uses constants with right
types where appropriate. It results in no code changes. [Best results
will be when patching against latest -mm, you may get some warnings if
you patch it into older kernel, but it should still do the right
thing.] Please apply,
							Pavel

--- clean/sound/core/init.c	2005-01-22 02:47:30.000000000 +0100
+++ linux/sound/core/init.c	2005-01-19 11:59:14.000000000 +0100
@@ -719,7 +719,7 @@
  * handler and from the control API.
  */
 int snd_card_set_pm_callback(snd_card_t *card,
-			     int (*suspend)(snd_card_t *, unsigned int),
+			     int (*suspend)(snd_card_t *, pm_message_t),
 			     int (*resume)(snd_card_t *, unsigned int),
 			     void *private_data)
 {
@@ -765,7 +765,7 @@
  * from the ALSA's common PM handler and from the control API.
  */
 int snd_card_set_dev_pm_callback(snd_card_t *card, int type,
-				 int (*suspend)(snd_card_t *, unsigned int),
+				 int (*suspend)(snd_card_t *, pm_message_t),
 				 int (*resume)(snd_card_t *, unsigned int),
 				 void *private_data)
 {
@@ -778,7 +778,7 @@
 }
 
 #ifdef CONFIG_PCI
-int snd_card_pci_suspend(struct pci_dev *dev, u32 state)
+int snd_card_pci_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	snd_card_t *card = pci_get_drvdata(dev);
 	int err;
--- clean/sound/drivers/vx/vx_core.c	2005-01-22 02:49:22.000000000 +0100
+++ linux/sound/drivers/vx/vx_core.c	2005-01-28 19:18:10.000000000 +0100
@@ -718,7 +718,7 @@
 /*
  * suspend
  */
-static int snd_vx_suspend(snd_card_t *card, unsigned int state)
+static int snd_vx_suspend(snd_card_t *card, pm_message_t state)
 {
 	vx_core_t *chip = card->pm_private_data;
 	unsigned int i;
--- clean/sound/isa/ad1848/ad1848_lib.c	2005-01-22 02:48:59.000000000 +0100
+++ linux/sound/isa/ad1848/ad1848_lib.c	2005-01-28 19:18:10.000000000 +0100
@@ -644,7 +644,7 @@
 }
 
 #ifdef CONFIG_PM
-static int snd_ad1848_suspend(snd_card_t *card, unsigned int state)
+static int snd_ad1848_suspend(snd_card_t *card, pm_message_t state)
 {
 	ad1848_t *chip = card->pm_private_data;
 
--- clean/sound/isa/cs423x/cs4231_lib.c	2005-01-22 02:47:30.000000000 +0100
+++ linux/sound/isa/cs423x/cs4231_lib.c	2005-01-28 19:18:10.000000000 +0100
@@ -1394,7 +1394,7 @@
 #endif
 }
 
-static int snd_cs4231_pm_suspend(snd_card_t *card, unsigned int state)
+static int snd_cs4231_pm_suspend(snd_card_t *card, pm_message_t state)
 {
 	cs4231_t *chip = card->pm_private_data;
 	if (chip->suspend)
--- clean/sound/isa/es18xx.c	2005-01-22 02:47:49.000000000 +0100
+++ linux/sound/isa/es18xx.c	2005-01-28 19:18:10.000000000 +0100
@@ -1612,7 +1612,7 @@
 
 /* Power Management support functions */
 #ifdef CONFIG_PM
-static int snd_es18xx_suspend(snd_card_t *card, unsigned int state)
+static int snd_es18xx_suspend(snd_card_t *card, pm_message_t state)
 {
 	es18xx_t *chip = card->pm_private_data;
 
--- clean/sound/isa/opl3sa2.c	2005-01-22 02:49:12.000000000 +0100
+++ linux/sound/isa/opl3sa2.c	2005-01-28 19:18:10.000000000 +0100
@@ -529,7 +529,7 @@
 
 /* Power Management support functions */
 #ifdef CONFIG_PM
-static int snd_opl3sa2_suspend(snd_card_t *card, unsigned int state)
+static int snd_opl3sa2_suspend(snd_card_t *card, pm_message_t state)
 {
 	opl3sa2_t *chip = card->pm_private_data;
 
--- clean/sound/oss/ali5455.c	2005-01-22 02:48:45.000000000 +0100
+++ linux/sound/oss/ali5455.c	2005-01-28 19:18:10.000000000 +0100
@@ -3528,7 +3528,7 @@
 }
 
 #ifdef CONFIG_PM
-static int ali_pm_suspend(struct pci_dev *dev, u32 pm_state)
+static int ali_pm_suspend(struct pci_dev *dev, pm_message_t pm_state)
 {
 	struct ali_card *card = pci_get_drvdata(dev);
 	struct ali_state *state;
--- clean/sound/oss/cs4281/cs4281_wrapper-24.c	2005-01-22 02:47:48.000000000 +0100
+++ linux/sound/oss/cs4281/cs4281_wrapper-24.c	2005-01-28 19:18:10.000000000 +0100
@@ -27,7 +27,7 @@
 #include <linux/spinlock.h>
 
 static int cs4281_resume_null(struct pci_dev *pcidev) { return 0; }
-static int cs4281_suspend_null(struct pci_dev *pcidev, u32 state) { return 0; }
+static int cs4281_suspend_null(struct pci_dev *pcidev, pm_message_t state) { return 0; }
 
 #define free_dmabuf(state, dmabuf) \
 	pci_free_consistent(state->pcidev, \
--- clean/sound/oss/cs46xx.c	2005-01-22 02:49:21.000000000 +0100
+++ linux/sound/oss/cs46xx.c	2005-01-28 19:18:10.000000000 +0100
@@ -388,7 +388,7 @@
 static int cs46xx_powerup(struct cs_card *card, unsigned int type);
 static int cs461x_powerdown(struct cs_card *card, unsigned int type, int suspendflag);
 static void cs461x_clear_serial_FIFOs(struct cs_card *card, int type);
-static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state);
+static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);
 
 #ifndef CS46XX_ACPI_SUPPORT
@@ -5774,7 +5774,7 @@
 #endif
 
 #if CS46XX_ACPI_SUPPORT
-static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state)
+static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state)
 {
 	struct cs_card *s = PCI_GET_DRIVER_DATA(pcidev);
 	CS_DBGOUT(CS_PM | CS_FUNCTION, 2, 
--- clean/sound/oss/cs46xxpm-24.h	2005-01-22 02:48:58.000000000 +0100
+++ linux/sound/oss/cs46xxpm-24.h	2005-01-28 19:18:10.000000000 +0100
@@ -36,7 +36,7 @@
 * for now (12/22/00) only enable the pm_register PM support.
 * allow these table entries to be null.
 */
-static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state);
+static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);
 #define cs_pm_register(a, b, c)  NULL
 #define cs_pm_unregister_all(a) 
--- clean/sound/oss/esssolo1.c	2005-01-22 02:47:15.000000000 +0100
+++ linux/sound/oss/esssolo1.c	2005-01-28 19:18:10.000000000 +0100
@@ -2257,7 +2257,7 @@
 }
 
 static int
-solo1_suspend(struct pci_dev *pci_dev, u32 state) {
+solo1_suspend(struct pci_dev *pci_dev, pm_message_t state) {
 	struct solo1_state *s = (struct solo1_state*)pci_get_drvdata(pci_dev);
 	if (!s)
 		return 1;
--- clean/sound/oss/i810_audio.c	2005-01-22 02:48:35.000000000 +0100
+++ linux/sound/oss/i810_audio.c	2005-01-28 19:18:10.000000000 +0100
@@ -3457,7 +3457,7 @@
 }
 
 #ifdef CONFIG_PM
-static int i810_pm_suspend(struct pci_dev *dev, u32 pm_state)
+static int i810_pm_suspend(struct pci_dev *dev, pm_message_t pm_state)
 {
         struct i810_card *card = pci_get_drvdata(dev);
         struct i810_state *state;
--- clean/sound/oss/maestro3.c	2005-01-22 02:48:48.000000000 +0100
+++ linux/sound/oss/maestro3.c	2005-01-28 19:18:10.000000000 +0100
@@ -375,7 +375,7 @@
  * I'm not very good at laying out functions in a file :)
  */
 static int m3_notifier(struct notifier_block *nb, unsigned long event, void *buf);
-static int m3_suspend(struct pci_dev *pci_dev, u32 state);
+static int m3_suspend(struct pci_dev *pci_dev, pm_message_t state);
 static void check_suspend(struct m3_card *card);
 
 static struct notifier_block m3_reboot_nb = {
@@ -2777,12 +2777,12 @@
 
     for(card = devs; card != NULL; card = card->next) {
         if(!card->in_suspend)
-            m3_suspend(card->pcidev, 3); /* XXX legal? */
+            m3_suspend(card->pcidev, PMSG_SUSPEND); /* XXX legal? */
     }
     return 0;
 }
 
-static int m3_suspend(struct pci_dev *pci_dev, u32 state)
+static int m3_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
     unsigned long flags;
     int i;
--- clean/sound/oss/trident.c	2005-01-22 02:48:35.000000000 +0100
+++ linux/sound/oss/trident.c	2005-01-28 19:18:10.000000000 +0100
@@ -487,7 +487,7 @@
 static struct trident_channel *ali_alloc_pcm_channel(struct trident_card *card);
 static void ali_restore_regs(struct trident_card *card);
 static void ali_save_regs(struct trident_card *card);
-static int trident_suspend(struct pci_dev *dev, u32 unused);
+static int trident_suspend(struct pci_dev *dev, pm_message_t unused);
 static int trident_resume(struct pci_dev *dev);
 static void ali_free_pcm_channel(struct trident_card *card, unsigned int channel);
 static int ali_setup_multi_channels(struct trident_card *card, int chan_nums);
@@ -3723,7 +3723,7 @@
 }
 
 static int
-trident_suspend(struct pci_dev *dev, u32 unused)
+trident_suspend(struct pci_dev *dev, pm_message_t unused)
 {
 	struct trident_card *card = pci_get_drvdata(dev);
 
--- clean/sound/oss/ymfpci.c	2005-01-22 02:48:27.000000000 +0100
+++ linux/sound/oss/ymfpci.c	2005-01-28 19:18:10.000000000 +0100
@@ -2074,7 +2074,7 @@
 /*
  */
 
-static int ymf_suspend(struct pci_dev *pcidev, u32 unused)
+static int ymf_suspend(struct pci_dev *pcidev, pm_message_t unused)
 {
 	struct ymf_unit *unit = pci_get_drvdata(pcidev);
 	unsigned long flags;
--- clean/sound/pci/ali5451/ali5451.c	2005-01-22 02:48:58.000000000 +0100
+++ linux/sound/pci/ali5451/ali5451.c	2005-01-28 19:18:10.000000000 +0100
@@ -1894,7 +1894,7 @@
 }
 
 #ifdef CONFIG_PM
-static int ali_suspend(snd_card_t *card, unsigned int state)
+static int ali_suspend(snd_card_t *card, pm_message_t state)
 {
 	ali_t *chip = card->pm_private_data;
 	ali_image_t *im;
--- clean/sound/pci/atiixp.c	2005-01-22 02:48:20.000000000 +0100
+++ linux/sound/pci/atiixp.c	2005-01-28 19:18:10.000000000 +0100
@@ -1392,7 +1392,7 @@
 /*
  * power management
  */
-static int snd_atiixp_suspend(snd_card_t *card, unsigned int state)
+static int snd_atiixp_suspend(snd_card_t *card, pm_message_t state)
 {
 	atiixp_t *chip = card->pm_private_data;
 	int i;
@@ -1406,7 +1406,7 @@
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(chip->pci, 3);
+	pci_set_power_state(chip->pci, PCI_D3hot);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1417,7 +1417,7 @@
 	int i;
 
 	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	pci_set_power_state(chip->pci, PCI_D0);
 	pci_set_master(chip->pci);
 
 	snd_atiixp_aclink_reset(chip);
--- clean/sound/pci/atiixp_modem.c	2005-01-22 02:49:16.000000000 +0100
+++ linux/sound/pci/atiixp_modem.c	2005-01-28 19:18:10.000000000 +0100
@@ -1108,7 +1108,7 @@
 /*
  * power management
  */
-static int snd_atiixp_suspend(snd_card_t *card, unsigned int state)
+static int snd_atiixp_suspend(snd_card_t *card, pm_message_t state)
 {
 	atiixp_t *chip = card->pm_private_data;
 	int i;
@@ -1122,7 +1122,7 @@
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(chip->pci, 3);
+	pci_set_power_state(chip->pci, PCI_D3hot);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1133,7 +1133,7 @@
 	int i;
 
 	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	pci_set_power_state(chip->pci, PCI_D0);
 	pci_set_master(chip->pci);
 
 	snd_atiixp_aclink_reset(chip);
--- clean/sound/pci/cs4281.c	2005-01-22 02:48:58.000000000 +0100
+++ linux/sound/pci/cs4281.c	2005-01-28 19:18:10.000000000 +0100
@@ -1376,7 +1376,7 @@
 
 static int snd_cs4281_chip_init(cs4281_t *chip); /* defined below */
 #ifdef CONFIG_PM
-static int cs4281_suspend(snd_card_t *card, unsigned int state);
+static int cs4281_suspend(snd_card_t *card, pm_message_t state);
 static int cs4281_resume(snd_card_t *card, unsigned int state);
 #endif
 
@@ -2037,7 +2037,7 @@
 
 #define CLKCR1_CKRA                             0x00010000L
 
-static int cs4281_suspend(snd_card_t *card, unsigned int state)
+static int cs4281_suspend(snd_card_t *card, pm_message_t state)
 {
 	cs4281_t *chip = card->pm_private_data;
 	u32 ulCLK;
--- clean/sound/pci/cs46xx/cs46xx_lib.c	2005-01-22 02:46:59.000000000 +0100
+++ linux/sound/pci/cs46xx/cs46xx_lib.c	2005-01-28 19:18:10.000000000 +0100
@@ -3704,7 +3704,7 @@
  * APM support
  */
 #ifdef CONFIG_PM
-static int snd_cs46xx_suspend(snd_card_t *card, unsigned int state)
+static int snd_cs46xx_suspend(snd_card_t *card, pm_message_t state)
 {
 	cs46xx_t *chip = card->pm_private_data;
 	int amp_saved;
--- clean/sound/pci/es1938.c	2005-01-22 02:48:28.000000000 +0100
+++ linux/sound/pci/es1938.c	2005-01-28 19:18:10.000000000 +0100
@@ -1381,7 +1381,7 @@
 };
 
 
-static int es1938_suspend(snd_card_t *card, unsigned int state)
+static int es1938_suspend(snd_card_t *card, pm_message_t state)
 {
 	es1938_t *chip = card->pm_private_data;
 	unsigned char *s, *d;
--- clean/sound/pci/es1968.c	2005-01-22 02:48:34.000000000 +0100
+++ linux/sound/pci/es1968.c	2005-01-19 11:59:14.000000000 +0100
@@ -2404,7 +2404,7 @@
 /*
  * PM support
  */
-static int es1968_suspend(snd_card_t *card, unsigned int state)
+static int es1968_suspend(snd_card_t *card, pm_message_t state)
 {
 	es1968_t *chip = card->pm_private_data;
 
--- clean/sound/pci/intel8x0.c	2005-01-22 02:48:22.000000000 +0100
+++ linux/sound/pci/intel8x0.c	2005-01-22 21:25:20.000000000 +0100
@@ -2309,7 +2309,7 @@
 /*
  * power management
  */
-static int intel8x0_suspend(snd_card_t *card, unsigned int state)
+static int intel8x0_suspend(snd_card_t *card, pm_message_t state)
 {
 	intel8x0_t *chip = card->pm_private_data;
 	int i;
--- clean/sound/pci/intel8x0m.c	2005-01-22 02:48:19.000000000 +0100
+++ linux/sound/pci/intel8x0m.c	2005-01-28 19:18:10.000000000 +0100
@@ -1078,7 +1078,7 @@
 /*
  * power management
  */
-static int intel8x0m_suspend(snd_card_t *card, unsigned int state)
+static int intel8x0m_suspend(snd_card_t *card, pm_message_t state)
 {
 	intel8x0_t *chip = card->pm_private_data;
 	int i;
--- clean/sound/pci/maestro3.c	2005-01-22 02:48:21.000000000 +0100
+++ linux/sound/pci/maestro3.c	2005-01-19 11:59:14.000000000 +0100
@@ -2385,7 +2385,7 @@
  * APM support
  */
 #ifdef CONFIG_PM
-static int m3_suspend(snd_card_t *card, unsigned int state)
+static int m3_suspend(snd_card_t *card, pm_message_t state)
 {
 	m3_t *chip = card->pm_private_data;
 	int i, index;
--- clean/sound/pci/nm256/nm256.c	2005-01-22 02:48:48.000000000 +0100
+++ linux/sound/pci/nm256/nm256.c	2005-01-28 19:18:10.000000000 +0100
@@ -1267,7 +1267,7 @@
  * APM event handler, so the card is properly reinitialized after a power
  * event.
  */
-static int nm256_suspend(snd_card_t *card, unsigned int state)
+static int nm256_suspend(snd_card_t *card, pm_message_t state)
 {
 	nm256_t *chip = card->pm_private_data;
 
--- clean/sound/pci/trident/trident_main.c	2005-01-22 02:48:28.000000000 +0100
+++ linux/sound/pci/trident/trident_main.c	2005-01-28 19:18:10.000000000 +0100
@@ -48,7 +48,7 @@
 static int snd_trident_pcm_mixer_free(trident_t *trident, snd_trident_voice_t * voice, snd_pcm_substream_t *substream);
 static irqreturn_t snd_trident_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 #ifdef CONFIG_PM
-static int snd_trident_suspend(snd_card_t *card, unsigned int state);
+static int snd_trident_suspend(snd_card_t *card, pm_message_t state);
 static int snd_trident_resume(snd_card_t *card, unsigned int state);
 #endif
 static int snd_trident_sis_reset(trident_t *trident);
@@ -3921,7 +3921,7 @@
 }
 
 #ifdef CONFIG_PM
-static int snd_trident_suspend(snd_card_t *card, unsigned int state)
+static int snd_trident_suspend(snd_card_t *card, pm_message_t state)
 {
 	trident_t *trident = card->pm_private_data;
 
--- clean/sound/pci/via82xx.c	2005-01-22 02:48:48.000000000 +0100
+++ linux/sound/pci/via82xx.c	2005-01-19 11:59:14.000000000 +0100
@@ -1895,7 +1895,7 @@
 /*
  * power management
  */
-static int snd_via82xx_suspend(snd_card_t *card, unsigned int state)
+static int snd_via82xx_suspend(snd_card_t *card, pm_message_t state)
 {
 	via82xx_t *chip = card->pm_private_data;
 	int i;
--- clean/sound/pci/via82xx_modem.c	2005-01-22 02:48:58.000000000 +0100
+++ linux/sound/pci/via82xx_modem.c	2005-01-28 19:18:10.000000000 +0100
@@ -1034,7 +1034,7 @@
 /*
  * power management
  */
-static int snd_via82xx_suspend(snd_card_t *card, unsigned int state)
+static int snd_via82xx_suspend(snd_card_t *card, pm_message_t state)
 {
 	via82xx_t *chip = card->pm_private_data;
 	int i;
--- clean/sound/pci/ymfpci/ymfpci_main.c	2005-01-22 02:48:48.000000000 +0100
+++ linux/sound/pci/ymfpci/ymfpci_main.c	2005-01-28 19:18:10.000000000 +0100
@@ -2142,7 +2142,7 @@
 };
 #define YDSXGR_NUM_SAVED_REGS	ARRAY_SIZE(saved_regs_index)
 
-static int snd_ymfpci_suspend(snd_card_t *card, unsigned int state)
+static int snd_ymfpci_suspend(snd_card_t *card, pm_message_t state)
 {
 	ymfpci_t *chip = card->pm_private_data;
 	unsigned int i;
--- clean/sound/pcmcia/pdaudiocf/pdaudiocf.c	2005-01-22 02:47:32.000000000 +0100
+++ linux/sound/pcmcia/pdaudiocf/pdaudiocf.c	2005-01-28 19:18:10.000000000 +0100
@@ -342,7 +342,7 @@
 		link->state |= DEV_SUSPEND;
 		if (chip) {
 			snd_printdd(KERN_DEBUG "snd_pdacf_suspend calling\n");
-			snd_pdacf_suspend(chip->card, 0);
+			snd_pdacf_suspend(chip->card, PMSG_SUSPEND);
 		}
 		/* Fall through... */
 	case CS_EVENT_RESET_PHYSICAL:
--- clean/sound/pcmcia/pdaudiocf/pdaudiocf.h	2005-01-22 02:46:44.000000000 +0100
+++ linux/sound/pcmcia/pdaudiocf/pdaudiocf.h	2005-01-28 19:18:10.000000000 +0100
@@ -134,7 +134,7 @@
 int snd_pdacf_ak4117_create(pdacf_t *pdacf);
 void snd_pdacf_powerdown(pdacf_t *chip);
 #ifdef CONFIG_PM
-int snd_pdacf_suspend(snd_card_t *card, unsigned int state);
+int snd_pdacf_suspend(snd_card_t *card, pm_message_t state);
 int snd_pdacf_resume(snd_card_t *card, unsigned int state);
 #endif
 int snd_pdacf_pcm_new(pdacf_t *chip);
--- clean/sound/pcmcia/pdaudiocf/pdaudiocf_core.c	2005-01-22 02:47:31.000000000 +0100
+++ linux/sound/pcmcia/pdaudiocf/pdaudiocf_core.c	2005-01-28 19:18:10.000000000 +0100
@@ -255,7 +255,7 @@
 
 #ifdef CONFIG_PM
 
-int snd_pdacf_suspend(snd_card_t *card, unsigned int state)
+int snd_pdacf_suspend(snd_card_t *card, pm_message_t state)
 {
 	pdacf_t *chip = card->pm_private_data;
 	u16 val;
--- clean/include/sound/core.h	2005-01-22 02:49:19.000000000 +0100
+++ linux/include/sound/core.h	2005-01-19 11:59:14.000000000 +0100
@@ -26,6 +26,7 @@
 #include <asm/semaphore.h>		/* struct semaphore */
 #include <linux/rwsem.h>		/* struct rw_semaphore */
 #include <linux/workqueue.h>		/* struct workqueue_struct */
+#include <linux/pm.h>			/* pm_message_t */
 
 /* Typedef's */
 typedef struct timespec snd_timestamp_t;
@@ -206,18 +207,18 @@
 	wake_up(&card->power_sleep);
 }
 int snd_card_set_pm_callback(snd_card_t *card,
-			     int (*suspend)(snd_card_t *, unsigned int),
+			     int (*suspend)(snd_card_t *, pm_message_t),
 			     int (*resume)(snd_card_t *, unsigned int),
 			     void *private_data);
 int snd_card_set_dev_pm_callback(snd_card_t *card, int type,
-				 int (*suspend)(snd_card_t *, unsigned int),
+				 int (*suspend)(snd_card_t *, pm_message_t),
 				 int (*resume)(snd_card_t *, unsigned int),
 				 void *private_data);
 #define snd_card_set_isa_pm_callback(card,suspend,resume,data) \
 	snd_card_set_dev_pm_callback(card, PM_ISA_DEV, suspend, resume, data)
 #ifdef CONFIG_PCI
 #ifndef SND_PCI_PM_CALLBACKS
-int snd_card_pci_suspend(struct pci_dev *dev, u32 state);
+int snd_card_pci_suspend(struct pci_dev *dev, pm_message_t state);
 int snd_card_pci_resume(struct pci_dev *dev);
 #define SND_PCI_PM_CALLBACKS \
 	.suspend = snd_card_pci_suspend,  .resume = snd_card_pci_resume

 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
