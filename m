From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v2 01/14] ASoC: sun4i-codec: Move data
 structures to add create_card call to quirks
Date: Thu,  3 Nov 2016 15:55:43 +0800
Message-ID: <20161103075556.29018-2-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBHO35PAAKGQET7JUSCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161103075556.29018-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The audio codec on later Allwinner SoCs have a different layout and
audio path compared to the A10/A20. However the PCM parts are still
the same.

The different layout and audio paths mean we need a different
create_card function for different families, so they can create
DAPM endpoint widgets and routes.

This patch moves the regmap configs, quirks and of_device_id
structures to just before the probe function, so we can, among other
things, include a pointer for the create_card function. None of the
lines of code were changed.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 sound/soc/sunxi/sun4i-codec.c | 78 +++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 56ed9472e89f..249fa5033361 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -678,45 +678,6 @@ static struct snd_soc_dai_driver dummy_cpu_dai = {
 	 },
 };
 
-static const struct regmap_config sun4i_codec_regmap_config = {
-	.reg_bits	= 32,
-	.reg_stride	= 4,
-	.val_bits	= 32,
-	.max_register	= SUN4I_CODEC_ADC_RXCNT,
-};
-
-static const struct regmap_config sun7i_codec_regmap_config = {
-	.reg_bits	= 32,
-	.reg_stride	= 4,
-	.val_bits	= 32,
-	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
-};
-
-struct sun4i_codec_quirks {
-	const struct regmap_config *regmap_config;
-};
-
-static const struct sun4i_codec_quirks sun4i_codec_quirks = {
-	.regmap_config = &sun4i_codec_regmap_config,
-};
-
-static const struct sun4i_codec_quirks sun7i_codec_quirks = {
-	.regmap_config = &sun7i_codec_regmap_config,
-};
-
-static const struct of_device_id sun4i_codec_of_match[] = {
-	{
-		.compatible = "allwinner,sun4i-a10-codec",
-		.data = &sun4i_codec_quirks,
-	},
-	{
-		.compatible = "allwinner,sun7i-a20-codec",
-		.data = &sun7i_codec_quirks,
-	},
-	{}
-};
-MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
-
 static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 							int *num_links)
 {
@@ -781,6 +742,45 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 	return card;
 };
 
+static const struct regmap_config sun4i_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN4I_CODEC_ADC_RXCNT,
+};
+
+static const struct regmap_config sun7i_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
+};
+
+struct sun4i_codec_quirks {
+	const struct regmap_config *regmap_config;
+};
+
+static const struct sun4i_codec_quirks sun4i_codec_quirks = {
+	.regmap_config	= &sun4i_codec_regmap_config,
+};
+
+static const struct sun4i_codec_quirks sun7i_codec_quirks = {
+	.regmap_config	= &sun7i_codec_regmap_config,
+};
+
+static const struct of_device_id sun4i_codec_of_match[] = {
+	{
+		.compatible = "allwinner,sun4i-a10-codec",
+		.data = &sun4i_codec_quirks,
+	},
+	{
+		.compatible = "allwinner,sun7i-a20-codec",
+		.data = &sun7i_codec_quirks,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
+
 static int sun4i_codec_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
-- 
2.10.2
