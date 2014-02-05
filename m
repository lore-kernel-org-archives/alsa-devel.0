From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 7/8] rtc: da9055: Remove use of
	platform_get_irq_byname()
Date: Wed, 5 Feb 2014 17:48:37 +0000
Message-ID: <14837b7c85e701e0008b095c009790ebec252e0c.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 080D3265038
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 18:48:39 +0100 (CET)
In-Reply-To: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/rtc/rtc-da9055.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-da9055.c b/drivers/rtc/rtc-da9055.c
index 48cb2ac..6e06840 100644
--- a/drivers/rtc/rtc-da9055.c
+++ b/drivers/rtc/rtc-da9055.c
@@ -301,8 +301,7 @@ static int da9055_rtc_probe(struct platform_device *pdev)
 		goto err_rtc;
 	}

-	alm_irq = platform_get_irq_byname(pdev, "ALM");
-	alm_irq = regmap_irq_get_virq(rtc->da9055->irq_data, alm_irq);
+	alm_irq = regmap_irq_get_virq(rtc->da9055->irq_data, DA9055_IRQ_ALARM);
 	ret = devm_request_threaded_irq(&pdev->dev, alm_irq, NULL,
 					da9055_rtc_alm_irq,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
--
1.7.0.4
