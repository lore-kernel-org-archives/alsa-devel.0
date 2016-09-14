From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Allow specification of base for arizona_is_enabled_fll" to the asoc tree
Date: Wed, 14 Sep 2016 18:15:35 +0100
Message-ID: <E1bkDmZ-0001eS-FJ@debutante>
References: <1472831568-466-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472831568-466-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>, lee.jones@linaro.orgbroonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, s.nawrocki@samsung.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Allow specification of base for arizona_is_enabled_fll

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

>From 62bb7104687c0ac1e85b1cf45a85a20b492b06a6 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 2 Sep 2016 16:52:44 +0100
Subject: [PATCH] ASoC: arizona: Allow specification of base for
 arizona_is_enabled_fll

In preparation for future improvements allow a base to be passed to
arizona_is_enabled_fll, this will allow it to be used to check the state
of the synchroniser path as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ecfdbfcae366..5455d0e87f0f 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2188,13 +2188,13 @@ static void arizona_apply_fll(struct arizona *arizona, unsigned int base,
 				 ARIZONA_FLL1_CTRL_UPD | cfg->n);
 }
 
-static int arizona_is_enabled_fll(struct arizona_fll *fll)
+static int arizona_is_enabled_fll(struct arizona_fll *fll, int base)
 {
 	struct arizona *arizona = fll->arizona;
 	unsigned int reg;
 	int ret;
 
-	ret = regmap_read(arizona->regmap, fll->base + 1, &reg);
+	ret = regmap_read(arizona->regmap, base + 1, &reg);
 	if (ret != 0) {
 		arizona_fll_err(fll, "Failed to read current state: %d\n",
 				ret);
@@ -2208,7 +2208,7 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 {
 	struct arizona *arizona = fll->arizona;
 	bool use_sync = false;
-	int already_enabled = arizona_is_enabled_fll(fll);
+	int already_enabled = arizona_is_enabled_fll(fll, fll->base);
 	struct arizona_fll_cfg cfg;
 	int i;
 	unsigned int val;
-- 
2.8.1
