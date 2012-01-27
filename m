From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/3] regmap: Properly round reg_bytes and
	val_bytes
Date: Fri, 27 Jan 2012 16:10:21 +0100
Message-ID: <1327677023-29310-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 909EE244D4
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 16:10:34 +0100 (CET)
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

For the upcoming 2/6-format, we don't see debugfs output otherwise,
since the current division results in 0. I'd think 10/14 is broken
currently, too.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/base/regmap/regmap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6555803..8bd0232 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -159,8 +159,8 @@ struct regmap *regmap_init(struct device *dev,
 
 	mutex_init(&map->lock);
 	map->format.buf_size = (config->reg_bits + config->val_bits) / 8;
-	map->format.reg_bytes = config->reg_bits / 8;
-	map->format.val_bytes = config->val_bits / 8;
+	map->format.reg_bytes = DIV_ROUND_UP(config->reg_bits, 8);
+	map->format.val_bytes = DIV_ROUND_UP(config->val_bits, 8);
 	map->dev = dev;
 	map->bus = bus;
 	map->max_register = config->max_register;
-- 
1.7.8.3
