From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 04/10] ASoC: twl6040: Introduce SW only
	shadow register
Date: Thu, 22 Sep 2011 11:05:48 +0300
Message-ID: <1316678754-11935-5-git-send-email-peter.ujfalusi@ti.com>
References: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F61810386B
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 10:06:26 +0200 (CEST)
Received: by bkat2 with SMTP id t2so2778116bka.36
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 01:06:24 -0700 (PDT)
In-Reply-To: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Software only shadow register to be used by the driver.
For example Earpiece path will need this shadow register.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 include/linux/mfd/twl6040.h |    2 --
 sound/soc/codecs/twl6040.c  |   19 ++++++++++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index ec1ec79..47470ca 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -68,8 +68,6 @@
 #define TWL6040_REG_ACCCTL		0x2D
 #define TWL6040_REG_STATUS		0x2E
 
-#define TWL6040_CACHEREGNUM		(TWL6040_REG_STATUS + 1)
-
 /* INTID (0x03) fields */
 
 #define TWL6040_THINT			0x01
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 9fbfe0e..9635466 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -57,6 +57,10 @@
 #define TWL6040_HF_VOL_MASK	0x1F
 #define TWL6040_HF_VOL_SHIFT	0
 
+/* Shadow register used by the driver */
+#define TWL6040_REG_SW_SHADOW	0x2F
+#define TWL6040_CACHEREGNUM	(TWL6040_REG_SW_SHADOW + 1)
+
 struct twl6040_output {
 	u16 active;
 	u16 left_vol;
@@ -153,6 +157,8 @@ static const u8 twl6040_reg[TWL6040_CACHEREGNUM] = {
 	0x00, /* REG_HFOTRIM	0x2C	*/
 	0x09, /* REG_ACCCTL	0x2D	*/
 	0x00, /* REG_STATUS	0x2E (ro) */
+
+	0x00, /* REG_SW_SHADOW	0x2F - Shadow, non HW register */
 };
 
 /* List of registers to be restored after power up */
@@ -236,8 +242,12 @@ static int twl6040_read_reg_volatile(struct snd_soc_codec *codec,
 	if (reg >= TWL6040_CACHEREGNUM)
 		return -EIO;
 
-	value = twl6040_reg_read(twl6040, reg);
-	twl6040_write_reg_cache(codec, reg, value);
+	if (likely(reg < TWL6040_REG_SW_SHADOW)) {
+		value = twl6040_reg_read(twl6040, reg);
+		twl6040_write_reg_cache(codec, reg, value);
+	} else {
+		value = twl6040_read_reg_cache(codec, reg);
+	}
 
 	return value;
 }
@@ -254,7 +264,10 @@ static int twl6040_write(struct snd_soc_codec *codec,
 		return -EIO;
 
 	twl6040_write_reg_cache(codec, reg, value);
-	return twl6040_reg_write(twl6040, reg, value);
+	if (likely(reg < TWL6040_REG_SW_SHADOW))
+		return twl6040_reg_write(twl6040, reg, value);
+	else
+		return 0;
 }
 
 static void twl6040_init_chip(struct snd_soc_codec *codec)
-- 
1.7.6.1
