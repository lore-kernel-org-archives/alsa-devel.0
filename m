From: mac.chiang@intel.com
Subject: [PATCH] ASoC: Intel: common: Add Kabylake Dialog+Maxim
	machine driver entry
Date: Tue,  9 Oct 2018 15:37:08 +0800
Message-ID: <1539070628-14284-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E96E267951
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2018 09:37:03 +0200 (CEST)
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
Cc: mac.chiang@intel.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Mac Chiang <mac.chiang@intel.com>

This patch adds da7219_max98927 machine driver entry into
machine table

Signed-off-by: Mac Chiang <mac.chiang@intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
index 0ee173c..a317b77 100644
--- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
@@ -32,6 +32,11 @@ static struct snd_soc_acpi_codecs kbl_7219_98357_codecs = {
 	.codecs = {"MX98357A"}
 };
 
+static struct snd_soc_acpi_codecs kbl_7219_98927_codecs = {
+	.num_codecs = 1,
+	.codecs = {"MX98927"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
 	{
 		.id = "INT343A",
@@ -83,6 +88,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
 		.quirk_data = &kbl_7219_98357_codecs,
 		.pdata = &skl_dmic_data,
 	},
+	{
+		.id = "DLGS7219",
+		.drv_name = "kbl_da7219_max98927",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &kbl_7219_98927_codecs,
+		.pdata = &skl_dmic_data
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_kbl_machines);
-- 
2.7.4
