From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/3] regmap: Add support for 2/6 register
	formating
Date: Fri, 27 Jan 2012 16:10:22 +0100
Message-ID: <1327677023-29310-2-git-send-email-w.sang@pengutronix.de>
References: <1327677023-29310-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A0C92244D9
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 16:10:34 +0100 (CET)
In-Reply-To: <1327677023-29310-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Wolfram Sang <w.sang@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/base/regmap/regmap.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 8bd0232..fb3c132 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -76,6 +76,14 @@ static bool regmap_volatile_range(struct regmap *map, unsigned int reg,
 	return true;
 }
 
+static void regmap_format_2_6_write(struct regmap *map,
+				     unsigned int reg, unsigned int val)
+{
+	u8 *out = map->work_buf;
+
+	*out = (reg << 6) | val;
+}
+
 static void regmap_format_4_12_write(struct regmap *map,
 				     unsigned int reg, unsigned int val)
 {
@@ -178,6 +186,16 @@ struct regmap *regmap_init(struct device *dev,
 	}
 
 	switch (config->reg_bits) {
+	case 2:
+		switch (config->val_bits) {
+		case 6:
+			map->format.format_write = regmap_format_2_6_write;
+			break;
+		default:
+			goto err_map;
+		}
+		break;
+
 	case 4:
 		switch (config->val_bits) {
 		case 12:
-- 
1.7.8.3
