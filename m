From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: wm97xx: Reset AC'97 device before
	registering it
Date: Fri, 23 Jan 2015 16:21:37 +0100
Message-ID: <1422026497-23180-3-git-send-email-lars@metafoo.de>
References: <1422026497-23180-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-206.synserver.de
 [212.40.185.206])
 by alsa0.perex.cz (Postfix) with ESMTP id F00552654F1
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:59:13 +0100 (CET)
In-Reply-To: <1422026497-23180-1-git-send-email-lars@metafoo.de>
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The wm97xx touchscreen driver binds itself to the snd_ac97 device that gets
registered by the CODEC driver and expects that the device has already been
reset. Before commit 6794f709b712 ("ASoC: ac97: Drop delayed device
registration") the device was only registered after the probe function of
the CODEC driver had finished running, but starting with the mentioned
commit the device is registered as soon as snd_soc_new_ac97_codec() is
called. This causes the touchscreen driver to no longer work. Modify the
CODEC drivers to use snd_soc_alloc_ac97_codec() instead of
snd_soc_new_ac97_codec() and make sure that the AC'97 device is reset before
the snd_ac97 device gets registered.

Fixes: 6794f709b712 ("ASoC: ac97: Drop delayed device registration")
Reported-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9705.c | 16 ++++++++++------
 sound/soc/codecs/wm9712.c | 12 ++++++++----
 sound/soc/codecs/wm9713.c | 12 ++++++++----
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 3eddb18..5cc457e 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -344,23 +344,27 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 	struct snd_ac97 *ac97;
 	int ret = 0;
 
-	ac97 = snd_soc_new_ac97_codec(codec);
+	ac97 = snd_soc_alloc_ac97_codec(codec);
 	if (IS_ERR(ac97)) {
 		ret = PTR_ERR(ac97);
 		dev_err(codec->dev, "Failed to register AC97 codec\n");
 		return ret;
 	}
 
-	snd_soc_codec_set_drvdata(codec, ac97);
-
 	ret = wm9705_reset(codec);
 	if (ret)
-		goto reset_err;
+		goto err_put_device;
+
+	ret = device_add(&ac97->dev);
+	if (ret)
+		goto err_put_device;
+
+	snd_soc_codec_set_drvdata(codec, ac97);
 
 	return 0;
 
-reset_err:
-	snd_soc_free_ac97_codec(ac97);
+err_put_device:
+	put_device(&ac97->dev);
 	return ret;
 }
 
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index e04643d..9517571 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -666,7 +666,7 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	wm9712->ac97 = snd_soc_new_ac97_codec(codec);
+	wm9712->ac97 = snd_soc_alloc_ac97_codec(codec);
 	if (IS_ERR(wm9712->ac97)) {
 		ret = PTR_ERR(wm9712->ac97);
 		dev_err(codec->dev, "Failed to register AC97 codec: %d\n", ret);
@@ -675,15 +675,19 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 
 	ret = wm9712_reset(codec, 0);
 	if (ret < 0)
-		goto reset_err;
+		goto err_put_device;
+
+	ret = device_add(&wm9712->ac97->dev);
+	if (ret)
+		goto err_put_device;
 
 	/* set alc mux to none */
 	ac97_write(codec, AC97_VIDEO, ac97_read(codec, AC97_VIDEO) | 0x3000);
 
 	return 0;
 
-reset_err:
-	snd_soc_free_ac97_codec(wm9712->ac97);
+err_put_device:
+	put_device(&wm9712->ac97->dev);
 	return ret;
 }
 
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index e5807de..6822291 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1225,7 +1225,7 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0, reg;
 
-	wm9713->ac97 = snd_soc_new_ac97_codec(codec);
+	wm9713->ac97 = snd_soc_alloc_ac97_codec(codec);
 	if (IS_ERR(wm9713->ac97))
 		return PTR_ERR(wm9713->ac97);
 
@@ -1234,7 +1234,11 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	wm9713_reset(codec, 0);
 	ret = wm9713_reset(codec, 1);
 	if (ret < 0)
-		goto reset_err;
+		goto err_put_device;
+
+	ret = device_add(&wm9713->ac97->dev);
+	if (ret)
+		goto err_put_device;
 
 	/* unmute the adc - move to kcontrol */
 	reg = ac97_read(codec, AC97_CD) & 0x7fff;
@@ -1242,8 +1246,8 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 
 	return 0;
 
-reset_err:
-	snd_soc_free_ac97_codec(wm9713->ac97);
+err_put_device:
+	put_device(&wm9713->ac97->dev);
 	return ret;
 }
 
-- 
1.8.0
