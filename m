From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: jive: Automatically disconnect
	non-connected pins
Date: Fri, 16 Jan 2015 14:34:52 +0100
Message-ID: <1421415293-29589-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-006.synserver.de (smtp-out-006.synserver.de
 [212.40.185.6]) by alsa0.perex.cz (Postfix) with ESMTP id CACA2260513
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 14:34:57 +0100 (CET)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

All DAPM input and output pins of the wm8750 are either used in the card's
DAPM routing table or are marked as not connected.

Set the fully_routed flag of the card instead of manually marking the unused
inputs and outputs as not connected. This makes the code a bit shorter and
cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/jive_wm8750.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
index 6c3b359..7fcb51f 100644
--- a/sound/soc/samsung/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -83,22 +83,6 @@ static struct snd_soc_ops jive_ops = {
 	.hw_params	= jive_hw_params,
 };
 
-static int jive_wm8750_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	/* These endpoints are not being used. */
-	snd_soc_dapm_nc_pin(dapm, "LINPUT2");
-	snd_soc_dapm_nc_pin(dapm, "RINPUT2");
-	snd_soc_dapm_nc_pin(dapm, "LINPUT3");
-	snd_soc_dapm_nc_pin(dapm, "RINPUT3");
-	snd_soc_dapm_nc_pin(dapm, "OUT3");
-	snd_soc_dapm_nc_pin(dapm, "MONO");
-
-	return 0;
-}
-
 static struct snd_soc_dai_link jive_dai = {
 	.name		= "wm8750",
 	.stream_name	= "WM8750",
@@ -106,7 +90,6 @@ static struct snd_soc_dai_link jive_dai = {
 	.codec_dai_name = "wm8750-hifi",
 	.platform_name	= "s3c2412-i2s",
 	.codec_name	= "wm8750.0-001a",
-	.init		= jive_wm8750_init,
 	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &jive_ops,
@@ -123,6 +106,7 @@ static struct snd_soc_card snd_soc_machine_jive = {
 	.num_dapm_widgets = ARRAY_SIZE(wm8750_dapm_widgets),
 	.dapm_routes	= audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.fully_routed	= true,
 };
 
 static struct platform_device *jive_snd_device;
-- 
1.8.0
