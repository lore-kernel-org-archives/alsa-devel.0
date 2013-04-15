From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/17] ASoC: dmaengine-pcm: Make requesting the
	DMA channel at PCM open optional
Date: Mon, 15 Apr 2013 19:19:48 +0200
Message-ID: <1366046404-8759-2-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id E9EB826520E
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:07 +0200 (CEST)
In-Reply-To: <1366046404-8759-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Refactor the dmaengine PCM library to allow the DMA channel to be requested
before opening a PCM substream. snd_dmaengine_pcm_open() now expects a DMA
channel instead of a filter function and filter parameter as its parameters.
snd_dmaengine_pcm_close() is updated to not release the DMA channel. This allows
a dmaengine based PCM driver to request its channels before the substream is
opened.

The patch also introduces two new functions, snd_dmaengine_pcm_open_request_chan()
and snd_dmaengine_pcm_close_release_chan(), which have the same signature and
behaviour of the old snd_dmaengine_pcm_{open,close}() and internally use the new
variants of these functions. All users of snd_dmaengine_pcm_{open,close}() are
updated to use snd_dmaengine_pcm_open_request_chan() and
snd_dmaengine_pcm_close_release_chan().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/dmaengine_pcm.h   |  6 +++-
 sound/soc/atmel/atmel-pcm-dma.c |  6 ++--
 sound/soc/cirrus/ep93xx-pcm.c   |  5 +--
 sound/soc/fsl/imx-pcm-dma.c     |  2 +-
 sound/soc/mxs/mxs-pcm.c         |  4 +--
 sound/soc/omap/omap-pcm.c       |  7 ++--
 sound/soc/pxa/mmp-pcm.c         |  5 +--
 sound/soc/soc-dmaengine-pcm.c   | 72 ++++++++++++++++++++++++++++-------------
 sound/soc/spear/spear_pcm.c     |  5 +--
 sound/soc/tegra/tegra_pcm.c     |  4 +--
 sound/soc/ux500/ux500_pcm.c     |  6 ++--
 11 files changed, 78 insertions(+), 44 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 9562042..d015d67 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -39,9 +39,13 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
 snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream *substream);
 
 int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
-	dma_filter_fn filter_fn, void *filter_data);
+	struct dma_chan *chan);
 int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
 
+int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
+	dma_filter_fn filter_fn, void *filter_data);
+int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream);
+
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
 
 /**
diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index bb07989..1d38fd0 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -155,7 +155,7 @@ static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (ssc->pdev)
 		sdata = ssc->pdev->dev.platform_data;
 
-	ret = snd_dmaengine_pcm_open(substream, filter, sdata);
+	ret = snd_dmaengine_pcm_open_request_chan(substream, filter, sdata);
 	if (ret) {
 		pr_err("atmel-pcm: dmaengine pcm open failed\n");
 		return -EINVAL;
@@ -171,7 +171,7 @@ static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	return 0;
 err:
-	snd_dmaengine_pcm_close(substream);
+	snd_dmaengine_pcm_close_release_chan(substream);
 	return ret;
 }
 
@@ -197,7 +197,7 @@ static int atmel_pcm_open(struct snd_pcm_substream *substream)
 
 static struct snd_pcm_ops atmel_pcm_ops = {
 	.open		= atmel_pcm_open,
-	.close		= snd_dmaengine_pcm_close,
+	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= atmel_pcm_hw_params,
 	.prepare	= atmel_pcm_dma_prepare,
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index 298946f..4880326 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -69,7 +69,8 @@ static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
 
 	snd_soc_set_runtime_hwparams(substream, &ep93xx_pcm_hardware);
 
-	return snd_dmaengine_pcm_open(substream, ep93xx_pcm_dma_filter,
+	return snd_dmaengine_pcm_open_request_chan(substream,
+			ep93xx_pcm_dma_filter,
 			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
 }
 
@@ -100,7 +101,7 @@ static int ep93xx_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops ep93xx_pcm_ops = {
 	.open		= ep93xx_pcm_open,
-	.close		= snd_dmaengine_pcm_close,
+	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= ep93xx_pcm_hw_params,
 	.hw_free	= ep93xx_pcm_hw_free,
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index ee838c8..c664782 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -100,7 +100,7 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 
 static struct snd_pcm_ops imx_pcm_ops = {
 	.open		= snd_imx_open,
-	.close		= snd_dmaengine_pcm_close,
+	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_imx_pcm_hw_params,
 	.trigger	= snd_dmaengine_pcm_trigger,
diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index ebbef85..7bceb16 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -87,7 +87,7 @@ static int snd_mxs_open(struct snd_pcm_substream *substream)
 
 	snd_soc_set_runtime_hwparams(substream, &snd_mxs_hardware);
 
-	return snd_dmaengine_pcm_open(substream, filter,
+	return snd_dmaengine_pcm_open_request_chan(substream, filter,
 		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
 }
 
@@ -104,7 +104,7 @@ static int snd_mxs_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops mxs_pcm_ops = {
 	.open		= snd_mxs_open,
-	.close		= snd_dmaengine_pcm_close,
+	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_mxs_pcm_hw_params,
 	.trigger	= snd_dmaengine_pcm_trigger,
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index c8e272f..c28e042 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -118,8 +118,9 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	return snd_dmaengine_pcm_open(substream, omap_dma_filter_fn,
-				      dma_data->filter_data);
+	return snd_dmaengine_pcm_open_request_chan(substream,
+						   omap_dma_filter_fn,
+						   dma_data->filter_data);
 }
 
 static int omap_pcm_mmap(struct snd_pcm_substream *substream,
@@ -135,7 +136,7 @@ static int omap_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops omap_pcm_ops = {
 	.open		= omap_pcm_open,
-	.close		= snd_dmaengine_pcm_close,
+	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= omap_pcm_hw_params,
 	.hw_free	= omap_pcm_hw_free,
diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 6c39802..3499300 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -131,7 +131,8 @@ static int mmp_pcm_open(struct snd_pcm_substream *substream)
 	dma_data.dma_res = r;
 	dma_data.ssp_id = cpu_dai->id;
 
-	return snd_dmaengine_pcm_open(substream, filter, &dma_data);
+	return snd_dmaengine_pcm_open_request_chan(substream, filter,
+		    &dma_data);
 }
 
 static int mmp_pcm_mmap(struct snd_pcm_substream *substream,
@@ -148,7 +149,7 @@ static int mmp_pcm_mmap(struct snd_pcm_substream *substream,
 
 struct snd_pcm_ops mmp_pcm_ops = {
 	.open		= mmp_pcm_open,
-	.close		= snd_dmaengine_pcm_close,
+	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= mmp_pcm_hw_params,
 	.trigger	= snd_dmaengine_pcm_trigger,
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index a9a300a..b0420a7 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -254,44 +254,38 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer);
 
-static int dmaengine_pcm_request_channel(struct dmaengine_pcm_runtime_data *prtd,
-	dma_filter_fn filter_fn, void *filter_data)
+static struct dma_chan *dmaengine_pcm_request_channel(dma_filter_fn filter_fn,
+	void *filter_data)
 {
 	dma_cap_mask_t mask;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 	dma_cap_set(DMA_CYCLIC, mask);
-	prtd->dma_chan = dma_request_channel(mask, filter_fn, filter_data);
-
-	if (!prtd->dma_chan)
-		return -ENXIO;
 
-	return 0;
+	return dma_request_channel(mask, filter_fn, filter_data);
 }
 
 /**
  * snd_dmaengine_pcm_open - Open a dmaengine based PCM substream
  * @substream: PCM substream
- * @filter_fn: Filter function used to request the DMA channel
- * @filter_data: Data passed to the DMA filter function
+ * @chan: DMA channel to use for data transfers
  *
  * Returns 0 on success, a negative error code otherwise.
  *
- * This function will request a DMA channel using the passed filter function and
- * data. The function should usually be called from the pcm open callback.
- *
- * Note that this function will use private_data field of the substream's
- * runtime. So it is not availabe to your pcm driver implementation. If you need
- * to keep additional data attached to a substream use
- * snd_dmaengine_pcm_{set,get}_data.
+ * The function should usually be called from the pcm open callback. Note that
+ * this function will use private_data field of the substream's runtime. So it
+ * is not availabe to your pcm driver implementation.
  */
 int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
-	dma_filter_fn filter_fn, void *filter_data)
+	struct dma_chan *chan)
 {
 	struct dmaengine_pcm_runtime_data *prtd;
 	int ret;
 
+	if (!chan)
+		return -ENXIO;
+
 	ret = snd_pcm_hw_constraint_integer(substream->runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0)
@@ -301,11 +295,7 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 	if (!prtd)
 		return -ENOMEM;
 
-	ret = dmaengine_pcm_request_channel(prtd, filter_fn, filter_data);
-	if (ret < 0) {
-		kfree(prtd);
-		return ret;
-	}
+	prtd->dma_chan = chan;
 
 	substream->runtime->private_data = prtd;
 
@@ -314,6 +304,27 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open);
 
 /**
+ * snd_dmaengine_pcm_open_request_chan - Open a dmaengine based PCM substream and request channel
+ * @substream: PCM substream
+ * @filter_fn: Filter function used to request the DMA channel
+ * @filter_data: Data passed to the DMA filter function
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * This function will request a DMA channel using the passed filter function and
+ * data. The function should usually be called from the pcm open callback. Note
+ * that this function will use private_data field of the substream's runtime. So
+ * it is not availabe to your pcm driver implementation.
+ */
+int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
+	dma_filter_fn filter_fn, void *filter_data)
+{
+	return snd_dmaengine_pcm_open(substream,
+		    dmaengine_pcm_request_channel(filter_fn, filter_data));
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
+
+/**
  * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
  * @substream: PCM substream
  */
@@ -321,11 +332,26 @@ int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
 
-	dma_release_channel(prtd->dma_chan);
 	kfree(prtd);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
 
+/**
+ * snd_dmaengine_pcm_release_chan_close - Close a dmaengine based PCM substream and release channel
+ * @substream: PCM substream
+ *
+ * Releases the DMA channel associated with the PCM substream.
+ */
+int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+
+	dma_release_channel(prtd->dma_chan);
+
+	return snd_dmaengine_pcm_close(substream);
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close_release_chan);
+
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index bfbcc1f..2fbd489 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -64,7 +64,8 @@ static int spear_pcm_open(struct snd_pcm_substream *substream)
 	if (ret)
 		return ret;
 
-	return snd_dmaengine_pcm_open(substream, dma_data->filter, dma_data)
+	return snd_dmaengine_pcm_open_request_chan(substream, dma_data->filter,
+				dma_data);
 }
 
 static int spear_pcm_mmap(struct snd_pcm_substream *substream,
@@ -79,7 +80,7 @@ static int spear_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops spear_pcm_ops = {
 	.open		= spear_pcm_open,
-	.close		= snd_dmaengine_pcm_close,
+	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= spear_pcm_hw_params,
 	.hw_free	= spear_pcm_hw_free,
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index 6d1c70c..f9f247c 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -64,7 +64,7 @@ static int tegra_pcm_open(struct snd_pcm_substream *substream)
 	/* Set HW params now that initialization is complete */
 	snd_soc_set_runtime_hwparams(substream, &tegra_pcm_hardware);
 
-	ret = snd_dmaengine_pcm_open(substream, NULL, NULL);
+	ret = snd_dmaengine_pcm_open_request_chan(substream, NULL, NULL);
 	if (ret) {
 		dev_err(dev, "dmaengine pcm open failed with err %d\n", ret);
 		return ret;
@@ -122,7 +122,7 @@ static int tegra_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops tegra_pcm_ops = {
 	.open		= tegra_pcm_open,
-	.close		= snd_dmaengine_pcm_close,
+	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= tegra_pcm_hw_params,
 	.hw_free	= tegra_pcm_hw_free,
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 09b5364..a7d4f04 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -125,8 +125,8 @@ static int ux500_pcm_open(struct snd_pcm_substream *substream)
 		dma_cfg->dst_info.data_width = mem_data_width;
 	}
 
-
-	ret = snd_dmaengine_pcm_open(substream, stedma40_filter, dma_cfg);
+	ret = snd_dmaengine_pcm_open_request_chan(substream, stedma40_filter,
+			dma_cfg);
 	if (ret) {
 		dev_dbg(dai->dev,
 			"%s: ERROR: snd_dmaengine_pcm_open failed (%d)!\n",
@@ -211,7 +211,7 @@ static int ux500_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops ux500_pcm_ops = {
 	.open		= ux500_pcm_open,
-	.close		= snd_dmaengine_pcm_close,
+	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= ux500_pcm_hw_params,
 	.hw_free	= ux500_pcm_hw_free,
-- 
1.8.0
