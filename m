From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add output power up/down
	delays for speaker path" to the asoc tree
Date: Tue, 27 Sep 2016 09:18:12 -0700
Message-ID: <E1bov5A-0003gI-Eg@finisterre>
References: <1474990545-29282-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C9A0265D93
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 18:18:26 +0200 (CEST)
In-Reply-To: <1474990545-29282-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add output power up/down delays for speaker path

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

>From 8c7788f34e11f4c52d6a8a1340a8bd61476acabb Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 27 Sep 2016 16:35:45 +0100
Subject: [PATCH] ASoC: arizona: Add output power up/down delays for speaker
 path

The later Arizona parts do run write sequences to power up and down the
speaker path as such a delay needs to be inserted into the DAPM sequence
to allow this to run. This patch adds appropriate delays into the
existing coalesced delay scheme.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 7a99f77bbe84..85584ecf95bb 100644
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
2.9.3
