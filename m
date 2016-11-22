From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Remove unused wm_coeff_ctl.kcontrol" to the asoc tree
Date: Tue, 22 Nov 2016 17:26:14 +0000
Message-ID: <E1c9Epi-0005iv-KR@debutante>
References: <1479833937-5238-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479833937-5238-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Remove unused wm_coeff_ctl.kcontrol

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

>From 1db51e6fb0f5596518975fd1b2f7ef050e9d58ef Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 22 Nov 2016 16:58:56 +0000
Subject: [PATCH] ASoC: wm_adsp: Remove unused wm_coeff_ctl.kcontrol

The kcontrol pointer in wm_coeff_ctl is not used now.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 404466d2ae51..6e6b9d838332 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -451,7 +451,6 @@ struct wm_coeff_ctl {
 	unsigned int offset;
 	size_t len;
 	unsigned int set:1;
-	struct snd_kcontrol *kcontrol;
 	struct soc_bytes_ext bytes_ext;
 	unsigned int flags;
 	unsigned int type;
@@ -1138,8 +1137,6 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 
 	kfree(kcontrol);
 
-	ctl->kcontrol = snd_soc_card_get_kcontrol(dsp->card, ctl->name);
-
 	return 0;
 
 err_kcontrol:
-- 
2.10.2
