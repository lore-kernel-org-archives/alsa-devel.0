From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: hda: move hda_codec.h to include/sound"
	to the asoc tree
Date: Tue, 28 Aug 2018 21:41:36 +0100 (BST)
Message-ID: <20180828204136.3C86F44007A@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8412C26781A
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:42:20 +0200 (CEST)
In-Reply-To: 
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: hda: move hda_codec.h to include/sound

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

>From b4af16d617add4f6380d6651473b8efba13ca8ca Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 22 Aug 2018 15:24:57 -0500
Subject: [PATCH] ALSA: hda: move hda_codec.h to include/sound

As suggested by Takashi, move this header file to make it easier
to include from e.g. the Intel Skylake driver in follow-up patches

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 {sound/pci/hda => include/sound}/hda_codec.h | 0
 sound/pci/hda/hda_auto_parser.c              | 2 +-
 sound/pci/hda/hda_beep.h                     | 2 +-
 sound/pci/hda/hda_bind.c                     | 2 +-
 sound/pci/hda/hda_codec.c                    | 2 +-
 sound/pci/hda/hda_controller.h               | 2 +-
 sound/pci/hda/hda_eld.c                      | 2 +-
 sound/pci/hda/hda_generic.c                  | 2 +-
 sound/pci/hda/hda_hwdep.c                    | 2 +-
 sound/pci/hda/hda_intel.c                    | 2 +-
 sound/pci/hda/hda_jack.c                     | 2 +-
 sound/pci/hda/hda_proc.c                     | 2 +-
 sound/pci/hda/hda_sysfs.c                    | 2 +-
 sound/pci/hda/hda_tegra.c                    | 2 +-
 sound/pci/hda/patch_analog.c                 | 2 +-
 sound/pci/hda/patch_ca0110.c                 | 2 +-
 sound/pci/hda/patch_ca0132.c                 | 2 +-
 sound/pci/hda/patch_cirrus.c                 | 2 +-
 sound/pci/hda/patch_cmedia.c                 | 2 +-
 sound/pci/hda/patch_conexant.c               | 2 +-
 sound/pci/hda/patch_hdmi.c                   | 2 +-
 sound/pci/hda/patch_realtek.c                | 2 +-
 sound/pci/hda/patch_si3054.c                 | 2 +-
 sound/pci/hda/patch_sigmatel.c               | 2 +-
 sound/pci/hda/patch_via.c                    | 2 +-
 25 files changed, 24 insertions(+), 24 deletions(-)
 rename {sound/pci/hda => include/sound}/hda_codec.h (100%)

diff --git a/sound/pci/hda/hda_codec.h b/include/sound/hda_codec.h
similarity index 100%
rename from sound/pci/hda/hda_codec.h
rename to include/sound/hda_codec.h
diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index b9a6b66aeb0e..df0d636145f8 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -13,7 +13,7 @@
 #include <linux/export.h>
 #include <linux/sort.h>
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 
diff --git a/sound/pci/hda/hda_beep.h b/sound/pci/hda/hda_beep.h
index d1a6a9c1329a..f1457c6b3969 100644
--- a/sound/pci/hda/hda_beep.h
+++ b/sound/pci/hda/hda_beep.h
@@ -9,7 +9,7 @@
 #ifndef __SOUND_HDA_BEEP_H
 #define __SOUND_HDA_BEEP_H
 
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 
 #define HDA_BEEP_MODE_OFF	0
 #define HDA_BEEP_MODE_ON	1
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index d361bb77ca00..2222b47d4ec4 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -11,7 +11,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 
 /*
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0a5085537034..ccbb0d12b8cc 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -27,7 +27,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include <sound/asoundef.h>
 #include <sound/tlv.h>
 #include <sound/initval.h>
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index a68e75b00ea3..55760e5231e6 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -20,7 +20,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include <sound/hda_register.h>
 
 #define AZX_MAX_CODECS		HDA_MAX_CODECS
diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index ba7fe9b6655c..806b12ed44a2 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -27,7 +27,7 @@
 #include <sound/core.h>
 #include <asm/unaligned.h>
 #include <sound/hda_chmap.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 
 enum eld_versions {
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 579984ecdec3..276150f29cda 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -32,7 +32,7 @@
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/tlv.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index cc009a4a3d1d..268bba6ec985 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -23,7 +23,7 @@
 #include <linux/compat.h>
 #include <linux/nospec.h>
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include <sound/hda_hwdep.h>
 #include <sound/minors.h>
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1b2ce304152a..c8fde95e2393 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -63,7 +63,7 @@
 #include <linux/vgaarb.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/firmware.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_controller.h"
 #include "hda_intel.h"
 
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index a33234e04d4f..c499727920e6 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -15,7 +15,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/jack.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index c6b778b2580c..a65740419650 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <linux/module.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 
 static int dump_coef = -1;
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index 6ec79c58d48d..c154b19a0c45 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -14,7 +14,7 @@
 #include <linux/string.h>
 #include <linux/export.h>
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include <sound/hda_hwdep.h>
 #include <sound/minors.h>
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 0621920f7617..4bc5232eac1c 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -35,7 +35,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_controller.h"
 
 /* Defines for Nvidia Tegra HDA support */
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index fd476fb40e1b..ebfd0be885b3 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -24,7 +24,7 @@
 #include <linux/module.h>
 
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_beep.h"
diff --git a/sound/pci/hda/patch_ca0110.c b/sound/pci/hda/patch_ca0110.c
index c2d9ee9cfdc0..21d0f0610913 100644
--- a/sound/pci/hda/patch_ca0110.c
+++ b/sound/pci/hda/patch_ca0110.c
@@ -22,7 +22,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0166a3d7cd55..a585d0ec6d77 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -32,7 +32,7 @@
 #include <linux/io.h>
 #include <linux/pci.h>
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index a7f91be45194..64fa5a82bb9f 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -23,7 +23,7 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/tlv.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index 1b2195dd2b26..52642ba3e2c0 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index cfd4e4f97f8f..5592557fe50e 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -27,7 +27,7 @@
 #include <sound/core.h>
 #include <sound/jack.h>
 
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_beep.h"
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index cb587dce67a9..67099cbb6be2 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -41,7 +41,7 @@
 #include <sound/hdaudio.h>
 #include <sound/hda_i915.h>
 #include <sound/hda_chmap.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_jack.h"
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1d117f00d04d..6f3c8e888c2a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -32,7 +32,7 @@
 #include <linux/input.h>
 #include <sound/core.h>
 #include <sound/jack.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
diff --git a/sound/pci/hda/patch_si3054.c b/sound/pci/hda/patch_si3054.c
index f63acb1b965c..c49d25bcd7f2 100644
--- a/sound/pci/hda/patch_si3054.c
+++ b/sound/pci/hda/patch_si3054.c
@@ -27,7 +27,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 
 /* si3054 verbs */
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 046705b4691a..d16a25a395c9 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -32,7 +32,7 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/jack.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_beep.h"
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 6b9617aee0e6..9f6f13e25145 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -52,7 +52,7 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/asoundef.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
-- 
2.18.0
