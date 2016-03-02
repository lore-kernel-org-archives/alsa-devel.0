From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add IVI feedback path
	in nau88125_ssm4567 machine" to the asoc tree
Date: Wed, 02 Mar 2016 13:00:43 +0900
Message-ID: <E1aaxxr-0003bV-0h@finisterre>
References: <1456799352-22653-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 23E6026155D
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 05:00:48 +0100 (CET)
In-Reply-To: <1456799352-22653-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add IVI feedback path in nau88125_ssm4567 machine

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

>From 5188b95a60ce33d5445833f9b0a374a2ad3200f4 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 1 Mar 2016 07:59:11 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add IVI feedback path in
 nau88125_ssm4567 machine

We can enable the IVI feedback path by connecting Left/Right
speaker sensors (codec) to  ssp0 Rx (soc-dsp). This way aDSP gets
feedback data from codec to DSP algorithms

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index a75c09343f84..f6a672c55be9 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -132,6 +132,8 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 
 	/* IV feedback path */
 	{ "codec0_lp_in", NULL, "ssp0 Rx"},
+	{ "ssp0 Rx", NULL, "Left Capture Sense" },
+	{ "ssp0 Rx", NULL, "Right Capture Sense" },
 
 	{ "Playback", NULL, "ssp1 Tx"},
 	{ "ssp1 Tx", NULL, "codec1_out"},
@@ -534,6 +536,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = skylake_ssp_fixup,
 		.dpcm_playback = 1,
+		.dpcm_capture = 1,
 	},
 	{
 		/* SSP1 - Codec */
-- 
2.7.0
