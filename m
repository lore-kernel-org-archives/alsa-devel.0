From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2/3] gpio: arizona: Support Cirrus Logic CS47L24 and WM1831
Date: Mon, 19 Oct 2015 15:13:46 +0100
Message-ID: <1445264027-7357-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1445264027-7357-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445264027-7357-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The CS47L24 and WM1831 codecs only have two GPIO lines, but are
otherwise similar to the WM8280.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
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
