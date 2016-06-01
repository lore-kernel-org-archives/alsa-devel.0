From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add Broxton-P Dialog+Maxim
	machine driver entry" to the asoc tree
Date: Wed, 01 Jun 2016 17:16:08 +0100
Message-ID: <E1b88oS-0004SW-M2@finisterre>
References: <20160601063316.30042-3-sathyanarayana.nujella@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D4D3266009
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 18:16:30 +0200 (CEST)
In-Reply-To: <20160601063316.30042-3-sathyanarayana.nujella@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, yang.a.fang@intel.com, broonie@kernel.org, harshapriya.n@intel.com, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add Broxton-P Dialog+Maxim machine driver entry

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

>From de15996eab99b352926fb956d472d24d46c60309 Mon Sep 17 00:00:00 2001
From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Date: Tue, 31 May 2016 23:33:16 -0700
Subject: [PATCH] ASoC: Intel: Add Broxton-P Dialog+Maxim machine driver entry

This patch adds bxt_da7219_max98357a_i2s machine driver
entry into machine table

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index b0f7226b878f..55c301bf786b 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -803,6 +803,7 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 
 static struct sst_acpi_mach sst_bxtp_devdata[] = {
 	{ "INT343A", "bxt_alc298s_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
+	{ "DLGS7219", "bxt_da7219_max98357a_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
 };
 
 /* PCI IDs */
-- 
2.8.1
