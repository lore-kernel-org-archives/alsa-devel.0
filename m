From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove some unused defines from WM8903
Date: Mon, 20 Dec 2010 20:55:46 +0000
Message-ID: <1292878546-28557-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C819103801
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 21:55:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

These would have been used if we'd done manual clock divider setup,
but we didn't.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8903.h b/sound/soc/codecs/wm8903.h
index 7f9f6be..5f23d3c 100644
--- a/sound/soc/codecs/wm8903.h
+++ b/sound/soc/codecs/wm8903.h
@@ -19,10 +19,6 @@ extern int wm8903_mic_detect(struct snd_soc_codec *codec,
 			     struct snd_soc_jack *jack,
 			     int det, int shrt);
 
-#define WM8903_MCLK_DIV_2 1
-#define WM8903_CLK_SYS    2
-#define WM8903_BCLK       3
-#define WM8903_LRCLK      4
 
 /*
  * Register values.
-- 
1.7.1
