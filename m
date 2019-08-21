From: Jaska Uimonen <jaska.uimonen@linux.intel.com>
Subject: [PATCH v2] ASoC: SOF: topology: fix get control data
	return type and arguments
Date: Wed, 21 Aug 2019 16:21:15 +0300
Message-ID: <20190821132115.26578-1-jaska.uimonen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E0C6F802FB
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 15:31:25 +0200 (CEST)
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
Cc: Jaska Uimonen <jaska.uimonen@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jaska Uimonen <jaska.uimonen@intel.com>

sof_get_control_data returns negative values even though the return
value is defined unsigned (size_t). So change the return value type to
int and add the data size as pointer argument to sof_get_control_data to
avoid ambiquity in the meaning of the return type.

Fixes: cac974a51ebb ("ASoC: SOF: topology: use set_get_data in process load")
Reported by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jaska Uimonen <jaska.uimonen@intel.com>
---
 sound/soc/sof/topology.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 28a7a6e06a53..fc85efbad378 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1752,17 +1752,19 @@ static int sof_widget_load_siggen(struct snd_soc_component *scomp, int index,
 	return ret;
 }
 
-static size_t sof_get_control_data(struct snd_sof_dev *sdev,
-				   struct snd_soc_dapm_widget *widget,
-				   struct sof_widget_data *wdata)
+static int sof_get_control_data(struct snd_sof_dev *sdev,
+				struct snd_soc_dapm_widget *widget,
+				struct sof_widget_data *wdata,
+				size_t *size)
 {
 	const struct snd_kcontrol_new *kc;
 	struct soc_mixer_control *sm;
 	struct soc_bytes_ext *sbe;
 	struct soc_enum *se;
-	size_t size = 0;
 	int i;
 
+	*size = 0;
+
 	for (i = 0; i < widget->num_kcontrols; i++) {
 		kc = &widget->kcontrol_news[i];
 
@@ -1800,7 +1802,7 @@ static size_t sof_get_control_data(struct snd_sof_dev *sdev,
 		if (wdata[i].pdata->magic != SOF_ABI_MAGIC)
 			return -EINVAL;
 
-		size += wdata[i].pdata->size;
+		*size += wdata[i].pdata->size;
 
 		/* get data type */
 		switch (wdata[i].control->cmd) {
@@ -1819,7 +1821,7 @@ static size_t sof_get_control_data(struct snd_sof_dev *sdev,
 		}
 	}
 
-	return size;
+	return 0;
 }
 
 static int sof_process_load(struct snd_soc_component *scomp, int index,
@@ -1855,12 +1857,11 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
 			return -ENOMEM;
 
 		/* get possible component controls and get size of all pdata */
-		ipc_data_size = sof_get_control_data(sdev, widget, wdata);
+		ret = sof_get_control_data(sdev, widget, wdata,
+					   &ipc_data_size);
 
-		if (ipc_data_size <= 0) {
-			ret = ipc_data_size;
+		if (ret < 0)
 			goto out;
-		}
 	}
 
 	ipc_size = sizeof(struct sof_ipc_comp_process) +
-- 
2.13.6
