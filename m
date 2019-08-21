From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 06/11] soundwire: cadence_master: improve PDI allocation
Date: Wed, 21 Aug 2019 15:05:16 -0500
Message-ID: <20190821200521.17283-7-pierre-louis.bossart@linux.intel.com>
References: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

PDI number should match dai->id, there is no need to track if a PDI is
allocated or not.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 27 ++++++++++++++-------------
 drivers/soundwire/cadence_master.h |  4 +---
 drivers/soundwire/intel.c          |  5 ++---
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 8510d4ee8044..1e8cc14fc2ec 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -875,7 +875,6 @@ static int cdns_allocate_pdi(struct sdw_cdns *cdns,
 
 	for (i = 0; i < num; i++) {
 		pdi[i].num = i + pdi_offset;
-		pdi[i].assigned = false;
 	}
 
 	*stream = pdi;
@@ -1229,21 +1228,20 @@ EXPORT_SYMBOL(cdns_set_sdw_stream);
  * @num: Number of PDIs
  * @pdi: PDI instances
  *
- * Find and return a free PDI for a given PDI array
+ * Find a PDI for a given PDI array. The PDI num and dai_id are
+ * expected to match, return NULL otherwise.
  */
 static struct sdw_cdns_pdi *cdns_find_pdi(struct sdw_cdns *cdns,
 					  unsigned int offset,
 					  unsigned int num,
-					  struct sdw_cdns_pdi *pdi)
+					  struct sdw_cdns_pdi *pdi,
+					  int dai_id)
 {
 	int i;
 
-	for (i = offset; i < num; i++) {
-		if (pdi[i].assigned)
-			continue;
-		pdi[i].assigned = true;
-		return &pdi[i];
-	}
+	for (i = offset; i < offset + num; i++)
+		if (pdi[i].num == dai_id)
+			return &pdi[i];
 
 	return NULL;
 }
@@ -1283,18 +1281,21 @@ EXPORT_SYMBOL(sdw_cdns_config_stream);
  */
 struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 					struct sdw_cdns_streams *stream,
-					u32 ch, u32 dir)
+					u32 ch, u32 dir, int dai_id)
 {
 	struct sdw_cdns_pdi *pdi = NULL;
 
 	if (dir == SDW_DATA_DIR_RX)
-		pdi = cdns_find_pdi(cdns, 0, stream->num_in, stream->in);
+		pdi = cdns_find_pdi(cdns, 0, stream->num_in, stream->in,
+				    dai_id);
 	else
-		pdi = cdns_find_pdi(cdns, 0, stream->num_out, stream->out);
+		pdi = cdns_find_pdi(cdns, 0, stream->num_out, stream->out,
+				    dai_id);
 
 	/* check if we found a PDI, else find in bi-directional */
 	if (!pdi)
-		pdi = cdns_find_pdi(cdns, 2, stream->num_bd, stream->bd);
+		pdi = cdns_find_pdi(cdns, 2, stream->num_bd, stream->bd,
+				    dai_id);
 
 	if (pdi) {
 		pdi->l_ch_num = 0;
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 43493fc3d2ee..001457cbe5ad 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -8,7 +8,6 @@
 /**
  * struct sdw_cdns_pdi: PDI (Physical Data Interface) instance
  *
- * @assigned: pdi assigned
  * @num: pdi number
  * @intel_alh_id: link identifier
  * @l_ch_num: low channel for PDI
@@ -18,7 +17,6 @@
  * @type: stream type, PDM or PCM
  */
 struct sdw_cdns_pdi {
-	bool assigned;
 	int num;
 	int intel_alh_id;
 	int l_ch_num;
@@ -155,7 +153,7 @@ int sdw_cdns_get_stream(struct sdw_cdns *cdns,
 			u32 ch, u32 dir);
 struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 					struct sdw_cdns_streams *stream,
-					u32 ch, u32 dir);
+					u32 ch, u32 dir, int dai_id);
 void sdw_cdns_config_stream(struct sdw_cdns *cdns,
 			    u32 ch, u32 dir, struct sdw_cdns_pdi *pdi);
 
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index e21c994d46b9..0001f433e848 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -700,11 +700,10 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	if (dma->stream_type == SDW_STREAM_PDM)
 		pcm = false;
 
-	/* FIXME: We would need to get PDI info from topology */
 	if (pcm)
-		pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir);
+		pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir, dai->id);
 	else
-		pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pdm, ch, dir);
+		pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pdm, ch, dir, dai->id);
 
 	if (!pdi) {
 		ret = -EINVAL;
-- 
2.20.1
