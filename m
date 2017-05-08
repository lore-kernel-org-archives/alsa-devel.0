From: Naveen M <naveen.m@intel.com>
Subject: [PATCH 2/6] ASoC: Move quirk to identify correct
	machine driver
Date: Mon,  8 May 2017 14:48:56 +0530
Message-ID: <1494235140-29369-3-git-send-email-naveen.m@intel.com>
References: <1494235140-29369-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id AD800266A53
 for <alsa-devel@alsa-project.org>; Mon,  8 May 2017 11:19:31 +0200 (CEST)
In-Reply-To: <1494235140-29369-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, naveen.m@intel.com, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

sst_acpi_mach has a quirk field to handle board specific quirks.
Patch moves quirk call to sst_acpi_find_machine() instead of calling
it in respective driver

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c     |  2 --
 sound/soc/intel/common/sst-match-acpi.c | 12 +++++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index dd250b8..3e6650e 100644
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
index f4af3d1..88e4977 100644
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
1.9.1
