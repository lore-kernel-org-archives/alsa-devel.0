From: jayakumar.alsa@gmail.com
Subject: [PATCH 2.6.16 1/1] ALSA: PM support for cs5535audio
Date: Fri, 14 Apr 2006 14:14:16 +0800
Message-ID: <200604140614.k3E6EGx1004297@ns1.clipsalportal.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi, Jaroslav, ALSA folk,

This is the same patch as yesterday except the change to add
SNDRV_PCM_INFO_RESUME to pcm->info as per Takashi's feedback.

Please let me know if it looks okay and if you have any feedback 
or suggestions.

Thanks,
Jaya Kumar

Signed-off-by: Jaya Kumar <jayakumar.alsa@gmail.com>

---

 Kconfig                       |    9 ++-
 cs5535audio/Makefile          |    4 +
 cs5535audio/cs5535audio.c     |   31 ++++++++--
 cs5535audio/cs5535audio.h     |    8 ++
 cs5535audio/cs5535audio_pcm.c |   24 +++++++-
 cs5535audio/cs5535audio_pm.c  |  123 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 191 insertions(+), 8 deletions(-)

---

diff -X linux-2.6.16/Documentation/dontdiff -uprN linux-2.6.16-vanilla/sound/pci/cs5535audio/cs5535audio.c linux-2.6.16/sound/pci/cs5535audio/cs5535audio.c
--- linux-2.6.16-vanilla/sound/pci/cs5535audio/cs5535audio.c	2006-03-24 22:55:13.000000000 +0800
+++ linux-2.6.16/sound/pci/cs5535audio/cs5535audio.c	2006-04-13 11:25:41.000000000 +0800
@@ -1,5 +1,5 @@
 /*
- * Driver for audio on multifunction CS5535 companion device
+ * Driver for audio on multifunction CS5535/6 companion device
  * Copyright (C) Jaya Kumar
  *
  * Based on Jaroslav Kysela and Takashi Iwai's examples.
@@ -40,16 +40,29 @@
 
 #define DRIVER_NAME "cs5535audio"
 
+static char *ac97_quirk;
+module_param(ac97_quirk, charp, 0444);
+MODULE_PARM_DESC(ac97_quirk, "AC'97 board specific workarounds.");
+
+static struct ac97_quirk ac97_quirks[] __devinitdata = {
+#if 0 /* Not yet confirmed if all 5536 boards are HP only */
+	{
+		.subvendor = PCI_VENDOR_ID_AMD, 
+		.subdevice = PCI_DEVICE_ID_AMD_CS5536_AUDIO, 
+		.name = "AMD RDK",     
+		.type = AC97_TUNE_HP_ONLY
+	},
+#endif
+	{}
+};
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 
 static struct pci_device_id snd_cs5535audio_ids[] = {
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
-	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO) },
 	{}
 };
 
@@ -148,6 +161,8 @@ static int snd_cs5535audio_mixer(struct 
 		return err;
 	}
 
+	snd_ac97_tune_hardware(cs5535au->ac97, ac97_quirks, ac97_quirk);
+
 	return 0;
 }
 
@@ -347,6 +362,8 @@ static int __devinit snd_cs5535audio_pro
 	if ((err = snd_cs5535audio_create(card, pci, &cs5535au)) < 0)
 		goto probefail_out;
 
+	card->private_data = cs5535au;
+
 	if ((err = snd_cs5535audio_mixer(cs5535au)) < 0)
 		goto probefail_out;
 
@@ -383,6 +400,10 @@ static struct pci_driver driver = {
 	.id_table = snd_cs5535audio_ids,
 	.probe = snd_cs5535audio_probe,
 	.remove = __devexit_p(snd_cs5535audio_remove),
+#ifdef CONFIG_PM
+	.suspend = snd_cs5535audio_suspend,
+	.resume = snd_cs5535audio_resume,
+#endif
 };
 
 static int __init alsa_card_cs5535audio_init(void)
diff -X linux-2.6.16/Documentation/dontdiff -uprN linux-2.6.16-vanilla/sound/pci/cs5535audio/cs5535audio.h linux-2.6.16/sound/pci/cs5535audio/cs5535audio.h
--- linux-2.6.16-vanilla/sound/pci/cs5535audio/cs5535audio.h	2006-03-24 22:55:13.000000000 +0800
+++ linux-2.6.16/sound/pci/cs5535audio/cs5535audio.h	2006-03-25 20:54:59.000000000 +0800
@@ -74,6 +74,8 @@
 #define PRM_RDY_STS			0x00800000
 #define ACC_CODEC_CNTL_WR_CMD		(~0x80000000)
 #define ACC_CODEC_CNTL_RD_CMD		0x80000000
+#define ACC_CODEC_CNTL_LNK_SHUTDOWN	0x00040000
+#define ACC_CODEC_CNTL_LNK_WRM_RST	0x00020000
 #define PRD_JMP				0x2000
 #define PRD_EOP				0x4000
 #define PRD_EOT				0x8000
@@ -88,6 +90,7 @@ struct cs5535audio_dma_ops {
 	void (*disable_dma)(struct cs5535audio *cs5535au);
 	void (*pause_dma)(struct cs5535audio *cs5535au);
 	void (*setup_prd)(struct cs5535audio *cs5535au, u32 prd_addr);
+	u32 (*read_prd)(struct cs5535audio *cs5535au);
 	u32 (*read_dma_pntr)(struct cs5535audio *cs5535au);
 };
 
@@ -103,11 +106,14 @@ struct cs5535audio_dma {
 	struct snd_pcm_substream *substream;
 	unsigned int buf_addr, buf_bytes;
 	unsigned int period_bytes, periods;
+	int suspended;
+	u32 saved_prd;
 };
 
 struct cs5535audio {
 	struct snd_card *card;
 	struct snd_ac97 *ac97;
+	struct snd_pcm *pcm;
 	int irq;
 	struct pci_dev *pci;
 	unsigned long port;
@@ -117,6 +123,8 @@ struct cs5535audio {
 	struct cs5535audio_dma dmas[NUM_CS5535AUDIO_DMAS];
 };
 
+int snd_cs5535audio_suspend(struct pci_dev *pci, pm_message_t state);
+int snd_cs5535audio_resume(struct pci_dev *pci);
 int __devinit snd_cs5535audio_pcm(struct cs5535audio *cs5535audio);
 
 #endif /* __SOUND_CS5535AUDIO_H */
diff -X linux-2.6.16/Documentation/dontdiff -uprN linux-2.6.16-vanilla/sound/pci/cs5535audio/cs5535audio_pcm.c linux-2.6.16/sound/pci/cs5535audio/cs5535audio_pcm.c
--- linux-2.6.16-vanilla/sound/pci/cs5535audio/cs5535audio_pcm.c	2006-03-24 22:55:13.000000000 +0800
+++ linux-2.6.16/sound/pci/cs5535audio/cs5535audio_pcm.c	2006-04-14 10:55:06.000000000 +0800
@@ -43,7 +43,8 @@ static struct snd_pcm_hardware snd_cs553
 		 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 		SNDRV_PCM_INFO_MMAP_VALID |
 		 		SNDRV_PCM_INFO_PAUSE |
-				SNDRV_PCM_INFO_SYNC_START
+				SNDRV_PCM_INFO_SYNC_START |
+				SNDRV_PCM_INFO_RESUME
 				),
 	.formats =		(
 				SNDRV_PCM_FMTBIT_S16_LE
@@ -193,6 +194,11 @@ static void cs5535audio_playback_setup_p
 	cs_writel(cs5535au, ACC_BM0_PRD, prd_addr);
 }
 
+static u32 cs5535audio_playback_read_prd(struct cs5535audio *cs5535au)
+{
+	return cs_readl(cs5535au, ACC_BM0_PRD);
+}
+
 static u32 cs5535audio_playback_read_dma_pntr(struct cs5535audio *cs5535au)
 {
 	return cs_readl(cs5535au, ACC_BM0_PNTR);
@@ -219,6 +225,11 @@ static void cs5535audio_capture_setup_pr
 	cs_writel(cs5535au, ACC_BM1_PRD, prd_addr);
 }
 
+static u32 cs5535audio_capture_read_prd(struct cs5535audio *cs5535au)
+{
+	return cs_readl(cs5535au, ACC_BM1_PRD);
+}
+
 static u32 cs5535audio_capture_read_dma_pntr(struct cs5535audio *cs5535au)
 {
 	return cs_readl(cs5535au, ACC_BM1_PNTR);
@@ -285,9 +296,17 @@ static int snd_cs5535audio_trigger(struc
 	case SNDRV_PCM_TRIGGER_START:
 		dma->ops->enable_dma(cs5535au);
 		break;
+	case SNDRV_PCM_TRIGGER_RESUME:
+		dma->ops->enable_dma(cs5535au);
+		dma->suspended = 0;
+		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		dma->ops->disable_dma(cs5535au);
 		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		dma->ops->disable_dma(cs5535au);
+		dma->suspended = 1;
+		break;
 	default:
 		snd_printk(KERN_ERR "unhandled trigger\n");
 		err = -EINVAL;
@@ -375,6 +394,7 @@ static struct cs5535audio_dma_ops snd_cs
         .enable_dma = cs5535audio_playback_enable_dma,
         .disable_dma = cs5535audio_playback_disable_dma,
         .setup_prd = cs5535audio_playback_setup_prd,
+        .read_prd = cs5535audio_playback_read_prd,
         .pause_dma = cs5535audio_playback_pause_dma,
         .read_dma_pntr = cs5535audio_playback_read_dma_pntr,
 };
@@ -384,6 +404,7 @@ static struct cs5535audio_dma_ops snd_cs
         .enable_dma = cs5535audio_capture_enable_dma,
         .disable_dma = cs5535audio_capture_disable_dma,
         .setup_prd = cs5535audio_capture_setup_prd,
+        .read_prd = cs5535audio_capture_read_prd,
         .pause_dma = cs5535audio_capture_pause_dma,
         .read_dma_pntr = cs5535audio_capture_read_dma_pntr,
 };
@@ -413,6 +434,7 @@ int __devinit snd_cs5535audio_pcm(struct
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					snd_dma_pci_data(cs5535au->pci),
 					64*1024, 128*1024);
+	cs5535au->pcm = pcm;
 
 	return 0;
 }
diff -X linux-2.6.16/Documentation/dontdiff -uprN linux-2.6.16-vanilla/sound/pci/cs5535audio/cs5535audio_pm.c linux-2.6.16/sound/pci/cs5535audio/cs5535audio_pm.c
--- linux-2.6.16-vanilla/sound/pci/cs5535audio/cs5535audio_pm.c	1970-01-01 07:30:00.000000000 +0730
+++ linux-2.6.16/sound/pci/cs5535audio/cs5535audio_pm.c	2006-04-14 10:54:14.000000000 +0800
@@ -0,0 +1,123 @@
+/*
+ * Power management for audio on multifunction CS5535 companion device
+ * Copyright (C) Jaya Kumar
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/initval.h>
+#include <sound/asoundef.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include "cs5535audio.h"
+
+static void snd_cs5535audio_stop_hardware(struct cs5535audio *cs5535au)
+{
+	/* 
+	we depend on snd_ac97_suspend to tell the
+	AC97 codec to shutdown. the amd spec suggests
+	that the LNK_SHUTDOWN be done at the same time
+	that the codec power-down is issued. instead,
+	we do it just after rather than at the same 
+	time. excluding codec specific build_ops->suspend
+	ac97 powerdown hits:
+	0x8000 EAPD 
+	0x4000 Headphone amplifier 
+	0x0300 ADC & DAC 
+	0x0400 Analog Mixer powerdown (Vref on) 
+	I am not sure if this is the best that we can do.
+	The remainder to be investigated are:
+	- analog mixer (vref off) 0x0800
+	- AC-link powerdown 0x1000
+	- codec internal clock 0x2000
+	*/
+
+	/* set LNK_SHUTDOWN to shutdown AC link */
+	cs_writel(cs5535au, ACC_CODEC_CNTL, ACC_CODEC_CNTL_LNK_SHUTDOWN);
+
+}
+
+int snd_cs5535audio_suspend(struct pci_dev *pci, pm_message_t state)
+{
+	struct snd_card *card = pci_get_drvdata(pci);
+	struct cs5535audio *cs5535au = card->private_data;
+	int i;
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	for (i = 0; i < NUM_CS5535AUDIO_DMAS; i++) {
+		struct cs5535audio_dma *dma = &cs5535au->dmas[i];
+		if (dma && dma->substream && !dma->suspended) 
+			dma->saved_prd = dma->ops->read_prd(cs5535au);
+	}
+	snd_pcm_suspend_all(cs5535au->pcm);
+	snd_ac97_suspend(cs5535au->ac97);
+	/* save important regs, then disable aclink in hw */
+	snd_cs5535audio_stop_hardware(cs5535au);
+	pci_disable_device(pci);
+	pci_save_state(pci);
+
+	return 0;
+}
+
+int snd_cs5535audio_resume(struct pci_dev *pci)
+{
+	struct snd_card *card = pci_get_drvdata(pci);
+	struct cs5535audio *cs5535au = card->private_data;
+	u32 tmp;
+	int timeout;
+	int i;
+
+	pci_restore_state(pci);
+	pci_enable_device(pci);
+	pci_set_master(pci);
+
+	/* set LNK_WRM_RST to reset AC link */
+	cs_writel(cs5535au, ACC_CODEC_CNTL, ACC_CODEC_CNTL_LNK_WRM_RST);
+
+	timeout = 50;
+	do {
+		tmp = cs_readl(cs5535au, ACC_CODEC_STATUS);
+		if (tmp & PRM_RDY_STS)
+			break;
+		udelay(1);
+	} while (--timeout);
+
+	if (!timeout)
+		snd_printk(KERN_ERR "Failure getting AC Link ready\n");
+
+	/* we depend on ac97 to perform the codec power up */
+	snd_ac97_resume(cs5535au->ac97);
+	/* set up rate regs, dma. actual initiation is done in trig */
+	for (i = 0; i < NUM_CS5535AUDIO_DMAS; i++) {
+		struct cs5535audio_dma *dma = &cs5535au->dmas[i];
+		if (dma && dma->substream && dma->suspended) {
+			dma->substream->ops->prepare(dma->substream);
+			dma->ops->setup_prd(cs5535au, dma->saved_prd);
+		}
+	}
+		
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+
+	return 0;
+}
+
diff -X linux-2.6.16/Documentation/dontdiff -uprN linux-2.6.16-vanilla/sound/pci/cs5535audio/Makefile linux-2.6.16/sound/pci/cs5535audio/Makefile
--- linux-2.6.16-vanilla/sound/pci/cs5535audio/Makefile	2006-03-24 22:55:13.000000000 +0800
+++ linux-2.6.16/sound/pci/cs5535audio/Makefile	2006-03-26 19:29:27.000000000 +0800
@@ -4,5 +4,9 @@
 
 snd-cs5535audio-objs := cs5535audio.o cs5535audio_pcm.o
 
+ifdef CONFIG_PM
+snd-cs5535audio-objs += cs5535audio_pm.o
+endif
+
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_CS5535AUDIO) += snd-cs5535audio.o
diff -X linux-2.6.16/Documentation/dontdiff -uprN linux-2.6.16-vanilla/sound/pci/Kconfig linux-2.6.16/sound/pci/Kconfig
--- linux-2.6.16-vanilla/sound/pci/Kconfig	2006-03-24 22:55:13.000000000 +0800
+++ linux-2.6.16/sound/pci/Kconfig	2006-04-13 11:28:52.000000000 +0800
@@ -203,14 +203,19 @@ config SND_CS46XX_NEW_DSP
 	  This works better than the old code, so say Y.
 
 config SND_CS5535AUDIO
-	tristate "CS5535 Audio"
+	tristate "CS5535/CS5536 Audio"
 	depends on SND && X86 && !X86_64
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
 	  Say Y here to include support for audio on CS5535 chips. It is
 	  referred to as NS CS5535 IO or AMD CS5535 IO companion in
-	  various literature.
+	  various literature. This driver also supports the CS5536 audio
+	  device. However, for both chips, on certain boards, you may
+	  need to use ac97_quirk=hp_only if your board has physically 
+	  mapped headphone out to master output. If that works for you,
+	  send lspci -vvv output to the mailing list so that your board
+	  can be identified in the quirks list.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-cs5535audio.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
