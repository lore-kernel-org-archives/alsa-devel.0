From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt1308: Remove executable attribute from source files" to the asoc tree
Date: Wed, 10 Jul 2019 16:34:49 +0100 (BST)
Message-ID: <20190710153449.62FF6D02DA6@fitzroy.sirena.org.uk>
References: <d198a3e6ed3a0e9070afeb6aca69903c3e985149.camel@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d198a3e6ed3a0e9070afeb6aca69903c3e985149.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, Derek Fang <derek.fang@realtek.com>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt1308: Remove executable attribute from source files

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 72365164cbefe3afa7a146d27d502ed688bf7323 Mon Sep 17 00:00:00 2001
From: Joe Perches <joe@perches.com>
Date: Tue, 9 Jul 2019 10:22:16 -0700
Subject: [PATCH] ASoC: rt1308: Remove executable attribute from source files

These are source files not executable.

Signed-off-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/r/d198a3e6ed3a0e9070afeb6aca69903c3e985149.camel@perches.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1308.c | 0
 sound/soc/codecs/rt1308.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 sound/soc/codecs/rt1308.c
 mode change 100755 => 100644 sound/soc/codecs/rt1308.h

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
old mode 100755
new mode 100644
diff --git a/sound/soc/codecs/rt1308.h b/sound/soc/codecs/rt1308.h
old mode 100755
new mode 100644
-- 
2.20.1
