From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] ASoC: palm27x: Automatically disconnect
	non-connected pins
Date: Fri,  9 Jan 2015 22:03:32 +0100
Message-ID: <1420837413-29306-7-git-send-email-lars@metafoo.de>
References: <1420837413-29306-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-098.synserver.de
 [212.40.185.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 1493226060E
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 22:03:40 +0100 (CET)
In-Reply-To: <1420837413-29306-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

All DAPM input and output pins of the wm9712 are either used in the card's
DAPM routing table or are marked as not connected.

Set the fully_routed flag of the card instead of manually marking the unused
inputs and outputs as not connected. This makes the code a bit shorter and
cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/palm27x.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 5a0b82f..910336c 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -76,18 +76,8 @@ static struct snd_soc_card palm27x_asoc;
 static int palm27x_ac97_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
-	/* not connected pins */
-	snd_soc_dapm_nc_pin(dapm, "OUT3");
-	snd_soc_dapm_nc_pin(dapm, "MONOOUT");
-	snd_soc_dapm_nc_pin(dapm, "LINEINL");
-	snd_soc_dapm_nc_pin(dapm, "LINEINR");
-	snd_soc_dapm_nc_pin(dapm, "PCBEEP");
-	snd_soc_dapm_nc_pin(dapm, "PHONE");
-	snd_soc_dapm_nc_pin(dapm, "MIC2");
-
 	/* Jack detection API stuff */
 	err = snd_soc_jack_new(codec, "Headphone Jack",
 				SND_JACK_HEADPHONE, &hs_jack);
@@ -133,7 +123,8 @@ static struct snd_soc_card palm27x_asoc = {
 	.dapm_widgets = palm27x_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(palm27x_dapm_widgets),
 	.dapm_routes = audio_map,
-	.num_dapm_routes = ARRAY_SIZE(audio_map)
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.fully_routed = true,
 };
 
 static int palm27x_asoc_probe(struct platform_device *pdev)
-- 
1.8.0
