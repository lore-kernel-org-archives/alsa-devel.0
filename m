From: Joe Perches <joe@perches.com>
Subject: [PATCH 25/25] sound: wm5100-tables: Use bool function return values of true/false not 1/0
Date: Mon, 30 Mar 2015 16:46:23 -0700
Message-ID: <9340bd2566359c81dd562496b08408f167e9f7d3.1427759010.git.joe@perches.com>
References: <cover.1427759009.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1427759009.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the normal return values for bool functions

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/codecs/wm5100-tables.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm5100-tables.c b/sound/soc/codecs/wm5100-tables.c
index e239f4b..9e987cf 100644
--- a/sound/soc/codecs/wm5100-tables.c
+++ b/sound/soc/codecs/wm5100-tables.c
@@ -30,7 +30,7 @@ bool wm5100_volatile_register(struct device *dev, unsigned int reg)
 	case WM5100_OUTPUT_STATUS_2:
 	case WM5100_INPUT_ENABLES_STATUS:
 	case WM5100_MIC_DETECT_3:
-		return 1;
+		return true;
 	default:
 		if ((reg >= WM5100_DSP1_PM_0 && reg <= WM5100_DSP1_PM_1535) ||
 		    (reg >= WM5100_DSP1_ZM_0 && reg <= WM5100_DSP1_ZM_2047) ||
@@ -41,9 +41,9 @@ bool wm5100_volatile_register(struct device *dev, unsigned int reg)
 		    (reg >= WM5100_DSP3_PM_0 && reg <= WM5100_DSP3_PM_1535) ||
 		    (reg >= WM5100_DSP3_ZM_0 && reg <= WM5100_DSP3_ZM_2047) ||
 		    (reg >= WM5100_DSP3_DM_0 && reg <= WM5100_DSP3_DM_511))
-			return 1;
+			return true;
 		else
-			return 0;
+			return false;
 	}
 }
 
@@ -798,7 +798,7 @@ bool wm5100_readable_register(struct device *dev, unsigned int reg)
 	case WM5100_DSP3_CONTROL_28:
 	case WM5100_DSP3_CONTROL_29:
 	case WM5100_DSP3_CONTROL_30:
-		return 1;
+		return true;
 	default:
 		if ((reg >= WM5100_DSP1_PM_0 && reg <= WM5100_DSP1_PM_1535) ||
 		    (reg >= WM5100_DSP1_ZM_0 && reg <= WM5100_DSP1_ZM_2047) ||
@@ -809,9 +809,9 @@ bool wm5100_readable_register(struct device *dev, unsigned int reg)
 		    (reg >= WM5100_DSP3_PM_0 && reg <= WM5100_DSP3_PM_1535) ||
 		    (reg >= WM5100_DSP3_ZM_0 && reg <= WM5100_DSP3_ZM_2047) ||
 		    (reg >= WM5100_DSP3_DM_0 && reg <= WM5100_DSP3_DM_511))
-			return 1;
+			return true;
 		else
-			return 0;
+			return false;
 	}
 }
 
-- 
2.1.2
