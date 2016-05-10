From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8328: Fix mask for VMIDSEL" to the asoc tree
Date: Tue, 10 May 2016 19:49:35 +0100
Message-ID: <E1b0Cit-0007n7-3W@debutante>
References: <20160509112437.8924-4-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-4-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: Fix mask for VMIDSEL

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

>From 2da1ab667a506cc6a7dea88b70e6df3d281458f8 Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Mon, 9 May 2016 12:24:31 +0100
Subject: [PATCH] ASoC: es8328: Fix mask for VMIDSEL

This is always used along with ES8328_CONTROL1_ENREF so there is no
change in the generated code as a result of this fix.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8328.h b/sound/soc/codecs/es8328.h
index 5a4af014e516..8bc79fff0218 100644
--- a/sound/soc/codecs/es8328.h
+++ b/sound/soc/codecs/es8328.h
@@ -22,7 +22,7 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 #define ES8328_CONTROL1_VMIDSEL_50k (1 << 0)
 #define ES8328_CONTROL1_VMIDSEL_500k (2 << 0)
 #define ES8328_CONTROL1_VMIDSEL_5k (3 << 0)
-#define ES8328_CONTROL1_VMIDSEL_MASK (7 << 0)
+#define ES8328_CONTROL1_VMIDSEL_MASK (3 << 0)
 #define ES8328_CONTROL1_ENREF (1 << 2)
 #define ES8328_CONTROL1_SEQEN (1 << 3)
 #define ES8328_CONTROL1_SAMEFS (1 << 4)
-- 
2.8.1
