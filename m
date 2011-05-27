From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Remove redundant freq assignment for
 max98095->sysclk/max98088->sysclk
Date: Fri, 27 May 2011 23:30:53 +0800
Message-ID: <1306510253.19556.36.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Hsiang <peter.hsiang@maxim-ic.com>, Peter Hsiang <cdefgab1288@gmail.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Current implementation set max98095->sysclk/max98088->sysclk to freq twice.
Set it once is enough, this patch removes the first assignment in case
we may set invalid clock frequency to max98095->sysclk/max98088->sysclk.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
hi Peter,
I don't have this hardware handy. Can you help to test it?
Thanks,
Axel

 sound/soc/codecs/max98088.c |    2 --
 sound/soc/codecs/max98095.c |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 4173b67..ac65a2d 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1397,8 +1397,6 @@ static int max98088_dai_set_sysclk(struct snd_soc_dai *dai,
        if (freq == max98088->sysclk)
                return 0;
 
-       max98088->sysclk = freq; /* remember current sysclk */
-
        /* Setup clocks for slave mode, and using the PLL
         * PSCLK = 0x01 (when master clk is 10MHz to 20MHz)
         *         0x02 (when master clk is 20MHz to 30MHz)..
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index e1d282d..872a5fa 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1517,8 +1517,6 @@ static int max98095_dai_set_sysclk(struct snd_soc_dai *dai,
 	if (freq == max98095->sysclk)
 		return 0;
 
-	max98095->sysclk = freq; /* remember current sysclk */
-
 	/* Setup clocks for slave mode, and using the PLL
 	 * PSCLK = 0x01 (when master clk is 10MHz to 20MHz)
 	 *         0x02 (when master clk is 20MHz to 40MHz)..
-- 
1.7.1
