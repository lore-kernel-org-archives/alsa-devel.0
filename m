From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] ASoC: Ux500: remove test for undefined Kconfig macro
Date: Fri, 29 Mar 2013 13:28:21 +0100
Message-ID: <1364560101.1345.62.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A test for CONFIG_SND_SOC_UX500_AB5500 was added in v3.5. But there
never was a corresponding Kconfig symbol so this test has always
evaluated to true. And since AB5500 support was removed in v3.5 it
appears safe to remove this test and a few lines of code.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 sound/soc/ux500/ux500_msp_dai.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_dai.h b/sound/soc/ux500/ux500_msp_dai.h
index 9c778d9..f531043 100644
--- a/sound/soc/ux500/ux500_msp_dai.h
+++ b/sound/soc/ux500/ux500_msp_dai.h
@@ -35,13 +35,8 @@
 #define FRAME_PER_8_SLOTS				138
 #define FRAME_PER_16_SLOTS				277
 
-#ifndef CONFIG_SND_SOC_UX500_AB5500
 #define UX500_MSP_INTERNAL_CLOCK_FREQ  40000000
 #define UX500_MSP1_INTERNAL_CLOCK_FREQ UX500_MSP_INTERNAL_CLOCK_FREQ
-#else
-#define UX500_MSP_INTERNAL_CLOCK_FREQ 13000000
-#define UX500_MSP1_INTERNAL_CLOCK_FREQ (UX500_MSP_INTERNAL_CLOCK_FREQ * 2)
-#endif
 
 #define UX500_MSP_MIN_CHANNELS		1
 #define UX500_MSP_MAX_CHANNELS		8
-- 
1.7.11.7
