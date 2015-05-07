From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: tosa: Automatically disconnect
	non-connected pins
Date: Thu,  7 May 2015 21:27:48 +0200
Message-ID: <1431026869-27206-3-git-send-email-lars@metafoo.de>
References: <1431026869-27206-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-207.synserver.de (smtp-out-207.synserver.de
 [212.40.185.207])
 by alsa0.perex.cz (Postfix) with ESMTP id E2227265A43
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 21:27:56 +0200 (CEST)
In-Reply-To: <1431026869-27206-1-git-send-email-lars@metafoo.de>
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

Most DAPM input and output pins of the wm9712 are either used in the card's
DAPM routing table or are marked as not connected. The only two exception
are "PHONE" and "PCBEEP" input, lets assume that those were simply
overlooked and that the routing table is complete.

Set the fully_routed flag of the card instead of manually marking the
unused inputs and outputs as not connected. This makes the code a bit
shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/tosa.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index cb49284..f59f566 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -185,17 +185,6 @@ static const struct snd_kcontrol_new tosa_controls[] = {
 		tosa_set_spk),
 };
 
-static int tosa_ac97_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_nc_pin(dapm, "OUT3");
-	snd_soc_dapm_nc_pin(dapm, "MONOOUT");
-
-	return 0;
-}
-
 static struct snd_soc_dai_link tosa_dai[] = {
 {
 	.name = "AC97",
@@ -204,7 +193,6 @@ static struct snd_soc_dai_link tosa_dai[] = {
 	.codec_dai_name = "wm9712-hifi",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm9712-codec",
-	.init = tosa_ac97_init,
 	.ops = &tosa_ops,
 },
 {
@@ -230,6 +218,7 @@ static struct snd_soc_card tosa = {
 	.num_dapm_widgets = ARRAY_SIZE(tosa_dapm_widgets),
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.fully_routed = true,
 };
 
 static int tosa_probe(struct platform_device *pdev)
-- 
1.8.0
