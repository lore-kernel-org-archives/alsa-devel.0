From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/17] ASoC: Intel: soc-acpi: hsw-bdw-match:
	remove asoc_plat_name field
Date: Fri,  8 Feb 2019 17:45:53 -0600
Message-ID: <20190208234557.7816-14-pierre-louis.bossart@linux.intel.com>
References: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 98F8C267A70
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 00:46:14 +0100 (CET)
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
 sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index ddfe4250c2bc..690b305a255b 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -25,7 +25,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[] = {
 		.fw_filename = "intel/IntcSST1.bin",
 		.sof_fw_filename = "sof-hsw.ri",
 		.sof_tplg_filename = "sof-hsw.tplg",
-		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
 };
@@ -38,7 +37,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.fw_filename =  "intel/IntcSST2.bin",
 		.sof_fw_filename = "sof-bdw.ri",
 		.sof_tplg_filename = "sof-bdw-rt286.tplg",
-		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "RT5677CE",
@@ -46,7 +44,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.fw_filename =  "intel/IntcSST2.bin",
 		.sof_fw_filename = "sof-bdw.ri",
 		.sof_tplg_filename = "sof-bdw-rt5677.tplg",
-		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "INT33CA",
@@ -54,7 +51,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.fw_filename = "intel/IntcSST2.bin",
 		.sof_fw_filename = "sof-bdw.ri",
 		.sof_tplg_filename = "sof-bdw-rt5640.tplg",
-		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
 };
-- 
2.17.1
