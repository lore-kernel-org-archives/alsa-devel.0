From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: fix routing" to the asoc
	tree
Date: Mon, 16 Jul 2018 15:30:51 +0100
Message-ID: <E1ff4WZ-0005Wb-U6@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 916B4267750
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 16:30:54 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: fix routing

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

>From d30e23d69981a4b665f5ce8711335df986576389 Mon Sep 17 00:00:00 2001
From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Sat, 14 Jul 2018 16:01:06 +0100
Subject: [PATCH] ASoC: hdmi-codec: fix routing

Commit 943fa0228252 ("ASoC: hdmi-codec: Use different name for playback
streams") broke hdmi-codec's routing between it's output "TX" widget
and the S/PDIF or I2S streams by renaming the streams.

Whether an error occurs or not is dependent on whether there is another
widget called "Playback" registered by some other component - if there
is, that widget will be (incorrectly) bound to the HDMI codec's "TX"
output widget.  If we end up connecting "TX" incorrectly, it can result
in components not being started, causing no audio output.

Since the I2S and S/PDIF streams now have different names, we can't
use a static route at component level to describe the relationship, so
arrange to dynamically create the route when the DAI driver is probed.

Fixes: 943fa0228252 ("ASoC: hdmi-codec: Use different name for playback streams")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 6fa11888672d..3e5b12de71bb 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -291,10 +291,6 @@ static const struct snd_soc_dapm_widget hdmi_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("TX"),
 };
 
-static const struct snd_soc_dapm_route hdmi_routes[] = {
-	{ "TX", NULL, "Playback" },
-};
-
 enum {
 	DAI_ID_I2S = 0,
 	DAI_ID_SPDIF,
@@ -689,9 +685,23 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	return snd_ctl_add(rtd->card->snd_card, kctl);
 }
 
+static int hdmi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct snd_soc_dapm_context *dapm;
+	struct snd_soc_dapm_route route = {
+		.sink = "TX",
+		.source = dai->driver->playback.stream_name,
+	};
+
+	dapm = snd_soc_component_get_dapm(dai->component);
+
+	return snd_soc_dapm_add_routes(dapm, &route, 1);
+}
+
 static const struct snd_soc_dai_driver hdmi_i2s_dai = {
 	.name = "i2s-hifi",
 	.id = DAI_ID_I2S,
+	.probe = hdmi_dai_probe,
 	.playback = {
 		.stream_name = "I2S Playback",
 		.channels_min = 2,
@@ -707,6 +717,7 @@ static const struct snd_soc_dai_driver hdmi_i2s_dai = {
 static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 	.name = "spdif-hifi",
 	.id = DAI_ID_SPDIF,
+	.probe = hdmi_dai_probe,
 	.playback = {
 		.stream_name = "SPDIF Playback",
 		.channels_min = 2,
@@ -733,8 +744,6 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
 static const struct snd_soc_component_driver hdmi_driver = {
 	.dapm_widgets		= hdmi_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
-	.dapm_routes		= hdmi_routes,
-	.num_dapm_routes	= ARRAY_SIZE(hdmi_routes),
 	.of_xlate_dai_id	= hdmi_of_xlate_dai_id,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
-- 
2.18.0.rc2
