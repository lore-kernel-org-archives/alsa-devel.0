From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: davinci-evm: Register machine level DAPM
	elements with the card
Date: Mon,  3 Mar 2014 08:20:55 +0100
Message-ID: <1393831255-18033-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 382732654CE
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 08:20:26 +0100 (CET)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Machine level DAPM widgets and routes should be registered in the card's DAPM
context, rather than in the CODEC's context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/davinci/davinci-evm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 5e3bc3c..8d10244 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -95,23 +95,24 @@ static const struct snd_soc_dapm_route audio_map[] = {
 /* Logic for a aic3x as connected on a davinci-evm */
 static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct device_node *np = codec->card->dev->of_node;
 	int ret;
 
 	/* Add davinci-evm specific widgets */
-	snd_soc_dapm_new_controls(dapm, aic3x_dapm_widgets,
+	snd_soc_dapm_new_controls(&card->dapm, aic3x_dapm_widgets,
 				  ARRAY_SIZE(aic3x_dapm_widgets));
 
 	if (np) {
-		ret = snd_soc_of_parse_audio_routing(codec->card,
-							"ti,audio-routing");
+		ret = snd_soc_of_parse_audio_routing(card, "ti,audio-routing");
 		if (ret)
 			return ret;
 	} else {
 		/* Set up davinci-evm specific audio path audio_map */
-		snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
+		snd_soc_dapm_add_routes(&card->dapm, audio_map,
+					ARRAY_SIZE(audio_map));
 	}
 
 	/* not connected */
@@ -120,10 +121,10 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_disable_pin(dapm, "HPRCOM");
 
 	/* always connected */
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-	snd_soc_dapm_enable_pin(dapm, "Line Out");
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-	snd_soc_dapm_enable_pin(dapm, "Line In");
+	snd_soc_dapm_enable_pin(&card->dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(&card->dapm, "Line Out");
+	snd_soc_dapm_enable_pin(&card->dapm, "Mic Jack");
+	snd_soc_dapm_enable_pin(&card->dapm, "Line In");
 
 	return 0;
 }
-- 
1.8.0
