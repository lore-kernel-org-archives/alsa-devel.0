From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: make function stub static" to
	the asoc tree
Date: Tue, 24 May 2016 17:25:51 +0100
Message-ID: <E1b5F9T-0003Y7-Je@debutante>
References: <573F2F8E.5020704@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CC35265DD2
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2016 18:26:23 +0200 (CEST)
In-Reply-To: <573F2F8E.5020704@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Borislav Petkov <bp@alien8.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: make function stub static

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

>From 284f6829aedfa77e0135066b75d0c81464bbe904 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 20 May 2016 08:38:54 -0700
Subject: [PATCH] ASoC: intel: make function stub static

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 8398cb227ba9..b02f12900b93 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -20,7 +20,7 @@
 #if IS_ENABLED(CONFIG_ACPI)
 const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN]);
 #else
-inline const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
+static inline const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
 {
 	return NULL;
 }
-- 
2.8.1
