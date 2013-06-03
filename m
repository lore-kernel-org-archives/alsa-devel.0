From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: wm0010: Clear IRQ as wake source and
	include missing header
Date: Mon,  3 Jun 2013 15:57:55 +0100
Message-ID: <1370271475-24159-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D845B261B0A
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 17:08:33 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Both clear the IRQ as being a wake source when we are finished with it
and include a missing header file that is required.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index b6df319..f5e8356 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -14,6 +14,7 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/interrupt.h>
 #include <linux/irqreturn.h>
 #include <linux/init.h>
 #include <linux/spi/spi.h>
@@ -1002,6 +1003,8 @@ static int wm0010_spi_remove(struct spi_device *spi)
 	gpio_set_value_cansleep(wm0010->gpio_reset,
 				wm0010->gpio_reset_value);
 
+	irq_set_irq_wake(wm0010->irq, 0);
+
 	if (wm0010->irq)
 		free_irq(wm0010->irq, wm0010);
 
-- 
1.7.2.5
