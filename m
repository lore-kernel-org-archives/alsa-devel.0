From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: es8328: Remove some unused defines
Date: Sat, 15 Oct 2016 21:17:16 +0200
Message-ID: <1476559036-15489-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C6CFD261740
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 21:45:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Sean Cross <xobs@kosagi.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The es8328 drivers seems to have used the wm8753 driver as a template. Its
header file contains a few defines that are copied verbatim from the wm8753
header that do not really apply to this driver and are unused. So remove
those defines. This seems safe as they deal with PLL and clock divider
settings and the es8328 driver neither implements a set_pll() nor a
set_clkdiv() callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/es8328.h | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/sound/soc/codecs/es8328.h b/sound/soc/codecs/es8328.h
index 1a736e7..8930322 100644
--- a/sound/soc/codecs/es8328.h
+++ b/sound/soc/codecs/es8328.h
@@ -278,43 +278,6 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 
 #define ES8328_REG_MAX		0x35
 
-#define ES8328_PLL1		0
-#define ES8328_PLL2		1
-
-/* clock inputs */
-#define ES8328_MCLK		0
-#define ES8328_PCMCLK		1
-
-/* clock divider id's */
-#define ES8328_PCMDIV		0
-#define ES8328_BCLKDIV		1
-#define ES8328_VXCLKDIV		2
-
-/* PCM clock dividers */
-#define ES8328_PCM_DIV_1	(0 << 6)
-#define ES8328_PCM_DIV_3	(2 << 6)
-#define ES8328_PCM_DIV_5_5	(3 << 6)
-#define ES8328_PCM_DIV_2	(4 << 6)
-#define ES8328_PCM_DIV_4	(5 << 6)
-#define ES8328_PCM_DIV_6	(6 << 6)
-#define ES8328_PCM_DIV_8	(7 << 6)
-
-/* BCLK clock dividers */
-#define ES8328_BCLK_DIV_1	(0 << 7)
-#define ES8328_BCLK_DIV_2	(1 << 7)
-#define ES8328_BCLK_DIV_4	(2 << 7)
-#define ES8328_BCLK_DIV_8	(3 << 7)
-
-/* VXCLK clock dividers */
-#define ES8328_VXCLK_DIV_1	(0 << 6)
-#define ES8328_VXCLK_DIV_2	(1 << 6)
-#define ES8328_VXCLK_DIV_4	(2 << 6)
-#define ES8328_VXCLK_DIV_8	(3 << 6)
-#define ES8328_VXCLK_DIV_16	(4 << 6)
-
-#define ES8328_DAI_HIFI		0
-#define ES8328_DAI_VOICE	1
-
 #define ES8328_1536FS		1536
 #define ES8328_1024FS		1024
 #define ES8328_768FS		768
-- 
2.1.4
