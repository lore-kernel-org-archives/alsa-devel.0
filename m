From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 4/8] gpio: arizona: add support for WM8998 and WM1814
Date: Tue, 21 Apr 2015 13:33:52 +0100
Message-ID: <1429619636-25478-5-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 drivers/gpio/gpio-arizona.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index 052fbc8..ca00273 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -118,6 +118,8 @@ static int arizona_gpio_probe(struct platform_device *pdev)
 	case WM5110:
 	case WM8280:
 	case WM8997:
+	case WM8998:
+	case WM1814:
 		arizona_gpio->gpio_chip.ngpio = 5;
 		break;
 	default:
-- 
1.7.2.5
