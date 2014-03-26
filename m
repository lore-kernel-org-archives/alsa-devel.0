From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 09/11] ASoc: wm8400: Remove the
	set_cache_io() entirely from ASoC probe.
Date: Wed, 26 Mar 2014 13:40:31 +0800
Message-ID: <1395812433-26410-10-git-send-email-Li.Xiubo@freescale.com>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id D610326517C
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 07:28:35 +0100 (CET)
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

As we can set the CODEC I/O while snd_soc_register_codec(), so the
calling of set_cache_io() from CODEC ASoC probe could be removed
entirely.

And then we can set the CODEC I/O in the device probe instead of
CODEC ASoC probe as earily as possible.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/codecs/wm8400.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 146564f..e6410f2 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1318,8 +1318,6 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 	priv->wm8400 = wm8400;
 	priv->codec = codec;
 
-	snd_soc_codec_set_cache_io(codec, wm8400->regmap);
-
 	ret = devm_regulator_bulk_get(wm8400->dev,
 				 ARRAY_SIZE(power), &power[0]);
 	if (ret != 0) {
@@ -1361,11 +1359,19 @@ static int  wm8400_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
+struct regmap *wm8400_get_regmap(struct device *dev)
+{
+	struct wm8400 *wm8400 = dev_get_platdata(dev);
+
+	return wm8400->regmap;
+}
+
 static struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
 	.probe =	wm8400_codec_probe,
 	.remove =	wm8400_codec_remove,
 	.suspend =	wm8400_suspend,
 	.resume =	wm8400_resume,
+	.get_regmap =	wm8400_get_regmap,
 	.set_bias_level = wm8400_set_bias_level,
 
 	.controls = wm8400_snd_controls,
-- 
1.8.4
