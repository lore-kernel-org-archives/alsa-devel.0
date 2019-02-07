From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: jz4725b: fix spelling mistake "Deemphatize" -> "Deemphasize"" to the asoc tree
Date: Thu,  7 Feb 2019 12:16:05 +0000 (GMT)
Message-ID: <20190207121605.476781127EF9@debutante.sirena.org.uk>
References: <20190207092642.6655-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207092642.6655-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Paul Cercueil <paul@crapouillou.net>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: jz4725b: fix spelling mistake "Deemphatize" -> "Deemphasize"

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 6c3e6302364aa5d152e0f5f81d550fdbc7bb8d38 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 7 Feb 2019 09:26:42 +0000
Subject: [PATCH] ASoC: codecs: jz4725b: fix spelling mistake "Deemphatize" ->
 "Deemphasize"

There is a spelling mistake in the SOC_SINGLE control name. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index e3dba92f30bd..24b1b23b99c9 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -161,7 +161,7 @@ static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 	SOC_SINGLE("Master Playback Switch", JZ4725B_CODEC_REG_CR1,
 		   REG_CR1_DAC_MUTE_OFFSET, 1, 1),
 
-	SOC_SINGLE("Deemphatize Filter Playback Switch",
+	SOC_SINGLE("Deemphasize Filter Playback Switch",
 		   JZ4725B_CODEC_REG_CR2,
 		   REG_CR2_DAC_DEEMP_OFFSET, 1, 0),
 
-- 
2.20.1
