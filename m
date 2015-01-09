From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] ASoC: hx4700: Automatically disconnect
	non-connected pins
Date: Fri,  9 Jan 2015 22:03:29 +0100
Message-ID: <1420837413-29306-4-git-send-email-lars@metafoo.de>
References: <1420837413-29306-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-098.synserver.de
 [212.40.185.98])
 by alsa0.perex.cz (Postfix) with ESMTP id BE2C72604E5
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

All DAPM input and output pins of the ak4641 are either used in the card's
DAPM routing table or are marked as not connected.

Set the fully_routed flag of the card instead of manually marking the unused
inputs and outputs as not connected. This makes the code a bit shorter and
cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/hx4700.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index ce26551..73eb5dd 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -127,15 +127,8 @@ static const struct snd_soc_dapm_route hx4700_audio_map[] = {
 static int hx4700_ak4641_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
-	/* NC codec pins */
-	/* FIXME: is anything connected here? */
-	snd_soc_dapm_nc_pin(dapm, "MOUT1");
-	snd_soc_dapm_nc_pin(dapm, "MICEXT");
-	snd_soc_dapm_nc_pin(dapm, "AUX");
-
 	/* Jack detection API stuff */
 	err = snd_soc_jack_new(codec, "Headphone Jack",
 				SND_JACK_HEADPHONE, &hs_jack);
@@ -184,6 +177,7 @@ static struct snd_soc_card snd_soc_card_hx4700 = {
 	.num_dapm_widgets	= ARRAY_SIZE(hx4700_dapm_widgets),
 	.dapm_routes		= hx4700_audio_map,
 	.num_dapm_routes	= ARRAY_SIZE(hx4700_audio_map),
+	.fully_routed		= true,
 };
 
 static struct gpio hx4700_audio_gpios[] = {
-- 
1.8.0
