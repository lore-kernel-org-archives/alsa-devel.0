Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B83CC32771
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Sep 2022 08:20:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D92C15C3;
	Wed, 21 Sep 2022 10:19:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D92C15C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663748435;
	bh=wiUnHKQqtiJ6Xews4Yl5k7LExJd+w9oiMFoDNSCcz0M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a/D9GsWgzMXtecXCWXfBL2Ktj03wzBqsdNv0JLtp+stwNX3xhwyhh2RCfttr+u7xd
	 mCAmbmBwozSMZH3rbjgXjseuFA9hVoXeNjWZ16HfM2B4CX7eeXPUX/gYlvc5L7pULa
	 /lmhxjQqwvWKMsFWM9DSw2L0ghb6CZP+nV0POCC0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52CAFF8053C;
	Wed, 21 Sep 2022 10:18:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D517F80535; Wed, 21 Sep 2022 10:18:49 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B12E6F80169
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2022 10:18:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B12E6F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="Z+70AptG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1663748321;
 x=1695284321; h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wabbL0RF4cqJkhaKeIa2nvuu2KpYvr0mfs1CAwHKPh0=;
 b=Z+70AptGUIo3t7evTKhYVxfWqfGJT2Q8PdlF2tJYBWwnqy6WJmg5R1bB
 Pfcj63mbYbpOn1Q+PnmIgtoK/GN7RltLHsFul9xPVuddCdeTg+UAQlBE1
 20U9oXJxPoZzCBroo1L11JMPAJCB1XOMvX+AC/hS/kKdh8irWnVJx4Kmp
 QcsZbvYywx0FznTcdI7UXlmaOfmReD47jR8LLm1CmrNy+O4X+E919oahk
 A0DflC+5Bhr/HobaowYTBQVc5d+yjIPDltjhz0X4EEklkS8f2TXCPFTH4
 OPP0SJsAbc5al8bFt3WSD7zm5S0t+03YspYVLY6faYLQMGOpAwDQwm3Qv Q==;
From: Astrid Rost <astrid.rost@axis.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v4 3/3] ASoC: ts3a227e: add parameters to control debounce
 times
Date: Wed, 21 Sep 2022 10:18:34 +0200
Message-ID: <20220921081834.22009-4-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220921081834.22009-1-astrid.rost@axis.com>
References: <20220921081834.22009-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, Astrid Rost <astrid.rost@axis.com>,
 kernel@axis.com, linux-kernel@vger.kernel.org, Astrid Rost <astridr@axis.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add devicetree parameters to control the insert, release and press
debounce times.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 sound/soc/codecs/ts3a227e.c | 61 +++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index d8ab0810fceb..2305a472d132 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -78,12 +78,20 @@ static const int ts3a227e_buttons[] = {
 #define ADC_COMPLETE_INT_DISABLE 0x04
 #define INTB_DISABLE 0x08
 
+/* TS3A227E_REG_SETTING_1 0x4 */
+#define DEBOUNCE_INSERTION_SETTING_SFT (0)
+#define DEBOUNCE_INSERTION_SETTING_MASK (0x7 << DEBOUNCE_PRESS_SETTING_SFT)
+
 /* TS3A227E_REG_SETTING_2 0x05 */
 #define KP_ENABLE 0x04
 
 /* TS3A227E_REG_SETTING_3 0x06 */
-#define MICBIAS_SETTING_SFT (3)
+#define MICBIAS_SETTING_SFT 3
 #define MICBIAS_SETTING_MASK (0x7 << MICBIAS_SETTING_SFT)
+#define DEBOUNCE_RELEASE_SETTING_SFT 2
+#define DEBOUNCE_RELEASE_SETTING_MASK (0x1 << DEBOUNCE_RELEASE_SETTING_SFT)
+#define DEBOUNCE_PRESS_SETTING_SFT 0
+#define DEBOUNCE_PRESS_SETTING_MASK (0x3 << DEBOUNCE_PRESS_SETTING_SFT)
 
 /* TS3A227E_REG_ACCESSORY_STATUS  0x0b */
 #define TYPE_3_POLE 0x01
@@ -136,7 +144,7 @@ static bool ts3a227e_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case TS3A227E_REG_INTERRUPT ... TS3A227E_REG_INTERRUPT_DISABLE:
-	case TS3A227E_REG_SETTING_2:
+	case TS3A227E_REG_SETTING_1 ... TS3A227E_REG_SETTING_2:
 	case TS3A227E_REG_SWITCH_STATUS_1 ... TS3A227E_REG_ADC_OUTPUT:
 		return true;
 	default:
@@ -269,14 +277,55 @@ static const struct regmap_config ts3a227e_regmap_config = {
 static int ts3a227e_parse_device_property(struct ts3a227e *ts3a227e,
 				struct device *dev)
 {
-	u32 micbias;
+	u32 value;
+	u32 value_ms;
+	u32 setting3_value = 0;
+	u32 setting3_mask = 0;
 	int err;
 
-	err = device_property_read_u32(dev, "ti,micbias", &micbias);
+	err = device_property_read_u32(dev, "ti,micbias", &value);
+	if (!err) {
+		setting3_mask = MICBIAS_SETTING_MASK;
+		setting3_value = (value << MICBIAS_SETTING_SFT) &
+				 MICBIAS_SETTING_MASK;
+	}
+
+	err = device_property_read_u32(dev, "ti,debounce-release-ms",
+				       &value_ms);
 	if (!err) {
+		value = (value_ms > 10);
+		setting3_mask |= DEBOUNCE_RELEASE_SETTING_MASK;
+		setting3_value |= (value << DEBOUNCE_RELEASE_SETTING_SFT) &
+				  DEBOUNCE_RELEASE_SETTING_MASK;
+	}
+
+	err = device_property_read_u32(dev, "ti,debounce-press-ms", &value_ms);
+	if (!err) {
+		value = (value_ms + 20) / 40;
+		if (value > 3)
+			value = 3;
+		setting3_mask |= DEBOUNCE_PRESS_SETTING_MASK;
+		setting3_value |= (value << DEBOUNCE_PRESS_SETTING_SFT) &
+				  DEBOUNCE_PRESS_SETTING_MASK;
+	}
+
+	if (setting3_mask)
 		regmap_update_bits(ts3a227e->regmap, TS3A227E_REG_SETTING_3,
-			MICBIAS_SETTING_MASK,
-			(micbias & 0x07) << MICBIAS_SETTING_SFT);
+				   setting3_mask, setting3_value);
+
+	err = device_property_read_u32(dev, "ti,debounce-insertion-ms",
+				       &value_ms);
+	if (!err) {
+		if (value_ms < 165)
+			value = (value_ms + 15) / 30;
+		else if (value_ms < 1500)
+			value = 6;
+		else
+			value = 7;
+		regmap_update_bits(ts3a227e->regmap, TS3A227E_REG_SETTING_1,
+				   DEBOUNCE_INSERTION_SETTING_MASK,
+				   (value << DEBOUNCE_INSERTION_SETTING_SFT) &
+					   DEBOUNCE_INSERTION_SETTING_MASK);
 	}
 
 	return 0;
-- 
2.20.1

