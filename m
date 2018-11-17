From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/3] ASoC: acpi: fix: continue searching when
	machine is ignored
Date: Fri, 16 Nov 2018 18:47:04 -0600
Message-ID: <20181117004706.15911-2-pierre-louis.bossart@linux.intel.com>
References: <20181117004706.15911-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 85FAA2679C0
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2018 01:47:16 +0100 (CET)
In-Reply-To: <20181117004706.15911-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Keyon Jie <yang.jie@linux.intel.com>

The machine_quirk may return NULL which means the acpi entries should be
skipped and search for next matched entry is needed, here add return
check here and continue for NULL case.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-acpi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index b8e72b52db30..4fb29f0e561e 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -10,11 +10,17 @@ struct snd_soc_acpi_mach *
 snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 {
 	struct snd_soc_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach_alt;
 
 	for (mach = machines; mach->id[0]; mach++) {
 		if (acpi_dev_present(mach->id, NULL, -1)) {
-			if (mach->machine_quirk)
-				mach = mach->machine_quirk(mach);
+			if (mach->machine_quirk) {
+				mach_alt = mach->machine_quirk(mach);
+				if (!mach_alt)
+					continue; /* not full match, ignore */
+				mach = mach_alt;
+			}
+
 			return mach;
 		}
 	}
-- 
2.17.1
