From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: jack: fix snd_soc_codec_set_jack return error" to the asoc tree
Date: Tue, 08 Aug 2017 12:06:25 +0100
Message-ID: <E1df2LB-0004zQ-Iq@finisterre>
References: <20170726003512.18965-2-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726003512.18965-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: jack: fix snd_soc_codec_set_jack return error

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

>From 77a4525bc282b7072ebda5d6f6925ca6d604a16f Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 26 Jul 2017 02:35:07 +0200
Subject: [PATCH] ASoC: jack: fix snd_soc_codec_set_jack return error

This patch changes the error code returned by snd_soc_codec_set_jack()
from -EINVAL to -ENOTSUPP. The reason to do this is to make the caller
aware that the underlying codec does not support this callback. This can
make the caller write the code to handle this case properly.
Other reason is that -EINVAL is not the correct error to return in this
case anyway.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-jack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 7daf21fee355..42ca9f19843b 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -36,7 +36,7 @@ int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
 	if (codec->driver->set_jack)
 		return codec->driver->set_jack(codec, jack, data);
 	else
-		return -EINVAL;
+		return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_jack);
 
-- 
2.13.2
