From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 1/2] ASoC: topology: free stream_name of dai_drv
Date: Tue,  5 Mar 2019 23:57:52 +0800
Message-ID: <20190305155753.10362-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4EF88F806F7
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2019 04:57:16 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

The stream_name is allocated by kstrdup. We have to free it when the
dai is removed or return from error.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/soc-topology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 25fca7055464..4e05ef001e04 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -535,6 +535,8 @@ static void remove_dai(struct snd_soc_component *comp,
 		if (dai->driver == dai_drv)
 			dai->driver = NULL;
 
+	kfree(dai_drv->playback.stream_name);
+	kfree(dai_drv->capture.stream_name);
 	kfree(dai_drv->name);
 	list_del(&dobj->list);
 	kfree(dai_drv);
@@ -1806,6 +1808,9 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	ret = soc_tplg_dai_load(tplg, dai_drv, pcm, NULL);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
+		kfree(dai_drv->playback.stream_name);
+		kfree(dai_drv->capture.stream_name);
+		kfree(dai_drv->name);
 		kfree(dai_drv);
 		return ret;
 	}
-- 
2.17.1
