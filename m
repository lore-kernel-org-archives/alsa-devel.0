From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA - hda: Add support for parsing new HDA
	capabilities" to the asoc tree
Date: Tue, 09 Aug 2016 13:44:12 +0100
Message-ID: <E1bX6OC-0003dB-Ov@debutante>
References: <1470305764-20802-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FD27267D19
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 14:44:19 +0200 (CEST)
In-Reply-To: <1470305764-20802-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA - hda: Add support for parsing new HDA capabilities

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 50279d9b5facde811280afe13dd8c79f0e7b21ed Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Thu, 4 Aug 2016 15:46:03 +0530
Subject: [PATCH] ALSA - hda: Add support for parsing new HDA capabilities

Skylake onwards HDA controller supports new capabilities like
Global Time Stamping (GTS) capability. So add support to parse
these new capabilities.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_register.h   | 36 ++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.c |  5 +++++
 sound/pci/hda/hda_controller.h |  3 +++
 sound/pci/hda/hda_intel.c      | 17 +++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index ff1aecf325e8..0013063db7f2 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -89,6 +89,19 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_REG_SD_BDLPL		0x18
 #define AZX_REG_SD_BDLPU		0x1c
 
+/* GTS registers */
+#define AZX_REG_LLCH			0x14
+
+#define AZX_REG_GTS_BASE		0x520
+
+#define AZX_REG_GTSCC	(AZX_REG_GTS_BASE + 0x00)
+#define AZX_REG_WALFCC	(AZX_REG_GTS_BASE + 0x04)
+#define AZX_REG_TSCCL	(AZX_REG_GTS_BASE + 0x08)
+#define AZX_REG_TSCCU	(AZX_REG_GTS_BASE + 0x0C)
+#define AZX_REG_LLPFOC	(AZX_REG_GTS_BASE + 0x14)
+#define AZX_REG_LLPCL	(AZX_REG_GTS_BASE + 0x18)
+#define AZX_REG_LLPCU	(AZX_REG_GTS_BASE + 0x1C)
+
 /* Haswell/Broadwell display HD-A controller Extended Mode registers */
 #define AZX_REG_HSW_EM4			0x100c
 #define AZX_REG_HSW_EM5			0x1010
@@ -242,6 +255,29 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 /* Interval used to calculate the iterating register offset */
 #define AZX_DRSM_INTERVAL		0x08
 
+/* Global time synchronization registers */
+#define GTSCC_TSCCD_MASK		0x80000000
+#define GTSCC_TSCCD_SHIFT		BIT(31)
+#define GTSCC_TSCCI_MASK		0x20
+#define GTSCC_CDMAS_DMA_DIR_SHIFT	4
+
+#define WALFCC_CIF_MASK			0x1FF
+#define WALFCC_FN_SHIFT			9
+#define HDA_CLK_CYCLES_PER_FRAME	512
+
+/*
+ * An error occurs near frame "rollover". The clocks in frame value indicates
+ * whether this error may have occurred. Here we use the value of 10. Please
+ * see the errata for the right number [<10]
+ */
+#define HDA_MAX_CYCLE_VALUE		499
+#define HDA_MAX_CYCLE_OFFSET		10
+#define HDA_MAX_CYCLE_READ_RETRY	10
+
+#define TSCCU_CCU_SHIFT			32
+#define LLPC_CCU_SHIFT			32
+
+
 /*
  * helpers to read the stream position
  */
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 27de8015717d..1567fe209e01 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -412,6 +412,11 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 		goto unlock;
 	}
 	runtime->private_data = azx_dev;
+
+	if (chip->gts_present)
+		azx_pcm_hw.info = azx_pcm_hw.info |
+			SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME;
+
 	runtime->hw = azx_pcm_hw;
 	runtime->hw.channels_min = hinfo->channels_min;
 	runtime->hw.channels_max = hinfo->channels_max;
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index ec63bbf1ec6d..a50e0532622a 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -159,6 +159,9 @@ struct azx {
 	unsigned int region_requested:1;
 	unsigned int disabled:1; /* disabled by vga_switcheroo */
 
+	/* GTS present */
+	unsigned int gts_present:1;
+
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 	struct azx_dev saved_azx_dev;
 #endif
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 89dacf9b4e6c..4786f435eb64 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -54,6 +54,7 @@
 /* for snoop control */
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #endif
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -1655,6 +1656,22 @@ static int azx_first_init(struct azx *chip)
 		return -ENXIO;
 	}
 
+	if (IS_SKL_PLUS(pci))
+		snd_hdac_bus_parse_capabilities(bus);
+
+	/*
+	 * Some Intel CPUs has always running timer (ART) feature and
+	 * controller may have Global time sync reporting capability, so
+	 * check both of these before declaring synchronized time reporting
+	 * capability SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME
+	 */
+	chip->gts_present = false;
+
+#ifdef CONFIG_X86
+	if (bus->ppcap && boot_cpu_has(X86_FEATURE_ART))
+		chip->gts_present = true;
+#endif
+
 	if (chip->msi) {
 		if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
 			dev_dbg(card->dev, "Disabling 64bit MSI\n");
-- 
2.8.1
