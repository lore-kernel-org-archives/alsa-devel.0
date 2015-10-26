From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: Use #ifdef instead of #if for
	CONFIG_PM_SLEEP" to the asoc tree
Date: Mon, 26 Oct 2015 11:08:40 +0900
Message-ID: <E1ZqXDE-0007Xo-HM@finisterre>
References: <1445554600-43889-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2570C26044B
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 03:08:57 +0100 (CET)
In-Reply-To: <1445554600-43889-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: Use #ifdef instead of #if for CONFIG_PM_SLEEP

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

>From 739146b6144a6541cf94a668d6e7227b7882af30 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Thu, 22 Oct 2015 15:56:40 -0700
Subject: [PATCH] ASoC: fsl: Use #ifdef instead of #if for CONFIG_PM_SLEEP

Change them to #ifdef as CONFIG_PM_SLEEP might not be defined at all.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 sound/soc/fsl/fsl_sai.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index aab675a..59f234e 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -900,7 +900,7 @@ static const struct of_device_id fsl_esai_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
 
-#if CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 static int fsl_esai_suspend(struct device *dev)
 {
 	struct fsl_esai *esai = dev_get_drvdata(dev);
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 38505f3..a4435f5 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -806,7 +806,7 @@ static const struct of_device_id fsl_sai_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
 
-#if CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 static int fsl_sai_suspend(struct device *dev)
 {
 	struct fsl_sai *sai = dev_get_drvdata(dev);
-- 
2.6.1
