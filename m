From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] ASoC: corgi: Automatically disconnect
	non-connected pins
Date: Fri,  9 Jan 2015 22:03:26 +0100
Message-ID: <1420837413-29306-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-098.synserver.de
 [212.40.185.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 9503F260438
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 22:03:35 +0100 (CET)
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

All DAPM input and output pins of the wm8994 are either used in the card's
DAPM routing table or are marked as not connected.

Set the fully_routed flag of the card instead of manually marking the unused
inputs and outputs as not connected. This makes the code a bit shorter and
cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/corgi.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index b7cd0a7..3580d10 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -259,20 +259,6 @@ static const struct snd_kcontrol_new wm8731_corgi_controls[] = {
 		corgi_set_spk),
 };
 
-/*
- * Logic for a wm8731 as connected on a Sharp SL-C7x0 Device
- */
-static int corgi_wm8731_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_nc_pin(dapm, "LLINEIN");
-	snd_soc_dapm_nc_pin(dapm, "RLINEIN");
-
-	return 0;
-}
-
 /* corgi digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link corgi_dai = {
 	.name = "WM8731",
@@ -281,7 +267,6 @@ static struct snd_soc_dai_link corgi_dai = {
 	.codec_dai_name = "wm8731-hifi",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm8731.0-001b",
-	.init = corgi_wm8731_init,
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &corgi_ops,
@@ -300,6 +285,7 @@ static struct snd_soc_card corgi = {
 	.num_dapm_widgets = ARRAY_SIZE(wm8731_dapm_widgets),
 	.dapm_routes = corgi_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(corgi_audio_map),
+	.fully_routed = true,
 };
 
 static int corgi_probe(struct platform_device *pdev)
-- 
1.8.0
