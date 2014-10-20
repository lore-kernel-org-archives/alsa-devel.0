From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 7/7] ASoC: Intel: Provide streams with dynamic
	module information
Date: Mon, 20 Oct 2014 15:06:52 +0100
Message-ID: <1413814012-5619-7-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DEC0B260710
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 16:07:51 +0200 (CEST)
In-Reply-To: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Remove the hard coded module paramaters and provide each module with
dynamically generated buffer information for scratch and persistent
buffers.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 54 ++++++++++++++++-----------------------
 sound/soc/intel/sst-haswell-ipc.h |  3 +--
 sound/soc/intel/sst-haswell-pcm.c | 29 +++++----------------
 3 files changed, 29 insertions(+), 57 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 62daa97..770d467 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1351,10 +1351,11 @@ int sst_hsw_stream_buffer(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
 }
 
 int sst_hsw_stream_set_module_info(struct sst_hsw *hsw,
-	struct sst_hsw_stream *stream, enum sst_hsw_module_id module_id,
-	u32 entry_point)
+	struct sst_hsw_stream *stream, struct sst_module_runtime *runtime)
 {
 	struct sst_hsw_module_map *map = &stream->request.map;
+	struct sst_dsp *dsp = sst_hsw_get_dsp(hsw);
+	struct sst_module *module = runtime->module;
 
 	if (stream->commited) {
 		dev_err(hsw->dev, "error: stream committed for set module\n");
@@ -1363,36 +1364,25 @@ int sst_hsw_stream_set_module_info(struct sst_hsw *hsw,
 
 	/* only support initial module atm */
 	map->module_entries_count = 1;
-	map->module_entries[0].module_id = module_id;
-	map->module_entries[0].entry_point = entry_point;
-
-	return 0;
-}
-
-int sst_hsw_stream_set_pmemory_info(struct sst_hsw *hsw,
-	struct sst_hsw_stream *stream, u32 offset, u32 size)
-{
-	if (stream->commited) {
-		dev_err(hsw->dev, "error: stream committed for set pmem\n");
-		return -EINVAL;
-	}
-
-	stream->request.persistent_mem.offset = offset;
-	stream->request.persistent_mem.size = size;
-
-	return 0;
-}
-
-int sst_hsw_stream_set_smemory_info(struct sst_hsw *hsw,
-	struct sst_hsw_stream *stream, u32 offset, u32 size)
-{
-	if (stream->commited) {
-		dev_err(hsw->dev, "error: stream committed for set smem\n");
-		return -EINVAL;
-	}
-
-	stream->request.scratch_mem.offset = offset;
-	stream->request.scratch_mem.size = size;
+	map->module_entries[0].module_id = module->id;
+	map->module_entries[0].entry_point = module->entry;
+
+	stream->request.persistent_mem.offset =
+		sst_dsp_get_offset(dsp, runtime->persistent_offset, SST_MEM_DRAM);
+	stream->request.persistent_mem.size = module->persistent_size;
+
+	stream->request.scratch_mem.offset =
+		sst_dsp_get_offset(dsp, dsp->scratch_offset, SST_MEM_DRAM);
+	stream->request.scratch_mem.size = dsp->scratch_size;
+
+	dev_dbg(hsw->dev, "module %d runtime %d using:\n", module->id,
+		runtime->id);
+	dev_dbg(hsw->dev, " persistent offset 0x%x bytes 0x%x\n",
+		stream->request.persistent_mem.offset,
+		stream->request.persistent_mem.size);
+	dev_dbg(hsw->dev, " scratch offset 0x%x bytes 0x%x\n",
+		stream->request.scratch_mem.offset,
+		stream->request.scratch_mem.size);
 
 	return 0;
 }
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index f474f99..fe6e63f 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -433,8 +433,7 @@ int sst_hsw_stream_set_map_config(struct sst_hsw *hsw,
 int sst_hsw_stream_set_style(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
 	enum sst_hsw_interleaving style);
 int sst_hsw_stream_set_module_info(struct sst_hsw *hsw,
-	struct sst_hsw_stream *stream, enum sst_hsw_module_id module_id,
-	u32 entry_point);
+	struct sst_hsw_stream *stream, struct sst_module_runtime *runtime);
 int sst_hsw_stream_set_pmemory_info(struct sst_hsw *hsw,
 	struct sst_hsw_stream *stream, u32 offset, u32 size);
 int sst_hsw_stream_set_smemory_info(struct sst_hsw *hsw,
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 3690cf7..522edef 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -105,6 +105,7 @@ struct hsw_pcm_data {
 	unsigned int wpos;
 	struct mutex mutex;
 	bool allocated;
+	int persistent_offset;
 };
 
 /* private data for the driver */
@@ -478,28 +479,8 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* we use hardcoded memory offsets atm, will be updated for new FW */
-	if (stream_type == SST_HSW_STREAM_TYPE_CAPTURE) {
-		sst_hsw_stream_set_module_info(hsw, pcm_data->stream,
-			SST_HSW_MODULE_PCM_CAPTURE, module_data->entry);
-		sst_hsw_stream_set_pmemory_info(hsw, pcm_data->stream,
-			0x449400, 0x4000);
-		sst_hsw_stream_set_smemory_info(hsw, pcm_data->stream,
-			0x400000, 0);
-	} else { /* stream_type == SST_HSW_STREAM_TYPE_SYSTEM */
-		sst_hsw_stream_set_module_info(hsw, pcm_data->stream,
-			SST_HSW_MODULE_PCM_SYSTEM, module_data->entry);
-
-		sst_hsw_stream_set_pmemory_info(hsw, pcm_data->stream,
-			module_data->offset, module_data->size);
-		sst_hsw_stream_set_pmemory_info(hsw, pcm_data->stream,
-			0x44d400, 0x3800);
-
-		sst_hsw_stream_set_smemory_info(hsw, pcm_data->stream,
-			module_data->offset, module_data->size);
-		sst_hsw_stream_set_smemory_info(hsw, pcm_data->stream,
-			0x400000, 0);
-	}
+	sst_hsw_stream_set_module_info(hsw, pcm_data->stream,
+		pcm_data->runtime);
 
 	ret = sst_hsw_stream_commit(hsw, pcm_data->stream);
 	if (ret < 0) {
@@ -679,9 +660,11 @@ static int hsw_pcm_create_modules(struct hsw_priv_data *pdata)
 		pcm_data = &pdata->pcm[i];
 
 		pcm_data->runtime = sst_hsw_runtime_module_create(hsw,
-			mod_map[i].mod_id);
+			mod_map[i].mod_id, pcm_data->persistent_offset);
 		if (pcm_data->runtime == NULL)
 			goto err;
+		pcm_data->persistent_offset =
+			pcm_data->runtime->persistent_offset;
 	}
 
 	return 0;
-- 
1.9.1
