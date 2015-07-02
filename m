From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] Revert "ASoC: wm0010: Add missing
	IRQF_ONESHOT"
Date: Thu, 02 Jul 2015 21:26:44 +0800
Message-ID: <1435843604.17967.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id E5ABF265993
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2015 15:26:53 +0200 (CEST)
Received: by pdjd13 with SMTP id d13so45387731pdj.0
 for <alsa-devel@alsa-project.org>; Thu, 02 Jul 2015 06:26:52 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Michal Marek <mmarek@suse.cz>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

This reverts 58d468328646 ("ASoC: wm0010: Add missing IRQF_ONESHOT").

The coccinelle warnings is false positive because the original code does
set IRQF_ONESHOT by "trigger |= IRQF_ONESHOT;".

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm0010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 6560a66..ff924032 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -953,7 +953,7 @@ static int wm0010_spi_probe(struct spi_device *spi)
 		trigger = IRQF_TRIGGER_FALLING;
 	trigger |= IRQF_ONESHOT;
 
-	ret = request_threaded_irq(irq, NULL, wm0010_irq, trigger | IRQF_ONESHOT,
+	ret = request_threaded_irq(irq, NULL, wm0010_irq, trigger,
 				   "wm0010", wm0010);
 	if (ret) {
 		dev_err(wm0010->dev, "Failed to request IRQ %d: %d\n",
-- 
2.1.0
