From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH 1/2] ASoC: Remove unused AUDIO_NAME
	define from codec drivers
Date: Tue,  7 Oct 2008 14:49:22 +0300
Message-ID: <1223380163-29041-2-git-send-email-jarkko.nikula@nokia.com>
References: <1223380163-29041-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B9342454D
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 13:50:31 +0200 (CEST)
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com
	[10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m97BoCX3003986
	for <alsa-devel@alsa-project.org>; Tue, 7 Oct 2008 14:50:16 +0300
In-Reply-To: <1223380163-29041-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/ak4535.c      |    1 -
 sound/soc/codecs/ssm2602.c     |    1 -
 sound/soc/codecs/tlv320aic23.c |    1 -
 sound/soc/codecs/tlv320aic3x.c |    1 -
 sound/soc/codecs/uda1380.c     |    1 -
 sound/soc/codecs/wm8510.c      |    1 -
 sound/soc/codecs/wm8580.c      |    1 -
 sound/soc/codecs/wm8731.c      |    1 -
 sound/soc/codecs/wm8750.c      |    1 -
 sound/soc/codecs/wm8753.c      |    1 -
 sound/soc/codecs/wm8971.c      |    1 -
 sound/soc/codecs/wm8990.c      |    1 -
 12 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 088cf99..2a89b58 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -28,7 +28,6 @@
 
 #include "ak4535.h"
 
-#define AUDIO_NAME "ak4535"
 #define AK4535_VERSION "0.3"
 
 struct snd_soc_codec_device soc_codec_dev_ak4535;
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 940ce1c..44ef0da 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -42,7 +42,6 @@
 
 #include "ssm2602.h"
 
-#define AUDIO_NAME "ssm2602"
 #define SSM2602_VERSION "0.1"
 
 struct snd_soc_codec_device soc_codec_dev_ssm2602;
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index c2d35e9..0fd3466 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -35,7 +35,6 @@
 
 #include "tlv320aic23.h"
 
-#define AUDIO_NAME "tlv320aic23"
 #define AIC23_VERSION "0.1"
 
 struct tlv320aic23_srate_reg_info {
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 566a427..7cff192 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -48,7 +48,6 @@
 
 #include "tlv320aic3x.h"
 
-#define AUDIO_NAME "aic3x"
 #define AIC3X_VERSION "0.2"
 
 /* codec private data */
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index d206d7f..a69ee72 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -36,7 +36,6 @@
 #include "uda1380.h"
 
 #define UDA1380_VERSION "0.6"
-#define AUDIO_NAME "uda1380"
 
 /*
  * uda1380 register cache
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 75ed041..ffb41c5 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -27,7 +27,6 @@
 
 #include "wm8510.h"
 
-#define AUDIO_NAME "wm8510"
 #define WM8510_VERSION "0.6"
 
 struct snd_soc_codec_device soc_codec_dev_wm8510;
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index df1ffbe..056787f 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -36,7 +36,6 @@
 
 #include "wm8580.h"
 
-#define AUDIO_NAME "wm8580"
 #define WM8580_VERSION "0.1"
 
 struct pll_state {
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 7b64d9a..7f8a7e3 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -29,7 +29,6 @@
 
 #include "wm8731.h"
 
-#define AUDIO_NAME "wm8731"
 #define WM8731_VERSION "0.13"
 
 struct snd_soc_codec_device soc_codec_dev_wm8731;
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 4892e39..9b7296e 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -29,7 +29,6 @@
 
 #include "wm8750.h"
 
-#define AUDIO_NAME "WM8750"
 #define WM8750_VERSION "0.12"
 
 /* codec private data */
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 8c4df44..ef4f50f 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -51,7 +51,6 @@
 
 #include "wm8753.h"
 
-#define AUDIO_NAME "wm8753"
 #define WM8753_VERSION "0.16"
 
 static int caps_charge = 2000;
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 974a4cd..f41a578 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -29,7 +29,6 @@
 
 #include "wm8971.h"
 
-#define AUDIO_NAME "wm8971"
 #define WM8971_VERSION "0.9"
 
 #define	WM8971_REG_COUNT		43
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 63410d7..572d22b 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -30,7 +30,6 @@
 
 #include "wm8990.h"
 
-#define AUDIO_NAME "wm8990"
 #define WM8990_VERSION "0.2"
 
 /* codec private data */
-- 
1.5.6.5
