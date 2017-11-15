From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add help text for
	SND_SOC_INTEL_SST_TOPLEVEL" to the asoc tree
Date: Wed, 15 Nov 2017 11:44:35 +0000
Message-ID: <E1eEw7P-00068k-76@debutante>
References: <1510720862-12507-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 717C1266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 12:44:46 +0100 (CET)
In-Reply-To: <1510720862-12507-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add help text for SND_SOC_INTEL_SST_TOPLEVEL

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

>From 20a52c059be2eb470db75076d55e1d932173fcc3 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 15 Nov 2017 10:11:02 +0530
Subject: [PATCH] ASoC: Intel: Add help text for SND_SOC_INTEL_SST_TOPLEVEL

Symbol SND_SOC_INTEL_SST_TOPLEVEL is user selectable so add the
help text for this symbol.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index bb8be10b8437..7b49d04e3c60 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -34,6 +34,11 @@ config SND_SOC_INTEL_SST_TOPLEVEL
 	depends on X86 || COMPILE_TEST
 	select SND_SOC_INTEL_MACH
 	select SND_SOC_INTEL_COMMON
+	help
+          Intel ASoC Audio Drivers. If you have a Intel machine that
+          has audio controller with a DSP and I2S or DMIC port, then
+          enable this option by saying Y or M
+          If unsure select "N".
 
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
-- 
2.15.0
