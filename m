From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH]: ASoC: intel: make function stub static
Date: Fri, 20 May 2016 08:38:54 -0700
Message-ID: <573F2F8E.5020704@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B00D266B2F
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2016 17:39:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Borislav Petkov <bp@alien8.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

This function stub should have been 'static' in the original patch
so that multiple uses of the header file (in different drivers)
will not cause multiple function definitions.

sound/soc/intel/boards/built-in.o: In function `sst_acpi_find_name_from_hid':
(.text+0x560): multiple definition of `sst_acpi_find_name_from_hid'
sound/soc/intel/atom/built-in.o:(.text+0x10610): first defined here
../scripts/Makefile.build:369: recipe for target 'sound/soc/intel/built-in.o' failed

Fixes: f17131a93f43: add function stub when ACPI is not enabled

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/intel/common/sst-acpi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20160520.orig/sound/soc/intel/common/sst-acpi.h
+++ linux-next-20160520/sound/soc/intel/common/sst-acpi.h
@@ -20,7 +20,7 @@
 #if IS_ENABLED(CONFIG_ACPI)
 const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN]);
 #else
-inline const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
+static inline const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
 {
 	return NULL;
 }
