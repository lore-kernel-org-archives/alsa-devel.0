From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: es8316: add I2C dependency
Date: Thu, 22 Jun 2017 00:09:23 +0200
Message-ID: <20170621220943.104170-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 169372664EB
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 00:09:49 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>, David Yang <yangxiaohua@everest-semi.com>
List-Id: alsa-devel@alsa-project.org

Without CONFIG_I2C, we get a build failure:

sound/soc/codecs/es8316.c:633:1: error: data definition has no type or storage class [-Werror]
sound/soc/codecs/es8316.c:633:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
sound/soc/codecs/es8316.c:633:1: error: parameter names (without types) in function declaration [-Werror]
sound/soc/codecs/es8316.c:623:26: error: 'es8316_i2c_driver' defined but not used [-Werror=unused-variable]

This adds the required Kconfig dependency.

Fixes: b8b88b70875a ("ASoC: add es8316 codec driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c6286e5ba511..f0f794186186 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -546,6 +546,7 @@ config SND_SOC_ES7134
 
 config SND_SOC_ES8316
 	tristate "Everest Semi ES8316 CODEC"
+	depends on I2C
 
 config SND_SOC_ES8328
 	tristate
-- 
2.9.0
