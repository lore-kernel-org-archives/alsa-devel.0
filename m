From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 1/2] ASoC: tegra: rename Tegra20-specific
	driver files
Date: Thu,  5 Apr 2012 15:54:53 -0600
Message-ID: <1333662894-22672-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FACD24840
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 23:55:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Rename these files so they include a specific hardware version in their
filenames. The contents is only touched minimally so that git's rename
tracking operates correctly; renaming all symbols in the files results
in a diff so large that the rename detection fails.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/Makefile                           |   12 ++++++------
 sound/soc/tegra/{tegra_das.c => tegra20_das.c}     |    4 ++--
 sound/soc/tegra/{tegra_das.h => tegra20_das.h}     |    2 +-
 sound/soc/tegra/{tegra_i2s.c => tegra20_i2s.c}     |    4 ++--
 sound/soc/tegra/{tegra_i2s.h => tegra20_i2s.h}     |    2 +-
 sound/soc/tegra/{tegra_spdif.c => tegra20_spdif.c} |    4 ++--
 sound/soc/tegra/{tegra_spdif.h => tegra20_spdif.h} |    2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)
 rename sound/soc/tegra/{tegra_das.c => tegra20_das.c} (98%)
 rename sound/soc/tegra/{tegra_das.h => tegra20_das.h} (98%)
 rename sound/soc/tegra/{tegra_i2s.c => tegra20_i2s.c} (99%)
 rename sound/soc/tegra/{tegra_i2s.h => tegra20_i2s.h} (99%)
 rename sound/soc/tegra/{tegra_spdif.c => tegra20_spdif.c} (99%)
 rename sound/soc/tegra/{tegra_spdif.h => tegra20_spdif.h} (99%)

diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index 714d360..4a33884 100644
--- a/sound/soc/tegra/Makefile
+++ b/sound/soc/tegra/Makefile
@@ -1,15 +1,15 @@
 # Tegra platform Support
 snd-soc-tegra-pcm-objs := tegra_pcm.o
 snd-soc-tegra-utils-objs += tegra_asoc_utils.o
-snd-soc-tegra-das-objs := tegra_das.o
-snd-soc-tegra-i2s-objs := tegra_i2s.o
-snd-soc-tegra-spdif-objs := tegra_spdif.o
+snd-soc-tegra20-das-objs := tegra20_das.o
+snd-soc-tegra20-i2s-objs := tegra20_i2s.o
+snd-soc-tegra20-spdif-objs := tegra20_spdif.o
 
 obj-$(CONFIG_SND_SOC_TEGRA) += snd-soc-tegra-pcm.o
 obj-$(CONFIG_SND_SOC_TEGRA) += snd-soc-tegra-utils.o
-obj-$(CONFIG_SND_SOC_TEGRA_DAS) += snd-soc-tegra-das.o
-obj-$(CONFIG_SND_SOC_TEGRA_I2S) += snd-soc-tegra-i2s.o
-obj-$(CONFIG_SND_SOC_TEGRA_SPDIF) += snd-soc-tegra-spdif.o
+obj-$(CONFIG_SND_SOC_TEGRA_DAS) += snd-soc-tegra20-das.o
+obj-$(CONFIG_SND_SOC_TEGRA_I2S) += snd-soc-tegra20-i2s.o
+obj-$(CONFIG_SND_SOC_TEGRA_SPDIF) += snd-soc-tegra20-spdif.o
 
 # Tegra machine Support
 snd-soc-tegra-wm8903-objs := tegra_wm8903.o
diff --git a/sound/soc/tegra/tegra_das.c b/sound/soc/tegra/tegra20_das.c
similarity index 98%
rename from sound/soc/tegra/tegra_das.c
rename to sound/soc/tegra/tegra20_das.c
index 3b3c1ba..b5e3698 100644
--- a/sound/soc/tegra/tegra_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -1,5 +1,5 @@
 /*
- * tegra_das.c - Tegra DAS driver
+ * tegra20_das.c - Tegra20 DAS driver
  *
  * Author: Stephen Warren <swarren@nvidia.com>
  * Copyright (C) 2010 - NVIDIA, Inc.
@@ -29,7 +29,7 @@
 #include <linux/io.h>
 #include <mach/iomap.h>
 #include <sound/soc.h>
-#include "tegra_das.h"
+#include "tegra20_das.h"
 
 #define DRV_NAME "tegra-das"
 
diff --git a/sound/soc/tegra/tegra_das.h b/sound/soc/tegra/tegra20_das.h
similarity index 98%
rename from sound/soc/tegra/tegra_das.h
rename to sound/soc/tegra/tegra20_das.h
index 1810cd1..896bf03 100644
--- a/sound/soc/tegra/tegra_das.h
+++ b/sound/soc/tegra/tegra20_das.h
@@ -1,5 +1,5 @@
 /*
- * tegra_das.h - Definitions for Tegra DAS driver
+ * tegra20_das.h - Definitions for Tegra20 DAS driver
  *
  * Author: Stephen Warren <swarren@nvidia.com>
  * Copyright (C) 2010 - NVIDIA, Inc.
diff --git a/sound/soc/tegra/tegra_i2s.c b/sound/soc/tegra/tegra20_i2s.c
similarity index 99%
rename from sound/soc/tegra/tegra_i2s.c
rename to sound/soc/tegra/tegra20_i2s.c
index 86f5ca4..fa71af2 100644
--- a/sound/soc/tegra/tegra_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -1,5 +1,5 @@
 /*
- * tegra_i2s.c - Tegra I2S driver
+ * tegra20_i2s.c - Tegra20 I2S driver
  *
  * Author: Stephen Warren <swarren@nvidia.com>
  * Copyright (C) 2010,2012 - NVIDIA, Inc.
@@ -43,7 +43,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include "tegra_i2s.h"
+#include "tegra20_i2s.h"
 
 #define DRV_NAME "tegra-i2s"
 
diff --git a/sound/soc/tegra/tegra_i2s.h b/sound/soc/tegra/tegra20_i2s.h
similarity index 99%
rename from sound/soc/tegra/tegra_i2s.h
rename to sound/soc/tegra/tegra20_i2s.h
index c08e019..56f1e0f 100644
--- a/sound/soc/tegra/tegra_i2s.h
+++ b/sound/soc/tegra/tegra20_i2s.h
@@ -1,5 +1,5 @@
 /*
- * tegra_i2s.h - Definitions for Tegra I2S driver
+ * tegra20_i2s.h - Definitions for Tegra20 I2S driver
  *
  * Author: Stephen Warren <swarren@nvidia.com>
  * Copyright (C) 2010 - NVIDIA, Inc.
diff --git a/sound/soc/tegra/tegra_spdif.c b/sound/soc/tegra/tegra20_spdif.c
similarity index 99%
rename from sound/soc/tegra/tegra_spdif.c
rename to sound/soc/tegra/tegra20_spdif.c
index e16c4ff..6b1bbe4 100644
--- a/sound/soc/tegra/tegra_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -1,5 +1,5 @@
 /*
- * tegra_spdif.c - Tegra SPDIF driver
+ * tegra20_spdif.c - Tegra20 SPDIF driver
  *
  * Author: Stephen Warren <swarren@nvidia.com>
  * Copyright (C) 2011-2012 - NVIDIA, Inc.
@@ -34,7 +34,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include "tegra_spdif.h"
+#include "tegra20_spdif.h"
 
 #define DRV_NAME "tegra-spdif"
 
diff --git a/sound/soc/tegra/tegra_spdif.h b/sound/soc/tegra/tegra20_spdif.h
similarity index 99%
rename from sound/soc/tegra/tegra_spdif.h
rename to sound/soc/tegra/tegra20_spdif.h
index f5fc712..001f9dc 100644
--- a/sound/soc/tegra/tegra_spdif.h
+++ b/sound/soc/tegra/tegra20_spdif.h
@@ -1,5 +1,5 @@
 /*
- * tegra_spdif.h - Definitions for Tegra SPDIF driver
+ * tegra20_spdif.h - Definitions for Tegra20 SPDIF driver
  *
  * Author: Stephen Warren <swarren@nvidia.com>
  * Copyright (C) 2011 - NVIDIA, Inc.
-- 
1.7.0.4
