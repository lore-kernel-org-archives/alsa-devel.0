From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: PXA: Brownstone needs I2C
Date: Tue, 18 Oct 2016 17:18:58 +0200
Message-ID: <20161018151912.2742738-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

I rand into a new build error with SND_MMP_SOC_BROWNSTONE:

warning: (SND_MMP_SOC_BROWNSTONE && SND_SOC_SAMSUNG_SMDK_WM8994 && SND_SOC_SMDK_WM8994_PCM && SND_SOC_LITTLEMILL) selects MFD_WM8994 which has unmet direct dependencies (HAS_IOMEM && I2C)
drivers/mfd/wm8994-core.c:688:1: error: data definition has no type or storage class [-Werror]
drivers/mfd/wm8994-core.c:688:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]

I don't see why this never showed up before, as the dependency seems to
have been missing since the symbol was first introduced several years
ago. This adds a dependency like the other drivers have.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index f2bf8661dd21..823b5a236d8d 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -208,7 +208,7 @@ config SND_PXA2XX_SOC_IMOTE2
 
 config SND_MMP_SOC_BROWNSTONE
 	tristate "SoC Audio support for Marvell Brownstone"
-	depends on SND_MMP_SOC && MACH_BROWNSTONE
+	depends on SND_MMP_SOC && MACH_BROWNSTONE && I2C
 	select SND_MMP_SOC_SSPA
 	select MFD_WM8994
 	select SND_SOC_WM8994
-- 
2.9.0
