From: <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC:rt286:fix comment style
Date: Thu, 6 Nov 2014 10:00:00 +0800
Message-ID: <1415239200-13788-2-git-send-email-bardliao@realtek.com>
References: <1415239200-13788-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 78F7C2617AD
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 03:00:45 +0100 (CET)
In-Reply-To: <1415239200-13788-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

Adds spaces around the /* */.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index d4acb64..2e818aa 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -191,7 +191,7 @@ static int rt286_hw_write(void *context, unsigned int reg, unsigned int value)
 	u8 data[4];
 	int ret, i;
 
-	/*handle index registers*/
+	/* handle index registers */
 	if (reg <= 0xff) {
 		rt286_hw_write(client, RT286_COEF_INDEX, reg);
 		for (i = 0; i < INDEX_CACHE_SIZE; i++) {
@@ -234,7 +234,7 @@ static int rt286_hw_read(void *context, unsigned int reg, unsigned int *value)
 	__be32 be_reg;
 	unsigned int index, vid, buf = 0x0;
 
-	/*handle index registers*/
+	/* handle index registers */
 	if (reg <= 0xff) {
 		rt286_hw_write(client, RT286_COEF_INDEX, reg);
 		reg = RT286_PROC_COEF;
@@ -1281,11 +1281,11 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	mdelay(10);
 
 	regmap_write(rt286->regmap, RT286_MISC_CTRL1, 0x0000);
-	/*Power down LDO, VREF*/
+	/* Power down LDO, VREF */
 	regmap_update_bits(rt286->regmap, RT286_POWER_CTRL2, 0xc, 0x0);
 	regmap_update_bits(rt286->regmap, RT286_POWER_CTRL1, 0x1001, 0x1001);
 
-	/*Set depop parameter*/
+	/* Set depop parameter */
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL2, 0x403a, 0x401a);
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL3, 0xf777, 0x4737);
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL4, 0x00ff, 0x003f);
-- 
1.8.1.1.439.g50a6b54
