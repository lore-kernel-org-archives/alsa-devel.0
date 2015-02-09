From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: rt286: Add rt288 codec support
Date: Mon, 9 Feb 2015 14:19:45 +0800
Message-ID: <1423462785-26760-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B148C2604E2
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 07:20:03 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch adds support for rt288 codec.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 81bdd276..7a72eac 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -34,6 +34,7 @@
 #include "rt286.h"
 
 #define RT286_VENDOR_ID 0x10ec0286
+#define RT288_VENDOR_ID 0x10ec0288
 
 struct rt286_priv {
 	struct regmap *regmap;
@@ -1168,6 +1169,7 @@ static const struct regmap_config rt286_regmap = {
 
 static const struct i2c_device_id rt286_i2c_id[] = {
 	{"rt286", 0},
+	{"rt288", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, rt286_i2c_id);
@@ -1210,7 +1212,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 
 	regmap_read(rt286->regmap,
 		RT286_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &ret);
-	if (ret != RT286_VENDOR_ID) {
+	if (ret != RT286_VENDOR_ID && ret != RT288_VENDOR_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %x is not rt286\n", ret);
 		return -ENODEV;
-- 
1.8.1.1.439.g50a6b54
