From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9877: Remove unused function declaration" to the asoc tree
Date: Wed, 22 Jun 2016 16:28:21 +0100
Message-ID: <E1bFk4j-0002De-8K@debutante>
References: <1466450966-30768-1-git-send-email-helen.koike@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466450966-30768-1-git-send-email-helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Helen Koike <helen.koike@collabora.co.uk>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgbroonie@kernel.org, broonie@linaro.org, trivial@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9877: Remove unused function declaration

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

>From 49220e9b454e60774c4e65a2c7ad624fb22c9180 Mon Sep 17 00:00:00 2001
From: Helen Koike <helen.koike@collabora.co.uk>
Date: Mon, 20 Jun 2016 16:29:26 -0300
Subject: [PATCH] ASoC: max9877: Remove unused function declaration

Remove unused function declaration from header

Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9877.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max9877.h b/sound/soc/codecs/max9877.h
index 6da72290ac58..368343f29dd0 100644
--- a/sound/soc/codecs/max9877.h
+++ b/sound/soc/codecs/max9877.h
@@ -32,6 +32,4 @@
 #define MAX9877_BYPASS			(1 << 6)
 #define MAX9877_SHDN			(1 << 7)
 
-extern int max9877_add_controls(struct snd_soc_codec *codec);
-
 #endif
-- 
2.8.1
