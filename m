From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: Kill BUG_ON() usage" to the asoc
	tree
Date: Wed, 20 Sep 2017 04:47:46 -0700 (PDT)
Message-ID: <20170920114746.4A94B4400D3@finisterre.ee.mobilebroadband>
References: <20170907085918.4496-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7820A2674FD
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 13:47:47 +0200 (CEST)
In-Reply-To: <20170907085918.4496-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: Kill BUG_ON() usage

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

>From 89db6f9632e38b6b5cc7f23f4b67f74470319978 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 7 Sep 2017 10:59:18 +0200
Subject: [PATCH] ASoC: intel: Kill BUG_ON() usage

Don't use BUG_ON() for a non-critical sanity check on production
systems.  This patch either removes useless BUG_ON() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_loader.c | 1 -
 sound/soc/intel/atom/sst/sst_stream.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index 33917146d9c4..a686eef2cf7f 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -415,7 +415,6 @@ int sst_load_fw(struct intel_sst_drv *sst_drv_ctx)
 			return ret_val;
 	}
 
-	BUG_ON(!sst_drv_ctx->fw_in_mem);
 	block = sst_create_block(sst_drv_ctx, 0, FW_DWNL_ID);
 	if (block == NULL)
 		return -ENOMEM;
diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index 83d8dda15233..65e257b17a7e 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -45,7 +45,6 @@ int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 	void *data = NULL;
 
 	dev_dbg(sst_drv_ctx->dev, "Enter\n");
-	BUG_ON(!params);
 
 	str_params = (struct snd_sst_params *)params;
 	memset(&alloc_param, 0, sizeof(alloc_param));
-- 
2.13.2
