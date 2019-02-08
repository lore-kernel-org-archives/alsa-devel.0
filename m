From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 01/17] ASoC: Intel: bxt-match: remove prefix
	for SOF files
Date: Fri,  8 Feb 2019 17:45:41 -0600
Message-ID: <20190208234557.7816-2-pierre-louis.bossart@linux.intel.com>
References: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C571267A2E
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 00:46:05 +0100 (CET)
In-Reply-To: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
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

Prefix is now handled in the code. This allows for default and
alternate paths, and more flexibility for OEMs and distros

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-bxt-match.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 61dedc103b19..c0e5780e2ad1 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -51,8 +51,8 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 		.id = "INT343A",
 		.drv_name = "bxt_alc298s_i2s",
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
-		.sof_fw_filename = "intel/sof-apl.ri",
-		.sof_tplg_filename = "intel/sof-apl-rt298.tplg",
+		.sof_fw_filename = "sof-apl.ri",
+		.sof_tplg_filename = "sof-apl-rt298.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
@@ -61,30 +61,30 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &bxt_codecs,
-		.sof_fw_filename = "intel/sof-apl.ri",
-		.sof_tplg_filename = "intel/sof-apl-da7219.tplg",
+		.sof_fw_filename = "sof-apl.ri",
+		.sof_tplg_filename = "sof-apl-da7219.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
 		.id = "104C5122",
 		.drv_name = "bxt-pcm512x",
-		.sof_fw_filename = "intel/sof-apl.ri",
-		.sof_tplg_filename = "intel/sof-apl-pcm512x.tplg",
+		.sof_fw_filename = "sof-apl.ri",
+		.sof_tplg_filename = "sof-apl-pcm512x.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
 		.id = "1AEC8804",
 		.drv_name = "bxt-wm8804",
-		.sof_fw_filename = "intel/sof-apl.ri",
-		.sof_tplg_filename = "intel/sof-apl-wm8804.tplg",
+		.sof_fw_filename = "sof-apl.ri",
+		.sof_tplg_filename = "sof-apl-wm8804.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
 		.id = "INT34C3",
 		.drv_name = "bxt_tdf8532",
 		.machine_quirk = apl_quirk,
-		.sof_fw_filename = "intel/sof-apl.ri",
-		.sof_tplg_filename = "intel/sof-apl-tdf8532.tplg",
+		.sof_fw_filename = "sof-apl.ri",
+		.sof_tplg_filename = "sof-apl-tdf8532.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{},
-- 
2.17.1
