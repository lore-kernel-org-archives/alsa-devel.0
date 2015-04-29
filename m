From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v11 2/3] drm/i2c: tda998x: Change drvdata for audio extension
Date: Wed, 29 Apr 2015 12:26:33 +0200
Message-ID: <779ff69d5fd57f0ea0c62492debad181402805e5.1430320384.git.moinejf@free.fr>
References: <cover.1430320384.git.moinejf@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1430320384.git.moinejf@free.fr>
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
index a2ed391..e9b497e 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1448,6 +1448,8 @@ static int tda998x_encoder_init(struct i2c_client *client,
 	encoder_slave->slave_priv = priv;
 	encoder_slave->slave_funcs = &tda998x_encoder_slave_funcs;
 
+	dev_set_drvdata(&client->dev, priv);
+
 	return 0;
 }
 
@@ -1575,7 +1577,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	if (!priv)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, priv);
+	dev_set_drvdata(dev, &priv->base);
 
 	if (dev->of_node)
 		crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
@@ -1634,7 +1636,9 @@ err_encoder:
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
