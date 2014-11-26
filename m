From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH V2 4/6] gpio: arizona: Add support for WM8280/WM8281
Date: Wed, 26 Nov 2014 15:13:06 +0000
Message-ID: <1417014788-8311-5-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1417014788-8311-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1417014788-8311-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: cw00.choi@samsung.com, linus.walleij@linaro.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-arizona.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index fe369f5..9665d0a 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -116,6 +116,7 @@ static int arizona_gpio_probe(struct platform_device *pdev)
 	switch (arizona->type) {
 	case WM5102:
 	case WM5110:
+	case WM8280:
 	case WM8997:
 		arizona_gpio->gpio_chip.ngpio = 5;
 		break;
-- 
1.7.2.5

