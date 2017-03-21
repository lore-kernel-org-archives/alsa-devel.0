From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 5/6] mfd: arizona: Add support for new micbias regulators
Date: Tue, 21 Mar 2017 14:45:38 +0000
Message-ID: <1490107539-23995-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490107539-23995-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490107539-23995-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add mfd_cell's for each of the new micbias regulators,  provide the
appropriate supply mapping for these, and remove the old code that
configured the micbiases now that the regulator driver does so.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/mfd/arizona-core.c | 56 ++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index b6d4bc6..e7eba5d 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -936,10 +936,16 @@ static const char * const wm5102_supplies[] = {
 	"CPVDD",
 	"SPKVDDL",
 	"SPKVDDR",
+	"MICBIAS1",
+	"MICBIAS2",
+	"MICBIAS3",
 };
 
 static const struct mfd_cell wm5102_devs[] = {
 	{ .name = "arizona-micsupp" },
+	{ .name = "arizona-micbias", .id = 1 },
+	{ .name = "arizona-micbias", .id = 2 },
+	{ .name = "arizona-micbias", .id = 3 },
 	{ .name = "arizona-gpio" },
 	{
 		.name = "arizona-extcon",
@@ -957,6 +963,9 @@ static const struct mfd_cell wm5102_devs[] = {
 
 static const struct mfd_cell wm5110_devs[] = {
 	{ .name = "arizona-micsupp" },
+	{ .name = "arizona-micbias", .id = 1 },
+	{ .name = "arizona-micbias", .id = 2 },
+	{ .name = "arizona-micbias", .id = 3 },
 	{ .name = "arizona-gpio" },
 	{
 		.name = "arizona-extcon",
@@ -976,9 +985,13 @@ static const char * const cs47l24_supplies[] = {
 	"MICVDD",
 	"CPVDD",
 	"SPKVDD",
+	"MICBIAS1",
+	"MICBIAS2",
 };
 
 static const struct mfd_cell cs47l24_devs[] = {
+	{ .name = "arizona-micbias", .id = 1 },
+	{ .name = "arizona-micbias", .id = 2 },
 	{ .name = "arizona-gpio" },
 	{ .name = "arizona-haptics" },
 	{ .name = "arizona-pwm" },
@@ -994,10 +1007,16 @@ static const char * const wm8997_supplies[] = {
 	"DBVDD2",
 	"CPVDD",
 	"SPKVDD",
+	"MICBIAS1",
+	"MICBIAS2",
+	"MICBIAS3",
 };
 
 static const struct mfd_cell wm8997_devs[] = {
 	{ .name = "arizona-micsupp" },
+	{ .name = "arizona-micbias", .id = 1 },
+	{ .name = "arizona-micbias", .id = 2 },
+	{ .name = "arizona-micbias", .id = 3 },
 	{ .name = "arizona-gpio" },
 	{
 		.name = "arizona-extcon",
@@ -1015,6 +1034,9 @@ static const struct mfd_cell wm8997_devs[] = {
 
 static const struct mfd_cell wm8998_devs[] = {
 	{ .name = "arizona-micsupp" },
+	{ .name = "arizona-micbias", .id = 1 },
+	{ .name = "arizona-micbias", .id = 2 },
+	{ .name = "arizona-micbias", .id = 3 },
 	{ .name = "arizona-gpio" },
 	{
 		.name = "arizona-extcon",
@@ -1404,40 +1426,6 @@ int arizona_dev_init(struct arizona *arizona)
 		goto err_reset;
 	}
 
-	for (i = 0; i < ARIZONA_MAX_MICBIAS; i++) {
-		if (!arizona->pdata.micbias[i].mV &&
-		    !arizona->pdata.micbias[i].bypass)
-			continue;
-
-		/* Apply default for bypass mode */
-		if (!arizona->pdata.micbias[i].mV)
-			arizona->pdata.micbias[i].mV = 2800;
-
-		val = (arizona->pdata.micbias[i].mV - 1500) / 100;
-
-		val <<= ARIZONA_MICB1_LVL_SHIFT;
-
-		if (arizona->pdata.micbias[i].ext_cap)
-			val |= ARIZONA_MICB1_EXT_CAP;
-
-		if (arizona->pdata.micbias[i].discharge)
-			val |= ARIZONA_MICB1_DISCH;
-
-		if (arizona->pdata.micbias[i].soft_start)
-			val |= ARIZONA_MICB1_RATE;
-
-		if (arizona->pdata.micbias[i].bypass)
-			val |= ARIZONA_MICB1_BYPASS;
-
-		regmap_update_bits(arizona->regmap,
-				   ARIZONA_MIC_BIAS_CTRL_1 + i,
-				   ARIZONA_MICB1_LVL_MASK |
-				   ARIZONA_MICB1_EXT_CAP |
-				   ARIZONA_MICB1_DISCH |
-				   ARIZONA_MICB1_BYPASS |
-				   ARIZONA_MICB1_RATE, val);
-	}
-
 	for (i = 0; i < ARIZONA_MAX_INPUT; i++) {
 		/* Default for both is 0 so noop with defaults */
 		val = arizona->pdata.dmic_ref[i]
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
