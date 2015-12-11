From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/4] ASoC: sun4i-codec: Rename codec dapm
 widgets and routes
Date: Fri, 11 Dec 2015 19:43:56 +0100
Message-ID: <1449859439-30875-1-git-send-email-hdegoede@redhat.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDRZXY4CYYORB55SVSZQKGQEOROEJSY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Rename the codec dapm widgets and routes with a _codec prefix. This is
a preparation patch for adding card dapm widgets and routes.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
Changes in v2:
-New patch in v2 of this patchset
---
 sound/soc/sunxi/sun4i-codec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 7a3fe1d..519ccb3 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -532,7 +532,7 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mixer_controls[] = {
 			SUN4I_CODEC_DAC_ACTL_MIXPAS, 1, 0),
 };
 
-static const struct snd_soc_dapm_widget sun4i_codec_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	/* Digital parts of the ADCs */
 	SND_SOC_DAPM_SUPPLY("ADC", SUN4I_CODEC_ADC_FIFOC,
 			    SUN4I_CODEC_ADC_FIFOC_EN_AD, 0,
@@ -589,7 +589,7 @@ static const struct snd_soc_dapm_widget sun4i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("HP Left"),
 };
 
-static const struct snd_soc_dapm_route sun4i_codec_dapm_routes[] = {
+static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	/* Left ADC / DAC Routes */
 	{ "Left ADC", NULL, "ADC" },
 	{ "Left DAC", NULL, "DAC" },
@@ -628,10 +628,10 @@ static const struct snd_soc_dapm_route sun4i_codec_dapm_routes[] = {
 static struct snd_soc_codec_driver sun4i_codec_codec = {
 	.controls		= sun4i_codec_widgets,
 	.num_controls		= ARRAY_SIZE(sun4i_codec_widgets),
-	.dapm_widgets		= sun4i_codec_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_dapm_widgets),
-	.dapm_routes		= sun4i_codec_dapm_routes,
-	.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_dapm_routes),
+	.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
+	.dapm_routes		= sun4i_codec_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
 };
 
 static const struct snd_soc_component_driver sun4i_codec_component = {
-- 
2.5.0
