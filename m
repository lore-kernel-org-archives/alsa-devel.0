From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: remove unused 'ops'" to the
	asoc tree
Date: Thu, 15 Dec 2016 12:21:54 +0000
Message-ID: <E1cHV2o-0000wV-AA@debutante>
References: <1481218297-17568-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7221266333250892014=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B13ED266A53
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:22:00 +0100 (CET)
In-Reply-To: <1481218297-17568-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

--===============7221266333250892014==
Content-Type: text/plain

The patch

   ASoC: Intel: sst: remove unused 'ops'

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

>From cf90c8245bb0d528a8046b4bfa4f223320c9dbb0 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 8 Dec 2016 23:01:26 +0530
Subject: [PATCH] ASoC: Intel: sst: remove unused 'ops'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In sst_free_stream(), a variable 'ops' is initialized but
not used. So remove it.

sound/soc/intel/atom/sst/sst_stream.c: In function ‘sst_free_stream’:
sound/soc/intel/atom/sst/sst_stream.c:397:24: warning: variable ‘ops’ set but not used [-Wunused-but-set-variable]
  struct intel_sst_ops *ops;

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_stream.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index 51bdeeecb7c8..83d8dda15233 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -394,7 +394,6 @@ int sst_free_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
 {
 	int retval = 0;
 	struct stream_info *str_info;
-	struct intel_sst_ops *ops;
 
 	dev_dbg(sst_drv_ctx->dev, "SST DBG:sst_free_stream for %d\n", str_id);
 
@@ -407,7 +406,6 @@ int sst_free_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
 	str_info = get_stream_info(sst_drv_ctx, str_id);
 	if (!str_info)
 		return -EINVAL;
-	ops = sst_drv_ctx->ops;
 
 	mutex_lock(&str_info->lock);
 	if (str_info->status != STREAM_UN_INIT) {
-- 
2.11.0


--===============7221266333250892014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7221266333250892014==--
