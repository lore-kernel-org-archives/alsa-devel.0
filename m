From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Create a helper to search for
	matching machine" to the asoc tree
Date: Wed, 24 May 2017 18:41:33 +0100
Message-ID: <E1dDaHt-0002kF-UZ@debutante>
References: <1494235140-29369-2-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F2AD266C4D
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:41:41 +0200 (CEST)
In-Reply-To: <1494235140-29369-2-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Harsha Priya <harshapriya.n@intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Create a helper to search for matching machine

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

>From 915ae2b9f0fe0357a8f9cc53a7eb18ded03d11a4 Mon Sep 17 00:00:00 2001
From: Naveen M <naveen.m@intel.com>
Date: Mon, 15 May 2017 13:42:13 +0530
Subject: [PATCH] ASoC: Intel: Create a helper to search for matching machine

Create a helper function to search for a matching machine
based on HID. No functional change

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-acpi.h       |  3 +++
 sound/soc/intel/common/sst-match-acpi.c | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 214e000667ae..3649d3b08c9e 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -43,6 +43,9 @@ static inline bool sst_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
 /* acpi match */
 struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines);
 
+/* acpi check hid */
+bool sst_acpi_check_hid(const u8 hid[ACPI_ID_LEN]);
+
 /* Descriptor for SST ASoC machine driver */
 struct sst_acpi_mach {
 	/* ACPI ID for the matching machine driver. Audio codec for instance */
diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
index 1070f3ad23e5..f4af3d144b82 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -63,15 +63,26 @@ static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
+bool sst_acpi_check_hid(const u8 hid[ACPI_ID_LEN])
+{
+	acpi_status status;
+	bool found = false;
+
+	status = acpi_get_devices(hid, sst_acpi_mach_match, &found, NULL);
+
+	if (ACPI_FAILURE(status))
+		return false;
+
+	return found;
+}
+EXPORT_SYMBOL_GPL(sst_acpi_check_hid);
+
 struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
 {
 	struct sst_acpi_mach *mach;
-	bool found = false;
 
 	for (mach = machines; mach->id[0]; mach++)
-		if (ACPI_SUCCESS(acpi_get_devices(mach->id,
-						  sst_acpi_mach_match,
-						  &found, NULL)) && found)
+		if (sst_acpi_check_hid(mach->id) == true)
 			return mach;
 	return NULL;
 }
-- 
2.11.0
