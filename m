From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] ASoC: sgtl5000: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Sat, 10 Jan 2015 15:44:07 +0100
Message-ID: <1420901048-5756-4-git-send-email-lars@metafoo.de>
References: <1420901048-5756-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-109.synserver.de (smtp-out-109.synserver.de
 [212.40.185.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 60C362606E9
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 15:44:29 +0100 (CET)
In-Reply-To: <1420901048-5756-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sgtl5000.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 29cf7ce..6d6ba3a 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -155,18 +155,19 @@ struct sgtl5000_priv {
 static int mic_bias_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(w->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		/* change mic bias resistor */
-		snd_soc_update_bits(w->codec, SGTL5000_CHIP_MIC_CTRL,
+		snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
 			SGTL5000_BIAS_R_MASK,
 			sgtl5000->micbias_resistor << SGTL5000_BIAS_R_SHIFT);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(w->codec, SGTL5000_CHIP_MIC_CTRL,
+		snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
 				SGTL5000_BIAS_R_MASK, 0);
 		break;
 	}
@@ -181,11 +182,12 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
 static int power_vag_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	const u32 mask = SGTL5000_DAC_POWERUP | SGTL5000_ADC_POWERUP;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
 		break;
 
@@ -195,9 +197,9 @@ static int power_vag_event(struct snd_soc_dapm_widget *w,
 		 * operational to prevent inadvertently starving the
 		 * other one of them.
 		 */
-		if ((snd_soc_read(w->codec, SGTL5000_CHIP_ANA_POWER) &
+		if ((snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER) &
 				mask) != mask) {
-			snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
+			snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 				SGTL5000_VAG_POWERUP, 0);
 			msleep(400);
 		}
-- 
1.8.0
