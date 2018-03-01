From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: Fix error-code check in
	sst_pause_stream()" to the asoc tree
Date: Thu, 01 Mar 2018 18:07:20 +0000
Message-ID: <E1erSbw-0005zY-Uh@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 19261267B6F
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:07:23 +0100 (CET)
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

   ASoC: Intel: sst: Fix error-code check in sst_pause_stream()

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

>From 6f5062773747b3d3eb9f957030ac1be98e983ac2 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 18 Feb 2018 23:01:38 +0100
Subject: [PATCH] ASoC: Intel: sst: Fix error-code check in sst_pause_stream()

The value returned by sst_prepare_and_post_msg() is a negated SST_ERR_*
value, so we must check for -SST_ERR_INVALID_STREAM_ID. Note that
sst_pause_resume() already has the correct check.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index 7ee6aeb7e0af..b082b0922a7a 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -253,7 +253,7 @@ int sst_pause_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
 		if (retval == 0) {
 			str_info->prev = str_info->status;
 			str_info->status = STREAM_PAUSED;
-		} else if (retval == SST_ERR_INVALID_STREAM_ID) {
+		} else if (retval == -SST_ERR_INVALID_STREAM_ID) {
 			retval = -EINVAL;
 			mutex_lock(&sst_drv_ctx->sst_lock);
 			sst_clean_stream(str_info);
-- 
2.16.2
