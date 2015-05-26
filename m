From: yang.a.fang@intel.com
Subject: [PATCH 2/3] ASoC: ts3a227e: use device property api
Date: Tue, 26 May 2015 16:58:05 -0700
Message-ID: <1432684686-14460-2-git-send-email-yang.a.fang@intel.com>
References: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4300D265474
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 01:58:59 +0200 (CEST)
In-Reply-To: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, praveen.k.jain@intel.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

replace of_property_read_u32 with device_property_read_u32

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/ts3a227e.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 9fd80ac..dfb49b3 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -254,12 +254,12 @@ static const struct regmap_config ts3a227e_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(ts3a227e_reg_defaults),
 };
 
-static int ts3a227e_parse_dt(struct ts3a227e *ts3a227e, struct device_node *np)
+static int ts3a227e_parse_dt(struct ts3a227e *ts3a227e, struct device *dev)
 {
 	u32 micbias;
 	int err;
 
-	err = of_property_read_u32(np, "ti,micbias", &micbias);
+	err = device_property_read_u32(dev, "ti,micbias", &micbias);
 	if (!err) {
 		regmap_update_bits(ts3a227e->regmap, TS3A227E_REG_SETTING_3,
 			MICBIAS_SETTING_MASK,
@@ -287,12 +287,10 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(ts3a227e->regmap))
 		return PTR_ERR(ts3a227e->regmap);
 
-	if (dev->of_node) {
-		ret = ts3a227e_parse_dt(ts3a227e, dev->of_node);
-		if (ret) {
-			dev_err(dev, "Failed to parse device tree: %d\n", ret);
-			return ret;
-		}
+	ret = ts3a227e_parse_dt(ts3a227e, dev);
+	if (ret) {
+		dev_err(dev, "Failed to parse device tree: %d\n", ret);
+		return ret;
 	}
 
 	ret = devm_request_threaded_irq(dev, i2c->irq, NULL, ts3a227e_interrupt,
-- 
1.7.9.5
