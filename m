From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: fix module device table type for
 sgtl5000_dt_ids
Date: Thu, 11 Aug 2011 22:19:16 +0800
Message-ID: <1313072356.9215.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The module device table for of_device_id should use "of" type.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/sgtl5000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 666fae6..91130fb 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1441,7 +1441,7 @@ static const struct of_device_id sgtl5000_dt_ids[] = {
 	{ .compatible = "fsl,sgtl5000", },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(i2c, sgtl5000_dt_ids);
+MODULE_DEVICE_TABLE(of, sgtl5000_dt_ids);
 
 static struct i2c_driver sgtl5000_i2c_driver = {
 	.driver = {
-- 
1.7.4.1
