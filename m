From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 11/12] ASoC: wm_adsp: Add HALO MPU fault logging
Date: Tue, 19 Mar 2019 11:52:14 +0000
Message-ID: <20190319115215.22960-12-ckeepax@opensource.cirrus.com>
References: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16089F896B9
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 12:52:18 +0100 (CET)
In-Reply-To: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

A Halo Core DSP has a memory protection unit that can trap and signal
memory access faults. This patch adds a function that dumps the fault
information.

The interrupt reaches the host via the parent codec interrupt controller
so this fault function is exported to be called by the codec driver.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 85 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index bd31056db4f5e..3e74cbb80d3c5 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -228,6 +228,12 @@
 #define WM_ADSP_FW_EVENT_SHUTDOWN            0x000001
 
 /*
+ * HALO system info
+ */
+#define HALO_AHBM_WINDOW_DEBUG_0             0x02040
+#define HALO_AHBM_WINDOW_DEBUG_1             0x02044
+
+/*
  * HALO core
  */
 #define HALO_SCRATCH1                        0x005c0
@@ -260,9 +266,22 @@
 #define HALO_MPU_WINDOW_ACCESS_3             0x43050
 #define HALO_MPU_XREG_ACCESS_3               0x43054
 #define HALO_MPU_YREG_ACCESS_3               0x4305C
+#define HALO_MPU_XM_VIO_ADDR                 0x43100
+#define HALO_MPU_XM_VIO_STATUS               0x43104
+#define HALO_MPU_YM_VIO_ADDR                 0x43108
+#define HALO_MPU_YM_VIO_STATUS               0x4310C
+#define HALO_MPU_PM_VIO_ADDR                 0x43110
+#define HALO_MPU_PM_VIO_STATUS               0x43114
 #define HALO_MPU_LOCK_CONFIG                 0x43140
 
 /*
+ * HALO_AHBM_WINDOW_DEBUG_1
+ */
+#define HALO_AHBM_CORE_ERR_ADDR_MASK         0x0fffff00
+#define HALO_AHBM_CORE_ERR_ADDR_SHIFT                 8
+#define HALO_AHBM_FLAGS_ERR_MASK             0x000000ff
+
+/*
  * HALO_CCM_CORE_CONTROL
  */
 #define HALO_CORE_EN                        0x00000001
@@ -272,6 +291,15 @@
  */
 #define HALO_CORE_SOFT_RESET_MASK           0x00000001
 
+/*
+ * HALO_MPU_?M_VIO_STATUS
+ */
+#define HALO_MPU_VIO_STS_MASK               0x007e0000
+#define HALO_MPU_VIO_STS_SHIFT                      17
+#define HALO_MPU_VIO_ERR_WR_MASK            0x00008000
+#define HALO_MPU_VIO_ERR_SRC_MASK           0x00007fff
+#define HALO_MPU_VIO_ERR_SRC_SHIFT                   0
+
 struct wm_adsp_ops wm_adsp1_ops;
 struct wm_adsp_ops wm_adsp2_ops[];
 struct wm_adsp_ops wm_halo_ops;
@@ -4295,6 +4323,62 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_bus_error);
 
+irqreturn_t wm_halo_bus_error(struct wm_adsp *dsp)
+{
+	struct regmap *regmap = dsp->regmap;
+	unsigned int fault[6];
+	struct reg_sequence clear[] = {
+		{ dsp->base + HALO_MPU_XM_VIO_STATUS,     0x0 },
+		{ dsp->base + HALO_MPU_YM_VIO_STATUS,     0x0 },
+		{ dsp->base + HALO_MPU_PM_VIO_STATUS,     0x0 },
+	};
+	int ret;
+
+	mutex_lock(&dsp->pwr_lock);
+
+	ret = regmap_read(regmap, dsp->base_sysinfo + HALO_AHBM_WINDOW_DEBUG_1,
+			  fault);
+	if (ret) {
+		adsp_warn(dsp, "Failed to read AHB DEBUG_1: %d\n", ret);
+		goto exit_unlock;
+	}
+
+	adsp_warn(dsp, "AHB: STATUS: 0x%x ADDR: 0x%x\n",
+		  *fault & HALO_AHBM_FLAGS_ERR_MASK,
+		  (*fault & HALO_AHBM_CORE_ERR_ADDR_MASK) >>
+		  HALO_AHBM_CORE_ERR_ADDR_SHIFT);
+
+	ret = regmap_read(regmap, dsp->base_sysinfo + HALO_AHBM_WINDOW_DEBUG_0,
+			  fault);
+	if (ret) {
+		adsp_warn(dsp, "Failed to read AHB DEBUG_0: %d\n", ret);
+		goto exit_unlock;
+	}
+
+	adsp_warn(dsp, "AHB: SYS_ADDR: 0x%x\n", *fault);
+
+	ret = regmap_bulk_read(regmap, dsp->base + HALO_MPU_XM_VIO_ADDR,
+			       fault, ARRAY_SIZE(fault));
+	if (ret) {
+		adsp_warn(dsp, "Failed to read MPU fault info: %d\n", ret);
+		goto exit_unlock;
+	}
+
+	adsp_warn(dsp, "XM: STATUS:0x%x ADDR:0x%x\n", fault[1], fault[0]);
+	adsp_warn(dsp, "YM: STATUS:0x%x ADDR:0x%x\n", fault[3], fault[2]);
+	adsp_warn(dsp, "PM: STATUS:0x%x ADDR:0x%x\n", fault[5], fault[4]);
+
+	ret = regmap_multi_reg_write(dsp->regmap, clear, ARRAY_SIZE(clear));
+	if (ret)
+		adsp_warn(dsp, "Failed to clear MPU status: %d\n", ret);
+
+exit_unlock:
+	mutex_unlock(&dsp->pwr_lock);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(wm_halo_bus_error);
+
 struct wm_adsp_ops wm_adsp1_ops = {
 	.validate_version = wm_adsp_validate_version,
 	.parse_sizes = wm_adsp1_parse_sizes,
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index e7f1fde2b54b3..521dccbf3a2e1 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -175,6 +175,7 @@ int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event);
 
 irqreturn_t wm_adsp2_bus_error(struct wm_adsp *adsp);
+irqreturn_t wm_halo_bus_error(struct wm_adsp *dsp);
 
 int wm_adsp_event(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event);
-- 
2.11.0
