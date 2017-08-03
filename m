From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cnl: add pci id for cnl" to the
	asoc tree
Date: Thu, 03 Aug 2017 17:30:00 +0100
Message-ID: <E1ddJ0a-0002Rs-Q1@debutante>
References: <20170802162120.8935-10-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 266F8266D9B
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:30:11 +0200 (CEST)
In-Reply-To: <20170802162120.8935-10-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cnl: add pci id for cnl

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

>From 86d7ce3dd717e09a442d35dae3f9c62c03e024d8 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Wed, 2 Aug 2017 21:51:20 +0530
Subject: [PATCH] ASoC: Intel: cnl: add pci id for cnl

Enable cnl by adding its pci id in skl_ids[].

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index ab651517e8b8..e612a4097275 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -996,6 +996,14 @@ static struct sst_acpi_mach sst_glk_devdata[] = {
 	},
 };
 
+static const struct sst_acpi_mach sst_cnl_devdata[] = {
+	{
+		.id = "INT34C2",
+		.drv_name = "cnl_rt274",
+		.fw_filename = "intel/dsp_fw_cnl.bin",
+	},
+};
+
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 	/* Sunrise Point-LP */
@@ -1010,6 +1018,9 @@ static const struct pci_device_id skl_ids[] = {
 	/* GLK */
 	{ PCI_DEVICE(0x8086, 0x3198),
 		.driver_data = (unsigned long)&sst_glk_devdata},
+	/* CNL */
+	{ PCI_DEVICE(0x8086, 0x9dc8),
+		.driver_data = (unsigned long)&sst_cnl_devdata},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
2.13.2
