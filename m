From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 05/17] ASoC: Intel: glk-match: remove prefix
	for SOF files
Date: Fri,  8 Feb 2019 17:45:45 -0600
Message-ID: <20190208234557.7816-6-pierre-louis.bossart@linux.intel.com>
References: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CD15267A3F
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 00:46:08 +0100 (CET)
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
 sound/soc/intel/common/soc-acpi-intel-glk-match.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 305875af71ca..75bc0109166a 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -19,8 +19,8 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 		.id = "INT343A",
 		.drv_name = "glk_alc298s_i2s",
 		.fw_filename = "intel/dsp_fw_glk.bin",
-		.sof_fw_filename = "intel/sof-glk.ri",
-		.sof_tplg_filename = "intel/sof-glk-alc298.tplg",
+		.sof_fw_filename = "sof-glk.ri",
+		.sof_tplg_filename = "sof-glk-alc298.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
@@ -29,8 +29,8 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 		.fw_filename = "intel/dsp_fw_glk.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &glk_codecs,
-		.sof_fw_filename = "intel/sof-glk.ri",
-		.sof_tplg_filename = "intel/sof-glk-da7219.tplg",
+		.sof_fw_filename = "sof-glk.ri",
+		.sof_tplg_filename = "sof-glk-da7219.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{},
-- 
2.17.1
