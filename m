From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] ASoC: e750: Automatically disconnect
	non-connected pins
Date: Fri,  9 Jan 2015 22:03:28 +0100
Message-ID: <1420837413-29306-3-git-send-email-lars@metafoo.de>
References: <1420837413-29306-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-098.synserver.de
 [212.40.185.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 682EF260572
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 22:03:37 +0100 (CET)
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

All DAPM input and output pins of the wm9705 are either used in the card's
DAPM routing table or are marked as not connected.

Set the fully_routed flag of the card instead of manually marking the unused
inputs and outputs as not connected. This makes the code a bit shorter and
cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/e750_wm9705.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 30544b6..48f2d7c 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -70,24 +70,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"MIC1", NULL, "Mic (Internal)"},
 };
 
-static int e750_ac97_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_nc_pin(dapm, "LOUT");
-	snd_soc_dapm_nc_pin(dapm, "ROUT");
-	snd_soc_dapm_nc_pin(dapm, "PHONE");
-	snd_soc_dapm_nc_pin(dapm, "LINEINL");
-	snd_soc_dapm_nc_pin(dapm, "LINEINR");
-	snd_soc_dapm_nc_pin(dapm, "CDINL");
-	snd_soc_dapm_nc_pin(dapm, "CDINR");
-	snd_soc_dapm_nc_pin(dapm, "PCBEEP");
-	snd_soc_dapm_nc_pin(dapm, "MIC2");
-
-	return 0;
-}
-
 static struct snd_soc_dai_link e750_dai[] = {
 	{
 		.name = "AC97",
@@ -96,7 +78,6 @@ static struct snd_soc_dai_link e750_dai[] = {
 		.codec_dai_name = "wm9705-hifi",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
-		.init = e750_ac97_init,
 		/* use ops to check startup state */
 	},
 	{
@@ -119,6 +100,7 @@ static struct snd_soc_card e750 = {
 	.num_dapm_widgets = ARRAY_SIZE(e750_dapm_widgets),
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.fully_routed = true,
 };
 
 static struct gpio e750_audio_gpios[] = {
-- 
1.8.0
