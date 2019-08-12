From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: skl-hda-dsp-generic: add
	dependency to dmic driver" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:49 +0100 (BST)
Message-ID: <20190812130949.D8FCC2740CED@ypsilon.sirena.org.uk>
References: <20190809232236.21182-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5259CF80518
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 15:09:58 +0200 (CEST)
In-Reply-To: <20190809232236.21182-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Keyon Jie <yang.jie@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: skl-hda-dsp-generic: add dependency to dmic driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 0181d2853126db0717de6bd5b3287f1c87faf7c3 Mon Sep 17 00:00:00 2001
From: Keyon Jie <yang.jie@linux.intel.com>
Date: Fri, 9 Aug 2019 18:22:35 -0500
Subject: [PATCH] ASoC: Intel: skl-hda-dsp-generic: add dependency to dmic
 driver

The hda generic machine actually has dependency on the dmic driver,
select SND_SOC_DMIC at the machine selected to fix it.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190809232236.21182-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 50bf149818b5..4a529cea0190 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -387,6 +387,7 @@ if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC || SND_SOC_SOF_HDA_AUDIO_CODEC
 config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
 	tristate "SKL/KBL/BXT/APL with HDA Codecs"
 	select SND_SOC_HDAC_HDMI
+	select SND_SOC_DMIC
 	# SND_SOC_HDAC_HDA is already selected
 	help
 	  This adds support for ASoC machine driver for Intel platforms
-- 
2.20.1
