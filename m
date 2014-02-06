From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 7/8] rtc: da9055: Remove use of regmap_irq_get_virq()
Date: Thu, 6 Feb 2014 18:03:19 +0000
Message-ID: <b8020329a507379c71a4ef33fc3ae6bcce037ca6.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
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
 drivers/rtc/rtc-da9055.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-da9055.c b/drivers/rtc/rtc-da9055.c
index 48cb2ac..a825491 100644
--- a/drivers/rtc/rtc-da9055.c
+++ b/drivers/rtc/rtc-da9055.c
@@ -302,7 +302,9 @@ static int da9055_rtc_probe(struct platform_device *pdev)
 	}

 	alm_irq = platform_get_irq_byname(pdev, "ALM");
-	alm_irq = regmap_irq_get_virq(rtc->da9055->irq_data, alm_irq);
+	if (alm_irq < 0)
+		return alm_irq;
+
 	ret = devm_request_threaded_irq(&pdev->dev, alm_irq, NULL,
 					da9055_rtc_alm_irq,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
--
1.7.0.4
