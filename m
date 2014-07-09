From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/7] ASoC: Intel: mfld: add dsp error codes
Date: Wed,  9 Jul 2014 14:57:50 +0530
Message-ID: <1404898076-1882-3-git-send-email-vinod.koul@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 462B32625FE
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 11:30:12 +0200 (CEST)
In-Reply-To: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

DSP returns error codes for IPC return so add them in driver

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-dsp.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-dsp.h b/sound/soc/intel/sst-mfld-dsp.h
index 2c88785..4257263 100644
--- a/sound/soc/intel/sst-mfld-dsp.h
+++ b/sound/soc/intel/sst-mfld-dsp.h
@@ -171,6 +171,21 @@ enum stream_type {
 	SST_STREAM_TYPE_MUSIC = 1,
 };
 
+enum sst_error_codes {
+	/* Error code,response to msgId: Description */
+	/* Common error codes */
+	SST_SUCCESS = 0,        /* Success */
+	SST_ERR_INVALID_STREAM_ID = 1,
+	SST_ERR_INVALID_MSG_ID = 2,
+	SST_ERR_INVALID_STREAM_OP = 3,
+	SST_ERR_INVALID_PARAMS = 4,
+	SST_ERR_INVALID_CODEC = 5,
+	SST_ERR_INVALID_MEDIA_TYPE = 6,
+	SST_ERR_STREAM_ERR = 7,
+
+	SST_ERR_STREAM_IN_USE = 15,
+};
+
 struct ipc_dsp_hdr {
 	u16 mod_index_id:8;		/*!< DSP Command ID specific to tasks */
 	u16 pipe_id:8;	/*!< instance of the module in the pipeline */
-- 
1.7.0.4
