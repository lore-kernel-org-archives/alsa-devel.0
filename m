From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 10/11] ASoc: wm8994: Remove the
	set_cache_io() entirely from ASoC probe.
Date: Wed, 26 Mar 2014 13:40:32 +0800
Message-ID: <1395812433-26410-11-git-send-email-Li.Xiubo@freescale.com>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 by alsa0.perex.cz (Postfix) with ESMTP id A051026516E
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 07:28:41 +0100 (CET)
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
 sound/soc/codecs/wm8994.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 6303537..daa4edc 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3999,8 +3999,6 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	wm8994->hubs.codec = codec;
 
-	snd_soc_codec_set_cache_io(codec, control->regmap);
-
 	mutex_init(&wm8994->accdet_lock);
 	INIT_DELAYED_WORK(&wm8994->jackdet_bootstrap,
 			  wm1811_jackdet_bootstrap);
@@ -4434,11 +4432,19 @@ static int wm8994_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
+struct regmap *wm8994_get_regmap(struct device *dev)
+{
+	struct wm8994 *control = dev_get_drvdata(dev->parent);
+
+	return control->regmap;
+}
+
 static struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
 	.probe =	wm8994_codec_probe,
 	.remove =	wm8994_codec_remove,
 	.suspend =	wm8994_codec_suspend,
 	.resume =	wm8994_codec_resume,
+	.get_regmap =   wm8994_get_regmap,
 	.set_bias_level = wm8994_set_bias_level,
 };
 
-- 
1.8.4
