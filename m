From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/7] ASoC: Intel: mrlfd - add generic parameter
	interface
Date: Wed,  9 Jul 2014 14:57:51 +0530
Message-ID: <1404898076-1882-4-git-send-email-vinod.koul@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 331492625CF
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 11:30:15 +0200 (CEST)
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

This interface will be used by subsequent patches to set/get parameters from DSP

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 9dc962f..6c6a42c 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -63,7 +63,9 @@ enum sst_controls {
 	SST_SND_BUFFER_POINTER =	0x05,
 	SST_SND_STREAM_INIT =		0x06,
 	SST_SND_START	 =		0x07,
-	SST_MAX_CONTROLS =		0x07,
+	SST_SET_BYTE_STREAM =           0x100A,
+	SST_GET_BYTE_STREAM =           0x100B,
+	SST_MAX_CONTROLS = SST_GET_BYTE_STREAM,
 };
 
 enum sst_stream_ops {
@@ -127,6 +129,7 @@ struct compress_sst_ops {
 struct sst_ops {
 	int (*open) (struct snd_sst_params *str_param);
 	int (*device_control) (int cmd, void *arg);
+	int (*set_generic_params)(enum sst_controls cmd, void *arg);
 	int (*close) (unsigned int str_id);
 };
 
-- 
1.7.0.4
