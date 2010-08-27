From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/4] ASoC: tlv320aic3x: Sort output pin control
	registers in header file
Date: Fri, 27 Aug 2010 16:56:48 +0300
Message-ID: <1282917410-12000-3-git-send-email-jhnikula@gmail.com>
References: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 567FA103885
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 15:56:09 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so1983186ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 06:56:09 -0700 (PDT)
In-Reply-To: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
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

Each output pin has 7 consecutive control registers in tlv320aic3x register
map. First 6 of them control the signal mixing and one is for output level
and power control.

Sort these registers as they are sorted clearly in hardware, it makes also
definitions more readable and easier to pinpoint missing register
definitions.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.h |   47 +++++++++++++++++++++------------------
 1 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 98e4439..20d8cac 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -81,52 +81,55 @@
 /* DAC Digital control registers */
 #define LDAC_VOL			43
 #define RDAC_VOL			44
-/* High Power Output control registers */
+/* Left High Power Output control registers */
 #define LINE2L_2_HPLOUT_VOL		45
-#define LINE2R_2_HPROUT_VOL		62
 #define PGAL_2_HPLOUT_VOL		46
-#define PGAL_2_HPROUT_VOL		60
-#define PGAR_2_HPLOUT_VOL		49
-#define PGAR_2_HPROUT_VOL		63
 #define DACL1_2_HPLOUT_VOL		47
-#define DACR1_2_HPROUT_VOL		64
+#define PGAR_2_HPLOUT_VOL		49
 #define HPLOUT_CTRL			51
-#define HPROUT_CTRL			65
-/* High Power COM control registers */
+/* Left High Power COM control registers */
 #define LINE2L_2_HPLCOM_VOL		52
-#define LINE2R_2_HPRCOM_VOL		69
 #define PGAL_2_HPLCOM_VOL		53
+#define DACL1_2_HPLCOM_VOL		54
 #define PGAR_2_HPLCOM_VOL		56
+#define HPLCOM_CTRL			58
+/* Right High Power Output control registers */
+#define PGAL_2_HPROUT_VOL		60
+#define LINE2R_2_HPROUT_VOL		62
+#define PGAR_2_HPROUT_VOL		63
+#define DACR1_2_HPROUT_VOL		64
+#define HPROUT_CTRL			65
+/* Right High Power COM control registers */
 #define PGAL_2_HPRCOM_VOL		67
+#define LINE2R_2_HPRCOM_VOL		69
 #define PGAR_2_HPRCOM_VOL		70
-#define DACL1_2_HPLCOM_VOL		54
 #define DACR1_2_HPRCOM_VOL		71
-#define HPLCOM_CTRL			58
 #define HPRCOM_CTRL			72
 /* Mono Line Output Plus/Minus control registers */
 #define LINE2L_2_MONOLOPM_VOL		73
-#define LINE2R_2_MONOLOPM_VOL		76
 #define PGAL_2_MONOLOPM_VOL		74
-#define PGAR_2_MONOLOPM_VOL		77
 #define DACL1_2_MONOLOPM_VOL		75
+#define LINE2R_2_MONOLOPM_VOL		76
+#define PGAR_2_MONOLOPM_VOL		77
 #define DACR1_2_MONOLOPM_VOL		78
 #define MONOLOPM_CTRL			79
 /* Class-D speaker driver on tlv320aic3007 */
 #define CLASSD_CTRL			73
-/* Line Output Plus/Minus control registers */
+/* Left Line Output Plus/Minus control registers */
 #define LINE2L_2_LLOPM_VOL		80
-#define LINE2L_2_RLOPM_VOL		87
-#define LINE2R_2_LLOPM_VOL		83
-#define LINE2R_2_RLOPM_VOL		90
 #define PGAL_2_LLOPM_VOL		81
-#define PGAL_2_RLOPM_VOL		88
-#define PGAR_2_LLOPM_VOL		84
-#define PGAR_2_RLOPM_VOL		91
 #define DACL1_2_LLOPM_VOL		82
-#define DACL1_2_RLOPM_VOL		89
-#define DACR1_2_RLOPM_VOL		92
+#define LINE2R_2_LLOPM_VOL		83
+#define PGAR_2_LLOPM_VOL		84
 #define DACR1_2_LLOPM_VOL		85
 #define LLOPM_CTRL			86
+/* Right Line Output Plus/Minus control registers */
+#define LINE2L_2_RLOPM_VOL		87
+#define PGAL_2_RLOPM_VOL		88
+#define DACL1_2_RLOPM_VOL		89
+#define LINE2R_2_RLOPM_VOL		90
+#define PGAR_2_RLOPM_VOL		91
+#define DACR1_2_RLOPM_VOL		92
 #define RLOPM_CTRL			93
 /* GPIO/IRQ registers */
 #define AIC3X_STICKY_IRQ_FLAGS_REG	96
-- 
1.7.1
