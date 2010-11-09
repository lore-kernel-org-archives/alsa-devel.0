From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove broken WM8350 direction constants
Date: Tue,  9 Nov 2010 12:17:13 +0000
Message-ID: <1289305033-30397-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E784103842
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 13:17:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@Slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Tommy.Zhu@wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8350 driver was using some custom constants to interpret the direction
of the MCLK signal which had the opposite values to those used as standard
by the ASoC core, causing confusion in machine drivers such as the 1133-EV1
board.

Reported-by: Tommy Zhu <Tommy.Zhu@wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8350/audio.h |    3 ---
 sound/soc/codecs/wm8350.c        |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/wm8350/audio.h b/include/linux/mfd/wm8350/audio.h
index a95141e..bd581c6 100644
--- a/include/linux/mfd/wm8350/audio.h
+++ b/include/linux/mfd/wm8350/audio.h
@@ -522,9 +522,6 @@
 #define WM8350_MCLK_SEL_PLL_32K			3
 #define WM8350_MCLK_SEL_MCLK			5
 
-#define WM8350_MCLK_DIR_OUT			0
-#define WM8350_MCLK_DIR_IN			1
-
 /* clock divider id's */
 #define WM8350_ADC_CLKDIV			0
 #define WM8350_DAC_CLKDIV			1
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index f4f1fba..4f3e919 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -831,7 +831,7 @@ static int wm8350_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	}
 
 	/* MCLK direction */
-	if (dir == WM8350_MCLK_DIR_OUT)
+	if (dir == SND_SOC_CLOCK_OUT)
 		wm8350_set_bits(wm8350, WM8350_CLOCK_CONTROL_2,
 				WM8350_MCLK_DIR);
 	else
-- 
1.7.1
