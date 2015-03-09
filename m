From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] ASoC: tlv320aic23: remove incorrect __exit markups
Date: Mon, 9 Mar 2015 11:18:14 -0700
Message-ID: <20150309181814.GA27608@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Even if bus is not hot-pluggable, the devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe() which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/codecs/tlv320aic23-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23-i2c.c b/sound/soc/codecs/tlv320aic23-i2c.c
index f137019..78a94af 100644
--- a/sound/soc/codecs/tlv320aic23-i2c.c
+++ b/sound/soc/codecs/tlv320aic23-i2c.c
@@ -31,7 +31,7 @@ static int tlv320aic23_i2c_probe(struct i2c_client *i2c,
 	return tlv320aic23_probe(&i2c->dev, regmap);
 }
 
-static int __exit tlv320aic23_i2c_remove(struct i2c_client *i2c)
+static int tlv320aic23_i2c_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
 	return 0;
@@ -56,7 +56,7 @@ static struct i2c_driver tlv320aic23_i2c_driver = {
 		   .of_match_table = of_match_ptr(tlv320aic23_of_match),
 		   },
 	.probe = tlv320aic23_i2c_probe,
-	.remove = __exit_p(tlv320aic23_i2c_remove),
+	.remove = tlv320aic23_i2c_remove,
 	.id_table = tlv320aic23_id,
 };
 
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
