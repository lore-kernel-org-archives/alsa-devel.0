From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: add machine driver for
	baytrail-rt5645 hardware" to the asoc tree
Date: Tue, 31 Jan 2017 21:17:51 +0000
Message-ID: <E1cYfoF-00014b-6f@debutante>
References: <1485461385-14544-12-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ACF92673F2
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:17:59 +0100 (CET)
In-Reply-To: <1485461385-14544-12-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: add machine driver for baytrail-rt5645 hardware

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

>From e1d06914542a198a6ab3d41b9d7f5d62dd744f8b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 26 Jan 2017 14:09:39 -0600
Subject: [PATCH] ASoC: Intel: Atom: add machine driver for baytrail-rt5645
 hardware

Use machine driver initially defined for CherryTrail

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 0699ce511755..4c0b89ec42e0 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -445,6 +445,12 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 						&byt_rvp_platform_data },
 	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
 						&byt_rvp_platform_data },
+	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
+	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
+						&byt_rvp_platform_data },
+	{"10EC5648", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
+						&byt_rvp_platform_data },
+
 	{},
 };
 
-- 
2.11.0
