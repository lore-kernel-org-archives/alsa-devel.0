From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add HALO MPU fault logging" to
	the asoc tree
Date: Tue, 19 Mar 2019 13:12:58 +0000 (GMT)
Message-ID: <20190319131258.BE01911288DF@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A1D8F8968A
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 14:13:04 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add HALO MPU fault logging

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2ae581380e4da6b1b9eff37cb087e3788ec82c67 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Tue, 19 Mar 2019 11:52:14 +0000
Subject: [PATCH] ASoC: wm_adsp: Add HALO MPU fault logging

A Halo Core DSP has a memory protection unit that can trap and signal
memory access faults. This patch adds a function that dumps the fault
information.

The interrupt reaches the host via the parent codec interrupt controller
so this fault function is exported to be called by the codec driver.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 84 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 85 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index bd31056db4f5..3e74cbb80d3c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -227,6 +227,12 @@
  */
 #define WM_ADSP_FW_EVENT_SHUTDOWN            0x000001
 
+/*
+ * HALO system info
+ */
+#define HALO_AHBM_WINDOW_DEBUG_0             0x02040
+#define HALO_AHBM_WINDOW_DEBUG_1             0x02044
+
 /*
  * HALO core
  */
@@ -260,8 +266,21 @@
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
 
+/*
+ * HALO_AHBM_WINDOW_DEBUG_1
+ */
+#define HALO_AHBM_CORE_ERR_ADDR_MASK         0x0fffff00
+#define HALO_AHBM_CORE_ERR_ADDR_SHIFT                 8
+#define HALO_AHBM_FLAGS_ERR_MASK             0x000000ff
+
 /*
  * HALO_CCM_CORE_CONTROL
  */
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
index e7f1fde2b54b..521dccbf3a2e 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -175,6 +175,7 @@ int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event);
 
 irqreturn_t wm_adsp2_bus_error(struct wm_adsp *adsp);
+irqreturn_t wm_halo_bus_error(struct wm_adsp *dsp);
 
 int wm_adsp_event(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event);
-- 
2.20.1
