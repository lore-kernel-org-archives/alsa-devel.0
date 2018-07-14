From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] ASoC: hdmi-codec: fix routing
Date: Sat, 14 Jul 2018 16:01:06 +0100
Message-ID: <E1feM2k-0000p7-9v@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by alsa0.perex.cz (Postfix) with ESMTP id AE93326733D
 for <alsa-devel@alsa-project.org>; Sat, 14 Jul 2018 17:01:19 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

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
2.7.4
