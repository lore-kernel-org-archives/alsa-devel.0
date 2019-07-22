From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Fix handling of custom_stop_condition on DAPM graph walks" to the asoc tree
Date: Mon, 22 Jul 2019 13:22:10 +0100 (BST)
Message-ID: <20190722122210.7A072274046A@ypsilon.sirena.org.uk>
References: <20190718084333.15598-1-ckeepax@opensource.cirrus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190718084333.15598-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Fix handling of custom_stop_condition on DAPM graph walks

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

>From 8dd26dff00c0636b1d8621acaeef3f6f3a39dd77 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 18 Jul 2019 09:43:33 +0100
Subject: [PATCH] ASoC: dapm: Fix handling of custom_stop_condition on DAPM
 graph walks

DPCM uses snd_soc_dapm_dai_get_connected_widgets to build a
list of the widgets connected to a specific front end DAI so it
can search through this list for available back end DAIs. The
custom_stop_condition was added to is_connected_ep to facilitate this
list not containing more widgets than is necessary. Doing so both
speeds up the DPCM handling as less widgets need to be searched and
avoids issues with CODEC to CODEC links as these would be confused
with back end DAIs if they appeared in the list of available widgets.

custom_stop_condition was implemented by aborting the graph walk
when the condition is triggered, however there is an issue with this
approach. Whilst walking the graph is_connected_ep should update the
endpoints cache on each widget, if the walk is aborted the number
of attached end points is unknown for that sub-graph. When the stop
condition triggered, the original patch ignored the triggering widget
and returned zero connected end points; a later patch updated this
to set the triggering widget's cache to 1 and return that. Both of
these approaches result in inaccurate values being stored in various
end point caches as the values propagate back through the graph,
which can result in later issues with widgets powering/not powering
unexpectedly.

As the original goal was to reduce the size of the widget list passed
to the DPCM code, the simplest solution is to limit the functionality
of the custom_stop_condition to the widget list. This means the rest
of the graph will still be processed resulting in correct end point
caches, but only widgets up to the stop condition will be added to the
returned widget list.

Fixes: 6742064aef7f ("ASoC: dapm: support user-defined stop condition in dai_get_connected_widgets")
Fixes: 5fdd022c2026 ("ASoC: dpcm: play nice with CODEC<->CODEC links")
Fixes: 09464974eaa8 ("ASoC: dapm: Fix to return correct path list in is_connected_ep.")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20190718084333.15598-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6b44b4a78b8e..9cd87e47ee8f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1157,8 +1157,8 @@ static __always_inline int is_connected_ep(struct snd_soc_dapm_widget *widget,
 		list_add_tail(&widget->work_list, list);
 
 	if (custom_stop_condition && custom_stop_condition(widget, dir)) {
-		widget->endpoints[dir] = 1;
-		return widget->endpoints[dir];
+		list = NULL;
+		custom_stop_condition = NULL;
 	}
 
 	if ((widget->is_ep & SND_SOC_DAPM_DIR_TO_EP(dir)) && widget->connected) {
@@ -1195,8 +1195,8 @@ static __always_inline int is_connected_ep(struct snd_soc_dapm_widget *widget,
  *
  * Optionally, can be supplied with a function acting as a stopping condition.
  * This function takes the dapm widget currently being examined and the walk
- * direction as an arguments, it should return true if the walk should be
- * stopped and false otherwise.
+ * direction as an arguments, it should return true if widgets from that point
+ * in the graph onwards should not be added to the widget list.
  */
 static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 	struct list_head *list,
-- 
2.20.1
