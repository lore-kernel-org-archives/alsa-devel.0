From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8804: Workaround GCC uninitialised
	variable warning
Date: Fri,  1 Oct 2010 09:32:55 +0100
Message-ID: <1285921975-13467-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F15F21039E8
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 10:33:01 +0200 (CEST)
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

GCC 4.4.0 does not seem capable of working out that the variable is
never used unless it is initialised.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8804.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 40e5067..e1fc722 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -392,13 +392,20 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 {
 	int ret;
 	struct snd_soc_codec *codec;
-	struct pll_div pll_div = { 0 };
+	struct pll_div pll_div;
 
 	codec = dai->codec;
 	if (freq_in && freq_out) {
 		ret = pll_factors(&pll_div, freq_out, freq_in);
 		if (ret)
 			return ret;
+	} else {
+		/*
+		 * Bodge GCC 4.4.0 uninitialised variable warning - it
+		 * doesn't seem capable of working out that we exit if
+		 * freq_in or freq_out is 0 before any of the uses.
+		 */
+		memset(&pll_div, 0, sizeof pll_div);
 	}
 
 	/* power down the PLL before reprogramming it */
-- 
1.7.3.1
