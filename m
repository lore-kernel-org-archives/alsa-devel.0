From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: mediatek: add I2C dependency for CS42XX8
Date: Tue, 21 Feb 2017 23:00:46 +0100
Message-ID: <20170221220108.200734-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 978EB266AA9
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 23:01:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Koro Chen <koro.chen@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, Garlic Tseng <garlic.tseng@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

We should not select drivers that depend on I2C when that is disabled,
as it results in a build error:

warning: (SND_SOC_MT2701_CS42448) selects SND_SOC_CS42XX8_I2C which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && I2C)
sound/soc/codecs/cs42xx8-i2c.c:60:1: warning: data definition has no type or storage class
 module_i2c_driver(cs42xx8_i2c_driver);
sound/soc/codecs/cs42xx8-i2c.c:60:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]

Fixes: 1f458d53f76c ("ASoC: mediatek: Add mt2701-cs42448 driver and config option.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 05cf809cf9e1..d7013bde6f45 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -13,7 +13,7 @@ config SND_SOC_MT2701
 
 config SND_SOC_MT2701_CS42448
 	tristate "ASoc Audio driver for MT2701 with CS42448 codec"
-	depends on SND_SOC_MT2701
+	depends on SND_SOC_MT2701 && I2C
 	select SND_SOC_CS42XX8_I2C
 	select SND_SOC_BT_SCO
 	help
-- 
2.9.0
