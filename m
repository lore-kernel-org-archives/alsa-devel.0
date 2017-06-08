From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH v2 3/3] ASoC: Intel: Add Kabylake
	RT5663+RT5514+MAX98927 machine driver entry
Date: Wed,  7 Jun 2017 18:27:41 -0700
Message-ID: <1496885261-10771-4-git-send-email-harshapriya.n@intel.com>
References: <1496885261-10771-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 206C62672C4
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 03:27:52 +0200 (CEST)
In-Reply-To: <1496885261-10771-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds Kabylake I2S machine driver which uses codecs
MAX98927 as speakers and RT5514 as dmic on ssp0 and
RT5663 as headset on ssp1.
---
 sound/soc/intel/skylake/skl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 6a79fc7..e761550 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -896,6 +896,12 @@ static void skl_remove(struct pci_dev *pci)
 	.codecs = {"10EC5663"}
 };
 
+static struct sst_codecs kbl_5663_5514_codecs = {
+	.num_codecs = 2,
+	.codecs = {"10EC5663", "10EC5514"}
+};
+
+
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{
 		.id = "INT343A",
@@ -960,6 +966,14 @@ static void skl_remove(struct pci_dev *pci)
 	},
 	{
 		.id = "MX98927",
+		.drv_name = "kbl_r5514_5663_max",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = sst_acpi_codec_list,
+		.quirk_data = &kbl_5663_5514_codecs,
+		.pdata = &skl_dmic_data
+	},
+	{
+		.id = "MX98927",
 		.drv_name = "kbl_rt5663_m98927",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
 		.machine_quirk = sst_acpi_codec_list,
-- 
1.9.1
