From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/8] ASoC: Intel: common: add firmware/topology
	information for SOF
Date: Mon, 18 Jun 2018 13:29:39 -0500
Message-ID: <20180618182942.4925-6-pierre-louis.bossart@linux.intel.com>
References: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 55A95266E91
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 20:29:51 +0200 (CEST)
In-Reply-To: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

No functionality change for Skylake driver, add relevant names needed
by SOF for BXT/APL, GLK and CNL.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.14.1
