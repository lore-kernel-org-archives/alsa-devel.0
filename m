From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: arizona: Add output power up/down
	delays for speaker path
Date: Tue, 27 Sep 2016 16:35:45 +0100
Message-ID: <1474990545-29282-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1474990545-29282-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 77F8E265D93
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 17:35:38 +0200 (CEST)
In-Reply-To: <1474990545-29282-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The later Arizona parts do run write sequences to power up and down the
speaker path as such a delay needs to be inserted into the DAPM sequence
to allow this to run. This patch adds appropriate delays into the
existing coalesced delay scheme.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index eaf1dbb..7f7d4b3 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -109,7 +109,7 @@ static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
-	return 0;
+	return arizona_out_ev(w, kcontrol, event);
 }
 
 static irqreturn_t arizona_thermal_warn(int irq, void *data)
@@ -159,12 +159,14 @@ static irqreturn_t arizona_thermal_shutdown(int irq, void *data)
 static const struct snd_soc_dapm_widget arizona_spkl =
 	SND_SOC_DAPM_PGA_E("OUT4L", SND_SOC_NOPM,
 			   ARIZONA_OUT4L_ENA_SHIFT, 0, NULL, 0, arizona_spk_ev,
-			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU);
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD);
 
 static const struct snd_soc_dapm_widget arizona_spkr =
 	SND_SOC_DAPM_PGA_E("OUT4R", SND_SOC_NOPM,
 			   ARIZONA_OUT4R_ENA_SHIFT, 0, NULL, 0, arizona_spk_ev,
-			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU);
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD);
 
 int arizona_init_spk(struct snd_soc_codec *codec)
 {
@@ -864,6 +866,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -877,6 +880,18 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			priv->out_up_pending++;
 			priv->out_up_delay += 17;
 			break;
+		case ARIZONA_OUT4L_ENA_SHIFT:
+		case ARIZONA_OUT4R_ENA_SHIFT:
+			priv->out_up_pending++;
+			switch (arizona->type) {
+			case WM5102:
+			case WM8997:
+				break;
+			default:
+				priv->out_up_delay += 10;
+				break;
+			}
+			break;
 		default:
 			break;
 		}
@@ -889,8 +904,10 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 		case ARIZONA_OUT2R_ENA_SHIFT:
 		case ARIZONA_OUT3L_ENA_SHIFT:
 		case ARIZONA_OUT3R_ENA_SHIFT:
+		case ARIZONA_OUT4L_ENA_SHIFT:
+		case ARIZONA_OUT4R_ENA_SHIFT:
 			priv->out_up_pending--;
-			if (!priv->out_up_pending) {
+			if (!priv->out_up_pending && priv->out_up_delay) {
 				dev_dbg(codec->dev, "Power up delay: %d\n",
 					priv->out_up_delay);
 				msleep(priv->out_up_delay);
@@ -913,6 +930,21 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			priv->out_down_pending++;
 			priv->out_down_delay++;
 			break;
+		case ARIZONA_OUT4L_ENA_SHIFT:
+		case ARIZONA_OUT4R_ENA_SHIFT:
+			priv->out_down_pending++;
+			switch (arizona->type) {
+			case WM5102:
+			case WM8997:
+				break;
+			case WM8998:
+			case WM1814:
+				priv->out_down_delay += 5;
+				break;
+			default:
+				priv->out_down_delay++;
+				break;
+			}
 		default:
 			break;
 		}
@@ -925,8 +957,10 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 		case ARIZONA_OUT2R_ENA_SHIFT:
 		case ARIZONA_OUT3L_ENA_SHIFT:
 		case ARIZONA_OUT3R_ENA_SHIFT:
+		case ARIZONA_OUT4L_ENA_SHIFT:
+		case ARIZONA_OUT4R_ENA_SHIFT:
 			priv->out_down_pending--;
-			if (!priv->out_down_pending) {
+			if (!priv->out_down_pending && priv->out_down_delay) {
 				dev_dbg(codec->dev, "Power down delay: %d\n",
 					priv->out_down_delay);
 				msleep(priv->out_down_delay);
-- 
2.1.4
