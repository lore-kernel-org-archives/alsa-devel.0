From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 6/8] hwmon: da9055: Remove use of
	platform_get_irq_byname()
Date: Wed, 5 Feb 2014 17:48:36 +0000
Message-ID: <17c7fc7fe1e2246e32891be55a0e900231272371.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A51B265026
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
 drivers/hwmon/da9055-hwmon.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
index 029ecab..1867682 100644
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -274,11 +274,8 @@ static int da9055_hwmon_probe(struct platform_device *pdev)

 	platform_set_drvdata(pdev, hwmon);

-	hwmon_irq = platform_get_irq_byname(pdev, "HWMON");
-	if (hwmon_irq < 0)
-		return hwmon_irq;
-
-	hwmon_irq = regmap_irq_get_virq(hwmon->da9055->irq_data, hwmon_irq);
+	hwmon_irq = regmap_irq_get_virq(hwmon->da9055->irq_data,
+					DA9055_IRQ_HWMON);
 	if (hwmon_irq < 0)
 		return hwmon_irq;

--
1.7.0.4
