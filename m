From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Improve machine driver selection based
	on quirk data" to the asoc tree
Date: Wed, 24 May 2017 18:41:21 +0100
Message-ID: <E1dDaHh-0002hx-KJ@debutante>
References: <1494505944-31378-5-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A855E266C0A
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:41:30 +0200 (CEST)
In-Reply-To: <1494505944-31378-5-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Harsha Priya <harshapriya.n@intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, tiwai@suse.de, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Improve machine driver selection based on quirk data

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 54746dabf770eb268d302f2f770d6dacea24f08a Mon Sep 17 00:00:00 2001
From: Naveen M <naveen.m@intel.com>
Date: Mon, 15 May 2017 13:42:15 +0530
Subject: [PATCH] ASoC: Improve machine driver selection based on quirk data

Use quirk function to select the correct machine driver
by checking all codecs instead of only one based on quirk data.

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-acpi.h       | 20 ++++++++++++++++++++
 sound/soc/intel/common/sst-match-acpi.c | 18 ++++++++++++++++++
 sound/soc/intel/skylake/skl.c           | 14 ++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 3649d3b08c9e..afe9b87b8bd5 100644
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
index 88e4977578b5..56d26f36a3cb 100644
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
index a4d1121595b6..ceb7734d74ed 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -876,6 +876,10 @@ static void skl_remove(struct pci_dev *pci)
 	dev_set_drvdata(&pci->dev, NULL);
 }
 
+static struct sst_codecs skl_codecs = { 1, {"NAU88L25"} };
+static struct sst_codecs kbl_codecs = { 1, {"NAU88L25"} };
+static struct sst_codecs bxt_codecs = { 1, {"MX98357A"} };
+
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{
 		.id = "INT343A",
@@ -886,12 +890,16 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
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
@@ -907,6 +915,8 @@ static struct sst_acpi_mach sst_bxtp_devdata[] = {
 		.id = "DLGS7219",
 		.drv_name = "bxt_da7219_max98357a_i2s",
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
+		.machine_quirk = sst_acpi_codec_list,
+		.quirk_data = &bxt_codecs,
 	},
 };
 
@@ -920,12 +930,16 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
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
2.11.0
