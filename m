From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/8] ASoC: Remove unused AUDIO_NAME define from
	codec drivers
Date: Wed,  8 Oct 2008 10:37:58 +0100
Message-ID: <1223458680-9506-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081008093611.GA9425@rakim.wolfsonmicro.main>
	<1223458680-9506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10F7B244D5
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 11:38:16 +0200 (CEST)
In-Reply-To: <1223458680-9506-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
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
index bb7cfb8..bac7815 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -35,7 +35,6 @@
 
 #include "tlv320aic23.h"
 
-#define AUDIO_NAME "tlv320aic23"
 #define AIC23_VERSION "0.1"
 
 struct tlv320aic23_srate_reg_info {
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 57fc5af..05336ed 100644
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
index 16768a5..142c49b 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -28,7 +28,6 @@
 
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
index 83ba419..63dbc56 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -52,7 +52,6 @@
 
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
