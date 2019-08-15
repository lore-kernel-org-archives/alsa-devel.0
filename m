From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic23: remove unused variable 'tlv320aic23_rec_src'" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:23 +0100 (BST)
Message-ID: <20190815171423.BA3862742BC7@ypsilon.sirena.org.uk>
References: <20190815091534.57780-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815091534.57780-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: allison@lohutok.net, alsa-devel@alsa-project.org, broonie@kernel.org, Hulk Robot <hulkci@huawei.com>, kstewart@linuxfoundation.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic23: remove unused variable 'tlv320aic23_rec_src'

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

>From ab0ac2707784a966927c229752849c343bd1dbbf Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:15:34 +0800
Subject: [PATCH] ASoC: tlv320aic23: remove unused variable
 'tlv320aic23_rec_src'

sound/soc/codecs/tlv320aic23.c:70:29: warning:
 tlv320aic23_rec_src defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815091534.57780-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic23.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 080a840c987a..f8e2f4b74db3 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -67,8 +67,6 @@ static SOC_ENUM_SINGLE_DECL(rec_src_enum,
 static const struct snd_kcontrol_new tlv320aic23_rec_src_mux_controls =
 SOC_DAPM_ENUM("Input Select", rec_src_enum);
 
-static SOC_ENUM_SINGLE_DECL(tlv320aic23_rec_src,
-			    TLV320AIC23_ANLG, 2, rec_src_text);
 static SOC_ENUM_SINGLE_DECL(tlv320aic23_deemph,
 			    TLV320AIC23_DIGT, 1, deemph_text);
 
-- 
2.20.1
