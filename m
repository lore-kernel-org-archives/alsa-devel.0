From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: rockchips: fix build error
Date: Fri, 11 Jul 2014 15:07:08 +0200
Message-ID: <1405084028-1209898-1-git-send-email-arnd@arndb.de>
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
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, Jianqun Xu <xjq@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

The newly added rockchip_i2s driver is lacking an include of
linux/module.h, causing a build error in some cases:

../sound/soc/rockchip/rockchip_i2s.c:526:20: error: expected declaration specifiers or '...' before string constant
 MODULE_DESCRIPTION("ROCKCHIP IIS ASoC Interface");

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jianqun Xu <xjq@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index af1d8eb94f04..c3e53feba5b9 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/of_gpio.h>
 #include <linux/clk.h>
+#include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <sound/pcm_params.h>
-- 
1.8.3.2
