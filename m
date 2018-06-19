From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: add firmware/topology
	information for SOF" to the asoc tree
Date: Tue, 19 Jun 2018 16:24:35 +0100
Message-ID: <E1fVIUl-0002NI-Gq@debutante>
References: <20180618182942.4925-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D23952676B4
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 17:24:38 +0200 (CEST)
In-Reply-To: <20180618182942.4925-6-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: common: add firmware/topology information for SOF

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

>From e6d298fd4a4454dd121343323e3f00a27f8819a4 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 18 Jun 2018 13:29:39 -0500
Subject: [PATCH] ASoC: Intel: common: add firmware/topology information for
 SOF

No functionality change for Skylake driver, add relevant names needed
by SOF for BXT/APL, GLK and CNL.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c | 3 +++
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c | 3 +++
 sound/soc/intel/common/soc-acpi-intel-glk-match.c | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 569f1de97e82..50869eddbb3b 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -26,6 +26,9 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &bxt_codecs,
+		.sof_fw_filename = "intel/sof-apl.ri",
+		.sof_tplg_filename = "intel/sof-apl-da7219.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{},
 };
diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
index b83ee053d417..ec8e28e7b937 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
@@ -20,6 +20,9 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[] = {
 		.drv_name = "cnl_rt274",
 		.fw_filename = "intel/dsp_fw_cnl.bin",
 		.pdata = &cnl_pdata,
+		.sof_fw_filename = "intel/sof-cnl.ri",
+		.sof_tplg_filename = "intel/sof-cnl-rt274.tplg",
+		.asoc_plat_name = "0000:00:1f.3",
 	},
 	{},
 };
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 5902aa1d0ee3..305875af71ca 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -19,6 +19,9 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 		.id = "INT343A",
 		.drv_name = "glk_alc298s_i2s",
 		.fw_filename = "intel/dsp_fw_glk.bin",
+		.sof_fw_filename = "intel/sof-glk.ri",
+		.sof_tplg_filename = "intel/sof-glk-alc298.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
 		.id = "DLGS7219",
@@ -26,6 +29,9 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 		.fw_filename = "intel/dsp_fw_glk.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &glk_codecs,
+		.sof_fw_filename = "intel/sof-glk.ri",
+		.sof_tplg_filename = "intel/sof-glk-da7219.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{},
 };
-- 
2.17.1
