From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Add map for Maxim IV
	Feedback" to the asoc tree
Date: Tue, 29 Aug 2017 20:29:31 +0100 (BST)
Message-ID: <20170829192931.795894400E7@finisterre.ee.mobilebroadband>
References: <1503393562-31613-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 386B4267022
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 21:29:46 +0200 (CEST)
In-Reply-To: <1503393562-31613-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl: Add map for Maxim IV Feedback

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

>From 64220b9d10a5546b6dd1154ccaf43522ae7d02fc Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Sat, 26 Aug 2017 03:21:39 +0530
Subject: [PATCH] ASoC: Intel: kbl: Add map for Maxim IV Feedback

MAX98927 provides IV feedback on the capture widget.
Here we are connecting the capture widget to SSP0_RX and
SSP0_RX to the algorithm running on host.

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 5 +++++
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 3fa85c32b9f8..7f7607420706 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -105,6 +105,11 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "hs_in", NULL, "ssp1 Rx" },
 	{ "ssp1 Rx", NULL, "AIF Capture" },
 
+	/* IV feedback path */
+	{ "codec0_fb_in", NULL, "ssp0 Rx"},
+	{ "ssp0 Rx", NULL, "Left HiFi Capture" },
+	{ "ssp0 Rx", NULL, "Right HiFi Capture" },
+
 	/* DMIC */
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
 	{ "DMIC01 Rx", NULL, "DMIC AIF" },
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 11bd5ef1e3b2..4689991bcc86 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -117,6 +117,11 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "codec1_in", NULL, "ssp0 Rx" },
 	{ "ssp0 Rx", NULL, "AIF1 Capture" },
 
+	/* IV feedback path */
+	{ "codec0_fb_in", NULL, "ssp0 Rx"},
+	{ "ssp0 Rx", NULL, "Left HiFi Capture" },
+	{ "ssp0 Rx", NULL, "Right HiFi Capture" },
+
 	/* DMIC */
 	{ "DMIC1L", NULL, "DMIC" },
 	{ "DMIC1R", NULL, "DMIC" },
-- 
2.13.2
