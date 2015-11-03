From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 3/5] gpio: arizona: Support Cirrus Logic CS47L24 and WM1831
Date: Tue, 3 Nov 2015 15:08:34 +0000
Message-ID: <1446563316-28878-4-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1446563316-28878-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446563316-28878-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The CS47L24 and WM1831 codecs only have two GPIO lines, but are
otherwise similar to the WM8280.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-arizona.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index ca00273..624ea54 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -122,6 +122,10 @@ static int arizona_gpio_probe(struct platform_device *pdev)
 	case WM1814:
 		arizona_gpio->gpio_chip.ngpio = 5;
 		break;
+	case WM1831:
+	case CS47L24:
+		arizona_gpio->gpio_chip.ngpio = 2;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown chip variant %d\n",
 			arizona->type);
-- 
1.9.1
