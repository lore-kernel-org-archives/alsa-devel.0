From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8804: Power down the PLL correctly
Date: Mon,  4 Oct 2010 09:37:48 +0100
Message-ID: <1286181468-13095-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A642124366
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 10:37:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The PLL is disabled when the corresponding bit is set not the other
way around.  This commit depends on my other commit with Subject
"ASoC: WM8804: Refactor set_pll code to avoid GCC warnings".

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8804.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index b23c57c..2657f5c 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -395,7 +395,7 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 	codec = dai->codec;
 	if (!freq_in || !freq_out) {
 		/* disable the PLL */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x1, 0);
+		snd_soc_update_bits(codec, WM8804_PWRDN, 0x1, 0x1);
 		return 0;
 	} else {
 		int ret;
@@ -406,7 +406,7 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 			return ret;
 
 		/* power down the PLL before reprogramming it */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x1, 0);
+		snd_soc_update_bits(codec, WM8804_PWRDN, 0x1, 0x1);
 
 		if (!freq_in || !freq_out)
 			return 0;
@@ -423,7 +423,7 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 		snd_soc_write(codec, WM8804_PLL3, pll_div.k >> 16);
 
 		/* power up the PLL */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x1, 0x1);
+		snd_soc_update_bits(codec, WM8804_PWRDN, 0x1, 0);
 	}
 
 	return 0;
-- 
1.7.3.1
