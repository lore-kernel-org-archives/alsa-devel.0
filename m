From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: max9850: remove unused variable 'max9850_reg'
Date: Thu, 8 Aug 2019 22:35:07 +0800
Message-ID: <20190808143507.66788-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, allison@lohutok.net, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

sound/soc/codecs/max9850.c:31:33: warning:
 max9850_reg defined but not used [-Wunused-const-variable=]

It is not used since commit 068416620c0d ("ASoC:
max9850: Convert to direct regmap API usage")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/max9850.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index f50ee8f..6f43748 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -27,19 +27,6 @@ struct max9850_priv {
 	unsigned int sysclk;
 };
 
-/* max9850 register cache */
-static const struct reg_default max9850_reg[] = {
-	{  2, 0x0c },
-	{  3, 0x00 },
-	{  4, 0x00 },
-	{  5, 0x00 },
-	{  6, 0x00 },
-	{  7, 0x00 },
-	{  8, 0x00 },
-	{  9, 0x00 },
-	{ 10, 0x00 },
-};
-
 /* these registers are not used at the moment but provided for the sake of
  * completeness */
 static bool max9850_volatile_register(struct device *dev, unsigned int reg)
-- 
2.7.4
