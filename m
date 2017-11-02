From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix build warning in soc-core.c" to the asoc tree
Date: Thu, 02 Nov 2017 11:06:08 +0000
Message-ID: <E1eADK4-0002Fh-C2@debutante>
References: <ef36bde9-d303-efe1-ce77-57e281311301@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ef36bde9-d303-efe1-ce77-57e281311301@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fix build warning in soc-core.c

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

>From bb19ba2a345439b4de3f6d59819da9853500ac4d Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 29 Oct 2017 17:10:34 -0700
Subject: [PATCH] ASoC: fix build warning in soc-core.c

Fix kernel-doc build error. A symbol that ends with an underscore
character ('_') has special meaning in reST (reStructuredText), so add
a '*' to prevent this error and to indicate that there are several of
these values to choose from.

../sound/soc/soc-core.c:2799: ERROR: Unknown target name: "snd_soc_daifmt".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fee4b0ef5566..3ef6989552c9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2796,7 +2796,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_bclk_ratio);
 /**
  * snd_soc_dai_set_fmt - configure DAI hardware audio format.
  * @dai: DAI
- * @fmt: SND_SOC_DAIFMT_ format value.
+ * @fmt: SND_SOC_DAIFMT_* format value.
  *
  * Configures the DAI hardware format and clocking.
  */
-- 
2.15.0
