From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use framework for WM8996 HPOUT RMV_SHORT
	management
Date: Sun, 22 Jan 2012 22:16:15 +0000
Message-ID: <1327270575-31600-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D147410385A
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2012 23:16:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The framework is now perfactly capable of implementing the RMV_SHORT bits
for us and doing so actually improves performance somewhat due to being
able to combine register writes better.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   96 ++++-----------------------------------------
 1 files changed, 8 insertions(+), 88 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index e4b062d..e4fa104 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -68,9 +68,6 @@ struct wm8996_priv {
 	u16 dcs_pending;
 	struct completion dcs_done;
 
-	u16 hpout_ena;
-	u16 hpout_pending;
-
 	struct regulator_bulk_data supplies[WM8996_NUM_SUPPLIES];
 	struct notifier_block disable_nb[WM8996_NUM_SUPPLIES];
 	int bg_ena;
@@ -805,27 +802,6 @@ static int cp_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int rmv_short_event(struct snd_soc_dapm_widget *w,
-			   struct snd_kcontrol *kcontrol, int event)
-{
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(w->codec);
-
-	/* Record which outputs we enabled */
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMD:
-		wm8996->hpout_pending &= ~w->shift;
-		break;
-	case SND_SOC_DAPM_PRE_PMU:
-		wm8996->hpout_pending |= w->shift;
-		break;
-	default:
-		BUG();
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void wait_for_dc_servo(struct snd_soc_codec *codec, u16 mask)
 {
 	struct i2c_client *i2c = to_i2c_client(codec->dev);
@@ -864,7 +840,6 @@ static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_codec *codec = container_of(dapm,
 						   struct snd_soc_codec, dapm);
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
-	u16 val, mask;
 
 	/* Complete any pending DC servo starts */
 	if (wm8996->dcs_pending) {
@@ -877,57 +852,6 @@ static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
 
 		wm8996->dcs_pending = 0;
 	}
-
-	if (wm8996->hpout_pending != wm8996->hpout_ena) {
-		dev_dbg(codec->dev, "Applying RMV_SHORTs %x->%x\n",
-			wm8996->hpout_ena, wm8996->hpout_pending);
-
-		val = 0;
-		mask = 0;
-		if (wm8996->hpout_pending & HPOUT1L) {
-			val |= WM8996_HPOUT1L_RMV_SHORT;
-			mask |= WM8996_HPOUT1L_RMV_SHORT;
-		} else {
-			mask |= WM8996_HPOUT1L_RMV_SHORT |
-				WM8996_HPOUT1L_OUTP |
-				WM8996_HPOUT1L_DLY;
-		}
-
-		if (wm8996->hpout_pending & HPOUT1R) {
-			val |= WM8996_HPOUT1R_RMV_SHORT;
-			mask |= WM8996_HPOUT1R_RMV_SHORT;
-		} else {
-			mask |= WM8996_HPOUT1R_RMV_SHORT |
-				WM8996_HPOUT1R_OUTP |
-				WM8996_HPOUT1R_DLY;
-		}
-
-		snd_soc_update_bits(codec, WM8996_ANALOGUE_HP_1, mask, val);
-
-		val = 0;
-		mask = 0;
-		if (wm8996->hpout_pending & HPOUT2L) {
-			val |= WM8996_HPOUT2L_RMV_SHORT;
-			mask |= WM8996_HPOUT2L_RMV_SHORT;
-		} else {
-			mask |= WM8996_HPOUT2L_RMV_SHORT |
-				WM8996_HPOUT2L_OUTP |
-				WM8996_HPOUT2L_DLY;
-		}
-
-		if (wm8996->hpout_pending & HPOUT2R) {
-			val |= WM8996_HPOUT2R_RMV_SHORT;
-			mask |= WM8996_HPOUT2R_RMV_SHORT;
-		} else {
-			mask |= WM8996_HPOUT2R_RMV_SHORT |
-				WM8996_HPOUT2R_OUTP |
-				WM8996_HPOUT2R_DLY;
-		}
-
-		snd_soc_update_bits(codec, WM8996_ANALOGUE_HP_2, mask, val);
-
-		wm8996->hpout_ena = wm8996->hpout_pending;
-	}
 }
 
 static int dcs_start(struct snd_soc_dapm_widget *w,
@@ -1226,36 +1150,32 @@ SND_SOC_DAPM_PGA_S("HPOUT2L_DLY", 1, WM8996_ANALOGUE_HP_2, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT2L_DCS", 2, WM8996_DC_SERVO_1, 2, 0, dcs_start,
 		   SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_PGA_S("HPOUT2L_OUTP", 3, WM8996_ANALOGUE_HP_2, 6, 0, NULL, 0),
-SND_SOC_DAPM_PGA_S("HPOUT2L_RMV_SHORT", 3, SND_SOC_NOPM, HPOUT2L, 0,
-		   rmv_short_event,
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA_S("HPOUT2L_RMV_SHORT", 3, WM8996_ANALOGUE_HP_2, 7, 0,
+		   NULL, 0),
 
 SND_SOC_DAPM_PGA_S("HPOUT2R PGA", 0, WM8996_POWER_MANAGEMENT_1, 6, 0,NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT2R_DLY", 1, WM8996_ANALOGUE_HP_2, 1, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT2R_DCS", 2, WM8996_DC_SERVO_1, 3, 0, dcs_start,
 		   SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_PGA_S("HPOUT2R_OUTP", 3, WM8996_ANALOGUE_HP_2, 2, 0, NULL, 0),
-SND_SOC_DAPM_PGA_S("HPOUT2R_RMV_SHORT", 3, SND_SOC_NOPM, HPOUT2R, 0,
-		   rmv_short_event,
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA_S("HPOUT2R_RMV_SHORT", 3, WM8996_ANALOGUE_HP_2, 3, 0,
+		   NULL, 0),
 
 SND_SOC_DAPM_PGA_S("HPOUT1L PGA", 0, WM8996_POWER_MANAGEMENT_1, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT1L_DLY", 1, WM8996_ANALOGUE_HP_1, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT1L_DCS", 2, WM8996_DC_SERVO_1, 0, 0, dcs_start,
 		   SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_PGA_S("HPOUT1L_OUTP", 3, WM8996_ANALOGUE_HP_1, 6, 0, NULL, 0),
-SND_SOC_DAPM_PGA_S("HPOUT1L_RMV_SHORT", 3, SND_SOC_NOPM, HPOUT1L, 0,
-		   rmv_short_event,
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA_S("HPOUT1L_RMV_SHORT", 3, WM8996_ANALOGUE_HP_1, 7, 0,
+		   NULL, 0),
 
 SND_SOC_DAPM_PGA_S("HPOUT1R PGA", 0, WM8996_POWER_MANAGEMENT_1, 4, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT1R_DLY", 1, WM8996_ANALOGUE_HP_1, 1, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT1R_DCS", 2, WM8996_DC_SERVO_1, 1, 0, dcs_start,
 		   SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_PGA_S("HPOUT1R_OUTP", 3, WM8996_ANALOGUE_HP_1, 2, 0, NULL, 0),
-SND_SOC_DAPM_PGA_S("HPOUT1R_RMV_SHORT", 3, SND_SOC_NOPM, HPOUT1R, 0,
-		   rmv_short_event,
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA_S("HPOUT1R_RMV_SHORT", 3, WM8996_ANALOGUE_HP_1, 3, 0,
+		   NULL, 0),
 
 SND_SOC_DAPM_OUTPUT("HPOUT1L"),
 SND_SOC_DAPM_OUTPUT("HPOUT1R"),
-- 
1.7.7.3
