From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Enable mclk and ssp sclk
	early for rt5663" to the asoc tree
Date: Thu, 01 Mar 2018 18:07:07 +0000
Message-ID: <E1erSbj-0005v8-2w@debutante>
References: <1519008302-24432-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5524F267B64
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:07:24 +0100 (CET)
In-Reply-To: <1519008302-24432-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, broonie@kernel.org, Kevin Cheng <kevin.cheng@intel.com>, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl: Enable mclk and ssp sclk early for rt5663

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

>From 256ac58a7ea343600bd6d0e3df3eb7eebb2d65e0 Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Mon, 19 Feb 2018 08:15:02 +0530
Subject: [PATCH] ASoC: Intel: kbl: Enable mclk and ssp sclk early for rt5663

rt5663 requires mclk/sclk early to synchronize its internal clocks.
Enable these clocks early.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Kevin Cheng <kevin.cheng@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 3c9585eb6860..0e6b7e79441c 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -204,13 +204,18 @@ static const struct snd_soc_dapm_widget kabylake_5663_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_SPK("DP", NULL),
 	SND_SOC_DAPM_SPK("HDMI", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route kabylake_5663_map[] = {
+	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
 
 	/* other jacks */
+	{ "Headset Mic", NULL, "Platform Clock" },
 	{ "IN1P", NULL, "Headset Mic" },
 	{ "IN1N", NULL, "Headset Mic" },
 
-- 
2.16.2
