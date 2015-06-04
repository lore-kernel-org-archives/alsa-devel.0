From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 07/23] ASoC: tas2552: Simplify and reverse
	the functionality of tas2552_sw_shutdown
Date: Thu, 4 Jun 2015 16:04:19 +0300
Message-ID: <1433423075-14142-8-git-send-email-peter.ujfalusi@ti.com>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 657B626651C
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:04:56 +0200 (CEST)
In-Reply-To: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The function name and parameters of:
tas2552_sw_shutdown(struct tas2552_data *tas_data, int sw_shutdown)

implies that if sw_shutdown is 1 we should be entering to the software
shutdown mode.

The code can be simplified as well within the function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 2d52a397161d..61419e2f833b 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -118,14 +118,12 @@ static const struct snd_soc_dapm_route tas2552_audio_map[] = {
 #ifdef CONFIG_PM
 static void tas2552_sw_shutdown(struct tas2552_data *tas_data, int sw_shutdown)
 {
-	u8 cfg1_reg;
+	u8 cfg1_reg = 0;
 
 	if (!tas_data->codec)
 		return;
 
 	if (sw_shutdown)
-		cfg1_reg = 0;
-	else
 		cfg1_reg = TAS2552_SWS;
 
 	snd_soc_update_bits(tas_data->codec, TAS2552_CFG_1, TAS2552_SWS,
@@ -270,7 +268,7 @@ static int tas2552_runtime_suspend(struct device *dev)
 {
 	struct tas2552_data *tas2552 = dev_get_drvdata(dev);
 
-	tas2552_sw_shutdown(tas2552, 0);
+	tas2552_sw_shutdown(tas2552, 1);
 
 	regcache_cache_only(tas2552->regmap, true);
 	regcache_mark_dirty(tas2552->regmap);
@@ -288,7 +286,7 @@ static int tas2552_runtime_resume(struct device *dev)
 	if (tas2552->enable_gpio)
 		gpiod_set_value(tas2552->enable_gpio, 1);
 
-	tas2552_sw_shutdown(tas2552, 1);
+	tas2552_sw_shutdown(tas2552, 0);
 
 	regcache_cache_only(tas2552->regmap, false);
 	regcache_sync(tas2552->regmap);
-- 
2.4.2
