From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core: Add platform DAI widget mapping.
Date: Wed,  7 Mar 2012 11:47:41 +0000
Message-ID: <1331120862-16161-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009amx259.postini.com (na3sys009aog130.obsmtp.com
	[74.125.149.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 14E21244BB
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 12:47:49 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id ed3so4558358wgb.8
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 03:47:48 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Add platform driver support for CPU DAI DAPM widgets.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dai.h |    1 +
 sound/soc/soc-core.c    |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index c429f24..3248fbc 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -241,6 +241,7 @@ struct snd_soc_dai {
 
 	struct snd_soc_dapm_widget *playback_widget;
 	struct snd_soc_dapm_widget *capture_widget;
+	struct snd_soc_dapm_context dapm;
 
 	/* DAI DMA data */
 	void *playback_dma_data;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5aef34a..f466b9d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1074,6 +1074,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 {
 	int ret = 0;
 	const struct snd_soc_platform_driver *driver = platform->driver;
+	struct snd_soc_dai *dai;
 
 	platform->card = card;
 	platform->dapm.card = card;
@@ -1087,6 +1088,14 @@ static int soc_probe_platform(struct snd_soc_card *card,
 		snd_soc_dapm_new_controls(&platform->dapm,
 			driver->dapm_widgets, driver->num_dapm_widgets);
 
+	/* Create DAPM widgets for each DAI stream */
+	list_for_each_entry(dai, &dai_list, list) {
+		if (dai->dev != platform->dev)
+			continue;
+
+		snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
+	}
+
 	if (driver->probe) {
 		ret = driver->probe(platform);
 		if (ret < 0) {
@@ -1222,9 +1231,12 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 	/* probe the cpu_dai */
 	if (!cpu_dai->probed &&
 			cpu_dai->driver->probe_order == order) {
+		cpu_dai->dapm.card = card;
 		if (!try_module_get(cpu_dai->dev->driver->owner))
 			return -ENODEV;
 
+		snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
+
 		if (cpu_dai->driver->probe) {
 			ret = cpu_dai->driver->probe(cpu_dai);
 			if (ret < 0) {
@@ -3241,6 +3253,7 @@ int snd_soc_register_dai(struct device *dev,
 
 	dai->dev = dev;
 	dai->driver = dai_drv;
+	dai->dapm.dev = dev;
 	if (!dai->driver->ops)
 		dai->driver->ops = &null_dai_ops;
 
@@ -3317,6 +3330,7 @@ int snd_soc_register_dais(struct device *dev,
 			dai->id = dai->driver->id;
 		else
 			dai->id = i;
+		dai->dapm.dev = dev;
 		if (!dai->driver->ops)
 			dai->driver->ops = &null_dai_ops;
 
-- 
1.7.5.4
