From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: z2: Automatically disconnect
	non-connected pins
Date: Thu,  7 May 2015 21:27:49 +0200
Message-ID: <1431026869-27206-4-git-send-email-lars@metafoo.de>
References: <1431026869-27206-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-207.synserver.de (smtp-out-207.synserver.de
 [212.40.185.207])
 by alsa0.perex.cz (Postfix) with ESMTP id AF1AD265A45
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 21:27:57 +0200 (CEST)
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

Most DAPM input and output pins of the wm8750 are either used in the card's
DAPM routing table or are marked as not connected. The only exceptions are
the LINPUT1, RINPUT1, LINPUT2 input pins. Lets assume that those were
simply overlooked and that the routing table is complete.

Set the fully_routed flag of the card instead of manually marking the
unused inputs and outputs as not connected. This makes the code a bit
shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/z2.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index bcbfbe8..990b1aa 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -132,16 +132,8 @@ static const struct snd_soc_dapm_route z2_audio_map[] = {
  */
 static int z2_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	/* NC codec pins */
-	snd_soc_dapm_disable_pin(dapm, "LINPUT3");
-	snd_soc_dapm_disable_pin(dapm, "RINPUT3");
-	snd_soc_dapm_disable_pin(dapm, "OUT3");
-	snd_soc_dapm_disable_pin(dapm, "MONO1");
-
 	/* Jack detection API stuff */
 	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack", SND_JACK_HEADSET,
 				    &hs_jack, hs_jack_pins,
@@ -189,6 +181,7 @@ static struct snd_soc_card snd_soc_z2 = {
 	.num_dapm_widgets = ARRAY_SIZE(wm8750_dapm_widgets),
 	.dapm_routes = z2_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(z2_audio_map),
+	.fully_routed = true,
 };
 
 static struct platform_device *z2_snd_device;
-- 
1.8.0
