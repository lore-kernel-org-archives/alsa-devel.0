From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add a sanity check before using dai driver name" to the asoc tree
Date: Sun, 27 Aug 2017 14:39:19 +0100 (BST)
Message-ID: <20170827133919.9E1624400E7@finisterre.ee.mobilebroadband>
References: <20170824044017.10368-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824044017.10368-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.orgbroonie@kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, Takashi Iwai <tiwai@suse.com>dolinux.peng@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add a sanity check before using dai driver name

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

>From 6a6dafda937cfcdbbfe46a3e093de8bb929ba52d Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Thu, 24 Aug 2017 12:40:17 +0800
Subject: [PATCH] ASoC: Add a sanity check before using dai driver name

The dai driver's name is allowed to be NULL. So add a sanity check for
that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reported-by: Donglin Peng <dolinux.peng@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6fab0ff213ef..74c17068bb11 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1029,7 +1029,8 @@ struct snd_soc_dai *snd_soc_find_dai(
 			continue;
 		list_for_each_entry(dai, &component->dai_list, list) {
 			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
-			    && strcmp(dai->driver->name, dlc->dai_name))
+			    && (!dai->driver->name
+				|| strcmp(dai->driver->name, dlc->dai_name)))
 				continue;
 
 			return dai;
-- 
2.13.2
