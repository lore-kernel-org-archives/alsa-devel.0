From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 04/11] ASoC: twl4030: Separate write condition
	checking from I/O function
Date: Fri, 3 Jan 2014 15:27:49 +0200
Message-ID: <1388755676-16036-5-git-send-email-peter.ujfalusi@ti.com>
References: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 27ECE261A0E
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2014 14:28:10 +0100 (CET)
In-Reply-To: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Simplifies the code a bit and prepares it to the removal of local caching.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl4030.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index dfc51bb425da..419108ae31de 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -181,50 +181,56 @@ static inline void twl4030_write_reg_cache(struct snd_soc_codec *codec,
 	cache[reg] = value;
 }
 
-/*
- * write to the twl4030 register space
- */
-static int twl4030_write(struct snd_soc_codec *codec,
-			unsigned int reg, unsigned int value)
+static bool twl4030_can_write_to_chip(struct snd_soc_codec *codec,
+				      unsigned int reg)
 {
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
-	int write_to_reg = 0;
+	bool write_to_reg = false;
 
-	twl4030_write_reg_cache(codec, reg, value);
 	/* Decide if the given register can be written */
 	switch (reg) {
 	case TWL4030_REG_EAR_CTL:
 		if (twl4030->earpiece_enabled)
-			write_to_reg = 1;
+			write_to_reg = true;
 		break;
 	case TWL4030_REG_PREDL_CTL:
 		if (twl4030->predrivel_enabled)
-			write_to_reg = 1;
+			write_to_reg = true;
 		break;
 	case TWL4030_REG_PREDR_CTL:
 		if (twl4030->predriver_enabled)
-			write_to_reg = 1;
+			write_to_reg = true;
 		break;
 	case TWL4030_REG_PRECKL_CTL:
 		if (twl4030->carkitl_enabled)
-			write_to_reg = 1;
+			write_to_reg = true;
 		break;
 	case TWL4030_REG_PRECKR_CTL:
 		if (twl4030->carkitr_enabled)
-			write_to_reg = 1;
+			write_to_reg = true;
 		break;
 	case TWL4030_REG_HS_GAIN_SET:
 		if (twl4030->hsl_enabled || twl4030->hsr_enabled)
-			write_to_reg = 1;
+			write_to_reg = true;
 		break;
 	default:
 		/* All other register can be written */
-		write_to_reg = 1;
+		write_to_reg = true;
 		break;
 	}
-	if (write_to_reg)
-		return twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
-					    value, reg);
+
+	return write_to_reg;
+}
+
+/*
+ * write to the twl4030 register space
+ */
+static int twl4030_write(struct snd_soc_codec *codec,
+			 unsigned int reg, unsigned int value)
+{
+	twl4030_write_reg_cache(codec, reg, value);
+	if (twl4030_can_write_to_chip(codec, reg))
+		return twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, value, reg);
 
 	return 0;
 }
-- 
1.8.5.2
