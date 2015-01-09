From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/8] ASoC: magician: Automatically disconnect
	non-connected pins
Date: Fri,  9 Jan 2015 22:03:30 +0100
Message-ID: <1420837413-29306-5-git-send-email-lars@metafoo.de>
References: <1420837413-29306-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-098.synserver.de
 [212.40.185.98])
 by alsa0.perex.cz (Postfix) with ESMTP id DC57826057D
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 22:03:38 +0100 (CET)
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

All DAPM input and output pins of the uda1380 are either used in the card's
DAPM routing table or are marked as not connected.

Set the fully_routed flag of the card instead of manually marking the unused
inputs and outputs as not connected. This makes the code a bit shorter and
cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/magician.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 259e048..241d0be 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -391,25 +391,6 @@ static const struct snd_kcontrol_new uda1380_magician_controls[] = {
 			magician_get_input, magician_set_input),
 };
 
-/*
- * Logic for a uda1380 as connected on a HTC Magician
- */
-static int magician_uda1380_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	/* NC codec pins */
-	snd_soc_dapm_nc_pin(dapm, "VOUTLHP");
-	snd_soc_dapm_nc_pin(dapm, "VOUTRHP");
-
-	/* FIXME: is anything connected here? */
-	snd_soc_dapm_nc_pin(dapm, "VINL");
-	snd_soc_dapm_nc_pin(dapm, "VINR");
-
-	return 0;
-}
-
 /* magician digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link magician_dai[] = {
 {
@@ -419,7 +400,6 @@ static struct snd_soc_dai_link magician_dai[] = {
 	.codec_dai_name = "uda1380-hifi-playback",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "uda1380-codec.0-0018",
-	.init = magician_uda1380_init,
 	.ops = &magician_playback_ops,
 },
 {
@@ -446,6 +426,7 @@ static struct snd_soc_card snd_soc_card_magician = {
 	.num_dapm_widgets = ARRAY_SIZE(uda1380_dapm_widgets),
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.fully_routed = true,
 };
 
 static struct platform_device *magician_snd_device;
-- 
1.8.0
