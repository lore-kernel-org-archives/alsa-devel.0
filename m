From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/8] ASoC: Move WM9090 device identification
	and reset to I2C probe
Date: Wed, 14 Dec 2011 17:00:50 +0800
Message-ID: <1323853254-9020-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C153D245AA
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 10:01:14 +0100 (CET)
In-Reply-To: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9090.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 4be5551..a2b9208 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -532,18 +532,6 @@ static int wm9090_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	ret = snd_soc_read(codec, WM9090_SOFTWARE_RESET);
-	if (ret < 0)
-		return ret;
-	if (ret != 0x9093) {
-		dev_err(codec->dev, "Device is not a WM9090, ID=%x\n", ret);
-		return -EINVAL;
-	}
-
-	ret = snd_soc_write(codec, WM9090_SOFTWARE_RESET, 0);
-	if (ret < 0)
-		return ret;
-
 	/* Configure some defaults; they will be written out when we
 	 * bring the bias up.
 	 */
@@ -631,6 +619,7 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm9090_priv *wm9090;
+	unsigned int reg;
 	int ret;
 
 	wm9090 = devm_kzalloc(&i2c->dev, sizeof(*wm9090), GFP_KERNEL);
@@ -646,6 +635,19 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	ret = regmap_read(wm9090->regmap, WM9090_SOFTWARE_RESET, &reg);
+	if (ret < 0)
+		goto err;
+	if (reg != 0x9093) {
+		dev_err(&i2c->dev, "Device is not a WM9090, ID=%x\n", ret);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ret = regmap_write(wm9090->regmap, WM9090_SOFTWARE_RESET, 0);
+	if (ret < 0)
+		goto err;
+
 	if (i2c->dev.platform_data)
 		memcpy(&wm9090->pdata, i2c->dev.platform_data,
 		       sizeof(wm9090->pdata));
-- 
1.7.7.3
