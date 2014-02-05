From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 5/8] onkey: da9055: Remove use of
	platform_get_irq_byname()
Date: Wed, 5 Feb 2014 17:48:36 +0000
Message-ID: <c332a2885a76869f922057211ebae4757c5079f4.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.110])
 by alsa0.perex.cz (Postfix) with ESMTP id 87DFE265044
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 18:48:40 +0100 (CET)
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.netg>, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

Using platform_get_irq_byname() to retrieve the IRQ number
returns the VIRQ number rather than the local IRQ number for
the device. Passing that value then into regmap_irq_get_virq()
causes a failure because the function is expecting the local
IRQ number (e.g. 0, 1, 2, 3, etc). This patch removes use of
platform_get_irq_byname() and uses the local IRQ number instead.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/input/misc/da9055_onkey.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/da9055_onkey.c b/drivers/input/misc/da9055_onkey.c
index 4b11ede..4842c6c 100644
--- a/drivers/input/misc/da9055_onkey.c
+++ b/drivers/input/misc/da9055_onkey.c
@@ -79,13 +79,6 @@ static int da9055_onkey_probe(struct platform_device *pdev)
 	struct input_dev *input_dev;
 	int irq, err;

-	irq = platform_get_irq_byname(pdev, "ONKEY");
-	if (irq < 0) {
-		dev_err(&pdev->dev,
-			"Failed to get an IRQ for input device, %d\n", irq);
-		return -EINVAL;
-	}
-
 	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
 	if (!onkey) {
 		dev_err(&pdev->dev, "Failed to allocate memory\n");
@@ -109,7 +102,7 @@ static int da9055_onkey_probe(struct platform_device *pdev)

 	INIT_DELAYED_WORK(&onkey->work, da9055_onkey_work);

-	irq = regmap_irq_get_virq(da9055->irq_data, irq);
+	irq = regmap_irq_get_virq(da9055->irq_data, DA9055_IRQ_NONKEY);
 	err = request_threaded_irq(irq, NULL, da9055_onkey_irq,
 				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 				   "ONKEY", onkey);
--
1.7.0.4
