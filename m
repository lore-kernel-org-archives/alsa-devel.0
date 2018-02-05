From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Add Kabylake Dialog+Maxim
	machine driver entry
Date: Mon,  5 Feb 2018 09:59:57 +0530
Message-ID: <1517804997-13776-3-git-send-email-naveen.m@intel.com>
References: <1517804997-13776-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B7F242671CC
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 05:30:21 +0100 (CET)
In-Reply-To: <1517804997-13776-1-git-send-email-naveen.m@intel.com>
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
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Adds Kabylake kbl_da7219_max98357a_i2s machine driver entry into
machine table

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
---
 sound/soc/intel/skylake/skl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 32ce64c..aa9edc8 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1017,6 +1017,11 @@ static void skl_remove(struct pci_dev *pci)
 	.codecs = {"10EC5663", "10EC5514"}
 };
 
+static struct snd_soc_acpi_codecs kbl_7219_98357_codecs = {
+	.num_codecs = 1,
+	.codecs = {"MX98357A"}
+};
+
 static struct skl_machine_pdata cnl_pdata = {
 	.use_tplg_pcm = true,
 };
@@ -1105,6 +1110,14 @@ static void skl_remove(struct pci_dev *pci)
 		.drv_name = "kbl_rt5663",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
 	},
+	{
+		.id = "DLGS7219",
+		.drv_name = "kbl_da7219_max98357a",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &kbl_7219_98357_codecs,
+		.pdata = &skl_dmic_data
+	},
 
 	{}
 };
-- 
1.9.1
