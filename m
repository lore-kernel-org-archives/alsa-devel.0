From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] ASoC: wm8960: Add I2C dependency
Date: Wed, 30 Mar 2016 16:23:08 -0300
Message-ID: <1459365788-18711-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0056.outbound.protection.outlook.com [157.56.111.56])
 by alsa0.perex.cz (Postfix) with ESMTP id 06ECF265065
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 21:23:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, ckeepax@opensource.wolfsonmicro.com, festevam@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Building wm8960 codec without I2C support causes build issues:

sound/soc/codecs/wm8960.c:1388:1: warning: data definition has no type or storage class
 module_i2c_driver(wm8960_i2c_driver);
    ^
sound/soc/codecs/wm8960.c:1388:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
sound/soc/codecs/wm8960.c:1388:1: warning: parameter names (without types) in function declaration
sound/soc/codecs/wm8960.c:1378:26: warning: 'wm8960_i2c_driver' defined but not used [-Wunused-variable]
    static struct i2c_driver wm8960_i2c_driver = {

, so add the I2C dependency to fix this problem.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ba835b6..09e8c39 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -911,6 +911,7 @@ config SND_SOC_WM8955
 
 config SND_SOC_WM8960
 	tristate "Wolfson Microelectronics WM8960 CODEC"
+	depends on I2C
 
 config SND_SOC_WM8961
 	tristate
-- 
1.9.1
