From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: soc-core: Fix null pointer dereference in soc_find_component
Date: Fri, 11 Jan 2019 13:44:02 +0530
Message-ID: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org, vinod.koul@linaro.org
Cc: Ajit Pandey <ajitp@codeaurora.org>, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Ajit Pandey <ajitp@codeaurora.org>

soc_find_component() may lead to null pointer exception if both
arguments i.e of_node and name is NULL. Add NULL check before
calling soc_find_component(). Also fix some typos.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/soc-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0934b36..df05fb8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1131,11 +1131,13 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	}
 
 	/*
-	 * Defer card registartion if platform dai component is not added to
+	 * Defer card registration if platform dai component is not added to
 	 * component list.
 	 */
-	if (!soc_find_component(link->platform->of_node, link->platform->name))
-		return -EPROBE_DEFER;
+	if (link->platform->of_node || link->platform->name)
+		if (!soc_find_component(link->platform->of_node,
+					link->platform->name))
+			return -EPROBE_DEFER;
 
 	/*
 	 * CPU device may be specified by either name or OF node, but
@@ -1150,11 +1152,12 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	}
 
 	/*
-	 * Defer card registartion if cpu dai component is not added to
+	 * Defer card registration if cpu dai component is not added to
 	 * component list.
 	 */
-	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
-		return -EPROBE_DEFER;
+	if (link->cpu_of_node || link->cpu_name)
+		if (!soc_find_component(link->cpu_of_node, link->cpu_name))
+			return -EPROBE_DEFER;
 
 	/*
 	 * At least one of CPU DAI name or CPU device name/node must be
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
