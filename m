From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH v4 3/3] ASoC: Intel: Add Kabylake
	RT5663+RT5514+MAX98927 machine driver entry
Date: Wed, 14 Jun 2017 10:32:19 -0700
Message-ID: <1497461539-12923-4-git-send-email-harshapriya.n@intel.com>
References: <1497461539-12923-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 77A0526731C
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 19:32:51 +0200 (CEST)
In-Reply-To: <1497461539-12923-1-git-send-email-harshapriya.n@intel.com>
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
Cc: Harsha Priya <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds Kabylake I2S machine driver which uses codecs
MAX98927 as speakers and RT5514 as dmic on ssp0 and
RT5663 as headset on ssp1.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Naveen M <naveen.m@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
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
