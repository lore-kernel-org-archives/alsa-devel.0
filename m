From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: tegra: sort includes, remove mach/iomap.h
Date: Fri,  6 Apr 2012 11:12:25 -0600
Message-ID: <1333732345-9826-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DAE8F244B8
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 19:12:33 +0200 (CEST)
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

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra20_das.c   |    5 ++---
 sound/soc/tegra/tegra20_i2s.c   |    7 +++----
 sound/soc/tegra/tegra20_spdif.c |    5 ++---
 sound/soc/tegra/tegra_pcm.c     |    2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
index 486d7b2..812696d 100644
--- a/sound/soc/tegra/tegra20_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -20,14 +20,13 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include <linux/io.h>
-#include <mach/iomap.h>
 #include <sound/soc.h>
 #include "tegra20_das.h"
 
diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 878798c..9427f36 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -29,15 +29,14 @@
  */
 
 #include <linux/clk.h>
-#include <linux/module.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <mach/iomap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 052bff8..00a2d33 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -21,14 +21,13 @@
  */
 
 #include <linux/clk.h>
-#include <linux/module.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include <linux/io.h>
-#include <mach/iomap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index 476b8ac..127348d 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -29,8 +29,8 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
-- 
1.7.0.4
