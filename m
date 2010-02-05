From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] sound: use DEFINE_PCI_DEVICE_TABLE
Date: Sat, 6 Feb 2010 00:21:03 +0200
Message-ID: <20100205222103.GA32410@x200>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f223.google.com (mail-fx0-f223.google.com
	[209.85.220.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 982371037FB
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 23:21:10 +0100 (CET)
Received: by fxm23 with SMTP id 23so1442552fxm.22
	for <alsa-devel@alsa-project.org>; Fri, 05 Feb 2010 14:21:10 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use DEFINE_PCI_DEVICE_TABLE() to make PCI device ids go to
.devinit.rodata section, so they can be discarded in some cases,
and make them const.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 sound/oss/kahlua.c                  |    2 +-
 sound/pci/ad1889.c                  |    2 +-
 sound/pci/ali5451/ali5451.c         |    2 +-
 sound/pci/als300.c                  |    2 +-
 sound/pci/als4000.c                 |    2 +-
 sound/pci/atiixp.c                  |    2 +-
 sound/pci/atiixp_modem.c            |    2 +-
 sound/pci/au88x0/au8810.c           |    2 +-
 sound/pci/au88x0/au8820.c           |    2 +-
 sound/pci/au88x0/au8830.c           |    2 +-
 sound/pci/aw2/aw2-alsa.c            |    2 +-
 sound/pci/azt3328.c                 |    2 +-
 sound/pci/bt87x.c                   |    4 ++--
 sound/pci/ca0106/ca0106_main.c      |    2 +-
 sound/pci/cmipci.c                  |    4 ++--
 sound/pci/cs4281.c                  |    2 +-
 sound/pci/cs46xx/cs46xx.c           |    2 +-
 sound/pci/cs5530.c                  |    2 +-
 sound/pci/cs5535audio/cs5535audio.c |    2 +-
 sound/pci/ctxfi/xfi.c               |    2 +-
 sound/pci/echoaudio/darla20.c       |    2 +-
 sound/pci/echoaudio/darla24.c       |    2 +-
 sound/pci/echoaudio/echo3g.c        |    2 +-
 sound/pci/echoaudio/gina20.c        |    2 +-
 sound/pci/echoaudio/gina24.c        |    2 +-
 sound/pci/echoaudio/indigo.c        |    2 +-
 sound/pci/echoaudio/indigodj.c      |    2 +-
 sound/pci/echoaudio/indigodjx.c     |    2 +-
 sound/pci/echoaudio/indigoio.c      |    2 +-
 sound/pci/echoaudio/indigoiox.c     |    2 +-
 sound/pci/echoaudio/layla20.c       |    2 +-
 sound/pci/echoaudio/layla24.c       |    2 +-
 sound/pci/echoaudio/mia.c           |    2 +-
 sound/pci/echoaudio/mona.c          |    2 +-
 sound/pci/emu10k1/emu10k1.c         |    2 +-
 sound/pci/emu10k1/emu10k1x.c        |    2 +-
 sound/pci/ens1370.c                 |    2 +-
 sound/pci/es1938.c                  |    2 +-
 sound/pci/es1968.c                  |    2 +-
 sound/pci/fm801.c                   |    2 +-
 sound/pci/hda/hda_intel.c           |    2 +-
 sound/pci/ice1712/ice1712.c         |    2 +-
 sound/pci/ice1712/ice1724.c         |    2 +-
 sound/pci/intel8x0.c                |    2 +-
 sound/pci/intel8x0m.c               |    2 +-
 sound/pci/korg1212/korg1212.c       |    2 +-
 sound/pci/lx6464es/lx6464es.c       |    2 +-
 sound/pci/maestro3.c                |    2 +-
 sound/pci/mixart/mixart.c           |    2 +-
 sound/pci/nm256/nm256.c             |    2 +-
 sound/pci/oxygen/hifier.c           |    2 +-
 sound/pci/oxygen/oxygen.c           |    2 +-
 sound/pci/oxygen/virtuoso.c         |    2 +-
 sound/pci/pcxhr/pcxhr.c             |    2 +-
 sound/pci/riptide/riptide.c         |    4 ++--
 sound/pci/rme32.c                   |    2 +-
 sound/pci/rme96.c                   |    2 +-
 sound/pci/rme9652/hdsp.c            |    2 +-
 sound/pci/rme9652/hdspm.c           |    2 +-
 sound/pci/rme9652/rme9652.c         |    2 +-
 sound/pci/sis7019.c                 |    2 +-
 sound/pci/sonicvibes.c              |    2 +-
 sound/pci/trident/trident.c         |    2 +-
 sound/pci/via82xx.c                 |    2 +-
 sound/pci/via82xx_modem.c           |    2 +-
 sound/pci/vx222/vx222.c             |    2 +-
 sound/pci/ymfpci/ymfpci.c           |    2 +-
 67 files changed, 70 insertions(+), 70 deletions(-)

--- a/sound/oss/kahlua.c
+++ b/sound/oss/kahlua.c
@@ -198,7 +198,7 @@ MODULE_LICENSE("GPL");
  *	5530 only. The 5510/5520 decode is different.
  */
 
-static struct pci_device_id id_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(id_tbl) = {
 	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5530_AUDIO), 0 },
 	{ }
 };
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -1048,7 +1048,7 @@ snd_ad1889_remove(struct pci_dev *pci)
 	pci_set_drvdata(pci, NULL);
 }
 
-static struct pci_device_id snd_ad1889_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_ad1889_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ANALOG_DEVICES, PCI_DEVICE_ID_AD1889JS) },
 	{ 0, },
 };
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -275,7 +275,7 @@ struct snd_ali {
 #endif
 };
 
-static struct pci_device_id snd_ali_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_ali_ids) = {
 	{PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5451), 0, 0, 0},
 	{0, }
 };
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -145,7 +145,7 @@ struct snd_als300_substream_data {
 	int block_counter_register;
 };
 
-static struct pci_device_id snd_als300_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_als300_ids) = {
 	{ 0x4005, 0x0300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_ALS300 },
 	{ 0x4005, 0x0308, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_ALS300_PLUS },
 	{ 0, }
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -117,7 +117,7 @@ struct snd_card_als4000 {
 #endif
 };
 
-static struct pci_device_id snd_als4000_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_als4000_ids) = {
 	{ 0x4005, 0x4000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* ALS4000 */
 	{ 0, }
 };
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -286,7 +286,7 @@ struct atiixp {
 
 /*
  */
-static struct pci_device_id snd_atiixp_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_atiixp_ids) = {
 	{ PCI_VDEVICE(ATI, 0x4341), 0 }, /* SB200 */
 	{ PCI_VDEVICE(ATI, 0x4361), 0 }, /* SB300 */
 	{ PCI_VDEVICE(ATI, 0x4370), 0 }, /* SB400 */
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -261,7 +261,7 @@ struct atiixp_modem {
 
 /*
  */
-static struct pci_device_id snd_atiixp_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_atiixp_ids) = {
 	{ PCI_VDEVICE(ATI, 0x434d), 0 }, /* SB200 */
 	{ PCI_VDEVICE(ATI, 0x4378), 0 }, /* SB400 */
 	{ 0, }
--- a/sound/pci/au88x0/au8810.c
+++ b/sound/pci/au88x0/au8810.c
@@ -1,6 +1,6 @@
 #include "au8810.h"
 #include "au88x0.h"
-static struct pci_device_id snd_vortex_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_vortex_ids) = {
 	{PCI_VDEVICE(AUREAL, PCI_DEVICE_ID_AUREAL_ADVANTAGE), 1,},
 	{0,}
 };
--- a/sound/pci/au88x0/au8820.c
+++ b/sound/pci/au88x0/au8820.c
@@ -1,6 +1,6 @@
 #include "au8820.h"
 #include "au88x0.h"
-static struct pci_device_id snd_vortex_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_vortex_ids) = {
 	{PCI_VDEVICE(AUREAL, PCI_DEVICE_ID_AUREAL_VORTEX_1), 0,},
 	{0,}
 };
--- a/sound/pci/au88x0/au8830.c
+++ b/sound/pci/au88x0/au8830.c
@@ -1,6 +1,6 @@
 #include "au8830.h"
 #include "au88x0.h"
-static struct pci_device_id snd_vortex_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_vortex_ids) = {
 	{PCI_VDEVICE(AUREAL, PCI_DEVICE_ID_AUREAL_VORTEX_2), 0,},
 	{0,}
 };
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -164,7 +164,7 @@ MODULE_PARM_DESC(id, "ID string for the Audiowerk2 soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable Audiowerk2 soundcard.");
 
-static struct pci_device_id snd_aw2_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_aw2_ids) = {
 	{PCI_VENDOR_ID_SAA7146, PCI_DEVICE_ID_SAA7146, 0, 0,
 	 0, 0, 0},
 	{0}
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -350,7 +350,7 @@ struct snd_azf3328 {
 #endif
 };
 
-static const struct pci_device_id snd_azf3328_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_azf3328_ids) = {
 	{ 0x122D, 0x50DC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },   /* PCI168/3328 */
 	{ 0x122D, 0x80DA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },   /* 3328 */
 	{ 0, }
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -795,7 +795,7 @@ fail:
 	  .driver_data = SND_BT87X_BOARD_ ## id }
 /* driver_data is the card id for that device */
 
-static struct pci_device_id snd_bt87x_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_bt87x_ids) = {
 	/* Hauppauge WinTV series */
 	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x0070, 0x13eb, GENERIC),
 	/* Hauppauge WinTV series */
@@ -964,7 +964,7 @@ static void __devexit snd_bt87x_remove(struct pci_dev *pci)
 
 /* default entries for all Bt87x cards - it's not exported */
 /* driver_data is set to 0 to call detection */
-static struct pci_device_id snd_bt87x_default_ids[] __devinitdata = {
+static DEFINE_PCI_DEVICE_TABLE(snd_bt87x_default_ids) = {
 	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, PCI_ANY_ID, PCI_ANY_ID, UNKNOWN),
 	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_879, PCI_ANY_ID, PCI_ANY_ID, UNKNOWN),
 	{ }
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1875,7 +1875,7 @@ static int snd_ca0106_resume(struct pci_dev *pci)
 #endif
 
 // PCI IDs
-static struct pci_device_id snd_ca0106_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_ca0106_ids) = {
 	{ PCI_VDEVICE(CREATIVE, 0x0007), 0 },	/* Audigy LS or Live 24bit */
 	{ 0, }
 };
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -2796,7 +2796,7 @@ static inline void snd_cmipci_proc_init(struct cmipci *cm) {}
 #endif
 
 
-static struct pci_device_id snd_cmipci_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_cmipci_ids) = {
 	{PCI_VDEVICE(CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8338A), 0},
 	{PCI_VDEVICE(CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8338B), 0},
 	{PCI_VDEVICE(CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8738), 0},
@@ -3018,7 +3018,7 @@ static int __devinit snd_cmipci_create(struct snd_card *card, struct pci_dev *pc
 	int integrated_midi = 0;
 	char modelstr[16];
 	int pcm_index, pcm_spdif_index;
-	static struct pci_device_id intel_82437vx[] = {
+	static DEFINE_PCI_DEVICE_TABLE(intel_82437vx) = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437VX) },
 		{ },
 	};
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -494,7 +494,7 @@ struct cs4281 {
 
 static irqreturn_t snd_cs4281_interrupt(int irq, void *dev_id);
 
-static struct pci_device_id snd_cs4281_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_cs4281_ids) = {
 	{ PCI_VDEVICE(CIRRUS, 0x6005), 0, },	/* CS4281 */
 	{ 0, }
 };
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -64,7 +64,7 @@ MODULE_PARM_DESC(thinkpad, "Force to enable Thinkpad's CLKRUN control.");
 module_param_array(mmap_valid, bool, NULL, 0444);
 MODULE_PARM_DESC(mmap_valid, "Support OSS mmap.");
 
-static struct pci_device_id snd_cs46xx_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_cs46xx_ids) = {
 	{ PCI_VDEVICE(CIRRUS, 0x6001), 0, },   /* CS4280 */
 	{ PCI_VDEVICE(CIRRUS, 0x6003), 0, },   /* CS4612 */
 	{ PCI_VDEVICE(CIRRUS, 0x6004), 0, },   /* CS4615 */
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -58,7 +58,7 @@ struct snd_cs5530 {
 	unsigned long pci_base;
 };
 
-static struct pci_device_id snd_cs5530_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_cs5530_ids) = {
 	{PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_AUDIO, PCI_ANY_ID,
 							PCI_ANY_ID, 0, 0},
 	{0,}
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -66,7 +66,7 @@ MODULE_PARM_DESC(id, "ID string for " DRIVER_NAME);
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable " DRIVER_NAME);
 
-static struct pci_device_id snd_cs5535audio_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_cs5535audio_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO) },
 	{}
--- a/sound/pci/ctxfi/xfi.c
+++ b/sound/pci/ctxfi/xfi.c
@@ -43,7 +43,7 @@ MODULE_PARM_DESC(enable, "Enable Creative X-Fi driver");
 module_param_array(subsystem, int, NULL, 0444);
 MODULE_PARM_DESC(subsystem, "Override subsystem ID for Creative X-Fi driver");
 
-static struct pci_device_id ct_pci_dev_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(ct_pci_dev_ids) = {
 	/* only X-Fi is supported, so... */
 	{ PCI_DEVICE(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K1),
 	  .driver_data = ATC20K1,
--- a/sound/pci/echoaudio/darla20.c
+++ b/sound/pci/echoaudio/darla20.c
@@ -63,7 +63,7 @@ static const struct firmware card_fw[] = {
 	{0, "darla20_dsp.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x1801, 0xECC0, 0x0010, 0, 0, 0},	/* DSP 56301 Darla20 rev.0 */
 	{0,}
 };
--- a/sound/pci/echoaudio/darla24.c
+++ b/sound/pci/echoaudio/darla24.c
@@ -67,7 +67,7 @@ static const struct firmware card_fw[] = {
 	{0, "darla24_dsp.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x1801, 0xECC0, 0x0040, 0, 0, 0},	/* DSP 56301 Darla24 rev.0 */
 	{0x1057, 0x1801, 0xECC0, 0x0041, 0, 0, 0},	/* DSP 56301 Darla24 rev.1 */
 	{0,}
--- a/sound/pci/echoaudio/echo3g.c
+++ b/sound/pci/echoaudio/echo3g.c
@@ -81,7 +81,7 @@ static const struct firmware card_fw[] = {
 	{0, "3g_asic.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x3410, 0xECC0, 0x0100, 0, 0, 0},	/* Echo 3G */
 	{0,}
 };
--- a/sound/pci/echoaudio/gina20.c
+++ b/sound/pci/echoaudio/gina20.c
@@ -67,7 +67,7 @@ static const struct firmware card_fw[] = {
 	{0, "gina20_dsp.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x1801, 0xECC0, 0x0020, 0, 0, 0},	/* DSP 56301 Gina20 rev.0 */
 	{0,}
 };
--- a/sound/pci/echoaudio/gina24.c
+++ b/sound/pci/echoaudio/gina24.c
@@ -85,7 +85,7 @@ static const struct firmware card_fw[] = {
 	{0, "gina24_361_asic.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x1801, 0xECC0, 0x0050, 0, 0, 0},	/* DSP 56301 Gina24 rev.0 */
 	{0x1057, 0x1801, 0xECC0, 0x0051, 0, 0, 0},	/* DSP 56301 Gina24 rev.1 */
 	{0x1057, 0x3410, 0xECC0, 0x0050, 0, 0, 0},	/* DSP 56361 Gina24 rev.0 */
--- a/sound/pci/echoaudio/indigo.c
+++ b/sound/pci/echoaudio/indigo.c
@@ -68,7 +68,7 @@ static const struct firmware card_fw[] = {
 	{0, "indigo_dsp.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x3410, 0xECC0, 0x0090, 0, 0, 0},	/* Indigo */
 	{0,}
 };
--- a/sound/pci/echoaudio/indigodj.c
+++ b/sound/pci/echoaudio/indigodj.c
@@ -68,7 +68,7 @@ static const struct firmware card_fw[] = {
 	{0, "indigo_dj_dsp.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x3410, 0xECC0, 0x00B0, 0, 0, 0},	/* Indigo DJ*/
 	{0,}
 };
--- a/sound/pci/echoaudio/indigodjx.c
+++ b/sound/pci/echoaudio/indigodjx.c
@@ -68,7 +68,7 @@ static const struct firmware card_fw[] = {
 	{0, "indigo_djx_dsp.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x3410, 0xECC0, 0x00E0, 0, 0, 0},	/* Indigo DJx*/
 	{0,}
 };
--- a/sound/pci/echoaudio/indigoio.c
+++ b/sound/pci/echoaudio/indigoio.c
@@ -69,7 +69,7 @@ static const struct firmware card_fw[] = {
 	{0, "indigo_io_dsp.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x3410, 0xECC0, 0x00A0, 0, 0, 0},	/* Indigo IO*/
 	{0,}
 };
--- a/sound/pci/echoaudio/indigoiox.c
+++ b/sound/pci/echoaudio/indigoiox.c
@@ -69,7 +69,7 @@ static const struct firmware card_fw[] = {
 	{0, "indigo_iox_dsp.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x3410, 0xECC0, 0x00D0, 0, 0, 0},	/* Indigo IOx */
 	{0,}
 };
--- a/sound/pci/echoaudio/layla20.c
+++ b/sound/pci/echoaudio/layla20.c
@@ -76,7 +76,7 @@ static const struct firmware card_fw[] = {
 	{0, "layla20_asic.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x1801, 0xECC0, 0x0030, 0, 0, 0},	/* DSP 56301 Layla20 rev.0 */
 	{0x1057, 0x1801, 0xECC0, 0x0031, 0, 0, 0},	/* DSP 56301 Layla20 rev.1 */
 	{0,}
--- a/sound/pci/echoaudio/layla24.c
+++ b/sound/pci/echoaudio/layla24.c
@@ -87,7 +87,7 @@ static const struct firmware card_fw[] = {
 	{0, "layla24_2S_asic.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x3410, 0xECC0, 0x0060, 0, 0, 0},	/* DSP 56361 Layla24 rev.0 */
 	{0,}
 };
--- a/sound/pci/echoaudio/mia.c
+++ b/sound/pci/echoaudio/mia.c
@@ -77,7 +77,7 @@ static const struct firmware card_fw[] = {
 	{0, "mia_dsp.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x3410, 0xECC0, 0x0080, 0, 0, 0},	/* DSP 56361 Mia rev.0 */
 	{0x1057, 0x3410, 0xECC0, 0x0081, 0, 0, 0},	/* DSP 56361 Mia rev.1 */
 	{0,}
--- a/sound/pci/echoaudio/mona.c
+++ b/sound/pci/echoaudio/mona.c
@@ -92,7 +92,7 @@ static const struct firmware card_fw[] = {
 	{0, "mona_2_asic.fw"}
 };
 
-static struct pci_device_id snd_echo_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_echo_ids) = {
 	{0x1057, 0x1801, 0xECC0, 0x0070, 0, 0, 0},	/* DSP 56301 Mona rev.0 */
 	{0x1057, 0x1801, 0xECC0, 0x0071, 0, 0, 0},	/* DSP 56301 Mona rev.1 */
 	{0x1057, 0x1801, 0xECC0, 0x0072, 0, 0, 0},	/* DSP 56301 Mona rev.2 */
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -76,7 +76,7 @@ MODULE_PARM_DESC(subsystem, "Force card subsystem model.");
 /*
  * Class 0401: 1102:0008 (rev 00) Subsystem: 1102:1001 -> Audigy2 Value  Model:SB0400
  */
-static struct pci_device_id snd_emu10k1_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_emu10k1_ids) = {
 	{ PCI_VDEVICE(CREATIVE, 0x0002), 0 },	/* EMU10K1 */
 	{ PCI_VDEVICE(CREATIVE, 0x0004), 1 },	/* Audigy */
 	{ PCI_VDEVICE(CREATIVE, 0x0008), 1 },	/* Audigy 2 Value SB0400 */
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1605,7 +1605,7 @@ static void __devexit snd_emu10k1x_remove(struct pci_dev *pci)
 }
 
 // PCI IDs
-static struct pci_device_id snd_emu10k1x_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_emu10k1x_ids) = {
 	{ PCI_VDEVICE(CREATIVE, 0x0006), 0 },	/* Dell OEM version (EMU10K1) */
 	{ 0, }
 };
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -443,7 +443,7 @@ struct ensoniq {
 
 static irqreturn_t snd_audiopci_interrupt(int irq, void *dev_id);
 
-static struct pci_device_id snd_audiopci_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_audiopci_ids) = {
 #ifdef CHIP1370
 	{ PCI_VDEVICE(ENSONIQ, 0x5000), 0, },	/* ES1370 */
 #endif
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -243,7 +243,7 @@ struct es1938 {
 
 static irqreturn_t snd_es1938_interrupt(int irq, void *dev_id);
 
-static struct pci_device_id snd_es1938_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_es1938_ids) = {
 	{ PCI_VDEVICE(ESS, 0x1969), 0, },   /* Solo-1 */
 	{ 0, }
 };
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -551,7 +551,7 @@ struct es1968 {
 
 static irqreturn_t snd_es1968_interrupt(int irq, void *dev_id);
 
-static struct pci_device_id snd_es1968_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_es1968_ids) = {
 	/* Maestro 1 */
         { 0x1285, 0x0100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, TYPE_MAESTRO },
 	/* Maestro 2 */
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -205,7 +205,7 @@ struct fm801 {
 #endif
 };
 
-static struct pci_device_id snd_fm801_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_fm801_ids) = {
 	{ 0x1319, 0x0801, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 0, },   /* FM801 */
 	{ 0x5213, 0x0510, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 0, },   /* Gallant Odyssey Sound 4 */
 	{ 0, }
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2664,7 +2664,7 @@ static void __devexit azx_remove(struct pci_dev *pci)
 }
 
 /* PCI IDs */
-static struct pci_device_id azx_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	/* ICH 6..10 */
 	{ PCI_DEVICE(0x8086, 0x2668), .driver_data = AZX_DRIVER_ICH },
 	{ PCI_DEVICE(0x8086, 0x27d8), .driver_data = AZX_DRIVER_ICH },
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -106,7 +106,7 @@ module_param_array(dxr_enable, int, NULL, 0444);
 MODULE_PARM_DESC(dxr_enable, "Enable DXR support for Terratec DMX6FIRE.");
 
 
-static const struct pci_device_id snd_ice1712_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_ice1712_ids) = {
 	{ PCI_VDEVICE(ICE, PCI_DEVICE_ID_ICE_1712), 0 },   /* ICE1712 */
 	{ 0, }
 };
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -94,7 +94,7 @@ MODULE_PARM_DESC(model, "Use the given board model.");
 
 
 /* Both VT1720 and VT1724 have the same PCI IDs */
-static const struct pci_device_id snd_vt1724_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_vt1724_ids) = {
 	{ PCI_VDEVICE(ICE, PCI_DEVICE_ID_VT1724), 0 },
 	{ 0, }
 };
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -420,7 +420,7 @@ struct intel8x0 {
 	u32 int_sta_mask;		/* interrupt status mask */
 };
 
-static struct pci_device_id snd_intel8x0_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_intel8x0_ids) = {
 	{ PCI_VDEVICE(INTEL, 0x2415), DEVICE_INTEL },	/* 82801AA */
 	{ PCI_VDEVICE(INTEL, 0x2425), DEVICE_INTEL },	/* 82901AB */
 	{ PCI_VDEVICE(INTEL, 0x2445), DEVICE_INTEL },	/* 82801BA */
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -219,7 +219,7 @@ struct intel8x0m {
 	unsigned int pcm_pos_shift;
 };
 
-static struct pci_device_id snd_intel8x0m_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_intel8x0m_ids) = {
 	{ PCI_VDEVICE(INTEL, 0x2416), DEVICE_INTEL },	/* 82801AA */
 	{ PCI_VDEVICE(INTEL, 0x2426), DEVICE_INTEL },	/* 82901AB */
 	{ PCI_VDEVICE(INTEL, 0x2446), DEVICE_INTEL },	/* 82801BA */
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -418,7 +418,7 @@ module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable Korg 1212 soundcard.");
 MODULE_AUTHOR("Haroldo Gamal <gamal@alternex.com.br>");
 
-static struct pci_device_id snd_korg1212_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_korg1212_ids) = {
 	{
 		.vendor	   = 0x10b5,
 		.device	   = 0x906d,
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -55,7 +55,7 @@ static const char card_name[] = "LX6464ES";
 
 #define PCI_DEVICE_ID_PLX_LX6464ES		PCI_DEVICE_ID_PLX_9056
 
-static struct pci_device_id snd_lx6464es_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_lx6464es_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_LX6464ES),
 	  .subvendor = PCI_VENDOR_ID_DIGIGRAM,
 	  .subdevice = PCI_SUBDEVICE_ID_DIGIGRAM_LX6464ES_SERIAL_SUBSYSTEM
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -861,7 +861,7 @@ struct snd_m3 {
 /*
  * pci ids
  */
-static struct pci_device_id snd_m3_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_m3_ids) = {
 	{PCI_VENDOR_ID_ESS, PCI_DEVICE_ID_ESS_ALLEGRO_1, PCI_ANY_ID, PCI_ANY_ID,
 	 PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 0},
 	{PCI_VENDOR_ID_ESS, PCI_DEVICE_ID_ESS_ALLEGRO, PCI_ANY_ID, PCI_ANY_ID,
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -60,7 +60,7 @@ MODULE_PARM_DESC(enable, "Enable Digigram " CARD_NAME " soundcard.");
 /*
  */
 
-static struct pci_device_id snd_mixart_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_mixart_ids) = {
 	{ PCI_VDEVICE(MOTOROLA, 0x0003), 0, }, /* MC8240 */
 	{ 0, }
 };
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -262,7 +262,7 @@ struct nm256 {
 /*
  * PCI ids
  */
-static struct pci_device_id snd_nm256_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_nm256_ids) = {
 	{PCI_VDEVICE(NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO), 0},
 	{PCI_VDEVICE(NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO), 0},
 	{PCI_VDEVICE(NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256XL_PLUS_AUDIO), 0},
--- a/sound/pci/oxygen/hifier.c
+++ b/sound/pci/oxygen/hifier.c
@@ -48,7 +48,7 @@ MODULE_PARM_DESC(id, "ID string");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "enable card");
 
-static struct pci_device_id hifier_ids[] __devinitdata = {
+static DEFINE_PCI_DEVICE_TABLE(hifier_ids) = {
 	{ OXYGEN_PCI_SUBID(0x14c3, 0x1710) },
 	{ OXYGEN_PCI_SUBID(0x14c3, 0x1711) },
 	{ OXYGEN_PCI_SUBID_BROKEN_EEPROM },
--- a/sound/pci/oxygen/oxygen.c
+++ b/sound/pci/oxygen/oxygen.c
@@ -72,7 +72,7 @@ enum {
 	MODEL_CLARO_HALO,	/* HT-Omega Claro halo */
 };
 
-static struct pci_device_id oxygen_ids[] __devinitdata = {
+static DEFINE_PCI_DEVICE_TABLE(oxygen_ids) = {
 	{ OXYGEN_PCI_SUBID(0x10b0, 0x0216), .driver_data = MODEL_CMEDIA_REF },
 	{ OXYGEN_PCI_SUBID(0x10b0, 0x0218), .driver_data = MODEL_CMEDIA_REF },
 	{ OXYGEN_PCI_SUBID(0x10b0, 0x0219), .driver_data = MODEL_CMEDIA_REF },
--- a/sound/pci/oxygen/virtuoso.c
+++ b/sound/pci/oxygen/virtuoso.c
@@ -40,7 +40,7 @@ MODULE_PARM_DESC(id, "ID string");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "enable card");
 
-static struct pci_device_id xonar_ids[] __devinitdata = {
+static DEFINE_PCI_DEVICE_TABLE(xonar_ids) = {
 	{ OXYGEN_PCI_SUBID(0x1043, 0x8269) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x8275) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x82b7) },
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -94,7 +94,7 @@ enum {
 	PCI_ID_LAST
 };
 
-static struct pci_device_id pcxhr_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(pcxhr_ids) = {
 	{ 0x10b5, 0x9656, 0x1369, 0xb001, 0, 0, PCI_ID_VX882HR, },
 	{ 0x10b5, 0x9656, 0x1369, 0xb101, 0, 0, PCI_ID_PCX882HR, },
 	{ 0x10b5, 0x9656, 0x1369, 0xb201, 0, 0, PCI_ID_VX881HR, },
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -506,7 +506,7 @@ static int riptide_reset(struct cmdif *cif, struct snd_riptide *chip);
 /*
  */
 
-static struct pci_device_id snd_riptide_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_riptide_ids) = {
 	{ PCI_DEVICE(0x127a, 0x4310) },
 	{ PCI_DEVICE(0x127a, 0x4320) },
 	{ PCI_DEVICE(0x127a, 0x4330) },
@@ -515,7 +515,7 @@ static struct pci_device_id snd_riptide_ids[] = {
 };
 
 #ifdef SUPPORT_JOYSTICK
-static struct pci_device_id snd_riptide_joystick_ids[] __devinitdata = {
+static DEFINE_PCI_DEVICE_TABLE(snd_riptide_joystick_ids) = {
 	{ PCI_DEVICE(0x127a, 0x4312) },
 	{ PCI_DEVICE(0x127a, 0x4322) },
 	{ PCI_DEVICE(0x127a, 0x4332) },
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -226,7 +226,7 @@ struct rme32 {
 	struct snd_kcontrol *spdif_ctl;
 };
 
-static struct pci_device_id snd_rme32_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_rme32_ids) = {
 	{PCI_VDEVICE(XILINX_RME, PCI_DEVICE_ID_RME_DIGI32), 0,},
 	{PCI_VDEVICE(XILINX_RME, PCI_DEVICE_ID_RME_DIGI32_8), 0,},
 	{PCI_VDEVICE(XILINX_RME, PCI_DEVICE_ID_RME_DIGI32_PRO), 0,},
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -231,7 +231,7 @@ struct rme96 {
 	struct snd_kcontrol   *spdif_ctl;
 };
 
-static struct pci_device_id snd_rme96_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_rme96_ids) = {
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_RME_DIGI96), 0, },
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_RME_DIGI96_8), 0, },
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_RME_DIGI96_8_PRO), 0, },
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -585,7 +585,7 @@ static void snd_hammerfall_free_buffer(struct snd_dma_buffer *dmab, struct pci_d
 }
 
 
-static struct pci_device_id snd_hdsp_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_hdsp_ids) = {
 	{
 		.vendor = PCI_VENDOR_ID_XILINX,
 		.device = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP,
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -512,7 +512,7 @@ static char channel_map_madi_ss[HDSPM_MAX_CHANNELS] = {
 };
 
 
-static struct pci_device_id snd_hdspm_ids[] __devinitdata = {
+static DEFINE_PCI_DEVICE_TABLE(snd_hdspm_ids) = {
 	{
 	 .vendor = PCI_VENDOR_ID_XILINX,
 	 .device = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP_MADI,
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -314,7 +314,7 @@ static void snd_hammerfall_free_buffer(struct snd_dma_buffer *dmab, struct pci_d
 }
 
 
-static struct pci_device_id snd_rme9652_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_rme9652_ids) = {
 	{
 		.vendor	   = 0x10ee,
 		.device	   = 0x3fc4,
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -48,7 +48,7 @@ MODULE_PARM_DESC(id, "ID string for SiS7019 Audio Accelerator.");
 module_param(enable, bool, 0444);
 MODULE_PARM_DESC(enable, "Enable SiS7019 Audio Accelerator.");
 
-static struct pci_device_id snd_sis7019_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_sis7019_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x7019) },
 	{ 0, }
 };
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -242,7 +242,7 @@ struct sonicvibes {
 #endif
 };
 
-static struct pci_device_id snd_sonic_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_sonic_ids) = {
 	{ PCI_VDEVICE(S3, 0xca00), 0, },
         { 0, }
 };
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -62,7 +62,7 @@ MODULE_PARM_DESC(pcm_channels, "Number of hardware channels assigned for PCM.");
 module_param_array(wavetable_size, int, NULL, 0444);
 MODULE_PARM_DESC(wavetable_size, "Maximum memory size in kB for wavetable synth.");
 
-static struct pci_device_id snd_trident_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_trident_ids) = {
 	{PCI_DEVICE(PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_DX), 
 		PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 0},
 	{PCI_DEVICE(PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_NX), 
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -401,7 +401,7 @@ struct via82xx {
 #endif
 };
 
-static struct pci_device_id snd_via82xx_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_via82xx_ids) = {
 	/* 0x1106, 0x3058 */
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C686_5), TYPE_CARD_VIA686, },	/* 686A */
 	/* 0x1106, 0x3059 */
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -260,7 +260,7 @@ struct via82xx_modem {
 	struct snd_info_entry *proc_entry;
 };
 
-static struct pci_device_id snd_via82xx_modem_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_via82xx_modem_ids) = {
 	{ PCI_VDEVICE(VIA, 0x3068), TYPE_CARD_VIA82XX_MODEM, },
 	{ 0, }
 };
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -60,7 +60,7 @@ enum {
 	VX_PCI_VX222_NEW
 };
 
-static struct pci_device_id snd_vx222_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_vx222_ids) = {
 	{ 0x10b5, 0x9050, 0x1369, PCI_ANY_ID, 0, 0, VX_PCI_VX222_OLD, },   /* PLX */
 	{ 0x10b5, 0x9030, 0x1369, PCI_ANY_ID, 0, 0, VX_PCI_VX222_NEW, },   /* PLX */
 	{ 0, }
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -66,7 +66,7 @@ MODULE_PARM_DESC(joystick_port, "Joystick port address");
 module_param_array(rear_switch, bool, NULL, 0444);
 MODULE_PARM_DESC(rear_switch, "Enable shared rear/line-in switch");
 
-static struct pci_device_id snd_ymfpci_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(snd_ymfpci_ids) = {
 	{ PCI_VDEVICE(YAMAHA, 0x0004), 0, },   /* YMF724 */
 	{ PCI_VDEVICE(YAMAHA, 0x000d), 0, },   /* YMF724F */
 	{ PCI_VDEVICE(YAMAHA, 0x000a), 0, },   /* YMF740 */
