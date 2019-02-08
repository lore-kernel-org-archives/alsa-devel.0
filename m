From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 09/17] ASoC: Intel: soc-acpi: bxt-match: remove
	asoc_plat_name field
Date: Fri,  8 Feb 2019 17:45:49 -0600
Message-ID: <20190208234557.7816-10-pierre-louis.bossart@linux.intel.com>
References: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 83C17267A56
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 00:46:11 +0100 (CET)
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

This field was never used, let's remove it

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index c0e5780e2ad1..229e39586868 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -53,7 +53,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
 		.sof_fw_filename = "sof-apl.ri",
 		.sof_tplg_filename = "sof-apl-rt298.tplg",
-		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
 		.id = "DLGS7219",
@@ -63,21 +62,18 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 		.quirk_data = &bxt_codecs,
 		.sof_fw_filename = "sof-apl.ri",
 		.sof_tplg_filename = "sof-apl-da7219.tplg",
-		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
 		.id = "104C5122",
 		.drv_name = "bxt-pcm512x",
 		.sof_fw_filename = "sof-apl.ri",
 		.sof_tplg_filename = "sof-apl-pcm512x.tplg",
-		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
 		.id = "1AEC8804",
 		.drv_name = "bxt-wm8804",
 		.sof_fw_filename = "sof-apl.ri",
 		.sof_tplg_filename = "sof-apl-wm8804.tplg",
-		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
 		.id = "INT34C3",
@@ -85,7 +81,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 		.machine_quirk = apl_quirk,
 		.sof_fw_filename = "sof-apl.ri",
 		.sof_tplg_filename = "sof-apl-tdf8532.tplg",
-		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{},
 };
-- 
2.17.1
