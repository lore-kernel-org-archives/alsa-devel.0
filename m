From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: Add HP Pavilion x2 10-p000
	machine entry" to the asoc tree
Date: Tue, 31 Jan 2017 21:18:03 +0000
Message-ID: <E1cYfoR-00018a-GT@debutante>
References: <e129703fe81de8fdba680a4a6e27d1e414af2579.1483531270.git.neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9680D267407
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:18:15 +0100 (CET)
In-Reply-To: <e129703fe81de8fdba680a4a6e27d1e414af2579.1483531270.git.neko@nya.ai>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandrov Stansilav <neko@nya.ai>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: Add HP Pavilion x2 10-p000 machine entry

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

>From e7974816a8fce6cd11dc4dfa9f1c1844a9b5d8df Mon Sep 17 00:00:00 2001
From: Alexandrov Stansilav <neko@nya.ai>
Date: Thu, 26 Jan 2017 14:09:32 -0600
Subject: [PATCH] ASoC: Intel: Atom: Add HP Pavilion x2 10-p000 machine entry

Add machine entry for HP X2 Pavilion 10-p100.
This notebook contains rt5640 codec, but with ACPI ID "10EC3276".

Signed-off-by: Alexandrov Stansilav <neko@nya.ai>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index f4d92bbc5373..896ced2dd73c 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -463,6 +463,8 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", cht_quirk,
 						&chv_platform_data },
+	{"10EC3276", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
+						&chv_platform_data },
 
 	{},
 };
-- 
2.11.0
