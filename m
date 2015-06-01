From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/47] ASoC: wm5100: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  1 Jun 2015 10:10:26 +0200
Message-ID: <1433146266-1599-7-git-send-email-lars@metafoo.de>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 47EBA260511
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 10:11:15 +0200 (CEST)
In-Reply-To: <1433146266-1599-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to codec->dapm
with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm5100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 9674037..98495dd 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2101,7 +2101,7 @@ static void wm5100_micd_irq(struct wm5100_priv *wm5100)
 int wm5100_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 {
 	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	if (jack) {
 		wm5100->jack = jack;
@@ -2336,6 +2336,7 @@ static void wm5100_free_gpio(struct i2c_client *i2c)
 
 static int wm5100_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct i2c_client *i2c = to_i2c_client(codec->dev);
 	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
 	int ret, i;
@@ -2353,8 +2354,7 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 	/* TODO: check if we're symmetric */
 
 	if (i2c->irq)
-		snd_soc_dapm_new_controls(&codec->dapm,
-					  wm5100_dapm_widgets_noirq,
+		snd_soc_dapm_new_controls(dapm, wm5100_dapm_widgets_noirq,
 					  ARRAY_SIZE(wm5100_dapm_widgets_noirq));
 
 	if (wm5100->pdata.hp_pol) {
-- 
2.1.4
