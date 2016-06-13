From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm5102: Revert manual speaker enable
Date: Mon, 13 Jun 2016 13:35:17 +0100
Message-ID: <1465821317-28449-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1465821317-28449-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 02AF1265099
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:35:09 +0200 (CEST)
In-Reply-To: <1465821317-28449-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, ajit.pandey@soctronics.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The OUT4L and OUT4R widgets are not registered PRE_PMU or POST_PMD
events, as such the manual speaker enable on wm5102 does not actually
ever run. Furthermore since the issue actually only affected rev B of
the silicon which never shipped in volume, simply remove the work around
from the code.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 42 ------------------------------------------
 sound/soc/codecs/arizona.h |  3 ---
 2 files changed, 45 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 8d6dbf3..ed04257 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -85,30 +85,9 @@ static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
-	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
-	bool manual_ena = false;
 	int val;
 
-	switch (arizona->type) {
-	case WM5102:
-		switch (arizona->rev) {
-		case 0:
-			break;
-		default:
-			manual_ena = true;
-			break;
-		}
-	default:
-		break;
-	}
-
 	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		if (!priv->spk_ena && manual_ena) {
-			regmap_write_async(arizona->regmap, 0x4f5, 0x25a);
-			priv->spk_ena_pending = true;
-		}
-		break;
 	case SND_SOC_DAPM_POST_PMU:
 		val = snd_soc_read(codec, ARIZONA_INTERRUPT_RAW_STATUS_3);
 		if (val & ARIZONA_SPK_OVERHEAT_STS) {
@@ -120,33 +99,12 @@ static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 		regmap_update_bits_async(arizona->regmap,
 					 ARIZONA_OUTPUT_ENABLES_1,
 					 1 << w->shift, 1 << w->shift);
-
-		if (priv->spk_ena_pending) {
-			msleep(75);
-			regmap_write_async(arizona->regmap, 0x4f5, 0xda);
-			priv->spk_ena_pending = false;
-			priv->spk_ena++;
-		}
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
-		if (manual_ena) {
-			priv->spk_ena--;
-			if (!priv->spk_ena)
-				regmap_write_async(arizona->regmap,
-						   0x4f5, 0x25a);
-		}
-
 		regmap_update_bits_async(arizona->regmap,
 					 ARIZONA_OUTPUT_ENABLES_1,
 					 1 << w->shift, 0);
 		break;
-	case SND_SOC_DAPM_POST_PMD:
-		if (manual_ena) {
-			if (!priv->spk_ena)
-				regmap_write_async(arizona->regmap,
-						   0x4f5, 0x0da);
-		}
-		break;
 	default:
 		break;
 	}
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 2caf4d0..69da1ef 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -90,9 +90,6 @@ struct arizona_priv {
 	unsigned int out_down_pending;
 	unsigned int out_down_delay;
 
-	unsigned int spk_ena:2;
-	unsigned int spk_ena_pending:1;
-
 	unsigned int dvfs_reqs;
 	struct mutex dvfs_lock;
 	bool dvfs_cached;
-- 
2.1.4
