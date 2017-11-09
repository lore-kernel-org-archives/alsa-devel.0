From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v3] ASoC: rt5663: Delay and retry reading
	rt5663 ID register
Date: Thu, 9 Nov 2017 19:28:10 +0800
Message-ID: <1510226890-11507-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 519E6266B80
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 12:30:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

In the probe, the codec may not be ready for I2C reading or there are some
glitches on the i2c line. So if the i2c reading value is incorrect, it will
read again after delay. This issue is similar the patch
https://patchwork.kernel.org/patch/9681421/. In current project, these 2
devices were connected to the same i2c line, and they met the same problem.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index fcd1643..18dc1ec 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3429,7 +3429,16 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 			ret);
 		return ret;
 	}
-	regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
+
+	ret = regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
+	if (ret || (val != RT5663_DEVICE_ID_2 && val != RT5663_DEVICE_ID_1)) {
+		dev_err(&i2c->dev,
+			"Device with ID register %#x is not rt5663, retry one time.\n",
+			val);
+		msleep(100);
+		regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
+	}
+
 	switch (val) {
 	case RT5663_DEVICE_ID_2:
 		rt5663->regmap = devm_regmap_init_i2c(i2c, &rt5663_v2_regmap);
-- 
2.7.4
