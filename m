From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: Intel: pass correct parameter in
 sst_alloc_stream_mrfld()
Date: Wed, 18 Nov 2015 13:04:20 +0300
Message-ID: <20151118100255.GA15236@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"data" is always NULL in this function.  I think we should be passing
"&data" to sst_prepare_and_post_msg() instead of "data".

Fixes: 3d9ff34622ba ('ASoC: Intel: sst: add stream operations')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Not tested.

diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index a74c64c..4ccc80e 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -108,7 +108,7 @@ int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 			str_id, pipe_id);
 	ret = sst_prepare_and_post_msg(sst_drv_ctx, task_id, IPC_CMD,
 			IPC_IA_ALLOC_STREAM_MRFLD, pipe_id, sizeof(alloc_param),
-			&alloc_param, data, true, true, false, true);
+			&alloc_param, &data, true, true, false, true);
 
 	if (ret < 0) {
 		dev_err(sst_drv_ctx->dev, "FW alloc failed ret %d\n", ret);
