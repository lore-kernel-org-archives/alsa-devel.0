From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Fix logical inversion in set_link_hw_format()" to the asoc tree
Date: Mon, 26 Feb 2018 11:17:19 +0000
Message-ID: <E1eqGmV-0005Rk-Jt@debutante>
References: <1519336888-71831-1-git-send-email-xiuli.pan@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1519336888-71831-1-git-send-email-xiuli.pan@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, xiuli.pan@intel.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Fix logical inversion in set_link_hw_format()

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

>From 7f34c3f38e9666216fda155b6ebededd1073f5aa Mon Sep 17 00:00:00 2001
From: Pan Xiuli <xiuli.pan@linux.intel.com>
Date: Fri, 23 Feb 2018 06:01:28 +0800
Subject: [PATCH] ASoC: topology: Fix logical inversion in set_link_hw_format()

The master/slave conventions are wrt. the codec. The topology code
contains a logical inversion, fix to follow ASoC usage.

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 01a50413c66f..5f507993c43e 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1996,11 +1996,11 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
 		/* clock masters */
 		bclk_master = hw_config->bclk_master;
 		fsync_master = hw_config->fsync_master;
-		if (!bclk_master && !fsync_master)
+		if (bclk_master && fsync_master)
 			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
-		else if (bclk_master && !fsync_master)
-			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
 		else if (!bclk_master && fsync_master)
+			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
+		else if (bclk_master && !fsync_master)
 			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
 		else
 			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
-- 
2.16.1
