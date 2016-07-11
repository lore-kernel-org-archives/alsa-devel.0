From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: add kablake device IDs" to the
	asoc tree
Date: Mon, 11 Jul 2016 22:21:11 +0100
Message-ID: <E1bMidb-0003v8-N0@debutante>
References: <1468254731-15394-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32BD9265451
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 23:21:16 +0200 (CEST)
In-Reply-To: <1468254731-15394-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: add kablake device IDs

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

>From 451dfb5f82c7ed5f691be5f6409637e03d5f9c65 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 11 Jul 2016 22:02:08 +0530
Subject: [PATCH] ASoC: Intel: add kablake device IDs

Kabylake is next generation Intel platform which has similar
audio controller to Skylake, so add the ID and driver data in
SKL driver.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 6 ++++++
 sound/soc/intel/skylake/skl.c          | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 6902020df946..44ab595ce21a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -206,6 +206,12 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.cleanup = skl_sst_dsp_cleanup
 	},
 	{
+		.id = 0x9d71,
+		.loader_ops = skl_get_loader_ops,
+		.init = skl_sst_dsp_init,
+		.cleanup = skl_sst_dsp_cleanup
+	},
+	{
 		.id = 0x5a98,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index d5d7c53e07bc..4e30effc5469 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -813,6 +813,11 @@ static struct sst_acpi_mach sst_bxtp_devdata[] = {
 	{ "DLGS7219", "bxt_da7219_max98357a_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
 };
 
+static struct sst_acpi_mach sst_kbl_devdata[] = {
+	{ "INT343A", "kbl_alc286s_i2s", "intel/dsp_fw_kbl.bin", NULL, NULL, NULL },
+	{}
+};
+
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 	/* Sunrise Point-LP */
@@ -821,6 +826,9 @@ static const struct pci_device_id skl_ids[] = {
 	/* BXT-P */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 		.driver_data = (unsigned long)&sst_bxtp_devdata},
+	/* KBL */
+	{ PCI_DEVICE(0x8086, 0x9D71),
+		.driver_data = (unsigned long)&sst_kbl_devdata},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
2.8.1
