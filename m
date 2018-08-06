From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5100-tables: use true and false for
	boolean values" to the asoc tree
Date: Mon,  6 Aug 2018 12:41:31 +0100 (BST)
Message-ID: <20180806114131.4D2B81124240@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B9AA2676A3
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 13:41:32 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm5100-tables: use true and false for boolean values

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 380ae4ec420304aa59adb36776eaf78aef37192c Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Sat, 4 Aug 2018 16:54:54 -0500
Subject: [PATCH] ASoC: wm5100-tables: use true and false for boolean values

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5100-tables.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm5100-tables.c b/sound/soc/codecs/wm5100-tables.c
index e239f4bf2460..9e987cf07450 100644
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
2.18.0
