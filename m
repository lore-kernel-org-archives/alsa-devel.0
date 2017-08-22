From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: Allow searching dai driver name in snd_soc_find_dai" to the asoc tree
Date: Tue, 22 Aug 2017 13:47:18 +0100
Message-ID: <E1dk8aU-0008Pv-H3@finisterre>
References: <20170822075729.8438-3-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170822075729.8438-3-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de, alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, lars@metafoo.de, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.orgMark Brown <broonie@kernel.org>, dianders@chromium.org, mka@chromium.org, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: Allow searching dai driver name in snd_soc_find_dai

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

>From 4958471b0d2110a34df0b45803e6f24ed89b857b Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Tue, 22 Aug 2017 15:57:21 +0800
Subject: [PATCH] ASoC: soc-core: Allow searching dai driver name in
 snd_soc_find_dai

Currently we are searching dai name in snd_soc_find_dai, which could
either be dai driver name or component device name(for legacy naming).

Allow searching dai driver name in snd_soc_find_dai too, so that we can
use dai driver name to find legacy naming dais.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 50c8dba54649..6fab0ff213ef 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1000,7 +1000,7 @@ static struct snd_soc_component *soc_find_component(
 /**
  * snd_soc_find_dai - Find a registered DAI
  *
- * @dlc: name of the DAI and optional component info to match
+ * @dlc: name of the DAI or the DAI driver and optional component info to match
  *
  * This function will search all registered components and their DAIs to
  * find the DAI of the same name. The component's of_node and name
@@ -1028,7 +1028,8 @@ struct snd_soc_dai *snd_soc_find_dai(
 		if (dlc->name && strcmp(component->name, dlc->name))
 			continue;
 		list_for_each_entry(dai, &component->dai_list, list) {
-			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name))
+			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
+			    && strcmp(dai->driver->name, dlc->dai_name))
 				continue;
 
 			return dai;
-- 
2.13.2
