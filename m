From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/8] ASoC: sam9g20_wm8731: fix resource leak in
	at91sam9g20ek_init error path
Date: Thu, 25 Nov 2010 15:11:03 +0800
Message-ID: <1290669063.30158.14.camel@mola>
References: <1290668785.30158.7.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290668785.30158.7.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix the error path to properly free allocated resources.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 1c9de19..af3c730 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -240,6 +240,7 @@ static int __init at91sam9g20ek_init(void)
 	if (!at91sam9g20ek_snd_device) {
 		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
 		ret = -ENOMEM;
+		goto err_mclk;
 	}
 
 	platform_set_drvdata(at91sam9g20ek_snd_device,
@@ -248,11 +249,13 @@ static int __init at91sam9g20ek_init(void)
 	ret = platform_device_add(at91sam9g20ek_snd_device);
 	if (ret) {
 		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
-		platform_device_put(at91sam9g20ek_snd_device);
+		goto err_device_add;
 	}
 
 	return ret;
 
+err_device_add:
+	platform_device_put(at91sam9g20ek_snd_device);
 err_mclk:
 	clk_put(mclk);
 	mclk = NULL;
-- 
1.7.2
