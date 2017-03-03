From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 05/10] Replaced pr_err by dev_err. Modified
	debug message
Date: Fri, 3 Mar 2017 23:52:43 +0900
Message-ID: <1488552768-14901-6-git-send-email-ryans.lee@maximintegrated.com>
References: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0130.outbound.protection.outlook.com [104.47.34.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 13CC3266B6D
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 15:54:19 +0100 (CET)
In-Reply-To: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, arnd@arndb.de, michael@amarulasolutions.com, oder_chiou@realtek.com, yesanishhere@gmail.com, jacob@teenage.engineering, Damien.Horsley@imgtec.com, bardliao@realtek.com, kuninori.morimoto.gx@renesas.com, petr@barix.com, lars@metafoo.de, nh6z@nh6z.net, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Replaced 'pr_err' by 'dev_err'. Modified error message.

 sound/soc/codecs/max98927.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index efc761b..0abf6d3 100755
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -254,6 +254,7 @@ static const int rate_table[] = {
 static int max98927_set_clock(struct max98927_priv *max98927,
 	struct snd_pcm_hw_params *params)
 {
+	struct snd_soc_codec *codec = max98927->codec;
 	/* BCLK/LRCLK ratio calculation */
 	int blr_clk_ratio = params_channels(params) * max98927->ch_size;
 	int reg = MAX98927_R0022_PCM_CLK_SETUP;
@@ -268,8 +269,7 @@ static int max98927_set_clock(struct max98927_priv *max98927,
 				break;
 		}
 		if (i == ARRAY_SIZE(rate_table)) {
-			pr_err("%s couldn't get the MCLK to match codec\n",
-				__func__);
+			dev_err(codec->dev, "failed to find proper clock rate.\n");
 			return -EINVAL;
 		}
 		regmap_update_bits(max98927->regmap,
@@ -327,12 +327,12 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 		max98927->ch_size = 32;
 		break;
 	default:
-		pr_err("%s: format unsupported %d",
-			__func__, params_format(params));
+		dev_err(codec->dev, "format unsupported %d",
+			params_format(params));
 		goto err;
 	}
-	dev_dbg(codec->dev, "%s: format supported %d",
-		__func__, params_format(params));
+	dev_dbg(codec->dev, "format supported %d",
+		params_format(params));
 
 	/* sampling rate configuration */
 	switch (params_rate(params)) {
@@ -364,8 +364,8 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 		sampling_rate |= MAX98927_PCM_SR_SET1_SR_48000;
 		break;
 	default:
-		pr_err("%s rate %d not supported\n",
-			__func__, params_rate(params));
+		dev_err(codec->dev, "rate %d not supported\n",
+			params_rate(params));
 		goto err;
 	}
 	/* set DAI_SR to correct LRCLK frequency */
@@ -490,7 +490,7 @@ static int max98927_digital_gain_get(struct snd_kcontrol *kcontrol,
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = max98927->digital_gain;
-	dev_dbg(codec->dev, "%s: spk_gain setting returned %d\n", __func__,
+	dev_dbg(codec->dev, "%s: digital_gain setting returned %d\n", __func__,
 		(int) ucontrol->value.integer.value[0]);
 	return 0;
 }
-- 
2.7.4
