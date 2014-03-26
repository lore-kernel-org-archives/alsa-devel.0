From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 08/11] ASoc: wm8350: Remove the
	set_cache_io() entirely from ASoC probe.
Date: Wed, 26 Mar 2014 13:40:30 +0800
Message-ID: <1395812433-26410-9-git-send-email-Li.Xiubo@freescale.com>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 4992C265166
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 07:28:26 +0100 (CET)
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
 sound/soc/codecs/wm8350.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 757256b..6b31a9f 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1505,8 +1505,6 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	if (ret != 0)
 		return ret;
 
-	snd_soc_codec_set_cache_io(codec, wm8350->regmap);
-
 	/* Put the codec into reset if it wasn't already */
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
@@ -1608,11 +1606,19 @@ static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
+struct regmap *wm8350_get_regmap(struct device *dev)
+{
+	struct wm8350 *wm8350 = dev_get_platdata(dev);
+
+	return wm8350->regmap;
+}
+
 static struct snd_soc_codec_driver soc_codec_dev_wm8350 = {
 	.probe =	wm8350_codec_probe,
 	.remove =	wm8350_codec_remove,
 	.suspend = 	wm8350_suspend,
 	.resume =	wm8350_resume,
+	.get_regmap =	wm8350_get_regmap,
 	.set_bias_level = wm8350_set_bias_level,
 
 	.controls = wm8350_snd_controls,
-- 
1.8.4
