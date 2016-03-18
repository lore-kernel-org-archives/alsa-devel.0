From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dapm: Make sure we have a card when displaying component widgets
Date: Fri, 18 Mar 2016 15:04:34 +0000
Message-ID: <1458313474-28355-1-git-send-email-broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Harry Pan <harry.pan@intel.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The dummy component is reused for all cards so we special case and don't
bind it to any of them.  This means that code like that displaying the
component widgets that tries to look at the card will crash.  In the
future we will fix this by ensuring that the dummy component looks like
other components but that is invasive and so not suitable for a fix.
Instead add a special case check here.

Reported-by: Harry Pan <harry.pan@intel.com>
Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-dapm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 801ae1a81dfd..c4464858bf01 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2188,6 +2188,13 @@ static ssize_t dapm_widget_show_component(struct snd_soc_component *cmpnt,
 	int count = 0;
 	char *state = "not set";
 
+	/* card won't be set for the dummy component, as a spot fix
+	 * we're checking for that case specifically here but in future
+	 * we will ensure that the dummy component looks like others.
+	 */
+	if (!cmpnt->card)
+		return 0;
+
 	list_for_each_entry(w, &cmpnt->card->widgets, list) {
 		if (w->dapm != dapm)
 			continue;
-- 
2.7.0
