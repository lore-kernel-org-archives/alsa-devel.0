From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: make array rt5514_dai static" to the asoc tree
Date: Mon, 14 Aug 2017 17:44:54 +0100
Message-ID: <E1dhIU2-0005bq-7n@finisterre>
References: <20170813150803.17292-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170813150803.17292-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: make array rt5514_dai static

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

>From e5e8e6182a3b9514cde41d957684b59ee8f6cf21 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sun, 13 Aug 2017 16:08:03 +0100
Subject: [PATCH] ASoC: rt5514: make array rt5514_dai static

The array rt5514_dai is local to the source and does not need to be in
global scope, so make it static.

Cleans up sparse warnings:
symbol 'rt5514_dai' was not declared. Should it be static?

warning: symbol 'rt5514_dai' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 0eabe569ab73..a694ce9fed86 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1066,7 +1066,7 @@ static const struct snd_soc_dai_ops rt5514_aif_dai_ops = {
 	.set_tdm_slot = rt5514_set_tdm_slot,
 };
 
-struct snd_soc_dai_driver rt5514_dai[] = {
+static struct snd_soc_dai_driver rt5514_dai[] = {
 	{
 		.name = "rt5514-aif1",
 		.id = 0,
-- 
2.13.2
