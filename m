From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Boards: Add 4-channel DMIC
	fixup." to the asoc tree
Date: Tue, 06 Jun 2017 20:05:28 +0100
Message-ID: <E1dIJnE-00072P-7X@debutante>
References: <1495768803-24217-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04988266FEC
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 21:05:47 +0200 (CEST)
In-Reply-To: <1495768803-24217-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, "Kranthikumar,
 GudishaX" <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Boards: Add 4-channel DMIC fixup.

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

>From e8883cb61aa0a91980222e5e9d114100783eb7e2 Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Wed, 31 May 2017 10:30:26 +0530
Subject: [PATCH] ASoC: Intel: Boards: Add 4-channel DMIC fixup.

This patch adds a 4-channel dmic fixup so that DMIC copier will receive
4 channel data and further selection will be done by mic-select module.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 1a68d043c803..36ee7480e9f1 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -222,16 +222,13 @@ static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
-	if (params_channels(params) == 2)
-		channels->min = channels->max = 2;
-	else
-		channels->min = channels->max = 4;
+	channels->min = channels->max = 4;
 
 	return 0;
 }
 
 static unsigned int channels_dmic[] = {
-	2, 4,
+	1, 2, 3, 4,
 };
 
 static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
-- 
2.11.0
