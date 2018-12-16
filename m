From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 7/9] ASoC: Intel: Atom: simplify boolean tests
Date: Sun, 16 Dec 2018 16:49:08 -0600
Message-ID: <20181216224910.16198-8-pierre-louis.bossart@linux.intel.com>
References: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 68C602679E4
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 23:49:24 +0100 (CET)
In-Reply-To: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

Detected with Coccinelle

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c     | 2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
 sound/soc/intel/atom/sst/sst_acpi.c          | 2 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c | 2 +-
 sound/soc/intel/atom/sst/sst_loader.c        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 3672d36b4b66..d1207ea53523 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -647,7 +647,7 @@ static int sst_swm_mixer_event(struct snd_soc_dapm_widget *w,
 		set_mixer = false;
 	}
 
-	if (set_mixer == false)
+	if (!set_mixer)
 		return 0;
 
 	if (SND_SOC_DAPM_EVENT_ON(event) ||
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index afc559866095..aefa5ce4cb59 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -190,7 +190,7 @@ int sst_fill_stream_params(void *substream,
 	map = ctx->pdata->pdev_strm_map;
 	map_size = ctx->pdata->strm_map_size;
 
-	if (is_compress == true)
+	if (is_compress)
 		cstream = (struct snd_compr_stream *)substream;
 	else
 		pstream = (struct snd_pcm_substream *)substream;
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index ac542535b9d5..3a95ebbfc45d 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -334,7 +334,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = is_byt_cr(dev, &bytcr);
-	if (!((ret < 0) || (bytcr == false))) {
+	if (!(ret < 0 || !bytcr)) {
 		dev_info(dev, "Detected Baytrail-CR platform\n");
 
 		/* override resource info */
diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 5455d6e0ab53..a592df06aa58 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -146,7 +146,7 @@ static int sst_power_control(struct device *dev, bool state)
 	int ret = 0;
 	int usage_count = 0;
 
-	if (state == true) {
+	if (state) {
 		ret = pm_runtime_get_sync(dev);
 		usage_count = GET_USAGE_COUNT(dev);
 		dev_dbg(ctx->dev, "Enable: pm usage count: %d\n", usage_count);
diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index b8c456753f01..321c783cf833 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -269,7 +269,7 @@ static void sst_do_memcpy(struct list_head *memcpy_list)
 	struct sst_memcpy_list *listnode;
 
 	list_for_each_entry(listnode, memcpy_list, memcpylist) {
-		if (listnode->is_io == true)
+		if (listnode->is_io)
 			memcpy32_toio((void __iomem *)listnode->dstn,
 					listnode->src, listnode->size);
 		else
-- 
2.17.1
