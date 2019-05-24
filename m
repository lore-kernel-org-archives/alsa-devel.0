From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: cx2072x: fix integer overflow on unsigned int multiply
Date: Fri, 24 May 2019 23:25:51 +0100
Message-ID: <20190524222551.26573-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Simon Ho <simon.ho@conexant.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

In the case where frac_div larger than 96 the result of an unsigned
multiplication overflows an unsigned int.  For example, this can
happen when the sample_rate is 192000 and pll_input is 122.  Fix
this by casing the first term of the mutiply to a u64. Also remove
the extraneous parentheses around the expression.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: a497a4363706 ("ASoC: Add support for Conexant CX2072X CODEC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index c11a585bbf70..e8e6fd2e97b6 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -627,7 +627,7 @@ static int cx2072x_config_pll(struct cx2072x_priv *cx2072x)
 	if (frac_div) {
 		frac_div *= 1000;
 		frac_div /= pll_input;
-		frac_num = ((4000 + frac_div) * ((1 << 20) - 4));
+		frac_num = (u64)(4000 + frac_div) * ((1 << 20) - 4);
 		do_div(frac_num, 7);
 		frac = ((u32)frac_num + 499) / 1000;
 	}
-- 
2.20.1
