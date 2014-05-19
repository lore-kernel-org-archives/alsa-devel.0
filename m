From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: omap: Replace instances of
	rtd->codec->card with rtd->card
Date: Mon, 19 May 2014 11:41:46 +0200
Message-ID: <1400492508-2732-2-git-send-email-lars@metafoo.de>
References: <1400492508-2732-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D5035261ADB
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 11:41:52 +0200 (CEST)
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
 sound/soc/omap/omap-abe-twl6040.c | 5 ++---
 sound/soc/omap/omap-twl4030.c     | 5 ++---
 sound/soc/omap/rx51.c             | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 1a89e5b..cec836e 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -47,8 +47,7 @@ static int omap_abe_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct abe_twl6040 *priv = snd_soc_card_get_drvdata(card);
 	int clk_id, freq;
 	int ret;
@@ -168,7 +167,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct abe_twl6040 *priv = snd_soc_card_get_drvdata(card);
 	int hs_trim;
 	int ret = 0;
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index 0c83e20..64141db 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -55,8 +55,7 @@ static int omap_twl4030_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	unsigned int fmt;
 	int ret;
 
@@ -179,7 +178,7 @@ static inline void twl4030_disconnect_pin(struct snd_soc_dapm_context *dapm,
 static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct omap_tw4030_pdata *pdata = dev_get_platdata(card->dev);
 	struct omap_twl4030 *priv = snd_soc_card_get_drvdata(card);
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 866578b..6951dc8 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -286,7 +286,7 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
 static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = rtd->card;
 	struct rx51_audio_pdata *pdata = snd_soc_card_get_drvdata(card);
 
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-- 
1.8.0
