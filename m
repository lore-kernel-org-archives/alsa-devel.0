From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: [PATCH] ASoC: max98373: Added max98373_reset for
	stable amp reset
Date: Mon, 26 Nov 2018 18:46:05 +0000
Message-ID: <20181126183942.2631-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700136.outbound.protection.outlook.com [40.107.70.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 60CDD26770D
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 19:46:09 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ryan Lee <RyanS.Lee@maximintegrated.com>, Grant Grundler <grundler@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Benson Leung <bleung@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes : Created max98373_reset function to minimize code duplication.
           Changed regmap_write to regmap_update_bits. Other bits except LSB need to be masked.
           Added reset verification step to make sure software reset is completed well. Software reset is done in 10ms in normal case.
           Revision ID is available when the amp is in the idle state which means software reset is completed.
           Software reset will be performed maximum 3 times to avoid amp reset failure. Generally it is done in the first trial.
           sleep time after software reset is increased + 30ms for every retrial. Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).

 sound/soc/codecs/max98373.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index a09d013..55af7f02 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -724,14 +724,45 @@ static struct snd_soc_dai_driver max98373_dai[] = {
 	}
 };
 
+static void max98373_reset(struct max98373_priv *max98373, struct device *dev)
+{
+	int ret, reg, count, delay;
+
+	count = 0;
+	while (true) {
+		/* Software Reset */
+		ret = regmap_update_bits(max98373->regmap,
+			MAX98373_R2000_SW_RESET,
+			MAX98373_SOFT_RESET,
+			MAX98373_SOFT_RESET);
+		if (ret)
+			dev_err(dev, "Reset command failed. (ret:%d)\n", ret);
+
+		delay = 10000 + (count * 30000);
+		usleep_range(delay, delay + 1000);
+
+		/* Software Reset Verification */
+		ret = regmap_read(max98373->regmap,
+			MAX98373_R21FF_REV_ID, &reg);
+		if (!ret) {
+			dev_info(dev, "Reset completed (retry:%d)\n", count);
+			break;
+		}
+
+		if (++count > 3)	{
+			dev_err(dev, "Reset failed. (ret:%d)\n", ret);
+			break;
+		}
+		usleep_range(10000, 11000);
+	}
+}
+
 static int max98373_probe(struct snd_soc_component *component)
 {
 	struct max98373_priv *max98373 = snd_soc_component_get_drvdata(component);
 
 	/* Software Reset */
-	regmap_write(max98373->regmap,
-		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
-	usleep_range(10000, 11000);
+	max98373_reset(max98373, component->dev);
 
 	/* IV default slot configuration */
 	regmap_write(max98373->regmap,
@@ -818,9 +849,7 @@ static int max98373_resume(struct device *dev)
 {
 	struct max98373_priv *max98373 = dev_get_drvdata(dev);
 
-	regmap_write(max98373->regmap,
-		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
-	usleep_range(10000, 11000);
+	max98373_reset(max98373, dev);
 	regcache_cache_only(max98373->regmap, false);
 	regcache_sync(max98373->regmap);
 	return 0;
-- 
2.7.4
