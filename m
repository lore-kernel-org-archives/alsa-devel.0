From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 01/10] ASoC: acpi: add missing includes for
	non-ACPI platforms
Date: Thu,  4 Jan 2018 16:35:52 -0600
Message-ID: <20180104223601.5831-2-pierre-louis.bossart@linux.intel.com>
References: <20180104223601.5831-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BCB426798B
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 23:36:11 +0100 (CET)
In-Reply-To: <20180104223601.5831-1-pierre-louis.bossart@linux.intel.com>
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
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

0-day reports compilation issues with non-ACPI platforms.

In file included from sound/soc/soc-acpi.c:17:0:
>> include/sound/soc-acpi.h:36:46: error: 'ACPI_ID_LEN' undeclared here
(not in a function); did you mean 'ACPI_FILE'?
    snd_soc_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])

 sound/soc/soc-acpi.c: At top level:
>> sound/soc/soc-acpi.c:174:16: error: expected declaration specifiers or
'...' before string constant
    MODULE_LICENSE("GPL v2");

Add missing include files.

Fixes: 7feb2f786a46 ("ASoC: move ACPI common code out of Intel/sst tree")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/sound/soc-acpi-intel-match.h | 1 +
 include/sound/soc-acpi.h             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index 1a9191cd4bb3..9da6388c20a1 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -16,6 +16,7 @@
 #ifndef __LINUX_SND_SOC_ACPI_INTEL_MATCH_H
 #define __LINUX_SND_SOC_ACPI_INTEL_MATCH_H
 
+#include <linux/module.h>
 #include <linux/stddef.h>
 #include <linux/acpi.h>
 
diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index a7d8d335b043..a93436089bf5 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -17,6 +17,7 @@
 
 #include <linux/stddef.h>
 #include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 
 struct snd_soc_acpi_package_context {
 	char *name;           /* package name */
-- 
2.14.1
