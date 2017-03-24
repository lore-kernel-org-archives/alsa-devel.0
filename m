From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: blackfin: constify snd_soc_ops structures" to the asoc tree
Date: Fri, 24 Mar 2017 19:16:31 +0000
Message-ID: <E1crUhL-00065v-94@debutante>
References: <1490187095-12846-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490187095-12846-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, julia.lawall@lip6.fr, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: blackfin: constify snd_soc_ops structures

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

>From 381ca1d12e188f90ed9f36cebb4a62d46fb11274 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 22 Mar 2017 18:21:35 +0530
Subject: [PATCH] ASoC: blackfin: constify snd_soc_ops structures

Declare snd_soc_ops structures as const as they are only stored
in the ops field of a snd_soc_dai_link structure. This field is
of type const, so snd_soc_ops structures having this property
can be made const too.

Cross compiled the .o files for blackfin architecture.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/blackfin/bfin-eval-adau1373.c | 2 +-
 sound/soc/blackfin/bfin-eval-adav80x.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bfin-eval-adau1373.c b/sound/soc/blackfin/bfin-eval-adau1373.c
index 72ac78988426..64b88fdc1f6c 100644
--- a/sound/soc/blackfin/bfin-eval-adau1373.c
+++ b/sound/soc/blackfin/bfin-eval-adau1373.c
@@ -119,7 +119,7 @@ static int bfin_eval_adau1373_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	return ret;
 }
-static struct snd_soc_ops bfin_eval_adau1373_ops = {
+static const struct snd_soc_ops bfin_eval_adau1373_ops = {
 	.hw_params = bfin_eval_adau1373_hw_params,
 };
 
diff --git a/sound/soc/blackfin/bfin-eval-adav80x.c b/sound/soc/blackfin/bfin-eval-adav80x.c
index 1037477d10b2..99e5ecabdcda 100644
--- a/sound/soc/blackfin/bfin-eval-adav80x.c
+++ b/sound/soc/blackfin/bfin-eval-adav80x.c
@@ -64,7 +64,7 @@ static int bfin_eval_adav80x_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_ops bfin_eval_adav80x_ops = {
+static const struct snd_soc_ops bfin_eval_adav80x_ops = {
 	.hw_params = bfin_eval_adav80x_hw_params,
 };
 
-- 
2.11.0
