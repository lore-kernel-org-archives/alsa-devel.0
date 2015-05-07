From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: poodle: Automatically disconnect
	non-connected pins
Date: Thu,  7 May 2015 21:27:47 +0200
Message-ID: <1431026869-27206-2-git-send-email-lars@metafoo.de>
References: <1431026869-27206-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-207.synserver.de (smtp-out-207.synserver.de
 [212.40.185.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DDD9265A2D
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

The Zaurus SL-5600 seems to have a microphone input. Otherwise all DAPM
input and output pins of the wm8731 are either used in the card's DAPM
routing table or are marked as not connected.

So add the microphone to the DAPM tables and set the fully_routed flag of
the card instead of manually marking the unused inputs and outputs as not
connected. This makes the code a bit shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/poodle.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 0fce8c4..80b457a 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -192,6 +192,7 @@ static int poodle_amp_event(struct snd_soc_dapm_widget *w,
 static const struct snd_soc_dapm_widget wm8731_dapm_widgets[] = {
 SND_SOC_DAPM_HP("Headphone Jack", NULL),
 SND_SOC_DAPM_SPK("Ext Spk", poodle_amp_event),
+SND_SOC_DAPM_MIC("Microphone", NULL),
 };
 
 /* Corgi machine connections to the codec pins */
@@ -204,6 +205,8 @@ static const struct snd_soc_dapm_route poodle_audio_map[] = {
 	/* speaker connected to LOUT, ROUT */
 	{"Ext Spk", NULL, "ROUT"},
 	{"Ext Spk", NULL, "LOUT"},
+
+	{"MICIN", NULL, "Microphone"},
 };
 
 static const char *jack_function[] = {"Off", "Headphone"};
@@ -220,20 +223,6 @@ static const struct snd_kcontrol_new wm8731_poodle_controls[] = {
 		poodle_set_spk),
 };
 
-/*
- * Logic for a wm8731 as connected on a Sharp SL-C7x0 Device
- */
-static int poodle_wm8731_init(struct snd_soc_pcm_runtime *rtd)
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
 /* poodle digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link poodle_dai = {
 	.name = "WM8731",
@@ -242,7 +231,6 @@ static struct snd_soc_dai_link poodle_dai = {
 	.codec_dai_name = "wm8731-hifi",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm8731.0-001b",
-	.init = poodle_wm8731_init,
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &poodle_ops,
@@ -261,6 +249,7 @@ static struct snd_soc_card poodle = {
 	.num_dapm_widgets = ARRAY_SIZE(wm8731_dapm_widgets),
 	.dapm_routes = poodle_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(poodle_audio_map),
+	.fully_routed = true,
 };
 
 static int poodle_probe(struct platform_device *pdev)
-- 
1.8.0
