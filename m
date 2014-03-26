From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 01/11] ASoC: core: Move the default regmap
	I/O setting to snd_soc_register_codec()
Date: Wed, 26 Mar 2014 13:40:23 +0800
Message-ID: <1395812433-26410-2-git-send-email-Li.Xiubo@freescale.com>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe007.messaging.microsoft.com [65.55.88.31])
 by alsa0.perex.cz (Postfix) with ESMTP id B9C7C2650FE
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 07:27:49 +0100 (CET)
In-Reply-To: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, shc_work@mail.ru, tiwai@suse.de, viresh.kumar@linaro.org, patches@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com, Xiubo Li <Li.Xiubo@freescale.com>, akpm@linux-foundation.org, s.trumtrar@pengutronix.de, rf@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

Add the default regmap I/O setting to snd_soc_register_codec() while
the CODEC is initialising, which will be called by CODEC driver device
probe(), and then we can make XXX_set_cache_io() go away entirely from each
CODEC ASoC probe.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-core.c | 28 ++++++++++++++++++----------
 sound/soc/soc-io.c   |  9 +++------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0b83168..2f62436 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -754,6 +754,7 @@ struct snd_soc_codec_driver {
 		unsigned int freq_in, unsigned int freq_out);
 
 	/* codec IO */
+	struct regmap *(*get_regmap)(struct device *);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
 	int (*display_register)(struct snd_soc_codec *, char *,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b322cf2..465a367 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1137,16 +1137,6 @@ static int soc_probe_codec(struct snd_soc_card *card,
 
 	codec->dapm.idle_bias_off = driver->idle_bias_off;
 
-	if (!codec->write && dev_get_regmap(codec->dev, NULL)) {
-		/* Set the default I/O up try regmap */
-		ret = snd_soc_codec_set_cache_io(codec, NULL);
-		if (ret < 0) {
-			dev_err(codec->dev,
-				"Failed to set cache I/O: %d\n", ret);
-			goto err_probe;
-		}
-	}
-
 	if (driver->probe) {
 		ret = driver->probe(codec);
 		if (ret < 0) {
@@ -4269,6 +4259,7 @@ int snd_soc_register_codec(struct device *dev,
 			   int num_dai)
 {
 	struct snd_soc_codec *codec;
+	struct regmap *regmap;
 	int ret, i;
 
 	dev_dbg(dev, "codec register %s\n", dev_name(dev));
@@ -4300,6 +4291,23 @@ int snd_soc_register_codec(struct device *dev,
 	codec->num_dai = num_dai;
 	mutex_init(&codec->mutex);
 
+	if (!codec->write) {
+		if (codec_drv->get_regmap)
+			regmap = codec_drv->get_regmap(dev);
+		else
+			regmap = dev_get_regmap(dev, NULL);
+
+		if (regmap) {
+			ret = snd_soc_codec_set_cache_io(codec, regmap);
+			if (ret && ret != -ENOTSUPP) {
+				dev_err(codec->dev,
+						"Failed to set cache I/O:%d\n",
+						ret);
+				return ret;
+			}
+		}
+	}
+
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
 		fixup_codec_formats(&dai_drv[i].capture);
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 260efc8..6480e8f 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -60,14 +60,11 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 {
 	int ret;
 
-	/* Device has made its own regmap arrangements */
 	if (!regmap)
-		codec->control_data = dev_get_regmap(codec->dev, NULL);
-	else
-		codec->control_data = regmap;
+		return -EINVAL;
 
-	if (IS_ERR(codec->control_data))
-		return PTR_ERR(codec->control_data);
+	/* Device has made its own regmap arrangements */
+	codec->control_data = regmap;
 
 	codec->write = hw_write;
 	codec->read = hw_read;
-- 
1.8.4
