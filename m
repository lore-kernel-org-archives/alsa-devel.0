From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: remove redundant assignment to variable idx" to the asoc tree
Date: Fri,  5 Jul 2019 18:19:50 +0100 (BST)
Message-ID: <20190705171950.D1D422742B45@ypsilon.sirena.org.uk>
References: <20190705075303.14692-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190705075303.14692-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: remove redundant assignment to variable idx

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 590eb2f4ef94cb3f3e73345c6db4de97c9cd539e Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 5 Jul 2019 08:53:03 +0100
Subject: [PATCH] ASoC: rt5665: remove redundant assignment to variable idx

The variable idx is being initialized with a value that is never
read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190705075303.14692-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 87263317085a..c050d84a6916 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1478,7 +1478,7 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct rt5665_priv *rt5665 = snd_soc_component_get_drvdata(component);
-	int pd, idx = -EINVAL;
+	int pd, idx;
 
 	pd = rl6231_get_pre_div(rt5665->regmap,
 		RT5665_ADDA_CLK_1, RT5665_I2S_PD1_SFT);
-- 
2.20.1
