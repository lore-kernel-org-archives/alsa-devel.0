From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: brownstone: Automatically disconnect
	non-connected pins
Date: Thu,  7 May 2015 21:27:46 +0200
Message-ID: <1431026869-27206-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-207.synserver.de (smtp-out-207.synserver.de
 [212.40.185.207])
 by alsa0.perex.cz (Postfix) with ESMTP id DADCD265A28
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 21:27:55 +0200 (CEST)
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

Most DAPM input and output pins of the wm8994 are either used in the card's
DAPM routing table or are marked as not connected.

The only exception is DMIC2DAT input. Given that DMIC1DAT is explicitly
mentioned in the DAPM routes lets assume that DMIC2DAT simply has been
overlooked and should be marked as not connected.

Set the fully_routed flag of the card instead of manually marking the
unused inputs and outputs as not connected. This makes the code a bit
shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/brownstone.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 79936e3..2b26318 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -45,29 +45,6 @@ static const struct snd_soc_dapm_route brownstone_audio_map[] = {
 	{"MICBIAS1", NULL, "Main Mic"},
 };
 
-static int brownstone_wm8994_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	/* set endpoints to not connected */
-	snd_soc_dapm_nc_pin(dapm, "HPOUT2P");
-	snd_soc_dapm_nc_pin(dapm, "HPOUT2N");
-	snd_soc_dapm_nc_pin(dapm, "LINEOUT1N");
-	snd_soc_dapm_nc_pin(dapm, "LINEOUT1P");
-	snd_soc_dapm_nc_pin(dapm, "LINEOUT2N");
-	snd_soc_dapm_nc_pin(dapm, "LINEOUT2P");
-	snd_soc_dapm_nc_pin(dapm, "IN1LN");
-	snd_soc_dapm_nc_pin(dapm, "IN1LP");
-	snd_soc_dapm_nc_pin(dapm, "IN1RP");
-	snd_soc_dapm_nc_pin(dapm, "IN2LP:VXRN");
-	snd_soc_dapm_nc_pin(dapm, "IN2RN");
-	snd_soc_dapm_nc_pin(dapm, "IN2RP:VXRP");
-	snd_soc_dapm_nc_pin(dapm, "IN2LN");
-
-	return 0;
-}
-
 static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
 {
@@ -115,7 +92,6 @@ static struct snd_soc_dai_link brownstone_wm8994_dai[] = {
 	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &brownstone_ops,
-	.init		= brownstone_wm8994_init,
 },
 };
 
@@ -132,6 +108,7 @@ static struct snd_soc_card brownstone = {
 	.num_dapm_widgets = ARRAY_SIZE(brownstone_dapm_widgets),
 	.dapm_routes = brownstone_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(brownstone_audio_map),
+	.fully_routed = true,
 };
 
 static int brownstone_probe(struct platform_device *pdev)
-- 
1.8.0
