From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Delay and retry reading rt5663
	ID register
Date: Mon, 6 Nov 2017 14:18:02 +0800
Message-ID: <1509949082-21443-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F4CB266ED0
 for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2017 07:18:10 +0100 (CET)
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

In the probe, the codec may not be ready for I2C reading. So if the value
is not correct, it will read again after delay.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index fcd1643..5985d8e 100644
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
+			"Device with ID register %#x is not rt5663,"
+			" retry one time.\n", val);
+		msleep(100);
+		regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
+	}
+
 	switch (val) {
 	case RT5663_DEVICE_ID_2:
 		rt5663->regmap = devm_regmap_init_i2c(i2c, &rt5663_v2_regmap);
-- 
2.7.4
