From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: Fix some style" to the asoc tree
Date: Mon, 08 Jan 2018 16:23:19 +0000
Message-ID: <E1eYaCl-0002Fz-89@debutante>
References: <20180106201855.6131-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180106201855.6131-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: Fix some style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 25f3fd043ec1f60f3955f9d7277d97e2f9c1612c Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 6 Jan 2018 21:18:55 +0100
Subject: [PATCH] ASoC: Intel: sst: Fix some style

This patch fixes 3 small issues:
 - missing 2nd '*' at the beginning of a doxygen comment
 - extra space after a '\n' in a dev_dbg message
 - extra tab before a 'return" statement

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_stream.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index 20f5066fefb9..7ee6aeb7e0af 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -223,7 +223,7 @@ int sst_send_byte_stream_mrfld(struct intel_sst_drv *sst_drv_ctx,
 	return ret;
 }
 
-/*
+/**
  * sst_pause_stream - Send msg for a pausing stream
  * @str_id:	 stream ID
  *
@@ -261,7 +261,7 @@ int sst_pause_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
 		}
 	} else {
 		retval = -EBADRQC;
-		dev_dbg(sst_drv_ctx->dev, "SST DBG:BADRQC for stream\n ");
+		dev_dbg(sst_drv_ctx->dev, "SST DBG:BADRQC for stream\n");
 	}
 
 	return retval;
@@ -284,7 +284,7 @@ int sst_resume_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
 	if (!str_info)
 		return -EINVAL;
 	if (str_info->status == STREAM_RUNNING)
-			return 0;
+		return 0;
 	if (str_info->status == STREAM_PAUSED) {
 		retval = sst_prepare_and_post_msg(sst_drv_ctx, str_info->task_id,
 				IPC_CMD, IPC_IA_RESUME_STREAM_MRFLD,
-- 
2.15.1
