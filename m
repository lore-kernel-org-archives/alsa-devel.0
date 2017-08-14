From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98926: make max98926_spk_tlv and max98926_current_tlv static" to the asoc tree
Date: Mon, 14 Aug 2017 17:44:57 +0100
Message-ID: <E1dhIU5-0005cp-EE@finisterre>
References: <20170813150033.17049-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170813150033.17049-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, "Gustavo A . R . Silva" <garsilva@embeddedor.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98926: make max98926_spk_tlv and max98926_current_tlv static

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

>From 9ab51b9469e6a63dbf4385bdd02704e87b65a039 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sun, 13 Aug 2017 16:00:33 +0100
Subject: [PATCH] ASoC: max98926: make max98926_spk_tlv and
 max98926_current_tlv static

max98926_spk_tlv and max98926_current_tlv are local to the source and do
not need to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'max98926_spk_tlv' was not declared. Should it be static?
symbol 'max98926_current_tlv' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98926.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index f16145d8ee6b..13d2708657e1 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -213,8 +213,8 @@ static bool max98926_readable_register(struct device *dev, unsigned int reg)
 	}
 };
 
-DECLARE_TLV_DB_SCALE(max98926_spk_tlv, -600, 100, 0);
-DECLARE_TLV_DB_RANGE(max98926_current_tlv,
+static DECLARE_TLV_DB_SCALE(max98926_spk_tlv, -600, 100, 0);
+static DECLARE_TLV_DB_RANGE(max98926_current_tlv,
 	0, 11, TLV_DB_SCALE_ITEM(20, 20, 0),
 	12, 15, TLV_DB_SCALE_ITEM(320, 40, 0),
 );
-- 
2.13.2
