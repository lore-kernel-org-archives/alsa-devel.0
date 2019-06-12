From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/5] ASoC: SOF: uapi: align comments with
	firmware files
Date: Wed, 12 Jun 2019 11:57:02 -0500
Message-ID: <20190612165705.1858-3-pierre-louis.bossart@linux.intel.com>
References: <20190612165705.1858-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF3A7F896CE
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 18:57:13 +0200 (CEST)
In-Reply-To: <20190612165705.1858-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

No functional change, just mirror firmware comment changes

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/topology.h | 4 ++--
 include/sound/sof/trace.h    | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
index 4978999fd362..41dcabf89899 100644
--- a/include/sound/sof/topology.h
+++ b/include/sound/sof/topology.h
@@ -84,9 +84,9 @@ struct sof_ipc_buffer {
 struct sof_ipc_comp_config {
 	struct sof_ipc_cmd_hdr hdr;
 	uint32_t periods_sink;	/**< 0 means variable */
-	uint32_t periods_source;	/**< 0 means variable */
+	uint32_t periods_source;/**< 0 means variable */
 	uint32_t reserved1;	/**< reserved */
-	uint32_t frame_fmt;		/**< SOF_IPC_FRAME_ */
+	uint32_t frame_fmt;	/**< SOF_IPC_FRAME_ */
 	uint32_t xrun_action;
 
 	/* reserved for future use */
diff --git a/include/sound/sof/trace.h b/include/sound/sof/trace.h
index 2187ff7d07ce..9257d5473d97 100644
--- a/include/sound/sof/trace.h
+++ b/include/sound/sof/trace.h
@@ -66,7 +66,9 @@ struct sof_ipc_dma_trace_posn {
 #define SOF_IPC_PANIC_WFI			(SOF_IPC_PANIC_MAGIC | 0xa)
 #define SOF_IPC_PANIC_ASSERT			(SOF_IPC_PANIC_MAGIC | 0xb)
 
-/* panic info include filename and line number */
+/* panic info include filename and line number
+ * filename array will not include null terminator if fully filled
+ */
 struct sof_ipc_panic_info {
 	struct sof_ipc_hdr hdr;
 	uint32_t code;			/* SOF_IPC_PANIC_ */
-- 
2.20.1
