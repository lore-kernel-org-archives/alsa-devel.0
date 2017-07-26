From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix missing sentinels
	in sst_acpi_mach" to the asoc tree
Date: Wed, 26 Jul 2017 15:16:40 +0100
Message-ID: <E1daN7A-0003Py-Ud@debutante>
References: <1500964692-20866-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF29A26742B
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 16:16:49 +0200 (CEST)
In-Reply-To: <1500964692-20866-1-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Fix missing sentinels in sst_acpi_mach

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

>From b76e3f933327f9fd9df9a65a2d239e6e350cbee2 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 25 Jul 2017 12:08:12 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix missing sentinels in sst_acpi_mach

Couple of instances of sst_acpi_mach were having missing sentinels
so add them up

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 334917ee41cf..9e3f8c04dd32 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -941,6 +941,7 @@ static struct sst_acpi_mach sst_bxtp_devdata[] = {
 		.machine_quirk = sst_acpi_codec_list,
 		.quirk_data = &bxt_codecs,
 	},
+	{}
 };
 
 static struct sst_acpi_mach sst_kbl_devdata[] = {
@@ -991,6 +992,7 @@ static struct sst_acpi_mach sst_glk_devdata[] = {
 		.drv_name = "glk_alc298s_i2s",
 		.fw_filename = "intel/dsp_fw_glk.bin",
 	},
+	{}
 };
 
 /* PCI IDs */
-- 
2.13.2
