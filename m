From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: nau8825: use 64-bit arithmetic instead of 32-bit
Date: Wed, 4 Jul 2018 09:28:28 -0500
Message-ID: <20180704142828.GA11007@embeddedor.com>
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

256 * fs * 2 * mclk_src_scaling[i].param

Addresses-Coverity-ID: 1339616 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/nau8825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index dc6ea49..b9fed99 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2016,7 +2016,7 @@ static int nau8825_calc_fll_param(unsigned int fll_in, unsigned int fs,
 	fvco_max = 0;
 	fvco_sel = ARRAY_SIZE(mclk_src_scaling);
 	for (i = 0; i < ARRAY_SIZE(mclk_src_scaling); i++) {
-		fvco = 256 * fs * 2 * mclk_src_scaling[i].param;
+		fvco = 256ULL * fs * 2 * mclk_src_scaling[i].param;
 		if (fvco > NAU_FVCO_MIN && fvco < NAU_FVCO_MAX &&
 			fvco_max < fvco) {
 			fvco_max = fvco;
-- 
2.7.4
