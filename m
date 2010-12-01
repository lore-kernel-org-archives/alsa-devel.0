From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Remove unused aic3x_i2c_init and aic3x_i2c_exit
	functions
Date: Wed, 01 Dec 2010 14:38:24 +0800
Message-ID: <1291185504.5563.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index fc5abdf..8cd4cf5 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1545,21 +1545,6 @@ static struct i2c_driver aic3x_i2c_driver = {
 	.remove = aic3x_i2c_remove,
 	.id_table = aic3x_i2c_id,
 };
-
-static inline void aic3x_i2c_init(void)
-{
-	int ret;
-
-	ret = i2c_add_driver(&aic3x_i2c_driver);
-	if (ret)
-		printk(KERN_ERR "%s: error regsitering i2c driver, %d\n",
-		       __func__, ret);
-}
-
-static inline void aic3x_i2c_exit(void)
-{
-	i2c_del_driver(&aic3x_i2c_driver);
-}
 #endif
 
 static int __init aic3x_modinit(void)
-- 
1.7.2
