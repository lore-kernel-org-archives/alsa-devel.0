From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Take a pm_runtime reference on DAPM
	devices that are enabled
Date: Mon,  5 Dec 2011 15:18:03 +0000
Message-ID: <1323098284-26961-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A35B103AF2
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 16:18:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

As for PCMs take a runtime power management reference to devices that are
in a non-off bias, avoiding the need to do this in individual drivers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f47e869..1a9fa47 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -39,6 +39,7 @@
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
 #include <linux/debugfs.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -1213,6 +1214,9 @@ static void dapm_pre_sequence_async(void *data, async_cookie_t cookie)
 	/* If we're off and we're not supposed to be go into STANDBY */
 	if (d->bias_level == SND_SOC_BIAS_OFF &&
 	    d->target_bias_level != SND_SOC_BIAS_OFF) {
+		if (d->dev)
+			pm_runtime_get_sync(d->dev);
+
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
 			dev_err(d->dev,
@@ -1252,6 +1256,9 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_OFF);
 		if (ret != 0)
 			dev_err(d->dev, "Failed to turn off bias: %d\n", ret);
+
+		if (d->dev)
+			pm_runtime_put_sync(d->dev);
 	}
 
 	/* If we just powered up then move to active bias */
-- 
1.7.7.3
