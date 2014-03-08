From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: omap-abe-twl6040: No need to
	register DMIC routes seperatly
Date: Sat,  8 Mar 2014 19:16:54 +0100
Message-ID: <1394302616-15991-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-043.synserver.de
 [212.40.185.43])
 by alsa0.perex.cz (Postfix) with ESMTP id CDA3326550D
 for <alsa-devel@alsa-project.org>; Sat,  8 Mar 2014 19:16:27 +0100 (CET)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

When using table based DAPM setup there is no need to register DAPM elements for
different sub-components separately. The widgets will be registered before the
first sub-component is initialized, the routes are only added after the last
sub-component has been initialized, meaning everything will be available when it
is needed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/omap-abe-twl6040.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index ebb1390..5011bfa 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -163,6 +163,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	{"AFML", NULL, "Line In"},
 	{"AFMR", NULL, "Line In"},
+
+	/* DMIC routing */
+	{"DMic", NULL, "Digital Mic"},
+	{"Digital Mic", NULL, "Digital Mic1 Bias"},
 };
 
 static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
@@ -196,20 +200,6 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static const struct snd_soc_dapm_route dmic_audio_map[] = {
-	{"DMic", NULL, "Digital Mic"},
-	{"Digital Mic", NULL, "Digital Mic1 Bias"},
-};
-
-static int omap_abe_dmic_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	return snd_soc_dapm_add_routes(dapm, dmic_audio_map,
-				ARRAY_SIZE(dmic_audio_map));
-}
-
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link abe_twl6040_dai_links[] = {
 	{
@@ -229,7 +219,6 @@ static struct snd_soc_dai_link abe_twl6040_dai_links[] = {
 		.codec_dai_name = "dmic-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "dmic-codec",
-		.init = omap_abe_dmic_init,
 		.ops = &omap_abe_dmic_ops,
 	},
 };
-- 
1.8.0
