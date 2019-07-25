From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Fix some acpi vs apci typo in somme comments" to the asoc tree
Date: Thu, 25 Jul 2019 14:19:25 +0100 (BST)
Message-ID: <20190725131925.D36082742B5F@ypsilon.sirena.org.uk>
References: <20190725053523.16542-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725053523.16542-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, kernel-janitors@vger.kernel.org, liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, pierre-louis.bossart@linux.intel.com, tiwai@suse.com, yang.jie@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Fix some acpi vs apci typo in somme comments

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 72ea86391cd3249638fbef340b865c4bfa31465b Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Thu, 25 Jul 2019 07:35:23 +0200
Subject: [PATCH] ASoC: Intel: Fix some acpi vs apci typo in somme comments

Fix some typo to have the filaname given in a comment match the real name
of the file.
Some 'acpi' have erroneously been written 'apci'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20190725053523.16542-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-byt-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-cht-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-glk-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-hda-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c | 2 +-
 sound/soc/intel/common/soc-acpi-intel-icl-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-skl-match.c     | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 229e39586868..4a5adae1d785 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
+ * soc-acpi-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index b94b482ac34f..1cc801ba92eb 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-byt-match.c - tables and support for BYT ACPI enumeration.
+ * soc-acpi-intel-byt-match.c - tables and support for BYT ACPI enumeration.
  *
  * Copyright (c) 2017, Intel Corporation.
  */
diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index b7f11f6be1cf..d0fb43c2b9f6 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-cht-match.c - tables and support for CHT ACPI enumeration.
+ * soc-acpi-intel-cht-match.c - tables and support for CHT ACPI enumeration.
  *
  * Copyright (c) 2017, Intel Corporation.
  */
diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
index c36c0aa4f683..771b0ef21051 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-cnl-match.c - tables and support for CNL ACPI enumeration.
+ * soc-acpi-intel-cnl-match.c - tables and support for CNL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 616eb09e78a0..60dea358fa04 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-glk-match.c - tables and support for GLK ACPI enumeration.
+ * soc-acpi-intel-glk-match.c - tables and support for GLK ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-hda-match.c b/sound/soc/intel/common/soc-acpi-intel-hda-match.c
index 68ae43f7b4b2..cc972d2ac691 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hda-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hda-match.c
@@ -2,7 +2,7 @@
 // Copyright (c) 2018, Intel Corporation.
 
 /*
- * soc-apci-intel-hda-match.c - tables and support for HDA+ACPI enumeration.
+ * soc-acpi-intel-hda-match.c - tables and support for HDA+ACPI enumeration.
  *
  */
 
diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index d27853e7a369..34eb0baaa951 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-hsw-bdw-match.c - tables and support for ACPI enumeration.
+ * soc-acpi-intel-hsw-bdw-match.c - tables and support for ACPI enumeration.
  *
  * Copyright (c) 2017, Intel Corporation.
  */
diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
index 0b430b9b3673..38977669b576 100644
--- a/sound/soc/intel/common/soc-acpi-intel-icl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-icl-match.c - tables and support for ICL ACPI enumeration.
+ * soc-acpi-intel-icl-match.c - tables and support for ICL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
index 4b331058e807..e200baa11011 100644
--- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-kbl-match.c - tables and support for KBL ACPI enumeration.
+ * soc-acpi-intel-kbl-match.c - tables and support for KBL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-skl-match.c b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
index 0c9c0edd35b3..42fa40a8d932 100644
--- a/sound/soc/intel/common/soc-acpi-intel-skl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-skl-match.c - tables and support for SKL ACPI enumeration.
+ * soc-acpi-intel-skl-match.c - tables and support for SKL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
-- 
2.20.1
