From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: fix a NULL pointer dereference" to the asoc tree
Date: Thu,  2 May 2019 03:18:21 +0100 (BST)
Message-ID: <20190502021821.E7690441D3B@finisterre.ee.mobilebroadband>
References: <20190315034833.25037-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315034833.25037-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, pakki001@umn.edu, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: fix a NULL pointer dereference

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

>From 51dd97d1df5fb9ac58b9b358e63e67b530f6ae21 Mon Sep 17 00:00:00 2001
From: Kangjie Lu <kjlu@umn.edu>
Date: Thu, 14 Mar 2019 22:48:32 -0500
Subject: [PATCH] ASoC: rt5645: fix a NULL pointer dereference

devm_kcalloc() may fail and return NULL. The fix returns ENOMEM
in case it fails to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9a0751978090..f842775dbf2c 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3419,6 +3419,9 @@ static int rt5645_probe(struct snd_soc_component *component)
 		RT5645_HWEQ_NUM, sizeof(struct rt5645_eq_param_s),
 		GFP_KERNEL);
 
+	if (!rt5645->eq_param)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.20.1
