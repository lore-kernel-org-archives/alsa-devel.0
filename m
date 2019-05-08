From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: xtensa: fix undefined references"
	to the asoc tree
Date: Wed,  8 May 2019 07:47:08 +0100 (BST)
Message-ID: <20190508064708.607E6440017@finisterre.sirena.org.uk>
References: <20190507163236.8783-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35272F8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 08:47:20 +0200 (CEST)
In-Reply-To: <20190507163236.8783-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, kbuild test robot <lkp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: xtensa: fix undefined references

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 78989ff8aeaddc183237da558ee07deee35fbbbd Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 7 May 2019 11:32:35 -0500
Subject: [PATCH] ASoC: SOF: xtensa: fix undefined references

The SND_SOC_INTEL_COMMON Kconfig was removed months ago from SOF
Kconfig files but is still selected instead of the correct
SND_SOC_SOF_INTEL_COMMON kconfig which does select xtensa stuff,
leading to the following errors.

ld: sound/soc/sof/sof-acpi-dev.o:(.rodata+0x120): undefined reference
to `sof_xtensa_arch_ops'
ld: sound/soc/sof/sof-acpi-dev.o:(.rodata+0x180): undefined reference
to `sof_xtensa_arch_ops'
ld: sound/soc/sof/sof-acpi-dev.o:(.rodata+0x1e0): undefined reference
to `sof_xtensa_arch_ops'

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 32ee0fabab92..603e0db4f012 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -36,7 +36,7 @@ config SND_SOC_SOF_INTEL_HIFI_EP_IPC
 
 config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
 	tristate
-	select SND_SOC_INTEL_COMMON
+	select SND_SOC_SOF_INTEL_COMMON
 	select SND_SOC_SOF_INTEL_HIFI_EP_IPC
 	help
 	  This option is not user-selectable but automagically handled by
-- 
2.20.1
