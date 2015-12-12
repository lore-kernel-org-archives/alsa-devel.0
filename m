From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: Rename codec dapm widgets
	and routes" to the asoc tree
Date: Sat, 12 Dec 2015 23:07:21 +0000
Message-ID: <E1a7tG5-0002bR-Oo@finisterre>
References: <1449859439-30875-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33F272606E5
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:29 +0100 (CET)
In-Reply-To: <1449859439-30875-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-codec: Rename codec dapm widgets and routes

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

>From e6415b485059af183873e907662a3cdeefacb58b Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 11 Dec 2015 19:43:56 +0100
Subject: [PATCH] ASoC: sun4i-codec: Rename codec dapm widgets and routes

Rename the codec dapm widgets and routes with a _codec prefix. This is
a preparation patch for adding card dapm widgets and routes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.6.4
