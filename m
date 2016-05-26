From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH 1/2] ASoC: tas571x: add biquad registers for
	TAS5717/19
Date: Thu, 26 May 2016 19:26:16 +0200
Message-ID: <1464283577-29552-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep24.mx.upcmail.net (fep24.mx.upcmail.net [62.179.121.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AE942651C9
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 19:26:46 +0200 (CEST)
Received: from edge03.upcmail.net ([192.168.13.238]) by viefep24-int.chello.at
 (InterMail vM.8.01.05.21 201-2260-151-156-20141103) with ESMTP
 id <20160526172644.EEZP7908.viefep24-int.chello.at@edge03.upcmail.net>
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 19:26:44 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, cernekee@chromium.org
Cc: alsa-devel@alsa-project.org, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

Add biquad register definitions for TAS5717/19.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
---
 sound/soc/codecs/tas571x.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/soc/codecs/tas571x.h b/sound/soc/codecs/tas571x.h
index cf800c3..bf4d436 100644
--- a/sound/soc/codecs/tas571x.h
+++ b/sound/soc/codecs/tas571x.h
@@ -52,4 +52,39 @@
 #define TAS571X_CH4_SRC_SELECT_REG	0x21
 #define TAS571X_PWM_MUX_REG		0x25
 
+/* 20-byte biquad registers */
+#define TAS5717_CH1_BQ0_REG		0x26
+#define TAS5717_CH1_BQ1_REG		0x27
+#define TAS5717_CH1_BQ2_REG		0x28
+#define TAS5717_CH1_BQ3_REG		0x29
+#define TAS5717_CH1_BQ4_REG		0x2a
+#define TAS5717_CH1_BQ5_REG		0x2b
+#define TAS5717_CH1_BQ6_REG		0x2c
+#define TAS5717_CH1_BQ7_REG		0x2d
+#define TAS5717_CH1_BQ8_REG		0x2e
+#define TAS5717_CH1_BQ9_REG		0x2f
+
+#define TAS5717_CH2_BQ0_REG		0x30
+#define TAS5717_CH2_BQ1_REG		0x31
+#define TAS5717_CH2_BQ2_REG		0x32
+#define TAS5717_CH2_BQ3_REG		0x33
+#define TAS5717_CH2_BQ4_REG		0x34
+#define TAS5717_CH2_BQ5_REG		0x35
+#define TAS5717_CH2_BQ6_REG		0x36
+#define TAS5717_CH2_BQ7_REG		0x37
+#define TAS5717_CH2_BQ8_REG		0x38
+#define TAS5717_CH2_BQ9_REG		0x39
+
+#define TAS5717_CH1_BQ10_REG		0x58
+#define TAS5717_CH1_BQ11_REG		0x59
+
+#define TAS5717_CH4_BQ0_REG		0x5a
+#define TAS5717_CH4_BQ1_REG		0x5b
+
+#define TAS5717_CH2_BQ10_REG		0x5c
+#define TAS5717_CH2_BQ11_REG		0x5d
+
+#define TAS5717_CH3_BQ0_REG		0x5e
+#define TAS5717_CH3_BQ1_REG		0x5f
+
 #endif /* _TAS571X_H */
-- 
2.5.0
