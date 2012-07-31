From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] ASoC: AC97 doesn't use regmap by default
Date: Tue, 31 Jul 2012 14:42:27 +0200
Message-ID: <1343738547-24152-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0169A265D08
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 14:42:38 +0200 (CEST)
Received: by weyx10 with SMTP id x10so3883004wey.38
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 05:42:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>
List-Id: alsa-devel@alsa-project.org

From: Manuel Lauss <manuel.lauss@googlemail.com>

Since commit 38cbf9598feba97de9f9b43efa9153fd7c1a2ec9
("ASoC: core: Try to use regmap if the driver doesn't set up any I/O")
any ASoC codec which doesn't set codec::control_data is assumed
to use regmap.  That doesn't work with AC97 so this workaround
sets the codec::control_data member to a random value to restore
proper behaviour.

Tested with WM9712.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 sound/soc/codecs/ad1980.c   |    1 +
 sound/soc/codecs/stac9766.c |    1 +
 sound/soc/codecs/wm9712.c   |    1 +
 sound/soc/codecs/wm9713.c   |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 8c39ddd..11b1b71 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -186,6 +186,7 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 
 	printk(KERN_INFO "AD1980 SoC Audio Codec\n");
 
+	codec->control_data = codec;	/* we don't use regmap! */
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "ad1980: failed to register AC97 codec\n");
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 982e437..33c0f3d 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -340,6 +340,7 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 
 	printk(KERN_INFO "STAC9766 SoC Audio Codec %s\n", STAC9766_VERSION);
 
+	codec->control_data = codec;	/* we don't use regmap! */
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0)
 		goto codec_err;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 099e6ec..f16fb36 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -619,6 +619,7 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
+	codec->control_data = codec;	/* we don't use regmap! */
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9712: failed to register AC97 codec\n");
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 3eb19fb..d0b8a32 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1196,6 +1196,7 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	if (wm9713 == NULL)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, wm9713);
+	codec->control_data = wm9713;	/* we don't use regmap! */
 
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0)
-- 
1.7.8.6
