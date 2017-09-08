From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 5/8] ASoC: Intel: add SOF firmare/topology
	file information
Date: Fri,  8 Sep 2017 15:56:59 -0500
Message-ID: <20170908205702.1985-6-pierre-louis.bossart@linux.intel.com>
References: <20170908205702.1985-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AFC2266E41
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 22:57:18 +0200 (CEST)
In-Reply-To: <20170908205702.1985-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

Prepare for SOF integration, no functional change

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-match.c | 79 ++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-match.c b/sound/soc/intel/common/soc-acpi-intel-match.c
index 3b94816..a6687ff 100644
--- a/sound/soc/intel/common/soc-acpi-intel-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-match.c
@@ -116,6 +116,9 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[] = {
 		.id = "INT33CA",
 		.drv_name = "haswell-audio",
 		.fw_filename = "intel/IntcSST1.bin",
+		.sof_fw_filename = "intel/reef-hsw.ri",
+		.sof_tplg_filename = "intel/reef-hsw.tplg",
+		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
 };
@@ -126,12 +129,24 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.id = "INT343A",
 		.drv_name = "broadwell-audio",
 		.fw_filename =  "intel/IntcSST2.bin",
+		.sof_fw_filename = "intel/reef-bdw.ri",
+		.sof_tplg_filename = "intel/reef-bdw-rt286.tplg",
+		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "RT5677CE",
 		.drv_name = "bdw-rt5677",
 		.fw_filename =  "intel/IntcSST2.bin",
+		.sof_fw_filename = "intel/reef-bdw.ri",
+		.sof_tplg_filename = "intel/reef-bdw-rt286.tplg",
+		.asoc_plat_name = "haswell-pcm-audio",
 	},
+
+	/* FIXME: this was in SOF code but is this right ?
+	{ "INT33CA", "haswell-audio", "intel/reef-bdw.ri",
+		"intel/reef-bdw-rt5640.tplg", "haswell-pcm-audio",
+		&snd_sof_bdw_ops },
+	 */
 	{}
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_broadwell_machines);
@@ -158,36 +173,54 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
 		.machine_quirk = byt_quirk,
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5640.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5642",
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5640.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "INTCCFFD",
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5640.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5651",
 		.drv_name = "bytcr_rt5651",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5651",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5651.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7212",
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcht_da7213",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-da7213.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7213",
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcht_da7213",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-da7213.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
 	{
@@ -195,12 +228,18 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5645.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5648",
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5645.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* use CHT driver to Baytrail Chromebooks */
 	{
@@ -208,7 +247,9 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "cht-bsw-max98090",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
-		.pdata = &byt_rvp_platform_data
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-max98090.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
@@ -233,54 +274,81 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5670.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5672",
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5670.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5645",
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5650",
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC3270",
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "193C9890",
 		.drv_name = "cht-bsw-max98090",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-max98090.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7212",
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-da7213.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7213",
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-da7213.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "ESSX8316",
 		.drv_name = "bytcht_es8316",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_es8316",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-es8316.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{
@@ -289,12 +357,18 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
 		.machine_quirk = cht_quirk,
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5640.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC3276",
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5640.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
 	{
@@ -302,6 +376,9 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcr_rt5651",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5651",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5651.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
-- 
2.9.3
