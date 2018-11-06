From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: add SOF information for
	APL RVP" to the asoc tree
Date: Tue,  6 Nov 2018 17:56:10 +0000 (GMT)
Message-ID: <20181106175610.9E3A5112266B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 26F202678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:56:15 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard liao <bard.liao@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: add SOF information for APL RVP

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

>From 97bb91ae2f3325fd06ea2c28fb8b5b4e023b4b5d Mon Sep 17 00:00:00 2001
From: Bard liao <bard.liao@intel.com>
Date: Thu, 1 Nov 2018 16:34:53 -0500
Subject: [PATCH] ASoC: Intel: common: add SOF information for APL RVP

Add firmware/topology information for APL RVP

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bard liao <bard.liao@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index f39386e540d3..2756fa4ab552 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -19,6 +19,9 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 		.id = "INT343A",
 		.drv_name = "bxt_alc298s_i2s",
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
+		.sof_fw_filename = "intel/sof-apl.ri",
+		.sof_tplg_filename = "intel/sof-apl-rt298.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
 		.id = "DLGS7219",
-- 
2.19.0.rc2
