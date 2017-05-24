From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Convert skl machine data to C99
	style" to the asoc tree
Date: Wed, 24 May 2017 18:41:36 +0100
Message-ID: <E1dDaHw-0002lU-W5@debutante>
References: <1494835937-22068-3-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40638267386
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:41:51 +0200 (CEST)
In-Reply-To: <1494835937-22068-3-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Convert skl machine data to C99 style

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

>From 9bf70cd4cd9f82a5f914fbf1fa0d32eff7a5d892 Mon Sep 17 00:00:00 2001
From: Naveen M <naveen.m@intel.com>
Date: Mon, 15 May 2017 13:42:12 +0530
Subject: [PATCH] ASoC: Intel: Convert skl machine data to C99 style

C99 style struct initialization helps in readability as well as
initialization of variables not specified as NULL.
Patch modifies all skl machine data.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 60 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 4c9b5781282b..a4d1121595b6 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -877,28 +877,66 @@ static void skl_remove(struct pci_dev *pci)
 }
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
-	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
-	{ "INT343B", "skl_n88l25_s4567", "intel/dsp_fw_release.bin",
-				NULL, NULL, &skl_dmic_data },
-	{ "MX98357A", "skl_n88l25_m98357a", "intel/dsp_fw_release.bin",
-				NULL, NULL, &skl_dmic_data },
+	{
+		.id = "INT343A",
+		.drv_name = "skl_alc286s_i2s",
+		.fw_filename = "intel/dsp_fw_release.bin",
+	},
+	{
+		.id = "INT343B",
+		.drv_name = "skl_n88l25_s4567",
+		.fw_filename = "intel/dsp_fw_release.bin",
+		.pdata = &skl_dmic_data
+	},
+	{
+		.id = "MX98357A",
+		.drv_name = "skl_n88l25_m98357a",
+		.fw_filename = "intel/dsp_fw_release.bin",
+		.pdata = &skl_dmic_data
+	},
 	{}
 };
 
 static struct sst_acpi_mach sst_bxtp_devdata[] = {
-	{ "INT343A", "bxt_alc298s_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
-	{ "DLGS7219", "bxt_da7219_max98357a_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
+	{
+		.id = "INT343A",
+		.drv_name = "bxt_alc298s_i2s",
+		.fw_filename = "intel/dsp_fw_bxtn.bin",
+	},
+	{
+		.id = "DLGS7219",
+		.drv_name = "bxt_da7219_max98357a_i2s",
+		.fw_filename = "intel/dsp_fw_bxtn.bin",
+	},
 };
 
 static struct sst_acpi_mach sst_kbl_devdata[] = {
-	{ "INT343A", "kbl_alc286s_i2s", "intel/dsp_fw_kbl.bin", NULL, NULL, NULL },
-	{ "INT343B", "kbl_n88l25_s4567", "intel/dsp_fw_kbl.bin", NULL, NULL, &skl_dmic_data },
-	{ "MX98357A", "kbl_n88l25_m98357a", "intel/dsp_fw_kbl.bin", NULL, NULL, &skl_dmic_data },
+	{
+		.id = "INT343A",
+		.drv_name = "kbl_alc286s_i2s",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+	},
+	{
+		.id = "INT343B",
+		.drv_name = "kbl_n88l25_s4567",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.pdata = &skl_dmic_data
+	},
+	{
+		.id = "MX98357A",
+		.drv_name = "kbl_n88l25_m98357a",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.pdata = &skl_dmic_data
+	},
 	{}
 };
 
 static struct sst_acpi_mach sst_glk_devdata[] = {
-	{ "INT343A", "glk_alc298s_i2s", "intel/dsp_fw_glk.bin", NULL, NULL, NULL },
+	{
+		.id = "INT343A",
+		.drv_name = "glk_alc298s_i2s",
+		.fw_filename = "intel/dsp_fw_glk.bin",
+	},
 };
 
 /* PCI IDs */
-- 
2.11.0
