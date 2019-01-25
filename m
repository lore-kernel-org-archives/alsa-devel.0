From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/7] ASoC: topology: add SND_SOC_DOBJ_GRAPH
	type for dapm routes
Date: Fri, 25 Jan 2019 14:06:46 -0600
Message-ID: <20190125200648.12470-6-pierre-louis.bossart@linux.intel.com>
References: <20190125200648.12470-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 731EF26680F
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:07:01 +0100 (CET)
In-Reply-To: <20190125200648.12470-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add a new dobj type SND_SOC_DOBJ_GRAPH for dapm routes
and add snd_soc_dobj member to struct snd_soc_dapm_route.
This enables device drivers to save driver specific
data pertaining to dapm routes and also be able
to clean up the data when the driver module is unloaded.

Also, reorder the snd_soc_dobj_type types to align with
matching topology header types.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-dapm.h     | 2 ++
 include/sound/soc-topology.h | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index bd8163f151cb..46f2ba3ffcb7 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -540,6 +540,8 @@ struct snd_soc_dapm_route {
 	/* Note: currently only supported for links where source is a supply */
 	int (*connected)(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink);
+
+	struct snd_soc_dobj dobj;
 };
 
 /* dapm audio path between two widgets */
diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index fa4b8413d2e2..8c43cfc240fa 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -38,12 +38,13 @@ struct snd_soc_dapm_route;
 enum snd_soc_dobj_type {
 	SND_SOC_DOBJ_NONE		= 0,	/* object is not dynamic */
 	SND_SOC_DOBJ_MIXER,
-	SND_SOC_DOBJ_ENUM,
 	SND_SOC_DOBJ_BYTES,
-	SND_SOC_DOBJ_PCM,
+	SND_SOC_DOBJ_ENUM,
+	SND_SOC_DOBJ_GRAPH,
+	SND_SOC_DOBJ_WIDGET,
 	SND_SOC_DOBJ_DAI_LINK,
+	SND_SOC_DOBJ_PCM,
 	SND_SOC_DOBJ_CODEC_LINK,
-	SND_SOC_DOBJ_WIDGET,
 };
 
 /* dynamic control object */
-- 
2.17.1
