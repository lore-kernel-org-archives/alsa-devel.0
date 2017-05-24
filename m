From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Move quirk to identify correct machine
	driver" to the asoc tree
Date: Wed, 24 May 2017 18:41:28 +0100
Message-ID: <E1dDaHo-0002jD-Kc@debutante>
References: <1494235140-29369-3-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E311266D22
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:41:36 +0200 (CEST)
In-Reply-To: <1494235140-29369-3-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, naveen.m@intel.com, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Move quirk to identify correct machine driver

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

>From 7827d66946ad3af734ed46d1d68c23fa6974595c Mon Sep 17 00:00:00 2001
From: Naveen M <naveen.m@intel.com>
Date: Mon, 15 May 2017 13:42:14 +0530
Subject: [PATCH] ASoC: Move quirk to identify correct machine driver

sst_acpi_mach has a quirk field to handle board specific quirks.
Patch moves quirk call to sst_acpi_find_machine() instead of calling
it in respective driver

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c     |  2 --
 sound/soc/intel/common/sst-match-acpi.c | 12 +++++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 193c4d7b35f5..592f6afaf2a5 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -303,8 +303,6 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		dev_err(dev, "No matching machine driver found\n");
 		return -ENODEV;
 	}
-	if (mach->machine_quirk)
-		mach = mach->machine_quirk(mach);
 
 	pdata = mach->pdata;
 
diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
index f4af3d144b82..88e4977578b5 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -81,9 +81,15 @@ struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
 {
 	struct sst_acpi_mach *mach;
 
-	for (mach = machines; mach->id[0]; mach++)
-		if (sst_acpi_check_hid(mach->id) == true)
-			return mach;
+	for (mach = machines; mach->id[0]; mach++) {
+		if (sst_acpi_check_hid(mach->id) == true) {
+			if (mach->machine_quirk == NULL)
+				return mach;
+
+			if (mach->machine_quirk(mach) != NULL)
+				return mach;
+		}
+	}
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(sst_acpi_find_machine);
-- 
2.11.0
