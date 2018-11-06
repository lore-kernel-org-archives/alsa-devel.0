From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: remove GFP_ATOMIC,
	use GFP_KERNEL" to the asoc tree
Date: Tue,  6 Nov 2018 17:58:43 +0000 (GMT)
Message-ID: <20181106175843.6893A112266B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 330032678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:58:44 +0100 (CET)
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: remove GFP_ATOMIC, use GFP_KERNEL

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

>From 972b0d456e645ea8fd3fdc70f95f0e41c27c0870 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 1 Nov 2018 16:34:52 -0500
Subject: [PATCH] ASoC: Intel: remove GFP_ATOMIC, use GFP_KERNEL

GFP_ATOMIC is not required on any Intel drivers, use GFP_KERNEL
instead. A first cleanup was merged in April but missed a number
occurrences and new ones were added by copy/paste inertia.

While we are at it, make checkpatch happy with a sizeof(*msg)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_pvt.c            | 4 ++--
 sound/soc/intel/boards/cht_bsw_rt5672.c       | 2 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 2 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c  | 2 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c  | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index af93244b4868..00a37a09dc9b 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -166,11 +166,11 @@ int sst_create_ipc_msg(struct ipc_post **arg, bool large)
 {
 	struct ipc_post *msg;
 
-	msg = kzalloc(sizeof(struct ipc_post), GFP_ATOMIC);
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 	if (large) {
-		msg->mailbox_data = kzalloc(SST_MAILBOX_SIZE, GFP_ATOMIC);
+		msg->mailbox_data = kzalloc(SST_MAILBOX_SIZE, GFP_KERNEL);
 		if (!msg->mailbox_data) {
 			kfree(msg);
 			return -ENOMEM;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 51f0d45d6f8f..9de64f447e7b 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -403,7 +403,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	const char *i2c_name;
 	int i;
 
-	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index c4b94e2617c5..c74c4f17316f 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -603,7 +603,7 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 {
 	struct glk_card_private *ctx;
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 3bc78e3a91ee..58eb0fe69978 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -935,7 +935,7 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_codec_private *ctx;
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index b6f287fa9505..15c502d6774d 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -140,7 +140,7 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "%s: entry\n", __func__);
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-- 
2.19.0.rc2
