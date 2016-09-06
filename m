From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: fix IOSF_MBI dependency"
	to the asoc tree
Date: Tue, 06 Sep 2016 12:29:30 +0100
Message-ID: <E1bhEZG-00040D-PJ@finisterre>
References: <1472919806-6691-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60C1C2671D6
 for <alsa-devel@alsa-project.org>; Tue,  6 Sep 2016 13:29:48 +0200 (CEST)
In-Reply-To: <1472919806-6691-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: broonie@kernel.org, 0 day tester <fengguang.wu@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: fix IOSF_MBI dependency

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

>From 94ae3ce189c75e7d74753b0e1d3e855786514f03 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Sat, 3 Sep 2016 11:23:26 -0500
Subject: [PATCH] ASoC: Intel: Atom: fix IOSF_MBI dependency

fix issue reported by 0-Day with randconfig

The commit a68bc0d43e1b
("ASoC: Intel: Atom: auto-detection of Baytrail-CR")
added a dependency on IOSF_MBI. The code used the IS_ENABLED macro
to check for this dependency but this is not enough in case the SST
driver is built-in. This could be fixed with IS_REACHABLE but
Baytrail-CR would not be detected depending on combinations of options

Add dependency in Kconfig to solve this for good

Reported-by: 0 day tester <fengguang.wu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a20c3dfbcb5d..fc6e78050a79 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -25,6 +25,7 @@ config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
 	select SND_SOC_INTEL_SST
+	select IOSF_MBI
 
 config SND_SOC_INTEL_SST
 	tristate
-- 
2.9.3
