From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 6/8] hwmon: da9055: Remove use of regmap_irq_get_virq()
Date: Thu, 6 Feb 2014 18:03:17 +0000
Message-ID: <43bbe337fea5ac7e19b97179f2abb7e74684d0eb.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/hwmon/da9055-hwmon.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
index 029ecab..73b3865 100644
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -278,10 +278,6 @@ static int da9055_hwmon_probe(struct platform_device *pdev)
 	if (hwmon_irq < 0)
 		return hwmon_irq;

-	hwmon_irq = regmap_irq_get_virq(hwmon->da9055->irq_data, hwmon_irq);
-	if (hwmon_irq < 0)
-		return hwmon_irq;
-
 	ret = devm_request_threaded_irq(&pdev->dev, hwmon_irq,
 					NULL, da9055_auxadc_irq,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
--
1.7.0.4
