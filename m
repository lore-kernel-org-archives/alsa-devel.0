From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: rt5616: add I2C dependency
Date: Tue, 15 Mar 2016 22:42:50 +0100
Message-ID: <1458078220-551551-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F7C8260789
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 22:44:03 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Caesar Wang <wxt@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

The rt5616 codec registers itself as an i2c driver, but can
be enabled even when i2c is turned off, which leads to a build
error:

codecs/rt5616.c:1419:1: error: data definition has no type or storage class [-Werror]
 module_i2c_driver(rt5616_i2c_driver);

This adds an explicit Kconfig dependency, like the other codec
drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 288bc356a881 ("ASoC: rt5616: allow to build with CONFIG_SND_SOC_RT5616")
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 649e92a252ae..7ef3a0c16478 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -629,6 +629,7 @@ config SND_SOC_RT5514
 
 config SND_SOC_RT5616
 	tristate "Realtek RT5616 CODEC"
+	depends on I2C
 
 config SND_SOC_RT5631
 	tristate "Realtek ALC5631/RT5631 CODEC"
-- 
2.7.0
