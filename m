From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 01/10] ASoC: tlv320aic31xx: Fix GPIO header
	includes
Date: Thu, 7 Dec 2017 09:38:51 -0600
Message-ID: <20171207153900.9831-2-afd@ti.com>
References: <20171207153900.9831-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id C10152671A2
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 16:39:02 +0100 (CET)
In-Reply-To: <20171207153900.9831-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Use of gpiod_* needs <linux/gpio/consumer.h>, add this here.

Fixes: b6b247cd5e37 ("ASoC: tlv320aic31xx: Switch GPIO handling to use gpiod_* API")
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 38fd6ea275fb..13471a900085 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -18,7 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
-- 
2.15.0
