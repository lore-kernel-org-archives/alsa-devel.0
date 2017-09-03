From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: samsung: i2s: Fix error handling path in i2s_set_sysclk()
Date: Sun,  3 Sep 2017 14:29:02 +0200
Message-ID: <20170903122902.3591-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

If 'clk_prepare_enable()' fails, we must 'put' the corresponding clock.
Othewise, there is a resource leak.

Fixes: f5c97c7b0438 ("ASoC: samsung: i2s: Handle return value of clk_prepare_enable.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I'm not 100% confident in this patch.
It is mostly inspired by surrounding error handling. (L533 and L550)
---
 sound/soc/samsung/i2s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 10a4da06c0a1..d7e7f4244d38 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -552,8 +552,11 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 			}
 
 			ret = clk_prepare_enable(i2s->op_clk);
-			if (ret)
+			if (ret) {
+				clk_put(i2s->op_clk);
+				i2s->op_clk = NULL;
 				goto err;
+			}
 			i2s->rclk_srcrate = clk_get_rate(i2s->op_clk);
 
 			/* Over-ride the other's */
-- 
2.11.0
