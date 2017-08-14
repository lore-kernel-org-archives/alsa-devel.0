From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: blackfin: constify snd_pcm_ops structures" to the asoc tree
Date: Mon, 14 Aug 2017 17:44:27 +0100
Message-ID: <E1dhITb-0005VN-Ue@finisterre>
References: <1502690193-29059-3-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502690193-29059-3-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: blackfin: constify snd_pcm_ops structures

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

>From e76b3f41a3c39fae342fe4db530c3917199cfa96 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Mon, 14 Aug 2017 11:26:25 +0530
Subject: [PATCH] ASoC: blackfin: constify snd_pcm_ops structures

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/soc.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c | 2 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 913e29275f4e..8c1d1983b8f9 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -308,7 +308,7 @@ static	int bf5xx_pcm_copy_user(struct snd_pcm_substream *substream,
 }
 #endif
 
-static struct snd_pcm_ops bf5xx_pcm_ac97_ops = {
+static const struct snd_pcm_ops bf5xx_pcm_ac97_ops = {
 	.open		= bf5xx_pcm_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= bf5xx_pcm_hw_params,
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 470d99abf6f6..51cae76f14e6 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -318,7 +318,7 @@ static int bf5xx_pcm_silence(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_pcm_ops bf5xx_pcm_i2s_ops = {
+static const struct snd_pcm_ops bf5xx_pcm_i2s_ops = {
 	.open		= bf5xx_pcm_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= bf5xx_pcm_hw_params,
-- 
2.13.2
