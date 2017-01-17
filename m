From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: remove ignored dependencies" to
	the asoc tree
Date: Tue, 17 Jan 2017 18:45:16 +0000
Message-ID: <E1cTYku-0008UU-5i@debutante>
References: <20170102152017.13938-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B05432665B0
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 19:45:26 +0100 (CET)
In-Reply-To: <20170102152017.13938-4-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, dmaengine <dmaengine@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: remove ignored dependencies

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

>From 2914266975fcb09a688cefe98874625366e67c65 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 16 Jan 2017 15:12:28 +0200
Subject: [PATCH] ASoC: Intel: remove ignored dependencies

For selected only options the explicit dependencies do not make much sense
becase Kbuild ignores them anyway. Remove them explicitly.

Acked-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 93c41b7219f2..526855ad479e 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -31,7 +31,6 @@ config SND_SOC_INTEL_SST
 	tristate
 	select SND_SOC_INTEL_SST_ACPI if ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
-	depends on (X86 || COMPILE_TEST)
 
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
-- 
2.11.0
