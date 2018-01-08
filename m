From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: acpi: fix machine driver selection
	based on quirk" to the asoc tree
Date: Mon, 08 Jan 2018 12:35:15 +0000
Message-ID: <E1eYWe3-0003Fq-Ih@debutante>
References: <20180105205536.10366-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0315131458834636544=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 25CDF26698E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 13:35:29 +0100 (CET)
In-Reply-To: <20180105205536.10366-2-pierre-louis.bossart@linux.intel.com>
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
Cc: jeremy@jcline.org, alsa-devel@alsa-project.org, andriy.shevchenko@linux.intel.com, tiwai@suse.de, stable@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

--===============0315131458834636544==
Content-Type: text/plain

The patch

   ASoC: acpi: fix machine driver selection based on quirk

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5c256045b87b8aa8e5bc9d2e2fdc0802351c1f99 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 5 Jan 2018 14:55:33 -0600
Subject: [PATCH] ASoC: acpi: fix machine driver selection based on quirk
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ACPI/machine-driver code refactoring introduced in 4.13 introduced
a regression for cases where we need a DMI-based quirk to select the
machine driver (the BIOS reports an invalid HID). The fix is just to
make sure the results of the quirk are actually used.

Fixes: 54746dabf770 ('ASoC: Improve machine driver selection based on quirk data')
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96691
Tested-by: Nicole Færber <nicole.faerber@dpin.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-acpi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index f21df28bc28e..d4dd2efea45e 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -84,11 +84,9 @@ snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 
 	for (mach = machines; mach->id[0]; mach++) {
 		if (snd_soc_acpi_check_hid(mach->id) == true) {
-			if (mach->machine_quirk == NULL)
-				return mach;
-
-			if (mach->machine_quirk(mach) != NULL)
-				return mach;
+			if (mach->machine_quirk)
+				mach = mach->machine_quirk(mach);
+			return mach;
 		}
 	}
 	return NULL;
-- 
2.15.1


--===============0315131458834636544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0315131458834636544==--
