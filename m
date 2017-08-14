From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: constify snd_pcm_ops structures" to the asoc tree
Date: Mon, 14 Aug 2017 17:43:57 +0100
Message-ID: <E1dhIT7-0005PC-Kl@finisterre>
References: <1502690193-29059-8-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502690193-29059-8-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: constify snd_pcm_ops structures

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

>From d7622fa715f20dbc7c1ab0dbdd714be5a2b4c3bd Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Mon, 14 Aug 2017 11:26:30 +0530
Subject: [PATCH] ASoC: pxa: constify snd_pcm_ops structures

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/soc.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/mmp-pcm.c    | 2 +-
 sound/soc/pxa/pxa2xx-pcm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 38d599949ee4..624d9bd5dadd 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -131,7 +131,7 @@ static int mmp_pcm_mmap(struct snd_pcm_substream *substream,
 		vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
 
-static struct snd_pcm_ops mmp_pcm_ops = {
+static const struct snd_pcm_ops mmp_pcm_ops = {
 	.open		= mmp_pcm_open,
 	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 636895a778cb..e64958d8bff0 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -45,7 +45,7 @@ static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops pxa2xx_pcm_ops = {
+static const struct snd_pcm_ops pxa2xx_pcm_ops = {
 	.open		= __pxa2xx_pcm_open,
 	.close		= __pxa2xx_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
2.13.2
