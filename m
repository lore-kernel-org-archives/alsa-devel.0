From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: wm1133-ev1: Convert to table based DAPM
	setup
Date: Mon,  3 Mar 2014 08:17:08 +0100
Message-ID: <1393831028-17738-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id D3FFF265506
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 08:16:37 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the DAPM widgets and routes.  This on one hand
makes the code a bit shorter and cleaner and on the other hand the board level
DAPM elements get registered in the card's DAPM context rather than in the
CODEC's DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/wm1133-ev1.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index fce6325..804749a 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -214,12 +214,6 @@ static int wm1133_ev1_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(dapm, wm1133_ev1_widgets,
-				  ARRAY_SIZE(wm1133_ev1_widgets));
-
-	snd_soc_dapm_add_routes(dapm, wm1133_ev1_map,
-				ARRAY_SIZE(wm1133_ev1_map));
-
 	/* Headphone jack detection */
 	snd_soc_jack_new(codec, "Headphone", SND_JACK_HEADPHONE, &hp_jack);
 	snd_soc_jack_add_pins(&hp_jack, ARRAY_SIZE(hp_jack_pins),
@@ -257,6 +251,11 @@ static struct snd_soc_card wm1133_ev1 = {
 	.owner = THIS_MODULE,
 	.dai_link = &wm1133_ev1_dai,
 	.num_links = 1,
+
+	.dapm_widgets = wm1133_ev1_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm1133_ev1_widgets),
+	.dapm_routes = wm1133_ev1_map,
+	.num_dapm_routes = ARRAY_SIZE(wm1133_ev1_map),
 };
 
 static struct platform_device *wm1133_ev1_snd_device;
-- 
1.8.0
