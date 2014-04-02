From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: codec: fix the sparse check warnings.
Date: Thu, 3 Apr 2014 07:53:59 +0800
Message-ID: <1396482839-27609-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B138265535
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 02:37:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de
Cc: Xiubo Li <Li.Xiubo@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Some thing Likes:

reproduce: make C=1 CF=-D__CHECK_ENDIAN__

sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/wm8997.c:1084:15: sparse: symbol \
'wm8997_get_regmap' was not declared. Should it be static?

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/codecs/88pm860x-codec.c | 2 +-
 sound/soc/codecs/cq93vc.c         | 2 +-
 sound/soc/codecs/mc13783.c        | 2 +-
 sound/soc/codecs/si476x.c         | 2 +-
 sound/soc/codecs/wm5102.c         | 2 +-
 sound/soc/codecs/wm5110.c         | 2 +-
 sound/soc/codecs/wm8350.c         | 2 +-
 sound/soc/codecs/wm8400.c         | 2 +-
 sound/soc/codecs/wm8994.c         | 2 +-
 sound/soc/codecs/wm8997.c         | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index dc9e6b9..f073b6f 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1358,7 +1358,7 @@ static int pm860x_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct regmap *pm860x_get_regmap(struct device *dev)
+static struct regmap *pm860x_get_regmap(struct device *dev)
 {
 	struct pm860x_priv *pm860x = dev_get_drvdata(dev);
 
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 5e5518d..5ee48c8 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -152,7 +152,7 @@ static int cq93vc_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct regmap *cq93vc_get_regmap(struct device *dev)
+static struct regmap *cq93vc_get_regmap(struct device *dev)
 {
 	struct davinci_vc *davinci_vc = codec->dev->platform_data;
 
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 8c0cec3..9029e20 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -727,7 +727,7 @@ static struct snd_soc_dai_driver mc13783_dai_sync[] = {
 	}
 };
 
-struct regmap *mc13783_get_regmap(struct device *dev)
+static struct regmap *mc13783_get_regmap(struct device *dev)
 {
 	return dev_get_regmap(dev->parent, NULL);
 }
diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 961b7e8..f26befb 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -231,7 +231,7 @@ static struct snd_soc_dai_driver si476x_dai = {
 	.ops		= &si476x_dai_ops,
 };
 
-struct regmap *si476x_get_regmap(struct device *dev)
+static struct regmap *si476x_get_regmap(struct device *dev)
 {
 	return dev_get_regmap(dev->parent, NULL);
 }
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index aa60ba2..7a04653 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1798,7 +1798,7 @@ static unsigned int wm5102_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_5R,
 };
 
-struct regmap *wm5102_get_regmap(struct device *dev)
+static struct regmap *wm5102_get_regmap(struct device *dev)
 {
 	struct wm5102_priv *priv = dev_get_drvdata(dev);
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 4be5f99..97eb1bc 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1629,7 +1629,7 @@ static unsigned int wm5110_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_6R,
 };
 
-struct regmap *wm5110_get_regmap(struct device *dev)
+static struct regmap *wm5110_get_regmap(struct device *dev)
 {
 	struct wm5110_priv *priv = dev_get_drvdata(dev);
 
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 6b31a9f..1bd14b6 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1606,7 +1606,7 @@ static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct regmap *wm8350_get_regmap(struct device *dev)
+static struct regmap *wm8350_get_regmap(struct device *dev)
 {
 	struct wm8350 *wm8350 = dev_get_platdata(dev);
 
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index e6410f2..5880d22 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1359,7 +1359,7 @@ static int  wm8400_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct regmap *wm8400_get_regmap(struct device *dev)
+static struct regmap *wm8400_get_regmap(struct device *dev)
 {
 	struct wm8400 *wm8400 = dev_get_platdata(dev);
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index daa4edc..6f336da 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4432,7 +4432,7 @@ static int wm8994_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct regmap *wm8994_get_regmap(struct device *dev)
+static struct regmap *wm8994_get_regmap(struct device *dev)
 {
 	struct wm8994 *control = dev_get_drvdata(dev->parent);
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 3d50621..09c4150 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1081,7 +1081,7 @@ static unsigned int wm8997_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_5R,
 };
 
-struct regmap *wm8997_get_regmap(struct device *dev)
+static struct regmap *wm8997_get_regmap(struct device *dev)
 {
 	struct wm8997_priv *priv = dev_get_drvdata(dev);
 
-- 
1.8.4
