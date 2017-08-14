From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: constify snd_pcm_ops structures" to the asoc tree
Date: Mon, 14 Aug 2017 17:43:34 +0100
Message-ID: <E1dhISk-0005Iv-DY@finisterre>
References: <1502690193-29059-5-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502690193-29059-5-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: constify snd_pcm_ops structures

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

>From f2c402ba55fe7cc3924de683ac5eef99c75eab04 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Mon, 14 Aug 2017 11:26:27 +0530
Subject: [PATCH] ASoC: intel: constify snd_pcm_ops structures

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/soc.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/baytrail/sst-baytrail-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 84cb568c3ad6..c54529320f07 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -309,7 +309,7 @@ static int sst_byt_pcm_mmap(struct snd_pcm_substream *substream,
 	return snd_pcm_lib_default_mmap(substream, vma);
 }
 
-static struct snd_pcm_ops sst_byt_pcm_ops = {
+static const struct snd_pcm_ops sst_byt_pcm_ops = {
 	.open		= sst_byt_pcm_open,
 	.close		= sst_byt_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
2.13.2
