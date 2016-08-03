From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 4/5] ALSA - hda: Add support for parsing new
	HDA capabilities
Date: Wed,  3 Aug 2016 21:36:13 +0530
Message-ID: <1470240374-20018-5-git-send-email-vinod.koul@intel.com>
References: <1470240374-20018-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 795FE2675F2
 for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2016 17:59:25 +0200 (CEST)
In-Reply-To: <1470240374-20018-1-git-send-email-vinod.koul@intel.com>
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

Skylake onwards HDA controller supports new capabilities like
Global Time Stamping (GTS) capability. So add support to parse
these new capabilities.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_register.h   | 36 ++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.c |  5 +++++
 sound/pci/hda/hda_controller.h |  3 +++
 sound/pci/hda/hda_intel.c      | 16 ++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index ff1aecf325e8..c806060944e1 100644
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
index 89dacf9b4e6c..215f7be615bb 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1655,6 +1655,22 @@ static int azx_first_init(struct azx *chip)
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
+	if ((bus->ppcap && boot_cpu_has(X86_FEATURE_ART)))
+		chip->gts_present = true;
+#endif
+
 	if (chip->msi) {
 		if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
 			dev_dbg(card->dev, "Disabling 64bit MSI\n");
-- 
1.9.1
