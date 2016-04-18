From: Timur Karaldin <karaldin@mcsplus.ru>
Subject: [PATCH V2 2/2] ASoC: TLV320AIC3x: Adding additional
 functionality for 3106
Date: Mon, 18 Apr 2016 19:28:50 +0300
Message-ID: <57150B42.5090809@mcsplus.ru>
References: <56E69B3F.8090306@mcsplus.ru> <56E6CEE9.5030802@ti.com>
 <56E7FC3C.1030503@mcsplus.ru> <56E802D9.4040501@ti.com>
 <56E834B0.5010808@mcsplus.ru> <56E91FEE.4070604@ti.com>
 <56E934CB.4040209@mcsplus.ru> <56E97A75.7030700@ti.com>
 <56E98F99.2060100@mcsplus.ru> <56EA7833.7080302@ti.com>
 <56F2B48B.9030903@mcsplus.ru> <56FD1EF9.2030408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp50.i.mail.ru (smtp50.i.mail.ru [94.100.177.110])
 by alsa0.perex.cz (Postfix) with ESMTP id 36649265361
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 18:28:54 +0200 (CEST)
In-Reply-To: <56FD1EF9.2030408@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here is the result:
----------------------------------------------------------------------------
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index e521ac3..22bd0be 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -272,8 +272,13 @@ enum {
  };

  #define AIC3X_HEADSET_DETECT_ENABLED   0x80
-#define AIC3X_HEADSET_DETECT_SHIFT     5
-#define AIC3X_HEADSET_DETECT_MASK      3
+#define AIC3X_HEADSET_DETECT_A_SHIFT   5
+#define AIC3X_HEADSET_DETECT_A_MASK    3
+
+#define AIC3X_BUTTON_DETECT_SHIFT      5
+#define AIC3X_BUTTON_DETECT_MASK       1
+#define AIC3X_HEADSET_DETECT_B_SHIFT   4
+#define AIC3X_HEADSET_DETECT_B_MASK    1
  #define AIC3X_HEADSET_DEBOUNCE_SHIFT   2
  #define AIC3X_HEADSET_DEBOUNCE_MASK    7
  #define AIC3X_BUTTON_DEBOUNCE_SHIFT    0
----------------------------------------------------------------------------
Cheers,
Timur Karaldin
