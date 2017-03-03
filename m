From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 06/10] Added mask variable to apply it in one
	round after the switch
Date: Fri, 3 Mar 2017 23:52:44 +0900
Message-ID: <1488552768-14901-7-git-send-email-ryans.lee@maximintegrated.com>
References: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0130.outbound.protection.outlook.com [104.47.34.130])
 by alsa0.perex.cz (Postfix) with ESMTP id D0B14266B71
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 15:54:24 +0100 (CET)
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
Added the mask variable to apply in one round after the switch.

 sound/soc/codecs/max98927.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 0abf6d3..9e70883 100755
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -171,34 +171,31 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
+	unsigned int mode = 0;
 	unsigned int invert = 0;
 
 	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R0021_PCM_MASTER_MODE,
-			MAX98927_PCM_MASTER_MODE_MASK,
-			MAX98927_PCM_MASTER_MODE_SLAVE);
+		mode = MAX98927_PCM_MASTER_MODE_SLAVE;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		max98927->master = true;
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R0021_PCM_MASTER_MODE,
-			MAX98927_PCM_MASTER_MODE_MASK,
-			MAX98927_PCM_MASTER_MODE_MASTER);
+		mode = MAX98927_PCM_MASTER_MODE_MASTER;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R0021_PCM_MASTER_MODE,
-			MAX98927_PCM_MASTER_MODE_MASK,
-			MAX98927_PCM_MASTER_MODE_HYBRID);
+		mode = MAX98927_PCM_MASTER_MODE_HYBRID;
 	default:
 		dev_err(codec->dev, "DAI clock mode unsupported");
 		return -EINVAL;
 	}
 
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0021_PCM_MASTER_MODE,
+		MAX98927_PCM_MASTER_MODE_MASK,
+		mode);
+
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
@@ -210,24 +207,28 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0020_PCM_MODE_CFG,
+		MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE,
+		invert);
+
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		max98927->iface |= SND_SOC_DAIFMT_I2S;
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R0020_PCM_MODE_CFG,
-			max98927->iface, max98927->iface);
-		break;
+
+	break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		max98927->iface |= SND_SOC_DAIFMT_LEFT_J;
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R0020_PCM_MODE_CFG,
-			max98927->iface, max98927->iface);
-		break;
+	break;
 	default:
 		return -EINVAL;
 	}
 
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0020_PCM_MODE_CFG,
+		max98927->iface, max98927->iface);
+
 	/* pcm channel configuration */
 	if (max98927->iface & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
 		regmap_write(max98927->regmap,
@@ -301,29 +302,21 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
-	int sampling_rate = 0;
+	unsigned int sampling_rate = 0;
+	unsigned int chan_sz = 0;
 
 	/* pcm mode configuration */
 	switch (snd_pcm_format_width(params_format(params))) {
 	case 16:
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R0020_PCM_MODE_CFG,
-			MAX98927_PCM_MODE_CFG_CHANSZ_16,
-			MAX98927_PCM_MODE_CFG_CHANSZ_16);
+		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_16;
 		max98927->ch_size = 16;
 		break;
 	case 24:
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R0020_PCM_MODE_CFG,
-			MAX98927_PCM_MODE_CFG_CHANSZ_24,
-			MAX98927_PCM_MODE_CFG_CHANSZ_24);
+		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_24;
 		max98927->ch_size = 24;
 		break;
 	case 32:
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R0020_PCM_MODE_CFG,
-			MAX98927_PCM_MODE_CFG_CHANSZ_32,
-			MAX98927_PCM_MODE_CFG_CHANSZ_32);
+		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_32;
 		max98927->ch_size = 32;
 		break;
 	default:
@@ -331,6 +324,11 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 			params_format(params));
 		goto err;
 	}
+
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0020_PCM_MODE_CFG,
+		MAX98927_PCM_MODE_CFG_CHANSZ_MASK, chan_sz);
+
 	dev_dbg(codec->dev, "format supported %d",
 		params_format(params));
 
-- 
2.7.4
