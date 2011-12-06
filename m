From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Don't fail if we can't read the IRQ type
	in WM8903
Date: Tue,  6 Dec 2011 10:48:12 +0000
Message-ID: <1323168492-11003-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15973103B96
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 11:48:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If we fail to read the IRQ type from the interrupt controller don't
fail, just assume a value and solider on - we may fail later when we try
to request the IRQ but it's possible we'll succeed.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index adfbefa..21b9fdc 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2049,6 +2049,7 @@ static int wm8903_set_pdata_irq_trigger(struct i2c_client *i2c,
 
 	switch (irqd_get_trigger_type(irq_data)) {
 	case IRQ_TYPE_NONE:
+	default:
 		/*
 		* We assume the controller imposes no restrictions,
 		* so we are able to select active-high
@@ -2060,11 +2061,6 @@ static int wm8903_set_pdata_irq_trigger(struct i2c_client *i2c,
 	case IRQ_TYPE_LEVEL_LOW:
 		pdata->irq_active_low = true;
 		break;
-	default:
-		dev_err(&i2c->dev,
-			"Unsupported IRQ_TYPE %x\n",
-			irqd_get_trigger_type(irq_data));
-		return -EINVAL;
 	}
 
 	return 0;
-- 
1.7.7.3
