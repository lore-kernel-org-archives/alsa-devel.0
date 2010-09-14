From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 3/3] ASoC: tlv320aic3x: Complete the
	soc-cache conversion
Date: Tue, 14 Sep 2010 16:59:47 +0300
Message-ID: <1284472787-9881-1-git-send-email-jhnikula@gmail.com>
References: <20100914125510.GA21715@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E4475103885
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 15:59:53 +0200 (CEST)
Received: by ewy21 with SMTP id 21so3056280ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2010 06:59:51 -0700 (PDT)
In-Reply-To: <20100914125510.GA21715@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Complete the phasing out of aic3x_read_reg_cache, aic3x_write_reg_cache,
aic3x_read and aic3x_write calls.

This patch uses in aic3x_read the codec->hw_read that points to a function
implemented by soc-cache. Only use for aic3x_read is if wanting to read
volatile bits from those registers that has both read-only and read/write
bits. All other cases should use snd_soc_read.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 86e5a58..7b5f159 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -112,28 +112,21 @@ static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
 };
 
 /*
- * write aic3x register cache
- */
-static inline void aic3x_write_reg_cache(struct snd_soc_codec *codec,
-					 u8 reg, u8 value)
-{
-	u8 *cache = codec->reg_cache;
-	if (reg >= AIC3X_CACHEREGNUM)
-		return;
-	cache[reg] = value;
-}
-
-/*
- * read from the aic3x register space
+ * read from the aic3x register space. Only use for this function is if
+ * wanting to read volatile bits from those registers that has both read-only
+ * and read/write bits. All other cases should use snd_soc_read.
  */
 static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
 		      u8 *value)
 {
-	*value = reg & 0xff;
+	u8 *cache = codec->reg_cache;
+
+	if (reg >= AIC3X_CACHEREGNUM)
+		return -1;
 
-	value[0] = i2c_smbus_read_byte_data(codec->control_data, value[0]);
+	*value = codec->hw_read(codec, reg);
+	cache[reg] = *value;
 
-	aic3x_write_reg_cache(codec, reg, *value);
 	return 0;
 }
 
-- 
1.7.1
