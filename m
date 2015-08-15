From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: fix runtime pm imbalance on
	error" to the asoc tree
Date: Fri, 14 Aug 2015 19:13:38 -0700
Message-ID: <E1ZQQyY-0004MM-Bp@finisterre>
References: <1437100140-5048-1-git-send-email-junjie.mao@enight.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C49882665EB
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:13:47 +0200 (CEST)
In-Reply-To: <1437100140-5048-1-git-send-email-junjie.mao@enight.me>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Junjie Mao <junjie.mao@enight.me>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: fix runtime pm imbalance on error

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

>From e1d46d30d133e7909e7dde06a4e867225c7e079b Mon Sep 17 00:00:00 2001
From: Junjie Mao <junjie.mao@enight.me>
Date: Fri, 17 Jul 2015 10:29:00 +0800
Subject: [PATCH] ASoC: Intel: fix runtime pm imbalance on error

pm_runtime_get_sync() increments the runtime PM usage counter even the
call returns an error code. Thus a pairing decrement is needed on the
error handling path to keep the counter balanced.

Signed-off-by: Junjie Mao <junjie.mao@enight.me>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_drv_interface.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 620da1d..27a9653 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -152,6 +152,7 @@ static int sst_power_control(struct device *dev, bool state)
 
 		dev_dbg(ctx->dev, "Enable: pm usage count: %d\n", usage_count);
 		if (ret < 0) {
+			pm_runtime_put_sync(dev);
 			dev_err(ctx->dev, "Runtime get failed with err: %d\n", ret);
 			return ret;
 		}
@@ -204,8 +205,10 @@ static int sst_cdev_open(struct device *dev,
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
 
 	retval = pm_runtime_get_sync(ctx->dev);
-	if (retval < 0)
+	if (retval < 0) {
+		pm_runtime_put_sync(ctx->dev);
 		return retval;
+	}
 
 	str_id = sst_get_stream(ctx, str_params);
 	if (str_id > 0) {
@@ -672,8 +675,10 @@ static int sst_send_byte_stream(struct device *dev,
 	if (NULL == bytes)
 		return -EINVAL;
 	ret_val = pm_runtime_get_sync(ctx->dev);
-	if (ret_val < 0)
+	if (ret_val < 0) {
+		pm_runtime_put_sync(ctx->dev);
 		return ret_val;
+	}
 
 	ret_val = sst_send_byte_stream_mrfld(ctx, bytes);
 	sst_pm_runtime_put(ctx);
-- 
2.5.0
