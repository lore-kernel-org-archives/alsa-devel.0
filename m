From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 4/8] gpio: arizona: add support for WM8998
	and WM1814
Date: Wed, 29 Apr 2015 15:37:05 +0100
Message-ID: <1430318229-28518-5-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1430318229-28518-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3169A260705
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 16:37:47 +0200 (CEST)
In-Reply-To: <1430318229-28518-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, myungjoo.ham@samsung.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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
