From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Kbl: Add Playback DAI for fixup"
	to the asoc tree
Date: Wed, 27 Sep 2017 18:10:19 +0100 (BST)
Message-ID: <20170927171019.B4FC6440055@finisterre.ee.mobilebroadband>
References: <1506462122-23828-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DD745267291
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 19:10:58 +0200 (CEST)
In-Reply-To: <1506462122-23828-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Kbl: Add Playback DAI for fixup

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

>From 4b2b915f8887e5602a98b1da4fcb7c41c573cb13 Mon Sep 17 00:00:00 2001
From: Harsha Priya N <harshapriya.n@intel.com>
Date: Tue, 26 Sep 2017 22:35:13 -0700
Subject: [PATCH] ASoC: Intel: Kbl: Add Playback DAI for fixup

'Kbl Audio Headset Playback' FE DAI also needs SSP hw param fix.
Add this dai also to be handled in kabylake_ssp_fixup() call.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 88ff54220007..e7672831bc49 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -302,6 +302,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
 	 */
 	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
+	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
 	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
 		rate->min = rate->max = 48000;
 		channels->min = channels->max = 2;
-- 
2.14.1
