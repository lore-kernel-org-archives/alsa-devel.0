From: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Set ADSP1 clock rate to
	match sys clock
Date: Thu, 17 Jan 2013 13:11:46 +0000
Message-ID: <1358428307-30196-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6673E265185
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 14:12:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@ti.com, Chris Rattray <crattray@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Sets the ADSP1 clock rate to match the system clock
rate. To support this the codec driver provides
details of register containing the system clock
control bits.

Signed-off-by: Chris Rattray <crattray@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   35 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |    3 +++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 9a3f220..739dab6 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -75,6 +75,8 @@
 #define ADSP1_CONTROL_30                  0x24
 #define ADSP1_CONTROL_31                  0x26
 
+#define ADSP1_CLOCKING 38
+
 /*
  * ADSP1 Control 19
  */
@@ -103,6 +105,13 @@
 #define ADSP1_START_SHIFT                      0  /* DSP1_START */
 #define ADSP1_START_WIDTH                      1  /* DSP1_START */
 
+/*
+ * ADSP1 Control 31
+ */
+#define ADSP1_CLK_SEL_MASK                0x0007  /* CLK_SEL_ENA */
+#define ADSP1_CLK_SEL_SHIFT                    0  /* CLK_SEL_ENA */
+#define ADSP1_CLK_SEL_WIDTH                    3  /* CLK_SEL_ENA */
+
 #define ADSP2_CONTROL  0
 #define ADSP2_CLOCKING 1
 #define ADSP2_STATUS1  4
@@ -817,12 +826,38 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
 	int ret;
+	int val;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
 				   ADSP1_SYS_ENA, ADSP1_SYS_ENA);
 
+		/*
+		 * For simplicity set the DSP clock rate to be the
+		 * SYSCLK rate rather than making it configurable.
+		 */
+		if(dsp->sysclk_reg) {
+			ret = regmap_read(dsp->regmap, dsp->sysclk_reg, &val);
+			if (ret != 0) {
+				adsp_err(dsp, "Failed to read SYSCLK state: %d\n",
+				ret);
+				return ret;
+			}
+
+			val = (val & dsp->sysclk_mask)
+				>> dsp->sysclk_shift;
+
+			ret = regmap_update_bits(dsp->regmap,
+						 dsp->base + ADSP1_CLOCKING,
+						 ADSP1_CLK_SEL_MASK, val);
+			if (ret != 0) {
+				adsp_err(dsp, "Failed to set clock rate: %d\n",
+					 ret);
+				return ret;
+			}
+		}
+
 		ret = wm_adsp_load(dsp);
 		if (ret != 0)
 			goto err;
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 41206d7..cb8871a 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -40,6 +40,9 @@ struct wm_adsp {
 	struct regmap *regmap;
 
 	int base;
+	int sysclk_reg;
+	int sysclk_mask;
+	int sysclk_shift;
 
 	struct list_head alg_regions;
 
-- 
1.7.2.5
