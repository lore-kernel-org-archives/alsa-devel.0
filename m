From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add Geminlake IDs" to
	the asoc tree
Date: Thu, 16 Feb 2017 19:03:57 +0000
Message-ID: <E1ceRLR-0007Ol-Ac@debutante>
References: <1486638844-17975-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF9B0266D49
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 20:04:06 +0100 (CET)
In-Reply-To: <1486638844-17975-4-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add Geminlake IDs

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

>From 255048634366c9aee87d7ab801fa530c34f10b9f Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 9 Feb 2017 16:44:03 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add Geminlake IDs

Geminilake is next gen SoC, so add the IDs for Geminilake.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 7 +++++++
 sound/soc/intel/skylake/skl.c          | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index e79cbcf6e462..e66870474f10 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -220,6 +220,13 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.init_fw = bxt_sst_init_fw,
 		.cleanup = bxt_sst_dsp_cleanup
 	},
+	{
+		.id = 0x3198,
+		.loader_ops = bxt_get_loader_ops,
+		.init = bxt_sst_dsp_init,
+		.init_fw = bxt_sst_init_fw,
+		.cleanup = bxt_sst_dsp_cleanup
+	},
 };
 
 const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 1152e46daede..0c57d4eaae3a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -883,6 +883,10 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
 	{}
 };
 
+static struct sst_acpi_mach sst_glk_devdata[] = {
+	{ "INT343A", "glk_alc298s_i2s", "intel/dsp_fw_glk.bin", NULL, NULL, NULL },
+};
+
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 	/* Sunrise Point-LP */
@@ -894,6 +898,9 @@ static const struct pci_device_id skl_ids[] = {
 	/* KBL */
 	{ PCI_DEVICE(0x8086, 0x9D71),
 		.driver_data = (unsigned long)&sst_kbl_devdata},
+	/* GLK */
+	{ PCI_DEVICE(0x8086, 0x3198),
+		.driver_data = (unsigned long)&sst_glk_devdata},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
2.11.0
