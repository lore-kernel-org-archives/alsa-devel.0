From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: filter ACPI devices with
	_STA return value" to the asoc tree
Date: Sat, 05 Mar 2016 21:25:05 +0900
Message-ID: <E1acBGb-0003KS-G8@finisterre>
References: <1457062599-10032-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 49D06265857
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:25:09 +0100 (CET)
In-Reply-To: <1457062599-10032-3-git-send-email-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: common: filter ACPI devices with _STA return value

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

>From cab473850226c3e41823453b5b80eb294dae6e0c Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 3 Mar 2016 21:36:34 -0600
Subject: [PATCH] ASoC: Intel: common: filter ACPI devices with _STA return
 value

BIOS vendors typically list multiple audio codecs in the DSDT
table and enable the relevant one by changing the return value
of the _STA method.

With the current code, all devices are reported by
acpi_dev_present(), regardless of the _STA return values. This
causes errors on probe with the wrong machine driver being loaded.

This patch essentially reverts 'commit 6f08cbdaac5a
("ASoC: Intel: Use acpi_dev_present()")' and adds code to
force the evaluation of the _STA method.

A better solution might be to make sure the ACPI subsystem only
reports devices with a _STA value of 0xf but apparently it's
problematic so dealing with this in the audio subsystem directly.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-match-acpi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
index c429e2226d40..cf2c27cd8651 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -16,14 +16,30 @@
 
 #include "sst-acpi.h"
 
+static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
+				       void *context, void **ret)
+{
+	unsigned long long sta;
+	acpi_status status;
+
+	*(bool *)context = true;
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
+		*(bool *)context = false;
+
+	return AE_OK;
+}
+
 struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
 {
 	struct sst_acpi_mach *mach;
+	bool found = false;
 
 	for (mach = machines; mach->id[0]; mach++)
-		if (acpi_dev_present(mach->id))
+		if (ACPI_SUCCESS(acpi_get_devices(mach->id,
+						  sst_acpi_mach_match,
+						  &found, NULL)) && found)
 			return mach;
-
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(sst_acpi_find_machine);
-- 
2.7.0
