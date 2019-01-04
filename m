From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: simplify boolean tests" to
	the asoc tree
Date: Fri,  4 Jan 2019 17:09:50 +0000 (GMT)
Message-ID: <20190104170950.32C2811270A3@debutante.sirena.org.uk>
References: <20181216224910.16198-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E3A8267D70
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 18:09:52 +0100 (CET)
In-Reply-To: <20181216224910.16198-8-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Cezary Rojewski <cezary.rojewski@intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: simplify boolean tests

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

>From 10583cdac237b32c0d3f6027b06c5eec8bf91211 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Sun, 16 Dec 2018 16:49:08 -0600
Subject: [PATCH] ASoC: Intel: Atom: simplify boolean tests

Detected with Coccinelle

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
