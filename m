From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ALSA - hda: Add support for GTS capability
Date: Mon, 11 Jul 2016 15:43:27 +0530
Message-ID: <1468232009-14130-2-git-send-email-vinod.koul@intel.com>
References: <1468232009-14130-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 46F772654B5
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 12:06:29 +0200 (CEST)
In-Reply-To: <1468232009-14130-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

Skylake onwards HDA controller supports Global Time Stamping
(GTS) capability. So add support to parse this capability in HDA
driver.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_register.h   | 23 +++++++++++++++++++++++
 sound/pci/hda/hda_controller.c | 33 +++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.h | 27 +++++++++++++++++++++++++++
 sound/pci/hda/hda_intel.c      |  1 +
 4 files changed, 84 insertions(+)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index ff1aecf325e8..e4178328e8c8 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -242,6 +242,29 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 /* Interval used to calculate the iterating register offset */
 #define AZX_DRSM_INTERVAL		0x08
 
+/* Global time synchronization registers */
+#define GTSCC_TSCCD_MASK		0x80000000
+#define GTSCC_TSCCD_SHIFT		31
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
index 27de8015717d..9833666c6108 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -393,6 +393,34 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 	.fifo_size =		0,
 };
 
+void azx_parse_capabilities(struct azx *chip)
+{
+	unsigned int cur_cap;
+	unsigned int offset;
+
+	offset = azx_readl(chip, LLCH);
+
+	/* Lets walk the linked capabilities list */
+	do {
+		cur_cap = _snd_hdac_chip_read(l, azx_bus(chip), offset);
+
+		switch ((cur_cap & CAP_HDR_ID_MASK) >> CAP_HDR_ID_OFF) {
+		case GTS_CAP_ID:
+			dev_dbg(chip->card->dev, "Found GTS capability");
+			chip->gts_present = 1;
+			break;
+
+		default:
+			break;
+		}
+
+		/* read the offset of next capabiity */
+		offset = cur_cap & CAP_HDR_NXT_PTR_MASK;
+	} while (offset);
+
+}
+EXPORT_SYMBOL_GPL(azx_parse_capabilities);
+
 static int azx_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
@@ -412,6 +440,11 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 		goto unlock;
 	}
 	runtime->private_data = azx_dev;
+
+	/* CPU must have ART for reporting link synchronized time */
+	if (chip->gts_present && boot_cpu_has(X86_FEATURE_ART))
+		azx_pcm_hw.info = azx_pcm_hw.info |
+			SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME;
 	runtime->hw = azx_pcm_hw;
 	runtime->hw.channels_min = hinfo->channels_min;
 	runtime->hw.channels_max = hinfo->channels_max;
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index ec63bbf1ec6d..fc57eef9fd88 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -159,9 +159,14 @@ struct azx {
 	unsigned int region_requested:1;
 	unsigned int disabled:1; /* disabled by vga_switcheroo */
 
+	/* GTS present */
+	unsigned int gts_present:1;
+
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 	struct azx_dev saved_azx_dev;
 #endif
+	unsigned int link_count;
+	unsigned int mlcap_offset;
 };
 
 #define azx_bus(chip)	(&(chip)->bus.core)
@@ -173,6 +178,27 @@ struct azx {
 #define azx_snoop(chip)		true
 #endif
 
+#define AZX_REG_LLCH 0x14
+
+#define AZX_REG_GTS_BASE 0x520
+
+#define AZX_REG_GTSCC	(AZX_REG_GTS_BASE + 0x00)
+#define AZX_REG_WALFCC	(AZX_REG_GTS_BASE + 0x04)
+#define AZX_REG_TSCCL	(AZX_REG_GTS_BASE + 0x08)
+#define AZX_REG_TSCCU	(AZX_REG_GTS_BASE + 0x0C)
+#define AZX_REG_LLPFOC	(AZX_REG_GTS_BASE + 0x14)
+#define AZX_REG_LLPCL	(AZX_REG_GTS_BASE + 0x18)
+#define AZX_REG_LLPCU	(AZX_REG_GTS_BASE + 0x1C)
+
+#define CAP_HDR_VER_OFF                 28
+#define CAP_HDR_VER_MASK                (0xF << CAP_HDR_VER_OFF)
+
+#define CAP_HDR_ID_OFF                  16
+#define CAP_HDR_ID_MASK                 (0xFFF << CAP_HDR_ID_OFF)
+
+#define GTS_CAP_ID                 0x1
+#define CAP_HDR_NXT_PTR_MASK    0xFFFF
+
 /*
  * macros for easy use
  */
@@ -201,6 +227,7 @@ static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
 unsigned int azx_get_position(struct azx *chip, struct azx_dev *azx_dev);
 unsigned int azx_get_pos_lpib(struct azx *chip, struct azx_dev *azx_dev);
 unsigned int azx_get_pos_posbuf(struct azx *chip, struct azx_dev *azx_dev);
+void azx_parse_capabilities(struct azx *chip);
 
 /* Stream control. */
 void azx_stop_all_streams(struct azx *chip);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9a0d1445ca5c..b4ebdde59398 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1649,6 +1649,7 @@ static int azx_first_init(struct azx *chip)
 		return -ENXIO;
 	}
 
+	azx_parse_capabilities(chip);
 	if (chip->msi) {
 		if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
 			dev_dbg(card->dev, "Disabling 64bit MSI\n");
-- 
1.9.1
