From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: add entries for
	SOF-based machine drivers" to the asoc tree
Date: Tue, 19 Jun 2018 16:24:33 +0100
Message-ID: <E1fVIUj-0002MP-Bf@debutante>
References: <20180618182942.4925-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E5D42673CF
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 17:24:36 +0200 (CEST)
In-Reply-To: <20180618182942.4925-8-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: add entries for SOF-based machine drivers

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

>From b45350135b9241b64cc91ccc8dddca2ee4dc25d7 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 18 Jun 2018 13:29:41 -0500
Subject: [PATCH] ASoC: Intel: common: add entries for SOF-based machine
 drivers

While we are at it, add entries for machine drivers that are used on
SOF-based platforms. The drivers will be submitted upstream after the
core SOF patches, but there's no harm in adding these references now.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../intel/common/soc-acpi-intel-bxt-match.c   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 50869eddbb3b..f39386e540d3 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -30,6 +30,27 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 		.sof_tplg_filename = "intel/sof-apl-da7219.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
 	},
+	{
+		.id = "104C5122",
+		.drv_name = "bxt-pcm512x",
+		.sof_fw_filename = "intel/sof-apl.ri",
+		.sof_tplg_filename = "intel/sof-apl-pcm512x.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
+	},
+	{
+		.id = "1AEC8804",
+		.drv_name = "bxt-wm8804",
+		.sof_fw_filename = "intel/sof-apl.ri",
+		.sof_tplg_filename = "intel/sof-apl-wm8804.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
+	},
+	{
+		.id = "INT34C3",
+		.drv_name = "bxt_tdf8532",
+		.sof_fw_filename = "intel/sof-apl.ri",
+		.sof_tplg_filename = "intel/sof-apl-tdf8532.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_bxt_machines);
-- 
2.17.1
