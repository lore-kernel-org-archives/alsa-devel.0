From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 11/11] ASoc: wm8997: Remove the
	set_cache_io() entirely from ASoC probe.
Date: Wed, 26 Mar 2014 13:40:33 +0800
Message-ID: <1395812433-26410-12-git-send-email-Li.Xiubo@freescale.com>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id B29D426518B
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
 sound/soc/codecs/wm8997.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 004186b..3d50621 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1051,11 +1051,6 @@ static struct snd_soc_dai_driver wm8997_dai[] = {
 static int wm8997_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm8997_priv *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	ret = snd_soc_codec_set_cache_io(codec, priv->core.arizona->regmap);
-	if (ret != 0)
-		return ret;
 
 	arizona_init_spk(codec);
 
@@ -1086,9 +1081,17 @@ static unsigned int wm8997_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_5R,
 };
 
+struct regmap *wm8997_get_regmap(struct device *dev)
+{
+	struct wm8997_priv *priv = dev_get_drvdata(dev);
+
+	return priv->core.arizona->regmap;
+}
+
 static struct snd_soc_codec_driver soc_codec_dev_wm8997 = {
 	.probe = wm8997_codec_probe,
 	.remove = wm8997_codec_remove,
+	.get_regmap =   wm8997_get_regmap,
 
 	.idle_bias_off = true,
 
-- 
1.8.4
