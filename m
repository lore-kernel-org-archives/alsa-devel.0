From: Naveen M <naveen.m@intel.com>
Subject: [PATCH v3 7/7] ASoC: Intel: Add Kabylake
	RT5663+MAX98927 machine driver entry
Date: Mon, 15 May 2017 13:42:17 +0530
Message-ID: <1494835937-22068-8-git-send-email-naveen.m@intel.com>
References: <1494835937-22068-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 30507267350
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:12:32 +0200 (CEST)
In-Reply-To: <1494835937-22068-1-git-send-email-naveen.m@intel.com>
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Adds kbl_rt5663_max98927_i2s machine driver entry into machine table

Signed-off-by: Naveen M <naveen.m@intel.com>
---
 sound/soc/intel/skylake/skl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index fd1dae1..9e22723 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -865,6 +865,7 @@ static void skl_remove(struct pci_dev *pci)
 static struct sst_codecs skl_codecs = { 1, {"NAU88L25"} };
 static struct sst_codecs kbl_codecs = { 1, {"NAU88L25"} };
 static struct sst_codecs bxt_codecs = { 1, {"MX98357A"} };
+static struct sst_codecs kbl_poppy_codecs = { 1, {"10EC5663"} };
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{
@@ -928,6 +929,15 @@ static void skl_remove(struct pci_dev *pci)
 		.quirk_data = &kbl_codecs,
 		.pdata = &skl_dmic_data
 	},
+	{
+		.id = "MX98927",
+		.drv_name = "kbl_rt5663_m98927",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = sst_acpi_codec_list,
+		.quirk_data = &kbl_poppy_codecs,
+		.pdata = &skl_dmic_data
+	},
+
 	{}
 };
 
-- 
1.9.1
