From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 02/11] ASoc: 88pm860x: Remove the
	set_cache_io() entirely from ASoC probe.
Date: Wed, 26 Mar 2014 13:40:24 +0800
Message-ID: <1395812433-26410-3-git-send-email-Li.Xiubo@freescale.com>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id C56B42650FE
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 07:27:57 +0100 (CET)
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
 sound/soc/codecs/88pm860x-codec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index b07e171..dc9e6b9 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1327,10 +1327,6 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 
 	pm860x->codec = codec;
 
-	ret = snd_soc_codec_set_cache_io(codec, pm860x->regmap);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < 4; i++) {
 		ret = request_threaded_irq(pm860x->irq[i], NULL,
 					   pm860x_codec_handler, IRQF_ONESHOT,
@@ -1362,10 +1358,18 @@ static int pm860x_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
+struct regmap *pm860x_get_regmap(struct device *dev)
+{
+	struct pm860x_priv *pm860x = dev_get_drvdata(dev);
+
+	return pm860x->regmap;
+}
+
 static struct snd_soc_codec_driver soc_codec_dev_pm860x = {
 	.probe		= pm860x_probe,
 	.remove		= pm860x_remove,
 	.set_bias_level	= pm860x_set_bias_level,
+	.get_regmap	= pm860x_get_regmap,
 
 	.controls = pm860x_snd_controls,
 	.num_controls = ARRAY_SIZE(pm860x_snd_controls),
-- 
1.8.4
