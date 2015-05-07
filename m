From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: dapm: Break out of widget search
	when source and sink are located
Date: Thu,  7 May 2015 11:33:58 +0100
Message-ID: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 54AA0260682
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 12:42:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Currently snd_soc_dapm_add_route will continue to search the widget list
even after both the source and sink for the route have been located.
This patch breaks out of the search when both are located giving a
small improvement in probe time for drivers.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Note these patches depend on:

commit 92fa12426741d52b39ec92ad77c9843d3fc2b3d6
Author: Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri May 1 18:02:42 2015 +0200

    ASoC: dapm: Add new widgets to the end of the widget list

Thanks,
Charles

 sound/soc/soc-dapm.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a2e5f22..ea3348e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2617,14 +2617,20 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	list_for_each_entry(w, &dapm->card->widgets, list) {
 		if (!wsink && !(strcmp(w->name, sink))) {
 			wtsink = w;
-			if (w->dapm == dapm)
+			if (w->dapm == dapm) {
 				wsink = w;
+				if (wsource)
+					break;
+			}
 			continue;
 		}
 		if (!wsource && !(strcmp(w->name, source))) {
 			wtsource = w;
-			if (w->dapm == dapm)
+			if (w->dapm == dapm) {
 				wsource = w;
+				if (wsink)
+					break;
+			}
 		}
 	}
 	/* use widget from another DAPM context if not found from this */
-- 
1.7.2.5
