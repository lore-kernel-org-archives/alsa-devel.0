From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2] ASoC: SOF: topology: use set_get_data in
	process load
Date: Fri,  9 Aug 2019 18:17:14 -0500
Message-ID: <20190809231714.20874-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAC01F800E4
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 01:17:26 +0200 (CEST)
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
Cc: tiwai@suse.de, Jaska Uimonen <jaska.uimonen@intel.com>, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jaska Uimonen <jaska.uimonen@intel.com>

Currently when loading sof process components there's a check if binary
control data is associated with it. If found the data is extracted to be
part of component loading and initialization. If binary data exceeds the
ipc max size, loading fails with error as large message support is only
implemented in set_get_data method. So make the process loading use
set_get_data to enable large parameters in component initialization.

Also refactor the process component loading function as it digs out 3
times almost identical information of related controls. This is
redundant, looks ugly and makes it difficult to understand the
mechanism. So make a function out of fetching the control data and use
it in process loading.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Jaska Uimonen <jaska.uimonen@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---

v2: simplify error handling with gotos as suggested by Cezary.

 sound/soc/sof/topology.c | 201 +++++++++++++++++++++++++--------------
 1 file changed, 127 insertions(+), 74 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 12b7d900b9c2..9cffea142395 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -42,6 +42,13 @@
 /* size of tplg abi in byte */
 #define SOF_TPLG_ABI_SIZE 3
 
+struct sof_widget_data {
+	int ctrl_type;
+	int ipc_cmd;
+	struct sof_abi_hdr *pdata;
+	struct snd_sof_control *control;
+};
+
 /* send pcm params ipc */
 static int ipc_pcm_params(struct snd_sof_widget *swidget, int dir)
 {
@@ -1742,51 +1749,32 @@ static int sof_widget_load_siggen(struct snd_soc_component *scomp, int index,
 	return ret;
 }
 
-static int sof_process_load(struct snd_soc_component *scomp, int index,
-			    struct snd_sof_widget *swidget,
-			    struct snd_soc_tplg_dapm_widget *tw,
-			    struct sof_ipc_comp_reply *r,
-			    int type)
+static size_t sof_get_control_data(struct snd_sof_dev *sdev,
+				   struct snd_soc_dapm_widget *widget,
+				   struct sof_widget_data *wdata)
 {
-	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
-	struct snd_soc_tplg_private *private = &tw->priv;
-	struct snd_soc_dapm_widget *widget = swidget->widget;
 	const struct snd_kcontrol_new *kc;
-	struct soc_bytes_ext *sbe;
 	struct soc_mixer_control *sm;
+	struct soc_bytes_ext *sbe;
 	struct soc_enum *se;
-	struct snd_sof_control *scontrol = NULL;
-	struct sof_abi_hdr *pdata = NULL;
-	struct sof_ipc_comp_process *process;
-	size_t ipc_size, ipc_data_size = 0;
-	int ret, i, offset = 0;
-
-	if (type == SOF_COMP_NONE) {
-		dev_err(sdev->dev, "error: invalid process comp type %d\n",
-			type);
-		return -EINVAL;
-	}
+	size_t size = 0;
+	int i;
 
-	/*
-	 * get possible component controls - get size of all pdata,
-	 * then memcpy with headers
-	 */
 	for (i = 0; i < widget->num_kcontrols; i++) {
-
 		kc = &widget->kcontrol_news[i];
 
 		switch (widget->dobj.widget.kcontrol_type) {
 		case SND_SOC_TPLG_TYPE_MIXER:
 			sm = (struct soc_mixer_control *)kc->private_value;
-			scontrol = sm->dobj.private;
+			wdata[i].control = sm->dobj.private;
 			break;
 		case SND_SOC_TPLG_TYPE_BYTES:
 			sbe = (struct soc_bytes_ext *)kc->private_value;
-			scontrol = sbe->dobj.private;
+			wdata[i].control = sbe->dobj.private;
 			break;
 		case SND_SOC_TPLG_TYPE_ENUM:
 			se = (struct soc_enum *)kc->private_value;
-			scontrol = se->dobj.private;
+			wdata[i].control = se->dobj.private;
 			break;
 		default:
 			dev_err(sdev->dev, "error: unknown kcontrol type %d in widget %s\n",
@@ -1795,31 +1783,98 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
 			return -EINVAL;
 		}
 
-		if (!scontrol) {
+		if (!wdata[i].control) {
 			dev_err(sdev->dev, "error: no scontrol for widget %s\n",
 				widget->name);
 			return -EINVAL;
 		}
 
-		/* don't include if no private data */
-		pdata = scontrol->control_data->data;
-		if (!pdata)
-			continue;
+		wdata[i].pdata = wdata[i].control->control_data->data;
+		if (!wdata[i].pdata)
+			return -EINVAL;
 
 		/* make sure data is valid - data can be updated at runtime */
-		if (pdata->magic != SOF_ABI_MAGIC)
-			continue;
+		if (wdata[i].pdata->magic != SOF_ABI_MAGIC)
+			return -EINVAL;
+
+		size += wdata[i].pdata->size;
+
+		/* get data type */
+		switch (wdata[i].control->cmd) {
+		case SOF_CTRL_CMD_VOLUME:
+		case SOF_CTRL_CMD_ENUM:
+		case SOF_CTRL_CMD_SWITCH:
+			wdata[i].ipc_cmd = SOF_IPC_COMP_SET_VALUE;
+			wdata[i].ctrl_type = SOF_CTRL_TYPE_VALUE_CHAN_SET;
+			break;
+		case SOF_CTRL_CMD_BINARY:
+			wdata[i].ipc_cmd = SOF_IPC_COMP_SET_DATA;
+			wdata[i].ctrl_type = SOF_CTRL_TYPE_DATA_SET;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return size;
+}
+
+static int sof_process_load(struct snd_soc_component *scomp, int index,
+			    struct snd_sof_widget *swidget,
+			    struct snd_soc_tplg_dapm_widget *tw,
+			    struct sof_ipc_comp_reply *r,
+			    int type)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
+	struct snd_soc_dapm_widget *widget = swidget->widget;
+	struct snd_soc_tplg_private *private = &tw->priv;
+	struct sof_ipc_comp_process *process = NULL;
+	struct sof_widget_data *wdata = NULL;
+	size_t ipc_data_size = 0;
+	size_t ipc_size;
+	int offset = 0;
+	int ret = 0;
+	int i;
+
+	if (type == SOF_COMP_NONE) {
+		dev_err(sdev->dev, "error: invalid process comp type %d\n",
+			type);
+		return -EINVAL;
+	}
+
+	/* allocate struct for widget control data sizes and types */
+	if (widget->num_kcontrols) {
+		wdata = kcalloc(widget->num_kcontrols,
+				sizeof(*wdata),
+				GFP_KERNEL);
+
+		if (!wdata)
+			return -ENOMEM;
 
-		ipc_data_size += pdata->size;
+		/* get possible component controls and get size of all pdata */
+		ipc_data_size = sof_get_control_data(sdev, widget, wdata);
+
+		if (ipc_data_size <= 0) {
+			ret = ipc_data_size;
+			goto out;
+		}
 	}
 
 	ipc_size = sizeof(struct sof_ipc_comp_process) +
 		le32_to_cpu(private->size) +
 		ipc_data_size;
 
+	/* we are exceeding max ipc size, config needs to be sent separately */
+	if (ipc_size > SOF_IPC_MSG_MAX_SIZE) {
+		ipc_size -= ipc_data_size;
+		ipc_data_size = 0;
+	}
+
 	process = kzalloc(ipc_size, GFP_KERNEL);
-	if (!process)
-		return -ENOMEM;
+	if (!process) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	/* configure iir IPC message */
 	process->comp.hdr.size = ipc_size;
@@ -1845,40 +1900,13 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
 	 * get possible component controls - get size of all pdata,
 	 * then memcpy with headers
 	 */
-	for (i = 0; i < widget->num_kcontrols; i++) {
-		kc = &widget->kcontrol_news[i];
-
-		switch (widget->dobj.widget.kcontrol_type) {
-		case SND_SOC_TPLG_TYPE_MIXER:
-			sm = (struct soc_mixer_control *)kc->private_value;
-			scontrol = sm->dobj.private;
-			break;
-		case SND_SOC_TPLG_TYPE_BYTES:
-			sbe = (struct soc_bytes_ext *)kc->private_value;
-			scontrol = sbe->dobj.private;
-			break;
-		case SND_SOC_TPLG_TYPE_ENUM:
-			se = (struct soc_enum *)kc->private_value;
-			scontrol = se->dobj.private;
-			break;
-		default:
-			dev_err(sdev->dev, "error: unknown kcontrol type %d in widget %s\n",
-				widget->dobj.widget.kcontrol_type,
-				widget->name);
-			return -EINVAL;
+	if (ipc_data_size) {
+		for (i = 0; i < widget->num_kcontrols; i++) {
+			memcpy(&process->data + offset,
+			       wdata[i].pdata->data,
+			       wdata[i].pdata->size);
+			offset += wdata[i].pdata->size;
 		}
-
-		/* don't include if no private data */
-		pdata = scontrol->control_data->data;
-		if (!pdata)
-			continue;
-
-		/* make sure data is valid - data can be updated at runtime */
-		if (pdata->magic != SOF_ABI_MAGIC)
-			continue;
-
-		memcpy(&process->data + offset, pdata->data, pdata->size);
-		offset += pdata->size;
 	}
 
 	process->size = ipc_data_size;
@@ -1886,10 +1914,35 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
 
 	ret = sof_ipc_tx_message(sdev->ipc, process->comp.hdr.cmd, process,
 				 ipc_size, r, sizeof(*r));
-	if (ret >= 0)
-		return ret;
+
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: create process failed\n");
+		goto err;
+	}
+
+	/* we sent the data in single message so return */
+	if (ipc_data_size)
+		goto out;
+
+	/* send control data with large message supported method */
+	for (i = 0; i < widget->num_kcontrols; i++) {
+		wdata[i].control->readback_offset = 0;
+		ret = snd_sof_ipc_set_get_comp_data(sdev->ipc, wdata[i].control,
+						    wdata[i].ipc_cmd,
+						    wdata[i].ctrl_type,
+						    wdata[i].control->cmd,
+						    true);
+		if (ret != 0) {
+			dev_err(sdev->dev, "error: send control failed\n");
+			break;
+		}
+	}
+
 err:
-	kfree(process);
+	if (ret < 0)
+		kfree(process);
+out:
+	kfree(wdata);
 	return ret;
 }
 
-- 
2.20.1
