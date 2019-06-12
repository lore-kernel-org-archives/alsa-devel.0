From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/4] ASoC: SOF: topology: add min/max step for
	volume_table
Date: Wed, 12 Jun 2019 12:01:45 -0500
Message-ID: <20190612170148.15327-2-pierre-louis.bossart@linux.intel.com>
References: <20190612170148.15327-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2076BF896CE
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:02:05 +0200 (CEST)
In-Reply-To: <20190612170148.15327-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>

add two units min_volume_step and max_volume_step to the snd_sof_control
struct, for the min and max step of the volume_table.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-priv.h | 2 ++
 sound/soc/sof/topology.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 563623bcaad6..d2dbca7d57d1 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -297,6 +297,8 @@ struct snd_sof_pcm {
 struct snd_sof_control {
 	struct snd_sof_dev *sdev;
 	int comp_id;
+	int min_volume_step; /* min volume step for volume_table */
+	int max_volume_step; /* max volume step for volume_table */
 	int num_channels;
 	u32 readback_offset; /* offset to mmaped data if used */
 	struct sof_ipc_ctrl_data *control_data;
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index a13233ae6d0e..1c661dec8dd4 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -451,6 +451,8 @@ static int sof_control_load_volume(struct snd_soc_component *scomp,
 		return -ENOMEM;
 
 	scontrol->comp_id = sdev->next_comp_id;
+	scontrol->min_volume_step = le32_to_cpu(mc->min);
+	scontrol->max_volume_step = le32_to_cpu(mc->max);
 	scontrol->num_channels = le32_to_cpu(mc->num_channels);
 
 	/* set cmd for mixer control */
-- 
2.20.1
