From: Kevin Cernekee <cernekee@chromium.org>
Subject: [PATCH] ASoC: tas571x: Eliminate redundant dev->of_node NULL check
Date: Tue,  5 May 2015 15:52:29 -0700
Message-ID: <1430866350-21391-1-git-send-email-cernekee@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: lars@metafoo.de, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

of_match_device() checks if dev->of_node is NULL, so we don't need to do
it again in the probe function.

Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
---


This applies to the broonie/sound.git for-next branch.


 sound/soc/codecs/tas571x.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index b187ea53a7f9..85bcc374c8e8 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -377,6 +377,7 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 {
 	struct tas571x_private *priv;
 	struct device *dev = &client->dev;
+	const struct of_device_id *of_id;
 	int i, ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -384,18 +385,12 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 	i2c_set_clientdata(client, priv);
 
-	if (dev->of_node) {
-		const struct of_device_id *of_id;
-
-		of_id = of_match_device(tas571x_of_match, dev);
-		if (of_id)
-			priv->chip = of_id->data;
-	}
-
-	if (!priv->chip) {
+	of_id = of_match_device(tas571x_of_match, dev);
+	if (!of_id) {
 		dev_err(dev, "Unknown device type\n");
 		return -EINVAL;
 	}
+	priv->chip = of_id->data;
 
 	priv->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(priv->mclk) && PTR_ERR(priv->mclk) != -ENOENT) {
-- 
2.2.0.rc0.207.ga3a616c
