From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 3/5] ASoC: tas571x: implemented digital mute
Date: Thu, 31 Mar 2016 13:53:59 +0200
Message-ID: <1459425241-21941-3-git-send-email-petr@barix.com>
References: <1459425241-21941-1-git-send-email-petr@barix.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459425241-21941-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The driver did not have a mute function. The amplifier was brought out of
shutdown mode (hard-mute) once for ever in probe(), which was causing
clicks and pops when altering the I2C register configuration later.

This adds the digital_mute() function. The amplifier unmute in probe()
was removed.

Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
v1: <initial>

v2: <no change>

v3: <no change>

 sound/soc/codecs/tas571x.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 2107322..ef6c8d9 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -171,6 +171,23 @@ static int tas571x_hw_params(struct snd_pcm_substream *substream,
 				  TAS571X_SDI_FMT_MASK, val);
 }
 
+static int tas571x_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 sysctl2;
+	int ret;
+
+	sysctl2 = mute ? TAS571X_SYS_CTRL_2_SDN_MASK : 0;
+
+	ret = snd_soc_update_bits(codec,
+			    TAS571X_SYS_CTRL_2_REG,
+		     TAS571X_SYS_CTRL_2_SDN_MASK,
+		     sysctl2);
+	usleep_range(1000, 2000);
+
+	return ret;
+}
+
 static int tas571x_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
@@ -218,6 +235,7 @@ static int tas571x_set_bias_level(struct snd_soc_codec *codec,
 static const struct snd_soc_dai_ops tas571x_dai_ops = {
 	.set_fmt	= tas571x_set_dai_fmt,
 	.hw_params	= tas571x_hw_params,
+	.digital_mute	= tas571x_mute,
 };
 
 static const char *const tas5711_supply_names[] = {
@@ -472,10 +490,6 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(priv->regmap, TAS571X_SYS_CTRL_2_REG,
-				 TAS571X_SYS_CTRL_2_SDN_MASK, 0);
-	if (ret)
-		return ret;
 
 	memcpy(&priv->codec_driver, &tas571x_codec, sizeof(priv->codec_driver));
 	priv->codec_driver.controls = priv->chip->controls;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
