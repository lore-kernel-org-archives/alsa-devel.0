From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v2] ASoC: Add a sanity check before using dai driver name
Date: Thu, 24 Aug 2017 11:34:11 +0800
Message-ID: <20170824033411.5788-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, broonie@kernel.org
Cc: tiwai@suse.de, dolinux.peng@gmail.com, Jeffy Chen <jeffy.chen@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The dai driver's name is allowed to be NULL. So add a sanity check for
that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reported-by: Donglin Peng <dolinux.peng@gmail.com>
---

Changes in v2:
Keep the oringinal check style.

 sound/soc/soc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fc1bb2da3e2e..c38c8f844546 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1029,7 +1029,8 @@ struct snd_soc_dai *snd_soc_find_dai(
 			continue;
 		list_for_each_entry(dai, &component->dai_list, list) {
 			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
-			    && strcmp(dai->driver->name, dlc->dai_name))
+			    && (!dai->driver->name
+				|| !strcmp(dai->driver->name, dlc->dai_name))
 				continue;
 
 			return dai;
-- 
2.11.0
