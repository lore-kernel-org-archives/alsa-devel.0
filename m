From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: add function stub when ACPI is
	not enabled" to the asoc tree
Date: Wed, 30 Mar 2016 15:28:35 -0700
Message-ID: <E1alObL-0006t2-Ke@finisterre>
References: <56FAB10C.502@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C8588266332
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 00:28:53 +0200 (CEST)
In-Reply-To: <56FAB10C.502@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Borislav Petkov <bp@alien8.de>, Randy Dunlap <rdunlap@infradead.org>, "Subhransu S.Prusty" <subhransu.s.prusty@intel.com>, Cc@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, "Cc:alsa-devel"@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: add function stub when ACPI is not enabled

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

>From 52908a9c5c80a17aedff70be2a898933f7322be4 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 29 Mar 2016 09:45:00 -0700
Subject: [PATCH] ASoC: intel: add function stub when ACPI is not enabled

Add function stub for "sst_acpi_find_name_from_hid()"
when CONFIG_ACPI is not enabled so that the driver will build
successfully. This fixes the following build errors:

(loadable module)
ERROR: "sst_acpi_find_name_from_hid" [sound/soc/intel/boards/snd-soc-sst-bytcr-rt5640.ko] undefined!
(or built-in)
bytcr_rt5640.c:(.text+0x26fc52): undefined reference to `sst_acpi_find_name_from_hid'

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Cc:	Jie Yang <yang.jie@linux.intel.com>
Cc:	alsa-devel@alsa-project.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-acpi.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 4dcfb7e5ed70..8398cb227ba9 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -12,10 +12,19 @@
  *
  */
 
+#include <linux/kconfig.h>
+#include <linux/stddef.h>
 #include <linux/acpi.h>
 
 /* translation fron HID to I2C name, needed for DAI codec_name */
+#if IS_ENABLED(CONFIG_ACPI)
 const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN]);
+#else
+inline const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
+{
+	return NULL;
+}
+#endif
 
 /* acpi match */
 struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines);
-- 
2.8.0.rc3
