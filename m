From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Bxtn: Add Broxton PCI ID" to the
	asoc tree
Date: Sun, 13 Mar 2016 15:14:58 +0700
Message-ID: <E1af1Aw-0004Gd-1q@finisterre>
References: <1457671376-18667-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 61E8F26051B
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:15:11 +0100 (CET)
In-Reply-To: <1457671376-18667-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Bxtn: Add Broxton PCI ID

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

>From b379b1fad6e80274309f650f3a82c6f3c4fe9d6b Mon Sep 17 00:00:00 2001
From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Date: Fri, 11 Mar 2016 10:12:54 +0530
Subject: [PATCH] ASoC: Intel: Bxtn: Add Broxton PCI ID

Broxton is an Intel SoC which sports a DSP and system is quite
like Skylake. So add this ID in Skylake driver

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 0d38bdb8321b..ab5e25aaeee3 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -742,11 +742,18 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 	{}
 };
 
+static struct sst_acpi_mach sst_bxtp_devdata[] = {
+	{ "INT343A", "bxt_alc298s_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
+};
+
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
 		.driver_data = (unsigned long)&sst_skl_devdata},
+	/* BXT-P */
+	{ PCI_DEVICE(0x8086, 0x5a98),
+		.driver_data = (unsigned long)&sst_bxtp_devdata},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
2.7.0
