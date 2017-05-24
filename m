From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Remove unused member of struct wm_coeff_ctl_ops" to the asoc tree
Date: Wed, 24 May 2017 18:42:16 +0100
Message-ID: <E1dDaIa-0002w1-CC@debutante>
References: <1495619979-3620-2-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495619979-3620-2-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Remove unused member of struct wm_coeff_ctl_ops

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

>From f6db09488f58372909728cea5a7c063ebf78f386 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 24 May 2017 10:59:39 +0100
Subject: [PATCH] ASoC: wm_adsp: Remove unused member of struct
 wm_coeff_ctl_ops

The xinfo member of struct wm_coeff_ctl_ops is never used.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a7dc76030ee4..5aff83be375c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -482,8 +482,6 @@ struct wm_coeff_ctl_ops {
 		    struct snd_ctl_elem_value *ucontrol);
 	int (*xput)(struct snd_kcontrol *kcontrol,
 		    struct snd_ctl_elem_value *ucontrol);
-	int (*xinfo)(struct snd_kcontrol *kcontrol,
-		     struct snd_ctl_elem_info *uinfo);
 };
 
 struct wm_coeff_ctl {
-- 
2.11.0
