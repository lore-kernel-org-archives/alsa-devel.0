From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: The ACPI also should use the
	function rt5514_parse_dp()
Date: Thu, 2 Nov 2017 19:21:16 +0800
Message-ID: <1509621676-14608-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F4A4266DEA
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 12:21:36 +0100 (CET)
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

The patch fixed that the ACPI cannot access the device property from the
function rt5514_parse_dp().

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index d7956ab..2a5b5d7 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1143,7 +1143,7 @@ static const struct acpi_device_id rt5514_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5514_acpi_match);
 #endif
 
-static int rt5514_parse_dt(struct rt5514_priv *rt5514, struct device *dev)
+static int rt5514_parse_dp(struct rt5514_priv *rt5514, struct device *dev)
 {
 	device_property_read_u32(dev, "realtek,dmic-init-delay-ms",
 		&rt5514->pdata.dmic_init_delay);
@@ -1183,8 +1183,8 @@ static int rt5514_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5514->pdata = *pdata;
-	else if (i2c->dev.of_node)
-		rt5514_parse_dt(rt5514, &i2c->dev);
+	else
+		rt5514_parse_dp(rt5514, &i2c->dev);
 
 	rt5514->i2c_regmap = devm_regmap_init_i2c(i2c, &rt5514_i2c_regmap);
 	if (IS_ERR(rt5514->i2c_regmap)) {
-- 
2.7.4
