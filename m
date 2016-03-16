From: Harry Pan <harry.pan@intel.com>
Subject: [PATCH] ASoC: dapm: Do not traverse widget hooks to snd-soc-dummy
Date: Wed, 16 Mar 2016 19:17:51 +0800
Message-ID: <1458127071-14417-1-git-send-email-harry.pan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Harry Pan <gs0622@gmail.com>, Harry Pan <harry.pan@intel.com>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

All components are initially given an empty card when registering platform,
and since the commit 6e78108bda78
("ASoC: core: Don't probe the component which is dummy")',
snd-soc-dummy will not be probed so that it remains an empty card assigned.

This patch ignores to iterate widget hooks to the 'snd-soc-dummy'
component, else it will trigger memory fault because of invalid dereference
address of card->widgets.

Test by grep -rsI "hello" /sys/devices/platform/skl_nau88l25_ssm4567_i2s/

Conflicts:
	sound/soc/soc-dapm.c

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 sound/soc/soc-dapm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 581175a..0bc15c9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2188,6 +2188,9 @@ static ssize_t dapm_widget_show_component(struct snd_soc_component *cmpnt,
 	int count = 0;
 	char *state = "not set";
 
+	if (!strcmp(cmpnt->name, "snd-soc-dummy"))
+		return 0;
+
 	list_for_each_entry(w, &cmpnt->card->widgets, list) {
 		if (w->dapm != dapm)
 			continue;
-- 
2.1.2
