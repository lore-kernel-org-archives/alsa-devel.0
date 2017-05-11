From: Naveen M <naveen.m@intel.com>
Subject: [PATCH v2 4/6] ASoC: Improve machine driver selection
	based on quirk data
Date: Thu, 11 May 2017 18:02:22 +0530
Message-ID: <1494505944-31378-5-git-send-email-naveen.m@intel.com>
References: <1494505944-31378-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id E0EE9266D01
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 14:32:34 +0200 (CEST)
In-Reply-To: <1494505944-31378-1-git-send-email-naveen.m@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, naveen.m@intel.com, Harsha Priya <harshapriya.n@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Use quirk function to select the correct machine driver
by checking all codecs instead of only one based on quirk data.

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/common/sst-acpi.h       | 20 ++++++++++++++++++++
 sound/soc/intel/common/sst-match-acpi.c | 18 ++++++++++++++++++
 sound/soc/intel/skylake/skl.c           | 14 ++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 3649d3b..afe9b87 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -58,5 +58,25 @@ struct sst_acpi_mach {
 	/* board name */
 	const char *board;
 	struct sst_acpi_mach * (*machine_quirk)(void *arg);
+	const void *quirk_data;
 	void *pdata;
 };
+
+#define SST_ACPI_MAX_CODECS 3
+
+/**
+ * struct sst_codecs: Structure to hold secondary codec information apart from
+ * the matched one, this data will be passed to the quirk function to match
+ * with the ACPI detected devices
+ *
+ * @num_codecs: number of secondary codecs used in the platform
+ * @codecs: holds the codec IDs
+ *
+ */
+struct sst_codecs {
+	int num_codecs;
+	u8 codecs[SST_ACPI_MAX_CODECS][ACPI_ID_LEN];
+};
+
+/* check all codecs */
+struct sst_acpi_mach *sst_acpi_codec_list(void *arg);
diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
index 88e4977..56d26f3 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -151,5 +151,23 @@ bool sst_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
 }
 EXPORT_SYMBOL_GPL(sst_acpi_find_package_from_hid);
 
+struct sst_acpi_mach *sst_acpi_codec_list(void *arg)
+{
+	struct sst_acpi_mach *mach = arg;
+	struct sst_codecs *codec_list = (struct sst_codecs *) mach->quirk_data;
+	int i;
+
+	if (mach->quirk_data == NULL)
+		return mach;
+
+	for (i = 0; i < codec_list->num_codecs; i++) {
+		if (sst_acpi_check_hid(codec_list->codecs[i]) != true)
+			return NULL;
+	}
+
+	return mach;
+}
+EXPORT_SYMBOL_GPL(sst_acpi_codec_list);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel Common ACPI Match module");
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 22a7e39..fd1dae1 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -862,6 +862,10 @@ static void skl_remove(struct pci_dev *pci)
 	dev_set_drvdata(&pci->dev, NULL);
 }
 
+static struct sst_codecs skl_codecs = { 1, {"NAU88L25"} };
+static struct sst_codecs kbl_codecs = { 1, {"NAU88L25"} };
+static struct sst_codecs bxt_codecs = { 1, {"MX98357A"} };
+
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{
 		.id = "INT343A",
@@ -872,12 +876,16 @@ static void skl_remove(struct pci_dev *pci)
 		.id = "INT343B",
 		.drv_name = "skl_n88l25_s4567",
 		.fw_filename = "intel/dsp_fw_release.bin",
+		.machine_quirk = sst_acpi_codec_list,
+		.quirk_data = &skl_codecs,
 		.pdata = &skl_dmic_data
 	},
 	{
 		.id = "MX98357A",
 		.drv_name = "skl_n88l25_m98357a",
 		.fw_filename = "intel/dsp_fw_release.bin",
+		.machine_quirk = sst_acpi_codec_list,
+		.quirk_data = &skl_codecs,
 		.pdata = &skl_dmic_data
 	},
 	{}
@@ -893,6 +901,8 @@ static void skl_remove(struct pci_dev *pci)
 		.id = "DLGS7219",
 		.drv_name = "bxt_da7219_max98357a_i2s",
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
+		.machine_quirk = sst_acpi_codec_list,
+		.quirk_data = &bxt_codecs,
 	},
 };
 
@@ -906,12 +916,16 @@ static void skl_remove(struct pci_dev *pci)
 		.id = "INT343B",
 		.drv_name = "kbl_n88l25_s4567",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = sst_acpi_codec_list,
+		.quirk_data = &kbl_codecs,
 		.pdata = &skl_dmic_data
 	},
 	{
 		.id = "MX98357A",
 		.drv_name = "kbl_n88l25_m98357a",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = sst_acpi_codec_list,
+		.quirk_data = &kbl_codecs,
 		.pdata = &skl_dmic_data
 	},
 	{}
-- 
1.9.1
