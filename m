From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/2] regmap: Specify a module license
Date: Thu, 11 Aug 2011 11:59:10 -0600
Message-ID: <1313085551-26125-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A1CDD2438E
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 19:59:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

CONFIG_REGMAP_I2C/SPI are set to m when selected by a tristate config
option that's set to m. The regmap modules don't specify a license, so
fail to link to regmap_init at load time, since that is EXPORT_SYMBOL_GPL.
Fix this by specifying a license for the regmap modules.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/base/regmap/regmap-i2c.c |    1 +
 drivers/base/regmap/regmap-spi.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index e6ce82d..e7d916d 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -112,3 +112,4 @@ struct regmap *regmap_init_i2c(struct i2c_client *i2c,
 }
 EXPORT_SYMBOL_GPL(regmap_init_i2c);
 
+MODULE_LICENSE("GPL");
diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 07633bd..cc0f116 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -69,3 +69,5 @@ struct regmap *regmap_init_spi(struct spi_device *spi,
 	return regmap_init(&spi->dev, &regmap_spi, config);
 }
 EXPORT_SYMBOL_GPL(regmap_init_spi);
+
+MODULE_LICENSE("GPL");
-- 
1.7.0.4
