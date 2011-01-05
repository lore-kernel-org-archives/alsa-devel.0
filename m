From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: [PATCH] Fix the device references to codec and
	platform drivers
Date: Wed,  5 Jan 2011 11:34:51 +0530
Message-ID: <1294207491-17789-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id F12D310380B
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 06:53:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Harsha Priya <priya.harsha@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Harsha Priya <priya.harsha@intel.com>

The soc-core takes the platform and codec driver reference during probe. Few of
these references are not released during remove. This cause the platform and
codec driver module unload to fail.

This patch fixes by the taking only one reference to platform and codec module
during probe and releases them correctly during remove. This allows load/unload
properly

Signed-off-by: Vinod Koul<vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/soc-core.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a233607..bac7291 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1259,9 +1259,6 @@ find_codec:
 		if (!strcmp(codec->name, dai_link->codec_name)) {
 			rtd->codec = codec;
 
-			if (!try_module_get(codec->dev->driver->owner))
-				return -ENODEV;
-
 			/* CODEC found, so find CODEC DAI from registered DAIs from this CODEC*/
 			list_for_each_entry(codec_dai, &dai_list, list) {
 				if (codec->dev == codec_dai->dev &&
@@ -1287,10 +1284,6 @@ find_platform:
 	/* no, then find CPU DAI from registered DAIs*/
 	list_for_each_entry(platform, &platform_list, list) {
 		if (!strcmp(platform->name, dai_link->platform_name)) {
-
-			if (!try_module_get(platform->dev->driver->owner))
-				return -ENODEV;
-
 			rtd->platform = platform;
 			goto out;
 		}
@@ -1425,6 +1418,9 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	soc_init_codec_debugfs(codec);
 
 	/* mark codec as probed and add to card codec list */
+	if (!try_module_get(codec->dev->driver->owner))
+		return -ENODEV;
+
 	codec->probed = 1;
 	list_add(&codec->card_list, &card->codec_dev_list);
 	list_add(&codec->dapm.list, &card->dapm_list);
@@ -1556,6 +1552,10 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 			}
 		}
 		/* mark platform as probed and add to card platform list */
+
+		if (!try_module_get(platform->dev->driver->owner))
+			return -ENODEV;
+
 		platform->probed = 1;
 		list_add(&platform->card_list, &card->platform_dev_list);
 	}
-- 
1.7.2.3
