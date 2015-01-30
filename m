From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: Add rt288 codec support
Date: Fri, 30 Jan 2015 14:21:33 +0800
Message-ID: <1422598893-28393-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 75F5A260676
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 07:21:57 +0100 (CET)
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, flove@realtek.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds support for rt288 codec.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 81bdd276..2eafbcf 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -34,6 +34,7 @@
 #include "rt286.h"
 
 #define RT286_VENDOR_ID 0x10ec0286
+#define RT288_VENDOR_ID 0x10ec0288
 
 struct rt286_priv {
 	struct regmap *regmap;
@@ -1210,7 +1211,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 
 	regmap_read(rt286->regmap,
 		RT286_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &ret);
-	if (ret != RT286_VENDOR_ID) {
+	if (ret != RT286_VENDOR_ID && ret != RT288_VENDOR_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %x is not rt286\n", ret);
 		return -ENODEV;
-- 
1.8.1.1.439.g50a6b54
