From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: check regmap_read result for ID
	check
Date: Tue, 24 Mar 2015 09:51:12 +0800
Message-ID: <1427161872-12356-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 241CD261566
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 02:51:28 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, matt.fleming@intel.com, jocelyn.li@intel.com, liam.r.girdwood@linux.intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

It is worth to check the regmap_read result for ID check since it
is the first regmap_read. And we can check if there is any i2c
issue.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 098fc78..ccc0fa0 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1220,7 +1220,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 {
 	struct rt286_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt286_priv *rt286;
-	int i, ret;
+	int i, ret, val;
 
 	rt286 = devm_kzalloc(&i2c->dev,	sizeof(*rt286),
 				GFP_KERNEL);
@@ -1235,11 +1235,15 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt286->regmap,
-		RT286_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &ret);
-	if (ret != RT286_VENDOR_ID && ret != RT288_VENDOR_ID) {
+	ret = regmap_read(rt286->regmap,
+		RT286_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &val);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "I2C error %d\n", ret);
+		return ret;
+	}
+	if (val != RT286_VENDOR_ID && val != RT288_VENDOR_ID) {
 		dev_err(&i2c->dev,
-			"Device with ID register %x is not rt286\n", ret);
+			"Device with ID register %x is not rt286\n", val);
 		return -ENODEV;
 	}
 
-- 
1.8.1.1.439.g50a6b54
