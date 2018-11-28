From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: [PATCH V2] ASoC: max98373: Added max98373_reset for
	stable amp reset
Date: Wed, 28 Nov 2018 03:20:16 +0000
Message-ID: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800112.outbound.protection.outlook.com [40.107.80.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D8CF3267AF1
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 04:20:19 +0100 (CET)
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
Cc: "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changes since v1 : Removed unusual repeat for amp software reset and verification.
                   Amp software reset will be performed once and it repeats verification maximum 3 times if it is failed.
                   Wait 10ms before every verification trial. Maximum 30ms delay will be applied to wait AMP idle state.

Changes : Created max98373_reset function to minimize code duplication.
          Changed regmap_write to regmap_update_bits. Other bits except LSB need to be masked.
          Added reset verification step to make sure software reset is completed well. Software reset is done in 10ms in normal case.
          Revision ID is available when the amp is in the idle state which means software reset is completed.
          Software reset will be performed maximum 3 times to avoid amp reset failure. Generally it is done in the first trial.
          sleep time after software reset is increased + 30ms for every retrial. Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).

 sound/soc/codecs/max98373.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index a09d013..9c8616a 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -724,14 +724,39 @@ static struct snd_soc_dai_driver max98373_dai[] = {
 	}
 };
 
+static void max98373_reset(struct max98373_priv *max98373, struct device *dev)
+{
+	int ret, reg, count;
+
+	/* Software Reset */
+	ret = regmap_update_bits(max98373->regmap,
+		MAX98373_R2000_SW_RESET,
+		MAX98373_SOFT_RESET,
+		MAX98373_SOFT_RESET);
+	if (ret)
+		dev_err(dev, "Reset command failed. (ret:%d)\n", ret);
+
+	count = 0;
+	while (count < 3) {
+		usleep_range(10000, 11000);
+		/* Software Reset Verification */
+		ret = regmap_read(max98373->regmap,
+			MAX98373_R21FF_REV_ID, &reg);
+		if (!ret) {
+			dev_info(dev, "Reset completed (retry:%d)\n", count);
+			return;
+		}
+		count++;
+	}
+	dev_err(dev, "Reset failed. (ret:%d)\n", ret);
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
@@ -818,9 +843,7 @@ static int max98373_resume(struct device *dev)
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
