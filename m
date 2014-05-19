From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: davinci-evm: Replace instances of
	rtd->codec->card with rtd->card
Date: Mon, 19 May 2014 11:41:47 +0200
Message-ID: <1400492508-2732-3-git-send-email-lars@metafoo.de>
References: <1400492508-2732-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D8BF92650A9
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 11:41:53 +0200 (CEST)
In-Reply-To: <1400492508-2732-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Fabio Baltieri <fabio.baltieri@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

No need to go via the CODEC to get a pointer to the card. This will help to
eventually remove the card field from the snd_soc_codec struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/davinci/davinci-evm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index cab98a5..a50010e 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -38,7 +38,7 @@ struct snd_soc_card_drvdata_davinci {
 static int evm_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_card *soc_card = rtd->codec->card;
+	struct snd_soc_card *soc_card = rtd->card;
 	struct snd_soc_card_drvdata_davinci *drvdata =
 		snd_soc_card_get_drvdata(soc_card);
 
@@ -51,7 +51,7 @@ static int evm_startup(struct snd_pcm_substream *substream)
 static void evm_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_card *soc_card = rtd->codec->card;
+	struct snd_soc_card *soc_card = rtd->card;
 	struct snd_soc_card_drvdata_davinci *drvdata =
 		snd_soc_card_get_drvdata(soc_card);
 
@@ -65,8 +65,7 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_card *soc_card = codec->card;
+	struct snd_soc_card *soc_card = rtd->card;
 	int ret = 0;
 	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
 			   snd_soc_card_get_drvdata(soc_card))->sysclk;
@@ -125,7 +124,7 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_codec *codec = rtd->codec;
-	struct device_node *np = codec->card->dev->of_node;
+	struct device_node *np = card->dev->of_node;
 	int ret;
 
 	/* Add davinci-evm specific widgets */
-- 
1.8.0
