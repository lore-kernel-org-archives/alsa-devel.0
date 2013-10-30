From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/9] ASoC: wm0010: Fix possible out-of-bounds
	array read
Date: Wed, 30 Oct 2013 08:35:03 +0100
Message-ID: <1383118507-21503-6-git-send-email-tiwai@suse.de>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 73FE0265274
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 08:32:34 +0100 (CET)
In-Reply-To: <1383118507-21503-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Spotted by coverity CID 744701.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm0010.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index d5ebcb00019b..bf7804a12863 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -793,11 +793,11 @@ static int wm0010_set_sysclk(struct snd_soc_codec *codec, int source,
 		wm0010->max_spi_freq = 0;
 	} else {
 		for (i = 0; i < ARRAY_SIZE(pll_clock_map); i++)
-			if (freq >= pll_clock_map[i].max_sysclk)
+			if (freq >= pll_clock_map[i].max_sysclk) {
+				wm0010->max_spi_freq = pll_clock_map[i].max_pll_spi_speed;
+				wm0010->pll_clkctrl1 = pll_clock_map[i].pll_clkctrl1;
 				break;
-
-		wm0010->max_spi_freq = pll_clock_map[i].max_pll_spi_speed;
-		wm0010->pll_clkctrl1 = pll_clock_map[i].pll_clkctrl1;
+			}
 	}
 
 	return 0;
-- 
1.8.4.1
