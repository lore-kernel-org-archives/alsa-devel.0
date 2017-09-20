From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rl6231: make arrays div and pd static const, reduces object code size" to the asoc tree
Date: Wed, 20 Sep 2017 16:36:38 +0100
Message-ID: <E1duh3G-0000eN-3i@debutante>
References: <20170919215000.32040-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919215000.32040-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rl6231: make arrays div and pd static const, reduces object code size

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 57f7feff2912d6996b5f3fcac084308ce195127c Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 19 Sep 2017 22:50:00 +0100
Subject: [PATCH] ASoC: rl6231: make arrays div and pd static const, reduces
 object code size

Don't populate the read-only arrays div and pd on the stack,
instead make them static const. Makes the object code smaller by 210 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   2869	    720	      0	   3589	    e05	sound/soc/codecs/rl6231.o

After:
   text	   data	    bss	    dec	    hex	filename
   2495	    880	      0	   3375	    d2f	sound/soc/codecs/rl6231.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rl6231.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 7b447d0b173a..974a9040651d 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL_GPL(rl6231_get_pre_div);
  */
 int rl6231_calc_dmic_clk(int rate)
 {
-	int div[] = {2, 3, 4, 6, 8, 12};
+	static const int div[] = {2, 3, 4, 6, 8, 12};
 	int i;
 
 	if (rate < 1000000 * div[0]) {
@@ -189,7 +189,8 @@ EXPORT_SYMBOL_GPL(rl6231_pll_calc);
 
 int rl6231_get_clk_info(int sclk, int rate)
 {
-	int i, pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
+	int i;
+	static const int pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
 
 	if (sclk <= 0 || rate <= 0)
 		return -EINVAL;
-- 
2.14.1
