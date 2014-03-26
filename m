From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 04/11] ASoc: mc13783: Remove the
	set_cache_io() entirely from ASoC probe.
Date: Wed, 26 Mar 2014 13:40:26 +0800
Message-ID: <1395812433-26410-5-git-send-email-Li.Xiubo@freescale.com>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 733B92650F2
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 07:28:05 +0100 (CET)
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
 sound/soc/codecs/mc13783.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 2c59b1f..8c0cec3 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -608,14 +608,6 @@ static struct snd_kcontrol_new mc13783_control_list[] = {
 static int mc13783_probe(struct snd_soc_codec *codec)
 {
 	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	ret = snd_soc_codec_set_cache_io(codec,
-			dev_get_regmap(codec->dev->parent, NULL));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		return ret;
-	}
 
 	/* these are the reset values */
 	mc13xxx_reg_write(priv->mc13xxx, MC13783_AUDIO_RX0, 0x25893);
@@ -735,9 +727,15 @@ static struct snd_soc_dai_driver mc13783_dai_sync[] = {
 	}
 };
 
+struct regmap *mc13783_get_regmap(struct device *dev)
+{
+	return dev_get_regmap(dev->parent, NULL);
+}
+
 static struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
 	.probe		= mc13783_probe,
 	.remove		= mc13783_remove,
+	.get_regmap	= mc13783_get_regmap,
 	.controls	= mc13783_control_list,
 	.num_controls	= ARRAY_SIZE(mc13783_control_list),
 	.dapm_widgets	= mc13783_dapm_widgets,
-- 
1.8.4
