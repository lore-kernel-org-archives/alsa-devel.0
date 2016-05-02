From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Prevent sending Set DMA
	Control IPC if the widget is "On"" to the asoc tree
Date: Mon, 02 May 2016 12:03:36 +0100
Message-ID: <E1axBdY-0001Wv-OB@debutante>
References: <1461849329-20364-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C00026043C
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 13:03:41 +0200 (CEST)
In-Reply-To: <1461849329-20364-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Dharageswari.R" <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Prevent sending Set DMA Control IPC if the widget is "On"

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

>From 1a13b1fafffd41c12a7068c4aa74f5a1d2210a07 Mon Sep 17 00:00:00 2001
From: "Dharageswari.R" <dharageswari.r@intel.com>
Date: Thu, 28 Apr 2016 18:45:27 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Prevent sending Set DMA Control IPC if
 the widget is "On"

If widget of a playback or capture DAI is already On, then no
need not send the Set DMA Control IPC message to firmware.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index dab0900eef26..4fcf5f830a8c 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -213,7 +213,7 @@ static int skl_be_prepare(struct snd_pcm_substream *substream,
 	struct skl_sst *ctx = skl->skl_sst;
 	struct skl_module_cfg *mconfig;
 
-	if ((dai->playback_active > 1) || (dai->capture_active > 1))
+	if (dai->playback_widget->power || dai->capture_widget->power)
 		return 0;
 
 	mconfig = skl_tplg_be_get_cpr_module(dai, substream->stream);
-- 
2.8.1
