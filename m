From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l73: remove unused variables 'vsp_output_mux' and 'xsp_output_mux'" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:24 +0100 (BST)
Message-ID: <20190815171424.C54642742BD6@ypsilon.sirena.org.uk>
References: <20190815085454.30384-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815085454.30384-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, brian.austin@cirrus.com, broonie@kernel.org, Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l73: remove unused variables 'vsp_output_mux' and 'xsp_output_mux'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From c25b456dc579298ac0ed7304f7d06a66288e96df Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 16:54:54 +0800
Subject: [PATCH] ASoC: cs42l73: remove unused variables 'vsp_output_mux' and
 'xsp_output_mux'

sound/soc/codecs/cs42l73.c:276:38: warning:
 vsp_output_mux defined but not used [-Wunused-const-variable=]
sound/soc/codecs/cs42l73.c:279:38: warning:
 xsp_output_mux defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815085454.30384-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l73.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index a81739367109..36089f8bcf0a 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -273,12 +273,6 @@ static SOC_ENUM_SINGLE_DECL(xsp_output_mux_enum,
 			    CS42L73_MIXERCTL, 4,
 			    cs42l73_spo_mixer_text);
 
-static const struct snd_kcontrol_new vsp_output_mux =
-	SOC_DAPM_ENUM("Route", vsp_output_mux_enum);
-
-static const struct snd_kcontrol_new xsp_output_mux =
-	SOC_DAPM_ENUM("Route", xsp_output_mux_enum);
-
 static const struct snd_kcontrol_new hp_amp_ctl =
 	SOC_DAPM_SINGLE("Switch", CS42L73_PWRCTL3, 0, 1, 1);
 
-- 
2.20.1
