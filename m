From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/17] ASoC: Enable WM8990 ADC clocking
	workaround
Date: Tue, 18 Nov 2008 12:38:11 +0000
Message-ID: <1227011903-2825-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1227011903-2825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F40901037ED
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 13:38:26 +0100 (CET)
In-Reply-To: <1227011903-2825-4-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Enable a hardware workaround which avoids problems with the clocking of
the ADCs in certain configurations.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8990.c |    6 ++++--
 sound/soc/codecs/wm8990.h |    4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 5c84f02..938e154 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1272,9 +1272,11 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 
 			/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
 			wm8990_write(codec, WM8990_ANTIPOP2, WM8990_BUFIOEN);
-		} else {
-			/* ON -> standby */
 
+			/* Enable workaround for ADC clocking issue. */
+			wm8990_write(codec, WM8990_EXT_ACCESS_ENA, 0x2);
+			wm8990_write(codec, WM8990_EXT_CTL1, 0xa003);
+			wm8990_write(codec, WM8990_EXT_ACCESS_ENA, 0);
 		}
 		break;
 
diff --git a/sound/soc/codecs/wm8990.h b/sound/soc/codecs/wm8990.h
index 0e192f3..7114ddc 100644
--- a/sound/soc/codecs/wm8990.h
+++ b/sound/soc/codecs/wm8990.h
@@ -80,8 +80,8 @@
 #define WM8990_PLL3                             0x3E
 #define WM8990_INTDRIVBITS			0x3F
 
-#define WM8990_REGISTER_COUNT                   60
-#define WM8990_MAX_REGISTER                     0x3F
+#define WM8990_EXT_ACCESS_ENA			0x75
+#define WM8990_EXT_CTL1				0x7a
 
 /*
  * Field Definitions.
-- 
1.5.6.5
