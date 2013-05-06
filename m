From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: sam9g20ek: Let device core handle pinctrl
Date: Mon,  6 May 2013 20:28:28 +0100
Message-ID: <1367868508-12329-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A9F62607D7
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 21:28:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device
core) we can rely on device core for handling pinctrl so remove
devm_pinctrl_get_select_default() from the driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 2d6fbd0..802717e 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -38,8 +38,6 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 
-#include <linux/pinctrl/consumer.h>
-
 #include <linux/atmel-ssc.h>
 
 #include <sound/core.h>
@@ -203,15 +201,8 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	struct device_node *codec_np, *cpu_np;
 	struct clk *pllb;
 	struct snd_soc_card *card = &snd_soc_at91sam9g20ek;
-	struct pinctrl *pinctrl;
 	int ret;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		dev_err(&pdev->dev, "Failed to request pinctrl for mck\n");
-		return PTR_ERR(pinctrl);
-	}
-
 	if (!np) {
 		if (!(machine_is_at91sam9g20ek() ||
 			machine_is_at91sam9g20ek_2mmc()))
-- 
1.7.10.4
