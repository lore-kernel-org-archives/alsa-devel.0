From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v12 5/6] drm/i2c: tda998x: Change drvdata for audio extension
Date: Fri, 8 May 2015 10:23:24 +0200
Message-ID: <3021578d7e7a53b1932578aa36451aa8c93cb78a.1431083916.git.moinejf@free.fr>
References: <cover.1431083916.git.moinejf@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1431083916.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The device drvdata is used for component bind, but points to the
encoder/connector structure which is hidden from the slave encoder.
For audio extension, the slave encoder private data must be accessible,
so, this patch changes drvdata to the slave encoder private data and
sets it in case of slave encoder use.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index bcf96f7..7a9d9a7 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1450,6 +1450,8 @@ static int tda998x_encoder_init(struct i2c_client *client,
 	encoder_slave->slave_priv = priv;
 	encoder_slave->slave_funcs = &tda998x_encoder_slave_funcs;
 
+	dev_set_drvdata(&client->dev, priv);
+
 	return 0;
 }
 
@@ -1577,7 +1579,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	if (!priv)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, priv);
+	dev_set_drvdata(dev, &priv->base);
 
 	if (dev->of_node)
 		crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
@@ -1636,7 +1638,9 @@ err_encoder:
 static void tda998x_unbind(struct device *dev, struct device *master,
 			   void *data)
 {
-	struct tda998x_priv2 *priv = dev_get_drvdata(dev);
+	struct tda998x_priv *priv_s = dev_get_drvdata(dev);
+	struct tda998x_priv2 *priv =
+			container_of(priv_s, struct tda998x_priv2, base);
 
 	drm_connector_cleanup(&priv->connector);
 	drm_encoder_cleanup(&priv->encoder);
-- 
2.1.4
