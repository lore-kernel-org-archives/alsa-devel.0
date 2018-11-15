From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: Fixed build errors" to the asoc tree
Date: Thu, 15 Nov 2018 19:46:45 +0000 (GMT)
Message-ID: <20181115194645.CFE8D440078@finisterre.ee.mobilebroadband>
References: <1542298434-17287-1-git-send-email-Vijendar.Mukunda@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542298434-17287-1-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Vijendar Mukunda <vijendar.mukunda@amd.com>, Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC, AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: Fixed build errors

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

>From 1c4fb2457e541c614792e6d9986bc95461e67e41 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Thu, 15 Nov 2018 21:43:49 +0530
Subject: [PATCH] ASoC: amd: Fixed build errors

Fixed build errors.
- Implicit declaration of pci_enable_msi() & pci_disable_msi()
api's for openrisc architecture.
- type defaults to 'int' in declaration of 'module_pci_driver'

Enabled build for x86 architecture.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 5f3b56087ba1..33ebec990c2f 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -22,5 +22,6 @@ config SND_SOC_AMD_CZ_RT5645_MACH
 
 config SND_SOC_AMD_ACP3x
 	tristate "AMD Audio Coprocessor-v3.x support"
+	depends on X86 && PCI
 	help
 	 This option enables ACP v3.x I2S support on AMD platform
-- 
2.19.1
