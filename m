From: Vasiliy Kulikov <segoon@openwall.com>
Subject: [PATCH] ASoC: atmel: test wrong variable
Date: Sun, 21 Nov 2010 20:40:14 +0300
Message-ID: <1290361216-15166-1-git-send-email-segoon@openwall.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@freescale.com>, Jarkko Nikula <jhnikula@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

After clk_get() mclk is checked second time instead of pllb check.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Cannot compile this driver, so it is not tested.

 sound/soc/atmel/sam9g20_wm8731.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index da9c303..68072a2 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -223,7 +223,7 @@ static int __init at91sam9g20ek_init(void)
 	}
 
 	pllb = clk_get(NULL, "pllb");
-	if (IS_ERR(mclk)) {
+	if (IS_ERR(pllb)) {
 		printk(KERN_ERR "ASoC: Failed to get PLLB\n");
 		ret = PTR_ERR(mclk);
 		goto err_mclk;
-- 
1.7.0.4
