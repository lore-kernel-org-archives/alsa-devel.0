From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: Remove unused STREAM_DECODE
	and STREAM_RESET states" to the asoc tree
Date: Thu, 01 Mar 2018 18:07:14 +0000
Message-ID: <E1erSbq-0005xL-7s@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 685C4267B5D
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:07:16 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: Remove unused STREAM_DECODE and STREAM_RESET states

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

>From de9833476de7eb1d4b8bdc599cbbd616fb0e1a28 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 18 Feb 2018 23:01:41 +0100
Subject: [PATCH] ASoC: Intel: sst: Remove unused STREAM_DECODE and
 STREAM_RESET states

STREAM_DECODE is completely unused, status == STREAM_RESET was checked
for, but never set, remove both.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.h               |  4 +---
 sound/soc/intel/atom/sst/sst_drv_interface.c | 19 -------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 164b0f674c20..f4fd442080b2 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -65,9 +65,7 @@ enum sst_stream_states {
 	STREAM_UN_INIT	= 0,	/* Freed/Not used stream */
 	STREAM_RUNNING	= 1,	/* Running */
 	STREAM_PAUSED	= 2,	/* Paused stream */
-	STREAM_DECODE	= 3,	/* stream is in decoding only state */
-	STREAM_INIT	= 4,	/* stream init, waiting for data */
-	STREAM_RESET	= 5,	/* force reset on recovery */
+	STREAM_INIT	= 3,	/* stream init, waiting for data */
 };
 
 enum sst_ram_type {
diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 71af5449be90..6a8b253c58d2 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -238,16 +238,7 @@ static int sst_cdev_close(struct device *dev, unsigned int str_id)
 		return -EINVAL;
 	}
 
-	if (stream->status == STREAM_RESET) {
-		dev_dbg(dev, "stream in reset state...\n");
-		stream->status = STREAM_UN_INIT;
-
-		retval = 0;
-		goto put;
-	}
-
 	retval = sst_free_stream(ctx, str_id);
-put:
 	stream->compr_cb_param = NULL;
 	stream->compr_cb = NULL;
 
@@ -256,7 +247,6 @@ static int sst_cdev_close(struct device *dev, unsigned int str_id)
 
 	dev_dbg(dev, "End\n");
 	return retval;
-
 }
 
 static int sst_cdev_ack(struct device *dev, unsigned int str_id,
@@ -486,16 +476,7 @@ static int sst_close_pcm_stream(struct device *dev, unsigned int str_id)
 		return -EINVAL;
 	}
 
-	if (stream->status == STREAM_RESET) {
-		/* silently fail here as we have cleaned the stream earlier */
-		dev_dbg(ctx->dev, "stream in reset state...\n");
-
-		retval = 0;
-		goto put;
-	}
-
 	retval = free_stream_context(ctx, str_id);
-put:
 	stream->pcm_substream = NULL;
 	stream->status = STREAM_UN_INIT;
 	stream->period_elapsed = NULL;
-- 
2.16.2
