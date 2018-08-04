From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 10/12] ASoC: wm5100-tables: use true and false for boolean
 values
Date: Sat, 4 Aug 2018 16:54:54 -0500
Message-ID: <e20258db8af8bb40ef98efc2e21756222c1df39c.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533418275.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org
Cc: patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
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
2.7.4
