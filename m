From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: nau8810: use 64-bit arithmetic instead of 32-bit
Date: Thu, 5 Jul 2018 10:14:07 -0500
Message-ID: <20180705151407.GA30984@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Add suffix ULL to constant 256 in order to give the compiler complete
information about the proper arithmetic to use.

Notice that such constant is used in a context that expects an
expression of type u64 (64 bits, unsigned) and the following
expression is currently being evaluated using 32-bit arithmetic:

256 * fs * 4 * nau8810_mclk_scaler[i] / 10

Addresses-Coverity-ID: 1357595 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/nau8810.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index bfd74b8..e7fd0b2 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -505,7 +505,7 @@ static int nau88l0_calc_pll(unsigned int pll_in,
 	f2_max = 0;
 	scal_sel = ARRAY_SIZE(nau8810_mclk_scaler);
 	for (i = 0; i < ARRAY_SIZE(nau8810_mclk_scaler); i++) {
-		f2 = 256 * fs * 4 * nau8810_mclk_scaler[i] / 10;
+		f2 = 256ULL * fs * 4 * nau8810_mclk_scaler[i] / 10;
 		if (f2 > NAU_PLL_FREQ_MIN && f2 < NAU_PLL_FREQ_MAX &&
 			f2_max < f2) {
 			f2_max = f2;
-- 
2.7.4
