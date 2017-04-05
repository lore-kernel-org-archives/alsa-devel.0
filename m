From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add support for ADSP2V2" to the asoc tree
Date: Wed, 05 Apr 2017 18:31:04 +0100
Message-ID: <E1cvols-0000rQ-7f@debutante>
References: <1491386884-30689-12-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1491386884-30689-12-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lee.jones@linaro.orgbroonie@kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add support for ADSP2V2

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

>From e1ea1879f2889a26370bd0bc29c1e95caf9d36f2 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 5 Apr 2017 11:07:59 +0100
Subject: [PATCH] ASoC: wm_adsp: Add support for ADSP2V2

Adds support for ADSP2V2 cores. Primary differences are that
they use a 32-bit register map compared to the 16-bit register
map of ADSP2V1, and there are some changes to clocking control.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 187 ++++++++++++++++++++++++++++++++++-----------
 sound/soc/codecs/wm_adsp.h |   1 +
 2 files changed, 145 insertions(+), 43 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index bbdb72f73df1..a9acf222b502 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -112,17 +112,22 @@
 #define ADSP1_CLK_SEL_SHIFT                    0  /* CLK_SEL_ENA */
 #define ADSP1_CLK_SEL_WIDTH                    3  /* CLK_SEL_ENA */
 
-#define ADSP2_CONTROL        0x0
-#define ADSP2_CLOCKING       0x1
-#define ADSP2_STATUS1        0x4
-#define ADSP2_WDMA_CONFIG_1 0x30
-#define ADSP2_WDMA_CONFIG_2 0x31
-#define ADSP2_RDMA_CONFIG_1 0x34
-
-#define ADSP2_SCRATCH0        0x40
-#define ADSP2_SCRATCH1        0x41
-#define ADSP2_SCRATCH2        0x42
-#define ADSP2_SCRATCH3        0x43
+#define ADSP2_CONTROL                     0x0
+#define ADSP2_CLOCKING                    0x1
+#define ADSP2V2_CLOCKING                  0x2
+#define ADSP2_STATUS1                     0x4
+#define ADSP2_WDMA_CONFIG_1               0x30
+#define ADSP2_WDMA_CONFIG_2               0x31
+#define ADSP2V2_WDMA_CONFIG_2             0x32
+#define ADSP2_RDMA_CONFIG_1               0x34
+
+#define ADSP2_SCRATCH0                    0x40
+#define ADSP2_SCRATCH1                    0x41
+#define ADSP2_SCRATCH2                    0x42
+#define ADSP2_SCRATCH3                    0x43
+
+#define ADSP2V2_SCRATCH0_1                0x40
+#define ADSP2V2_SCRATCH2_3                0x42
 
 /*
  * ADSP2 Control
@@ -153,6 +158,17 @@
 #define ADSP2_CLK_SEL_WIDTH                    3  /* CLK_SEL_ENA */
 
 /*
+ * ADSP2V2 clocking
+ */
+#define ADSP2V2_CLK_SEL_MASK             0x70000  /* CLK_SEL_ENA */
+#define ADSP2V2_CLK_SEL_SHIFT                 16  /* CLK_SEL_ENA */
+#define ADSP2V2_CLK_SEL_WIDTH                  3  /* CLK_SEL_ENA */
+
+#define ADSP2V2_RATE_MASK                 0x7800  /* DSP_RATE */
+#define ADSP2V2_RATE_SHIFT                    11  /* DSP_RATE */
+#define ADSP2V2_RATE_WIDTH                     4  /* DSP_RATE */
+
+/*
  * ADSP2 Status 1
  */
 #define ADSP2_RAM_RDY                     0x0001
@@ -683,6 +699,9 @@ static const struct soc_enum wm_adsp_fw_enum[] = {
 	SOC_ENUM_SINGLE(0, 1, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
 	SOC_ENUM_SINGLE(0, 2, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
 	SOC_ENUM_SINGLE(0, 3, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
+	SOC_ENUM_SINGLE(0, 4, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
+	SOC_ENUM_SINGLE(0, 5, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
+	SOC_ENUM_SINGLE(0, 6, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
 };
 
 const struct snd_kcontrol_new wm_adsp_fw_controls[] = {
@@ -694,6 +713,12 @@ const struct snd_kcontrol_new wm_adsp_fw_controls[] = {
 		     wm_adsp_fw_get, wm_adsp_fw_put),
 	SOC_ENUM_EXT("DSP4 Firmware", wm_adsp_fw_enum[3],
 		     wm_adsp_fw_get, wm_adsp_fw_put),
+	SOC_ENUM_EXT("DSP5 Firmware", wm_adsp_fw_enum[4],
+		     wm_adsp_fw_get, wm_adsp_fw_put),
+	SOC_ENUM_EXT("DSP6 Firmware", wm_adsp_fw_enum[5],
+		     wm_adsp_fw_get, wm_adsp_fw_put),
+	SOC_ENUM_EXT("DSP7 Firmware", wm_adsp_fw_enum[6],
+		     wm_adsp_fw_get, wm_adsp_fw_put),
 };
 EXPORT_SYMBOL_GPL(wm_adsp_fw_controls);
 
@@ -750,6 +775,29 @@ static void wm_adsp2_show_fw_status(struct wm_adsp *dsp)
 		 be16_to_cpu(scratch[3]));
 }
 
+static void wm_adsp2v2_show_fw_status(struct wm_adsp *dsp)
+{
+	u32 scratch[2];
+	int ret;
+
+	ret = regmap_raw_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH0_1,
+			      scratch, sizeof(scratch));
+
+	if (ret) {
+		adsp_err(dsp, "Failed to read SCRATCH regs: %d\n", ret);
+		return;
+	}
+
+	scratch[0] = be32_to_cpu(scratch[0]);
+	scratch[1] = be32_to_cpu(scratch[1]);
+
+	adsp_dbg(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
+		 scratch[0] & 0xFFFF,
+		 scratch[0] >> 16,
+		 scratch[1] & 0xFFFF,
+		 scratch[1] >> 16);
+}
+
 static inline struct wm_coeff_ctl *bytes_ext_to_ctl(struct soc_bytes_ext *ext)
 {
 	return container_of(ext, struct wm_coeff_ctl, bytes_ext);
@@ -2435,10 +2483,17 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 	unsigned int val;
 	int ret, count;
 
-	ret = regmap_update_bits_async(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				       ADSP2_SYS_ENA, ADSP2_SYS_ENA);
-	if (ret != 0)
-		return ret;
+	switch (dsp->rev) {
+	case 0:
+		ret = regmap_update_bits_async(dsp->regmap,
+					       dsp->base + ADSP2_CONTROL,
+					       ADSP2_SYS_ENA, ADSP2_SYS_ENA);
+		if (ret != 0)
+			return ret;
+		break;
+	default:
+		break;
+	}
 
 	/* Wait for the RAM to start, should be near instantaneous */
 	for (count = 0; count < 10; ++count) {
@@ -2497,11 +2552,17 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	if (ret != 0)
 		goto err_ena;
 
-	/* Turn DSP back off until we are ready to run */
-	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				 ADSP2_SYS_ENA, 0);
-	if (ret != 0)
-		goto err_ena;
+	switch (dsp->rev) {
+	case 0:
+		/* Turn DSP back off until we are ready to run */
+		ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+					 ADSP2_SYS_ENA, 0);
+		if (ret != 0)
+			goto err_ena;
+		break;
+	default:
+		break;
+	}
 
 	dsp->booted = true;
 
@@ -2523,12 +2584,21 @@ static void wm_adsp2_set_dspclk(struct wm_adsp *dsp, unsigned int freq)
 {
 	int ret;
 
-	ret = regmap_update_bits_async(dsp->regmap,
-				       dsp->base + ADSP2_CLOCKING,
-				       ADSP2_CLK_SEL_MASK,
-				       freq << ADSP2_CLK_SEL_SHIFT);
-	if (ret != 0)
-		adsp_err(dsp, "Failed to set clock rate: %d\n", ret);
+	switch (dsp->rev) {
+	case 0:
+		ret = regmap_update_bits_async(dsp->regmap,
+					       dsp->base + ADSP2_CLOCKING,
+					       ADSP2_CLK_SEL_MASK,
+					       freq << ADSP2_CLK_SEL_SHIFT);
+		if (ret) {
+			adsp_err(dsp, "Failed to set clock rate: %d\n", ret);
+			return;
+		}
+		break;
+	default:
+		/* clock is handled by parent codec driver */
+		break;
+	}
 }
 
 int wm_adsp2_preloader_get(struct snd_kcontrol *kcontrol,
@@ -2664,22 +2734,46 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		wm_adsp_signal_event_controls(dsp, WM_ADSP_FW_EVENT_SHUTDOWN);
 
 		/* Log firmware state, it can be useful for analysis */
-		wm_adsp2_show_fw_status(dsp);
+		switch (dsp->rev) {
+		case 0:
+			wm_adsp2_show_fw_status(dsp);
+			break;
+		default:
+			wm_adsp2v2_show_fw_status(dsp);
+			break;
+		}
 
 		mutex_lock(&dsp->pwr_lock);
 
 		dsp->running = false;
 
-		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+		regmap_update_bits(dsp->regmap,
+				   dsp->base + ADSP2_CONTROL,
 				   ADSP2_CORE_ENA | ADSP2_START, 0);
 
 		/* Make sure DMAs are quiesced */
-		regmap_write(dsp->regmap, dsp->base + ADSP2_RDMA_CONFIG_1, 0);
-		regmap_write(dsp->regmap, dsp->base + ADSP2_WDMA_CONFIG_1, 0);
-		regmap_write(dsp->regmap, dsp->base + ADSP2_WDMA_CONFIG_2, 0);
-
-		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				   ADSP2_SYS_ENA, 0);
+		switch (dsp->rev) {
+		case 0:
+			regmap_write(dsp->regmap,
+				     dsp->base + ADSP2_RDMA_CONFIG_1, 0);
+			regmap_write(dsp->regmap,
+				     dsp->base + ADSP2_WDMA_CONFIG_1, 0);
+			regmap_write(dsp->regmap,
+				     dsp->base + ADSP2_WDMA_CONFIG_2, 0);
+
+			regmap_update_bits(dsp->regmap,
+					   dsp->base + ADSP2_CONTROL,
+					   ADSP2_SYS_ENA, 0);
+			break;
+		default:
+			regmap_write(dsp->regmap,
+				     dsp->base + ADSP2_RDMA_CONFIG_1, 0);
+			regmap_write(dsp->regmap,
+				     dsp->base + ADSP2_WDMA_CONFIG_1, 0);
+			regmap_write(dsp->regmap,
+				     dsp->base + ADSP2V2_WDMA_CONFIG_2, 0);
+			break;
+		}
 
 		if (wm_adsp_fw[dsp->fw].num_caps != 0)
 			wm_adsp_buffer_free(dsp);
@@ -2732,15 +2826,22 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 {
 	int ret;
 
-	/*
-	 * Disable the DSP memory by default when in reset for a small
-	 * power saving.
-	 */
-	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				 ADSP2_MEM_ENA, 0);
-	if (ret != 0) {
-		adsp_err(dsp, "Failed to clear memory retention: %d\n", ret);
-		return ret;
+	switch (dsp->rev) {
+	case 0:
+		/*
+		 * Disable the DSP memory by default when in reset for a small
+		 * power saving.
+		 */
+		ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+					 ADSP2_MEM_ENA, 0);
+		if (ret) {
+			adsp_err(dsp,
+				 "Failed to clear memory retention: %d\n", ret);
+			return ret;
+		}
+		break;
+	default:
+		break;
 	}
 
 	INIT_LIST_HEAD(&dsp->alg_regions);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 3706b11053a3..997227f4d404 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -40,6 +40,7 @@ struct wm_adsp_compr_buf;
 
 struct wm_adsp {
 	const char *part;
+	int rev;
 	int num;
 	int type;
 	struct device *dev;
-- 
2.11.0

