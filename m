From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Disable clock gating
	during firmware and library download" to the asoc tree
Date: Wed, 03 Jan 2018 12:12:47 +0000
Message-ID: <E1eWhuZ-0001Zy-TN@debutante>
References: <20180102092957.14091-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DA63E2675F5
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 13:13:01 +0100 (CET)
In-Reply-To: <20180102092957.14091-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Disable clock gating during firmware and library download

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

>From d5cc0a1fcbb5ddbef9fdd4c4a978da3254ddbf37 Mon Sep 17 00:00:00 2001
From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Date: Tue, 2 Jan 2018 14:59:57 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Disable clock gating during firmware
 and library download

During firmware and library download, sometimes it is observed that
firmware and library download is timed-out resulting into probe failure.

This patch disables dynamic clock gating while firmware and library
download.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 4 ++++
 sound/soc/intel/skylake/skl-pcm.c      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 4e63213a8d55..933c1fbb222f 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -417,7 +417,11 @@ int skl_resume_dsp(struct skl *skl)
 	if (skl->skl_sst->is_first_boot == true)
 		return 0;
 
+	/* disable dynamic clock gating during fw and lib download */
+	ctx->enable_miscbdcge(ctx->dev, false);
+
 	ret = skl_dsp_wake(ctx->dsp);
+	ctx->enable_miscbdcge(ctx->dev, true);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index cc6535ab84d1..b45a9cd5f058 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1342,7 +1342,11 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 			return -EIO;
 		}
 
+		/* disable dynamic clock gating during fw and lib download */
+		skl->skl_sst->enable_miscbdcge(platform->dev, false);
+
 		ret = ops->init_fw(platform->dev, skl->skl_sst);
+		skl->skl_sst->enable_miscbdcge(platform->dev, true);
 		if (ret < 0) {
 			dev_err(platform->dev, "Failed to boot first fw: %d\n", ret);
 			return ret;
-- 
2.15.1
