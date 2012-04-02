From: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH] ARM: pxa: pxa2xx-i2s: add io.h for IOMEM macro
Date: Mon,  2 Apr 2012 10:24:08 +0200
Message-ID: <1333355048-732-1-git-send-email-Martin.Jansa@gmail.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <rob.herring@calxeda.com>
Cc: "moderated list:SOUND - SOC LAYER..." <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>, Martin Jansa <Martin.Jansa@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, open list <linux-kernel@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, "moderated list:PXA2xx/PXA3xx SUP..." <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

* fixes
  sound/soc/pxa/pxa2xx-i2s.c:86:2: error: implicit declaration of function 'IOMEM' [-Werror=implicit-function-declaration]
  sound/soc/pxa/pxa2xx-i2s.c:86:2: error: initializer element is not constant
  after 23019a733bb83c8499f192fb428b7e6e81c95a34 removed IOMEM
  definition from arch/arm/mach-pxa/include/mach/hardware.h

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 sound/soc/pxa/pxa2xx-i2s.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 609abd5..d085837 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
-- 
1.7.8.5
