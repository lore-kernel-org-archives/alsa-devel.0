From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/8] ASoC: tlv320aic3x: Replace direct
	snd_soc_codec dapm field access
Date: Fri, 15 May 2015 12:32:57 +0200
Message-ID: <1431685980-6600-5-git-send-email-lars@metafoo.de>
References: <1431685980-6600-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-168.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id C67932664AB
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 12:33:06 +0200 (CEST)
In-Reply-To: <1431685980-6600-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level() and replace all
other manual access to codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/tlv320aic3x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 57d7090..a7cf19b 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -147,6 +147,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
@@ -179,7 +180,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 		update.mask = mask;
 		update.val = val;
 
-		snd_soc_dapm_mixer_update_power(&codec->dapm, kcontrol, connect,
+		snd_soc_dapm_mixer_update_power(dapm, kcontrol, connect,
 			&update);
 	}
 
@@ -979,7 +980,7 @@ static const struct snd_soc_dapm_route intercon_3007[] = {
 static int aic3x_add_widgets(struct snd_soc_codec *codec)
 {
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	switch (aic3x->model) {
 	case AIC3X_MODEL_3X:
@@ -1384,7 +1385,7 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_ON:
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY &&
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY &&
 		    aic3x->master) {
 			/* enable pll */
 			snd_soc_update_bits(codec, AIC3X_PLL_PROGA_REG,
@@ -1394,7 +1395,7 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (!aic3x->power)
 			aic3x_set_power(codec, 1);
-		if (codec->dapm.bias_level == SND_SOC_BIAS_PREPARE &&
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE &&
 		    aic3x->master) {
 			/* disable pll */
 			snd_soc_update_bits(codec, AIC3X_PLL_PROGA_REG,
-- 
1.8.0
