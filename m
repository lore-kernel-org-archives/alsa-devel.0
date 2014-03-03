From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: migor: Convert to table based DAPM setup
Date: Mon,  3 Mar 2014 08:14:14 +0100
Message-ID: <1393830854-17460-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 334BF2655BF
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 08:13:50 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the DAPM widgets and routes.  This on one hand
makes the code a bit shorter and cleaner and on the other hand the board level
DAPM elements get registered in the card's DAPM context rather than in the
CODEC's DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/sh/migor.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index 5014a88..c58c252 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -136,19 +136,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{ "Mic Bias", NULL, "External Microphone" },
 };
 
-static int migor_dai_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, migor_dapm_widgets,
-				  ARRAY_SIZE(migor_dapm_widgets));
-
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 /* migor digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link migor_dai = {
 	.name = "wm8978",
@@ -158,7 +145,6 @@ static struct snd_soc_dai_link migor_dai = {
 	.platform_name = "siu-pcm-audio",
 	.codec_name = "wm8978.0-001a",
 	.ops = &migor_dai_ops,
-	.init = migor_dai_init,
 };
 
 /* migor audio machine driver */
@@ -167,6 +153,11 @@ static struct snd_soc_card snd_soc_migor = {
 	.owner = THIS_MODULE,
 	.dai_link = &migor_dai,
 	.num_links = 1,
+
+	.dapm_widgets = migor_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(migor_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct platform_device *migor_snd_device;
-- 
1.8.0
