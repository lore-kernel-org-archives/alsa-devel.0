From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Add Kabylake
	RT5663+RT5514+MAX98927 machine driver entry
Date: Tue,  6 Jun 2017 13:51:33 -0700
Message-ID: <1496782293-15658-3-git-send-email-harshapriya.n@intel.com>
References: <1496782293-15658-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1496782293-15658-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, broonie@kernel.org, patch@alsa-project.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

Adds Kabylake rt5663_rt5514_max machine driver entry into machine table

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/skylake/skl.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 4ebae85..e761550 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -876,10 +876,31 @@ static void skl_remove(struct pci_dev *pci)
 	dev_set_drvdata(&pci->dev, NULL);
 }
 
-static struct sst_codecs skl_codecs = { 1, {"NAU88L25"} };
-static struct sst_codecs kbl_codecs = { 1, {"NAU88L25"} };
-static struct sst_codecs bxt_codecs = { 1, {"MX98357A"} };
-static struct sst_codecs kbl_poppy_codecs = { 1, {"10EC5663"} };
+static struct sst_codecs skl_codecs = {
+	.num_codecs = 1,
+	.codecs = {"NAU88L25"}
+};
+
+static struct sst_codecs kbl_codecs = {
+	.num_codecs = 1,
+	.codecs = {"NAU88L25"}
+};
+
+static struct sst_codecs bxt_codecs = {
+	.num_codecs = 1,
+	.codecs = {"MX98357A"}
+};
+
+static struct sst_codecs kbl_poppy_codecs = {
+	.num_codecs = 1,
+	.codecs = {"10EC5663"}
+};
+
+static struct sst_codecs kbl_5663_5514_codecs = {
+	.num_codecs = 2,
+	.codecs = {"10EC5663", "10EC5514"}
+};
+
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{
@@ -945,6 +966,14 @@ static void skl_remove(struct pci_dev *pci)
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
