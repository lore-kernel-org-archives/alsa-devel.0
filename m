From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] asoc tlv320aic3x: set power bits correctly
Date: Wed, 30 Apr 2008 11:37:19 +0200
Message-ID: <20080430093719.GA13740@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id F23C31038B1
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 11:37:22 +0200 (CEST)
Content-Disposition: inline
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Set power bits in output stage control registers to reflect the "!muted"
bits. The codec needs them set in order to operate correctly.

Signed-off-by: Daniel Mack <daniel@caiaq.de>



--2oS5YaxWCcQjTEyO
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-tlv320aic33-pwrbits.diff"

From: Daniel Mack <daniel@caiaq.de>

Set power bits in output stage control registers to reflect the "!muted"
bits. The codec needs them set in order to operate correctly.

Signed-off-by: Daniel Mack <daniel@caiaq.de>

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6e4bc69..c4c50b7 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -93,6 +93,28 @@ static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
 };
 
 /*
+ * power up/down aic3x functions
+ */
+static inline void aic3x_handle_pwr_bits(unsigned int reg, unsigned int *val)
+{
+	switch (reg) {
+	case HPLOUT_CTRL:
+	case HPROUT_CTRL:
+	case HPLCOM_CTRL:
+	case HPRCOM_CTRL:
+	case LLOPM_CTRL:
+	case RLOPM_CTRL:
+	case MONOLOPM_CTRL:
+		if (*val & 0x08)
+			*val |= 0x01;
+		else
+			*val &= ~0x01;
+
+		break;
+	}
+}
+
+/*
  * read aic3x register cache
  */
 static inline unsigned int aic3x_read_reg_cache(struct snd_soc_codec *codec,
@@ -124,6 +146,8 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
 {
 	u8 data[2];
 
+	aic3x_handle_pwr_bits(reg, &value);
+
 	/* data is
 	 *   D15..D8 aic3x register offset
 	 *   D7...D0 register data

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--2oS5YaxWCcQjTEyO--
