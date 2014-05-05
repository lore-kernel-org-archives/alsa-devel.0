From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/8] ASoC: Intel: mark sst_set_stream_status
	as non static
Date: Mon,  5 May 2014 22:19:20 +0530
Message-ID: <1399308565-14620-4-git-send-email-vinod.koul@intel.com>
References: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E471261987
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 19:02:53 +0200 (CEST)
In-Reply-To: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

as this will be used in compressed split file in subsequent patch

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |    2 +-
 sound/soc/intel/sst-mfld-platform.h     |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index ec499ae..3600003 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -156,7 +156,7 @@ static const struct snd_soc_component_driver sst_component = {
 };
 
 /* helper functions */
-static inline void sst_set_stream_status(struct sst_runtime_stream *stream,
+void sst_set_stream_status(struct sst_runtime_stream *stream,
 					int state)
 {
 	unsigned long flags;
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 5bf8f9d..1005f55 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -142,6 +142,7 @@ struct sst_device {
 	struct compress_sst_ops *compr_ops;
 };
 
+void sst_set_stream_status(struct sst_runtime_stream *stream, int state);
 int sst_register_dsp(struct sst_device *sst);
 int sst_unregister_dsp(struct sst_device *sst);
 #endif
-- 
1.7.0.4
