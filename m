From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC codec error reporting.
Date: Tue, 30 Jan 2007 18:26:43 +0000
Message-ID: <1170181603.22167.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-NXP8S8Z8mr155QYwB2d1"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-NXP8S8Z8mr155QYwB2d1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch improves the codec probe() error reporting by printing error
messages when the card or pcms fail to register.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
 

--=-NXP8S8Z8mr155QYwB2d1
Content-Disposition: attachment; filename=asoc-codec-err.patch
Content-Type: text/x-patch; name=asoc-codec-err.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 3be2f03501ef soc/codecs/wm8731.c
--- a/soc/codecs/wm8731.c	Tue Jan 30 17:30:55 2007 +0100
+++ b/soc/codecs/wm8731.c	Tue Jan 30 18:25:07 2007 +0000
@@ -696,8 +696,8 @@ static int wm8731_init(struct snd_soc_de
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
-		kfree(codec->reg_cache);
-		return ret;
+		printk(KERN_ERR "wm8731: failed to create pcms\n");
+		goto pcm_err;
 	}
 
 	/* power on device */
@@ -717,10 +717,17 @@ static int wm8731_init(struct snd_soc_de
 	wm8731_add_widgets(codec);
 	ret = snd_soc_register_card(socdev);
 	if (ret < 0) {
-		snd_soc_free_pcms(socdev);
-		snd_soc_dapm_free(socdev);
-	}
-
+		printk(KERN_ERR "wm8731: failed to register card\n");
+		goto card_err;
+	}
+
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	kfree(codec->reg_cache);
 	return ret;
 }
 
diff -r 3be2f03501ef soc/codecs/wm8750.c
--- a/soc/codecs/wm8750.c	Tue Jan 30 17:30:55 2007 +0100
+++ b/soc/codecs/wm8750.c	Tue Jan 30 18:20:31 2007 +0000
@@ -1075,8 +1075,8 @@ static int wm8750_init(struct snd_soc_de
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
-		kfree(codec->reg_cache);
-		return ret;
+		printk(KERN_ERR "wm8750: failed to create pcms\n");
+		goto pcm_err;
 	}
 
 	/* charge output caps */
@@ -1106,10 +1106,16 @@ static int wm8750_init(struct snd_soc_de
 	wm8750_add_widgets(codec);
 	ret = snd_soc_register_card(socdev);
 	if (ret < 0) {
-		snd_soc_free_pcms(socdev);
-		snd_soc_dapm_free(socdev);
-	}
-
+		printk(KERN_ERR "wm8750: failed to register card\n");
+		goto card_err;
+	}
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	kfree(codec->reg_cache);
 	return ret;
 }
 
diff -r 3be2f03501ef soc/codecs/wm9712.c
--- a/soc/codecs/wm9712.c	Tue Jan 30 17:30:55 2007 +0100
+++ b/soc/codecs/wm9712.c	Tue Jan 30 18:15:06 2007 +0000
@@ -692,10 +692,8 @@ static int wm9712_soc_probe(struct platf
 	codec->reg_cache =
 		kzalloc(sizeof(u16) * ARRAY_SIZE(wm9712_reg), GFP_KERNEL);
 	if (codec->reg_cache == NULL) {
-		kfree(codec->ac97);
-		kfree(socdev->codec);
-		socdev->codec = NULL;
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto cache_err;
 	}
 	memcpy(codec->reg_cache, wm9712_reg, sizeof(u16) * ARRAY_SIZE(wm9712_reg));
 	codec->reg_cache_size = sizeof(u16) * ARRAY_SIZE(wm9712_reg);
@@ -712,8 +710,10 @@ static int wm9712_soc_probe(struct platf
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
-	if (ret < 0)
-		goto err;
+	if (ret < 0) {
+		printk(KERN_ERR "wm9712: failed to register AC97 codec\n");
+		goto codec_err;
+	}
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
@@ -733,8 +733,10 @@ static int wm9712_soc_probe(struct platf
 	wm9712_add_controls(codec);
 	wm9712_add_widgets(codec);
 	ret = snd_soc_register_card(socdev);
-	if (ret < 0)
+	if (ret < 0) {
+		printk(KERN_ERR "wm9712: failed to register card\n");
 		goto reset_err;
+	}
 
 	return 0;
 
@@ -744,8 +746,10 @@ pcm_err:
 pcm_err:
 	snd_soc_free_ac97_codec(codec);
 
-err:
-	kfree(socdev->codec->reg_cache);
+codec_err:
+	kfree(codec->reg_cache);
+
+cache_err:
 	kfree(socdev->codec);
 	socdev->codec = NULL;
 	return ret;

--=-NXP8S8Z8mr155QYwB2d1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-NXP8S8Z8mr155QYwB2d1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-NXP8S8Z8mr155QYwB2d1--
