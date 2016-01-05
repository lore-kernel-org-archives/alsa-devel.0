From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: fix ACPI probe regression with
	Atom DPCM driver" to the asoc tree
Date: Tue, 05 Jan 2016 17:49:15 +0000
Message-ID: <E1aGVjP-00036y-DC@debutante>
References: <1450406156-22246-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 44608261469
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 18:49:24 +0100 (CET)
In-Reply-To: <1450406156-22246-2-git-send-email-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: fix ACPI probe regression with Atom DPCM driver

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

>From dc901a3541717ca4963dd017eacf50a4c954609c Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 4 Jan 2016 17:20:23 -0600
Subject: [PATCH] ASoC: Intel: fix ACPI probe regression with Atom DPCM driver

The commit 95f098014815b330838b1173d3d7bcea3b481242
"ASoC: Intel: Move apci find machine routines"

introduced a regression in ACPI probe of the DPCM driver.
Fix by conditionally compiling sst-acpi when the DPCM driver
is not selected

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 3b9332e7a094..668fdeee195e 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -1,5 +1,10 @@
 snd-soc-sst-dsp-objs := sst-dsp.o
+ifneq ($(CONFIG_SND_SST_IPC_ACPI),)
+snd-soc-sst-acpi-objs := sst-match-acpi.o
+else
 snd-soc-sst-acpi-objs := sst-acpi.o sst-match-acpi.o
+endif
+
 snd-soc-sst-ipc-objs := sst-ipc.o
 
 snd-soc-sst-dsp-$(CONFIG_DW_DMAC_CORE) += sst-firmware.o
-- 
2.7.0.rc3
