From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 8/8] mfd: da9055: Remove unused resource
	structures for mfd cells.
Date: Wed, 5 Feb 2014 17:48:38 +0000
Message-ID: <0f633e556abaecaa1feb70e0e3f6bbaeffc47874.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.140])
 by alsa0.perex.cz (Postfix) with ESMTP id BEAF926504A
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org



Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/mfd/da9055-core.c |   46 ---------------------------------------------
 1 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index caf8dcf..5cf8ca6 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -258,42 +258,6 @@ struct regmap_config da9055_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(da9055_regmap_config);

-static struct resource da9055_onkey_resource = {
-	.name = "ONKEY",
-	.start = DA9055_IRQ_NONKEY,
-	.end   = DA9055_IRQ_NONKEY,
-	.flags = IORESOURCE_IRQ,
-};
-
-static struct resource da9055_rtc_resource[] = {
-	{
-		.name = "ALM",
-		.start = DA9055_IRQ_ALARM,
-		.end   = DA9055_IRQ_ALARM,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "TICK",
-		.start = DA9055_IRQ_TICK,
-		.end   = DA9055_IRQ_TICK,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource da9055_hwmon_resource = {
-	.name = "HWMON",
-	.start = DA9055_IRQ_HWMON,
-	.end   = DA9055_IRQ_HWMON,
-	.flags = IORESOURCE_IRQ,
-};
-
-static struct resource da9055_ld05_6_resource = {
-	.name = "REGULATOR",
-	.start = DA9055_IRQ_REGULATOR,
-	.end   = DA9055_IRQ_REGULATOR,
-	.flags = IORESOURCE_IRQ,
-};
-
 static const struct mfd_cell da9055_devs[] = {
 	{
 		.of_compatible = "dialog,da9055-gpio",
@@ -333,33 +297,23 @@ static const struct mfd_cell da9055_devs[] = {
 		.of_compatible = "dialog,da9055-regulator",
 		.name = "da9055-regulator",
 		.id = 7,
-		.resources = &da9055_ld05_6_resource,
-		.num_resources = 1,
 	},
 	{
 		.of_compatible = "dialog,da9055-regulator",
 		.name = "da9055-regulator",
-		.resources = &da9055_ld05_6_resource,
-		.num_resources = 1,
 		.id = 8,
 	},
 	{
 		.of_compatible = "dialog,da9055-onkey",
 		.name = "da9055-onkey",
-		.resources = &da9055_onkey_resource,
-		.num_resources = 1,
 	},
 	{
 		.of_compatible = "dialog,da9055-rtc",
 		.name = "da9055-rtc",
-		.resources = da9055_rtc_resource,
-		.num_resources = ARRAY_SIZE(da9055_rtc_resource),
 	},
 	{
 		.of_compatible = "dialog,da9055-hwmon",
 		.name = "da9055-hwmon",
-		.resources = &da9055_hwmon_resource,
-		.num_resources = 1,
 	},
 	{
 		.of_compatible = "dialog,da9055-watchdog",
--
1.7.0.4
