From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Hold runtime PM references to
	components of active DAIs
Date: Mon,  5 Dec 2011 00:01:27 +0000
Message-ID: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E5961039C8
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 01:01:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Every device that implements runtime power management for DAIs is doing
it in pretty much the same way: in the startup callback they take a
runtime PM reference and then in the shutdown callback they release that
reference, keeping the device active while the DAI is active. Given the
frequency with which this is done and the obviousness of the need to keep
the device active in this period factor the code out into the core, taking
references on the device for each CPU DAI, CODEC DAI and DMA device in the
core.

As runtime PM is reference counted this shouldn't interfere with any
other reference holding by the drivers, and since (in common with the
existing implementations) we don't check for errors on enabling it
shouldn't matter if the device actually has runtime PM enabled or not.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-pcm.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 49aa71e..8aa7cec 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <sound/core.h>
@@ -77,6 +78,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_soc_dai_driver *codec_dai_drv = codec_dai->driver;
 	int ret = 0;
 
+	pm_runtime_get_sync(cpu_dai->dev);
+	pm_runtime_get_sync(codec_dai->dev);
+	pm_runtime_get_sync(platform->dev);
+
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
 	/* startup the audio subsystem */
@@ -233,6 +238,11 @@ platform_err:
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 out:
 	mutex_unlock(&rtd->pcm_mutex);
+
+	pm_runtime_put(platform->dev);
+	pm_runtime_put(codec_dai->dev);
+	pm_runtime_put(cpu_dai->dev);
+
 	return ret;
 }
 
@@ -339,6 +349,11 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
+
+	pm_runtime_put(platform->dev);
+	pm_runtime_put(codec_dai->dev);
+	pm_runtime_put(cpu_dai->dev);
+
 	return 0;
 }
 
-- 
1.7.7.3
