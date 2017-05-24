From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add Kabylake RT5663+MAX98927
	machine driver entry" to the asoc tree
Date: Wed, 24 May 2017 18:41:13 +0100
Message-ID: <E1dDaHZ-0002fa-1n@debutante>
References: <1494505944-31378-7-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A00B7266BEF
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:41:29 +0200 (CEST)
In-Reply-To: <1494505944-31378-7-git-send-email-naveen.m@intel.com>
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

   ASoC: Intel: Add Kabylake RT5663+MAX98927 machine driver entry

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

>From 0809d9871d1066634f8abae9ecfbdfadecb8cd35 Mon Sep 17 00:00:00 2001
From: Naveen M <naveen.m@intel.com>
Date: Mon, 15 May 2017 13:42:17 +0530
Subject: [PATCH] ASoC: Intel: Add Kabylake RT5663+MAX98927 machine driver
 entry

Adds kbl_rt5663_max98927_i2s machine driver entry into machine table

Signed-off-by: Naveen M <naveen.m@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index ceb7734d74ed..4ebae850c559 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -879,6 +879,7 @@ static void skl_remove(struct pci_dev *pci)
 static struct sst_codecs skl_codecs = { 1, {"NAU88L25"} };
 static struct sst_codecs kbl_codecs = { 1, {"NAU88L25"} };
 static struct sst_codecs bxt_codecs = { 1, {"MX98357A"} };
+static struct sst_codecs kbl_poppy_codecs = { 1, {"10EC5663"} };
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{
@@ -942,6 +943,15 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
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
2.11.0
