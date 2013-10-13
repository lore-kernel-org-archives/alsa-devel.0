From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/4] sound/soc/atmel: don't use
	devm_pinctrl_get_select_default() in probe
Date: Sun, 13 Oct 2013 18:17:50 +0200
Message-ID: <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 by alsa0.perex.cz (Postfix) with ESMTP id BA920261AB7
 for <alsa-devel@alsa-project.org>; Sun, 13 Oct 2013 18:18:28 +0200 (CEST)
In-Reply-To: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
we can rely on device core for setting the default pins.

Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 sound/soc/atmel/atmel_wm8904.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index 7222380..b4e3690 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/pinctrl/consumer.h>
 
 #include <sound/soc.h>
 
@@ -155,15 +154,8 @@ static int atmel_asoc_wm8904_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &atmel_asoc_wm8904_card;
 	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
 	struct clk *clk_src;
-	struct pinctrl *pinctrl;
 	int id, ret;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		dev_err(&pdev->dev, "failed to request pinctrl\n");
-		return PTR_ERR(pinctrl);
-	}
-
 	card->dev = &pdev->dev;
 	ret = atmel_asoc_wm8904_dt_init(pdev);
 	if (ret) {
-- 
1.8.4.rc3
