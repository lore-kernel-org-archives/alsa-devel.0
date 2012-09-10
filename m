From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 3/3] Revert "ASoC: AC97 doesn't use regmap by
	default"
Date: Mon, 10 Sep 2012 13:10:10 -0300
Message-ID: <1347293410-23683-3-git-send-email-fabio.estevam@freescale.com>
References: <1347293410-23683-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 2497C26510E
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 18:10:25 +0200 (CEST)
In-Reply-To: <1347293410-23683-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, manuel.lauss@googlemail.com, lee.jones@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since commit 98d3088e5 (SoC: core: Fix check before defaulting to regmap)
, it is not necessary to provide codec->control_data anymore.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/ad1980.c   |    1 -
 sound/soc/codecs/stac9766.c |    1 -
 sound/soc/codecs/wm9712.c   |    1 -
 sound/soc/codecs/wm9713.c   |    1 -
 4 files changed, 4 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 11b1b71..8c39ddd 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -186,7 +186,6 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 
 	printk(KERN_INFO "AD1980 SoC Audio Codec\n");
 
-	codec->control_data = codec;	/* we don't use regmap! */
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "ad1980: failed to register AC97 codec\n");
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 33c0f3d..982e437 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -340,7 +340,6 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 
 	printk(KERN_INFO "STAC9766 SoC Audio Codec %s\n", STAC9766_VERSION);
 
-	codec->control_data = codec;	/* we don't use regmap! */
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0)
 		goto codec_err;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 1992a62..4dd73ea 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -635,7 +635,6 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	codec->control_data = codec;	/* we don't use regmap! */
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9712: failed to register AC97 codec\n");
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index d0b8a32..3eb19fb 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1196,7 +1196,6 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	if (wm9713 == NULL)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, wm9713);
-	codec->control_data = wm9713;	/* we don't use regmap! */
 
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0)
-- 
1.7.9.5
