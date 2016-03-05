From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: add support for CHT w/
	RT5640" to the asoc tree
Date: Sat, 05 Mar 2016 21:24:58 +0900
Message-ID: <E1acBGU-0003IW-L6@finisterre>
References: <1457062599-10032-8-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D670F261A0D
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:25:02 +0100 (CET)
In-Reply-To: <1457062599-10032-8-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: add support for CHT w/ RT5640

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

>From fdf841937e4fa08e767dbe83f1c65696cfec67c9 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 3 Mar 2016 21:36:39 -0600
Subject: [PATCH] ASoC: Intel: Atom: add support for CHT w/ RT5640

Some CHT-T platforms make use of the Realtek RT5640 codec. Make use
of the machine driver developed for Baytrail.

Tested on Tronsmart Ara X5.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 4fce03fc1870..3bc4b63b2f9d 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -342,6 +342,10 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 						&chv_platform_data },
 	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
+	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
+	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
+						&chv_platform_data },
+
 	{},
 };
 
-- 
2.7.0
