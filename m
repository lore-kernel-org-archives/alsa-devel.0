From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: Add Kabylake
	Dialog+Maxim machine driver entry" to the asoc tree
Date: Mon, 15 Oct 2018 12:21:36 +0100 (BST)
Message-ID: <20181015112137.00AB411224A9@debutante.sirena.org.uk>
References: <1539070628-14284-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DC338267737
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 13:21:40 +0200 (CEST)
In-Reply-To: <1539070628-14284-1-git-send-email-mac.chiang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, mac.chiang@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: Add Kabylake Dialog+Maxim machine driver entry

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 6530adeaaf5018cd13437dc82adcd9349657a00e Mon Sep 17 00:00:00 2001
From: Mac Chiang <mac.chiang@intel.com>
Date: Tue, 9 Oct 2018 15:37:08 +0800
Subject: [PATCH] ASoC: Intel: common: Add Kabylake Dialog+Maxim machine driver
 entry

This patch adds da7219_max98927 machine driver entry into
machine table

Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
index 0ee173ca437d..a317b7790fce 100644
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
2.19.0.rc2
