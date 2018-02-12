From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: vc4_hdmi: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:37:20 +0000
Message-ID: <E1elDMG-00040r-9p@debutante>
References: <87607lwafz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 75B7A2678F5
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:37:22 +0100 (CET)
In-Reply-To: <87607lwafz.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: vc4_hdmi: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 635b1c185ee9cae61a740264d09095a7d20c019a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:35:04 +0000
Subject: [PATCH] ASoC: vc4_hdmi: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 47 ++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 984501e3f0b0..b92c6603c7a2 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -995,15 +995,17 @@ static const struct snd_soc_dapm_route vc4_hdmi_audio_routes[] = {
 	{ "TX", NULL, "Playback" },
 };
 
-static const struct snd_soc_codec_driver vc4_hdmi_audio_codec_drv = {
-	.component_driver = {
-		.controls = vc4_hdmi_audio_controls,
-		.num_controls = ARRAY_SIZE(vc4_hdmi_audio_controls),
-		.dapm_widgets = vc4_hdmi_audio_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(vc4_hdmi_audio_widgets),
-		.dapm_routes = vc4_hdmi_audio_routes,
-		.num_dapm_routes = ARRAY_SIZE(vc4_hdmi_audio_routes),
-	},
+static const struct snd_soc_component_driver vc4_hdmi_audio_component_drv = {
+	.controls		= vc4_hdmi_audio_controls,
+	.num_controls		= ARRAY_SIZE(vc4_hdmi_audio_controls),
+	.dapm_widgets		= vc4_hdmi_audio_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(vc4_hdmi_audio_widgets),
+	.dapm_routes		= vc4_hdmi_audio_routes,
+	.num_dapm_routes	= ARRAY_SIZE(vc4_hdmi_audio_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct snd_soc_dai_ops vc4_hdmi_audio_dai_ops = {
@@ -1101,11 +1103,11 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *hdmi)
 		return ret;
 	}
 
-	/* register codec and codec dai */
-	ret = snd_soc_register_codec(dev, &vc4_hdmi_audio_codec_drv,
+	/* register component and codec dai */
+	ret = devm_snd_soc_register_component(dev, &vc4_hdmi_audio_component_drv,
 				     &vc4_hdmi_audio_codec_dai_drv, 1);
 	if (ret) {
-		dev_err(dev, "Could not register codec: %d\n", ret);
+		dev_err(dev, "Could not register component: %d\n", ret);
 		return ret;
 	}
 
@@ -1130,29 +1132,11 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *hdmi)
 	 */
 	snd_soc_card_set_drvdata(card, hdmi);
 	ret = devm_snd_soc_register_card(dev, card);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "Could not register sound card: %d\n", ret);
-		goto unregister_codec;
-	}
-
-	return 0;
-
-unregister_codec:
-	snd_soc_unregister_codec(dev);
 
 	return ret;
-}
-
-static void vc4_hdmi_audio_cleanup(struct vc4_hdmi *hdmi)
-{
-	struct device *dev = &hdmi->pdev->dev;
 
-	/*
-	 * If drvdata is not set this means the audio card was not
-	 * registered, just skip codec unregistration in this case.
-	 */
-	if (dev_get_drvdata(dev))
-		snd_soc_unregister_codec(dev);
 }
 
 #ifdef CONFIG_DRM_VC4_HDMI_CEC
@@ -1480,7 +1464,6 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
 	struct vc4_dev *vc4 = drm->dev_private;
 	struct vc4_hdmi *hdmi = vc4->hdmi;
 
-	vc4_hdmi_audio_cleanup(hdmi);
 	cec_unregister_adapter(hdmi->cec_adap);
 	vc4_hdmi_connector_destroy(hdmi->connector);
 	vc4_hdmi_encoder_destroy(hdmi->encoder);
-- 
2.16.1
