From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: pass correct parameter in
	sst_alloc_stream_mrfld()" to the asoc tree
Date: Sat, 21 Nov 2015 14:01:27 +0000
Message-ID: <E1a08jH-0001Bn-W1@finisterre>
References: <20151118100255.GA15236@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D3B9261AB7
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 15:01:44 +0100 (CET)
In-Reply-To: <20151118100255.GA15236@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Dinesh Mirche <dinesh.mirche@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: pass correct parameter in sst_alloc_stream_mrfld()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d16a2b9f2465b5486f830178fbfb7d203e0a17ae Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 18 Nov 2015 13:04:20 +0300
Subject: [PATCH] ASoC: Intel: pass correct parameter in
 sst_alloc_stream_mrfld()

"data" is always NULL in this function.  I think we should be passing
"&data" to sst_prepare_and_post_msg() instead of "data".

Fixes: 3d9ff34622ba ('ASoC: Intel: sst: add stream operations')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Tested-by: Dinesh Mirche <dinesh.mirche@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.6.1
