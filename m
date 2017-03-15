From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Remove BE prepare ops"
	to the asoc tree
Date: Wed, 15 Mar 2017 18:13:32 +0000
Message-ID: <E1coDQS-0002Hh-Qr@debutante>
References: <1488910446-26415-7-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EFBD32670BB
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:13:41 +0100 (CET)
In-Reply-To: <1488910446-26415-7-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Remove BE prepare ops

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

>From 3643ff10d48140a283d2e50c0e0a47f290cc3e4d Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 13 Mar 2017 22:11:28 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Remove BE prepare ops

Remove BE prepare ops which enables MCLK by default. If MCLK is required
to be enabled for any specific platform, it needs to be enabled in the
corresponding machine driver.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 635cbb1e7d91..e3d206d50f3e 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -262,23 +262,6 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int skl_be_prepare(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	struct skl *skl = get_skl_ctx(dai->dev);
-	struct skl_sst *ctx = skl->skl_sst;
-	struct skl_module_cfg *mconfig;
-
-	if (dai->playback_widget->power || dai->capture_widget->power)
-		return 0;
-
-	mconfig = skl_tplg_be_get_cpr_module(dai, substream->stream);
-	if (mconfig == NULL)
-		return -EINVAL;
-
-	return skl_dsp_set_dma_control(ctx, mconfig);
-}
-
 static int skl_pcm_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -649,7 +632,6 @@ static struct snd_soc_dai_ops skl_dmic_dai_ops = {
 
 static struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
 	.hw_params = skl_be_hw_params,
-	.prepare = skl_be_prepare,
 };
 
 static struct snd_soc_dai_ops skl_link_dai_ops = {
-- 
2.11.0
