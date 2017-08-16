From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: make snd_compr_ops const" to the asoc tree
Date: Wed, 16 Aug 2017 13:09:10 +0100
Message-ID: <E1dhx8I-0005cJ-R3@finisterre>
References: <1502879941-16010-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502879941-16010-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, julia.lawall@lip6.fr, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: make snd_compr_ops const

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

>From 4dbcc5ff2513f2192dc2a5dfdbb9ad3d7e891e85 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 16 Aug 2017 16:09:01 +0530
Subject: [PATCH] ASoC: codecs: make snd_compr_ops const

Make these const as they are only stored in the compr_ops field of a
snd_soc_platform_driver structure, which is of type const.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l24.c | 2 +-
 sound/soc/codecs/wm5102.c  | 2 +-
 sound/soc/codecs/wm5110.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 47e6fddef92b..c1cbe23169d7 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1203,7 +1203,7 @@ static struct snd_soc_codec_driver soc_codec_dev_cs47l24 = {
 	},
 };
 
-static struct snd_compr_ops cs47l24_compr_ops = {
+static const struct snd_compr_ops cs47l24_compr_ops = {
 	.open = cs47l24_open,
 	.free = wm_adsp_compr_free,
 	.set_params = wm_adsp_compr_set_params,
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 1fe358e6be61..a8bdbe464f2e 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2017,7 +2017,7 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm5102 = {
 	},
 };
 
-static struct snd_compr_ops wm5102_compr_ops = {
+static const struct snd_compr_ops wm5102_compr_ops = {
 	.open = wm5102_open,
 	.free = wm_adsp_compr_free,
 	.set_params = wm_adsp_compr_set_params,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 1bc942152eff..8aa136c28ec1 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2372,7 +2372,7 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
 	},
 };
 
-static struct snd_compr_ops wm5110_compr_ops = {
+static const struct snd_compr_ops wm5110_compr_ops = {
 	.open = wm5110_open,
 	.free = wm_adsp_compr_free,
 	.set_params = wm_adsp_compr_set_params,
-- 
2.13.2
