From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/5] ASoC: rt5645: Prevent the pop sound of the
	headphone while rebooting or shutdowning
Date: Mon, 24 Aug 2015 20:32:55 +0800
Message-ID: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A4922606F5
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 14:33:10 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add i2c shutdown function to prevent the pop sound of the headphone while
the system is rebooting or shutdowning

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e5fef8f..4189d5a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3490,13 +3490,23 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+static void rt5645_i2c_shutdown(struct i2c_client *i2c)
+{
+	struct rt5645_priv *rt5645 = i2c_get_clientdata(i2c);
+
+	regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3, 0x0020, 0x0020);
+	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2, 0x1000, 0x1000);
+	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, 0x0004, 0x0000);
+}
+
 static struct i2c_driver rt5645_i2c_driver = {
 	.driver = {
 		.name = "rt5645",
 		.acpi_match_table = ACPI_PTR(rt5645_acpi_match),
 	},
 	.probe = rt5645_i2c_probe,
-	.remove   = rt5645_i2c_remove,
+	.remove = rt5645_i2c_remove,
+	.shutdown = rt5645_i2c_shutdown,
 	.id_table = rt5645_i2c_id,
 };
 module_i2c_driver(rt5645_i2c_driver);
-- 
1.8.1.1.439.g50a6b54
