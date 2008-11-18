From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/17] ASoC: Allow writes to uncached registers
	in WM8990
Date: Tue, 18 Nov 2008 12:38:10 +0000
Message-ID: <1227011903-2825-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1227011903-2825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E93FF1037ED
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 13:38:25 +0100 (CET)
In-Reply-To: <1227011903-2825-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Only fully documented registers are cached in the WM8990 but additional
registers exist.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8990.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 572d22b..5c84f02 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -106,6 +106,7 @@ static const u16 wm8990_reg[] = {
 	0x0008,     /* R60 - PLL1 */
 	0x0031,     /* R61 - PLL2 */
 	0x0026,     /* R62 - PLL3 */
+	0x0000,	    /* R63 - Driver internal */
 };
 
 /*
@@ -126,10 +127,9 @@ static inline void wm8990_write_reg_cache(struct snd_soc_codec *codec,
 	unsigned int reg, unsigned int value)
 {
 	u16 *cache = codec->reg_cache;
-	BUG_ON(reg > (ARRAY_SIZE(wm8990_reg)) - 1);
 
-	/* Reset register is uncached */
-	if (reg == 0)
+	/* Reset register and reserved registers are uncached */
+	if (reg == 0 || reg > ARRAY_SIZE(wm8990_reg) - 1)
 		return;
 
 	cache[reg] = value;
-- 
1.5.6.5
