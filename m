From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/17] ASoC: Intel: hsw-bdw-match: remove
	prefix for SOF files
Date: Fri,  8 Feb 2019 17:45:47 -0600
Message-ID: <20190208234557.7816-8-pierre-louis.bossart@linux.intel.com>
References: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id DBE91267A4B
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 00:46:09 +0100 (CET)
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
 .../intel/common/soc-acpi-intel-hsw-bdw-match.c  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index 494a0ea9b029..ddfe4250c2bc 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -23,8 +23,8 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[] = {
 		.id = "INT33CA",
 		.drv_name = "haswell-audio",
 		.fw_filename = "intel/IntcSST1.bin",
-		.sof_fw_filename = "intel/sof-hsw.ri",
-		.sof_tplg_filename = "intel/sof-hsw.tplg",
+		.sof_fw_filename = "sof-hsw.ri",
+		.sof_tplg_filename = "sof-hsw.tplg",
 		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
@@ -36,24 +36,24 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.id = "INT343A",
 		.drv_name = "broadwell-audio",
 		.fw_filename =  "intel/IntcSST2.bin",
-		.sof_fw_filename = "intel/sof-bdw.ri",
-		.sof_tplg_filename = "intel/sof-bdw-rt286.tplg",
+		.sof_fw_filename = "sof-bdw.ri",
+		.sof_tplg_filename = "sof-bdw-rt286.tplg",
 		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "RT5677CE",
 		.drv_name = "bdw-rt5677",
 		.fw_filename =  "intel/IntcSST2.bin",
-		.sof_fw_filename = "intel/sof-bdw.ri",
-		.sof_tplg_filename = "intel/sof-bdw-rt5677.tplg",
+		.sof_fw_filename = "sof-bdw.ri",
+		.sof_tplg_filename = "sof-bdw-rt5677.tplg",
 		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "INT33CA",
 		.drv_name = "haswell-audio",
 		.fw_filename = "intel/IntcSST2.bin",
-		.sof_fw_filename = "intel/sof-bdw.ri",
-		.sof_tplg_filename = "intel/sof-bdw-rt5640.tplg",
+		.sof_fw_filename = "sof-bdw.ri",
+		.sof_tplg_filename = "sof-bdw-rt5640.tplg",
 		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
-- 
2.17.1
