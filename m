From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 05/11] ASoc: si476x: Remove the
	set_cache_io() entirely from ASoC probe.
Date: Wed, 26 Mar 2014 13:40:27 +0800
Message-ID: <1395812433-26410-6-git-send-email-Li.Xiubo@freescale.com>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id C7C8D265132
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 07:28:10 +0100 (CET)
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
 sound/soc/codecs/si476x.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 244c097..961b7e8 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -208,13 +208,6 @@ out:
 	return err;
 }
 
-static int si476x_codec_probe(struct snd_soc_codec *codec)
-{
-	struct regmap *regmap = dev_get_regmap(codec->dev->parent, NULL);
-
-	return snd_soc_codec_set_cache_io(codec, regmap);
-}
-
 static struct snd_soc_dai_ops si476x_dai_ops = {
 	.hw_params	= si476x_codec_hw_params,
 	.set_fmt	= si476x_codec_set_dai_fmt,
@@ -238,8 +231,13 @@ static struct snd_soc_dai_driver si476x_dai = {
 	.ops		= &si476x_dai_ops,
 };
 
+struct regmap *si476x_get_regmap(struct device *dev)
+{
+	return dev_get_regmap(dev->parent, NULL);
+}
+
 static struct snd_soc_codec_driver soc_codec_dev_si476x = {
-	.probe  = si476x_codec_probe,
+	.get_regmap = si476x_get_regmap,
 	.dapm_widgets = si476x_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(si476x_dapm_widgets),
 	.dapm_routes = si476x_dapm_routes,
-- 
1.8.4
