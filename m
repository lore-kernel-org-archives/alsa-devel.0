From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/14] ASoC: wm9713: Move driver state struct
	allocation to driver probe
Date: Thu, 30 Oct 2014 21:01:09 +0100
Message-ID: <1414699271-22797-13-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DFFE265452
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:22 +0100 (CET)
In-Reply-To: <1414699271-22797-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Resources for the device should be allocated in the device driver probe
callback, rather than in the ASoC CODEC probe callback.

E.g. one advantage is that we can use device managed allocations.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9713.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index ba8c276..2704783 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1191,17 +1191,11 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 
 static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
-	struct wm9713_priv *wm9713;
 	int ret = 0, reg;
 
-	wm9713 = kzalloc(sizeof(struct wm9713_priv), GFP_KERNEL);
-	if (wm9713 == NULL)
-		return -ENOMEM;
-	snd_soc_codec_set_drvdata(codec, wm9713);
-
 	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
 	if (ret < 0)
-		goto codec_err;
+		return ret;
 
 	/* do a cold reset for the controller and then try
 	 * a warm reset followed by an optional cold reset for codec */
@@ -1220,16 +1214,12 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 
 reset_err:
 	snd_soc_free_ac97_codec(codec);
-codec_err:
-	kfree(wm9713);
 	return ret;
 }
 
 static int wm9713_soc_remove(struct snd_soc_codec *codec)
 {
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 	snd_soc_free_ac97_codec(codec);
-	kfree(wm9713);
 	return 0;
 }
 
@@ -1256,6 +1246,14 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
 
 static int wm9713_probe(struct platform_device *pdev)
 {
+	struct wm9713_priv *wm9713;
+
+	wm9713 = devm_kzalloc(&pdev->dev, sizeof(*wm9713), GFP_KERNEL);
+	if (wm9713 == NULL)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, wm9713);
+
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_wm9713, wm9713_dai, ARRAY_SIZE(wm9713_dai));
 }
-- 
1.8.0
