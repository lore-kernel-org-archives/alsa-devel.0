From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] ASoC: spitz: Automatically disconnect
	non-connected pins
Date: Fri,  9 Jan 2015 22:03:33 +0100
Message-ID: <1420837413-29306-8-git-send-email-lars@metafoo.de>
References: <1420837413-29306-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-098.synserver.de
 [212.40.185.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FDE426061E
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 22:03:41 +0100 (CET)
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

All DAPM input and output pins of the wm8750 are either used in the card's
DAPM routing table or are marked as not connected.

Set the fully_routed flag of the card instead of manually marking the unused
inputs and outputs as not connected. This makes the code a bit shorter and
cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/spitz.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index a6d680a..461123a 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -256,26 +256,6 @@ static const struct snd_kcontrol_new wm8750_spitz_controls[] = {
 		spitz_set_spk),
 };
 
-/*
- * Logic for a wm8750 as connected on a Sharp SL-Cxx00 Device
- */
-static int spitz_wm8750_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	/* NC codec pins */
-	snd_soc_dapm_nc_pin(dapm, "RINPUT1");
-	snd_soc_dapm_nc_pin(dapm, "LINPUT2");
-	snd_soc_dapm_nc_pin(dapm, "RINPUT2");
-	snd_soc_dapm_nc_pin(dapm, "LINPUT3");
-	snd_soc_dapm_nc_pin(dapm, "RINPUT3");
-	snd_soc_dapm_nc_pin(dapm, "OUT3");
-	snd_soc_dapm_nc_pin(dapm, "MONO1");
-
-	return 0;
-}
-
 /* spitz digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link spitz_dai = {
 	.name = "wm8750",
@@ -284,7 +264,6 @@ static struct snd_soc_dai_link spitz_dai = {
 	.codec_dai_name = "wm8750-hifi",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm8750.0-001b",
-	.init = spitz_wm8750_init,
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &spitz_ops,
@@ -303,6 +282,7 @@ static struct snd_soc_card snd_soc_spitz = {
 	.num_dapm_widgets = ARRAY_SIZE(wm8750_dapm_widgets),
 	.dapm_routes = spitz_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(spitz_audio_map),
+	.fully_routed = true,
 };
 
 static int spitz_probe(struct platform_device *pdev)
-- 
1.8.0
