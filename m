From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/4] ASoC: SOF: topology: pass volume min/max
	linear value to FW
Date: Wed, 12 Jun 2019 12:01:46 -0500
Message-ID: <20190612170148.15327-3-pierre-louis.bossart@linux.intel.com>
References: <20190612170148.15327-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E97D2F806F5
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:02:07 +0200 (CEST)
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

The driver currently passes the volume ramp type and length
topology tokens to firmware, but the min and max volume are
not set. This patch provides a correction to convert the
information from the topology file and pass the linear volume
min/max value to the firmware to improve transitions.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/topology.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 1c661dec8dd4..bbad8053b1bc 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1552,6 +1552,9 @@ static int sof_widget_load_pga(struct snd_soc_component *scomp, int index,
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct snd_soc_tplg_private *private = &tw->priv;
 	struct sof_ipc_comp_volume *volume;
+	struct snd_sof_control *scontrol;
+	int min_step;
+	int max_step;
 	int ret;
 
 	volume = kzalloc(sizeof(*volume), GFP_KERNEL);
@@ -1594,6 +1597,17 @@ static int sof_widget_load_pga(struct snd_soc_component *scomp, int index,
 
 	swidget->private = volume;
 
+	list_for_each_entry(scontrol, &sdev->kcontrol_list, list) {
+		if (scontrol->comp_id == swidget->comp_id) {
+			min_step = scontrol->min_volume_step;
+			max_step = scontrol->max_volume_step;
+			volume->min_value = scontrol->volume_table[min_step];
+			volume->max_value = scontrol->volume_table[max_step];
+			volume->channels = scontrol->num_channels;
+			break;
+		}
+	}
+
 	ret = sof_ipc_tx_message(sdev->ipc, volume->comp.hdr.cmd, volume,
 				 sizeof(*volume), r, sizeof(*r));
 	if (ret >= 0)
-- 
2.20.1
