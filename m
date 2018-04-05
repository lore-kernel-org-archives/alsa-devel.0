From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 13/13] soundwire: intel: Add audio DAI ops
Date: Thu,  5 Apr 2018 22:18:24 +0530
Message-ID: <1522946904-2089-14-git-send-email-vinod.koul@intel.com>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 716422676E4
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 18:44:39 +0200 (CEST)
In-Reply-To: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Add DAI registration and DAI ops for the Intel driver along with
callback for topology configuration.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/Kconfig           |   2 +-
 drivers/soundwire/intel.c           | 360 ++++++++++++++++++++++++++++++++++++
 drivers/soundwire/intel.h           |   4 +
 drivers/soundwire/intel_init.c      |   3 +
 include/linux/soundwire/sdw.h       |   3 +
 include/linux/soundwire/sdw_intel.h |  14 ++
 6 files changed, 385 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index b46084b4b1f8..19c8efb9a5ee 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -27,7 +27,7 @@ config SOUNDWIRE_INTEL
 	tristate "Intel SoundWire Master driver"
 	select SOUNDWIRE_CADENCE
 	select SOUNDWIRE_BUS
-	depends on X86 && ACPI
+	depends on X86 && ACPI && SND_SOC
 	---help---
 	  SoundWire Intel Master driver.
 	  If you have an Intel platform which has a SoundWire Master then
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 279cbd51cdfa..46c317171f71 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -87,6 +87,12 @@
 #define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
 #define SDW_ALH_STRMZCFG_CHN		GENMASK(19, 16)
 
+enum intel_pdi_type {
+	INTEL_PDI_IN = 0,
+	INTEL_PDI_OUT = 1,
+	INTEL_PDI_BD = 2,
+};
+
 struct sdw_intel {
 	struct sdw_cdns cdns;
 	int instance;
@@ -380,6 +386,349 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 	intel_writel(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id), conf);
 }
 
+static int intel_config_stream(struct sdw_intel *sdw,
+			struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai,
+			struct snd_pcm_hw_params *hw_params, int link_id)
+{
+	if (sdw->res->ops && sdw->res->ops->config_stream)
+		return sdw->res->ops->config_stream(sdw->res->arg,
+				substream, dai, hw_params, link_id);
+
+	return -EIO;
+}
+
+/*
+ * DAI routines
+ */
+
+static struct sdw_cdns_port *intel_alloc_port(struct sdw_intel *sdw,
+				u32 ch, u32 dir, bool pcm)
+{
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_cdns_port *port = NULL;
+	int i, ret = 0;
+
+	for (i = 0; i < cdns->num_ports; i++) {
+		if (cdns->ports[i].assigned == true)
+			continue;
+
+		port = &cdns->ports[i];
+		port->assigned = true;
+		port->direction = dir;
+		port->ch = ch;
+		break;
+	}
+
+	if (!port) {
+		dev_err(cdns->dev, "Unable to find a free port\n");
+		return NULL;
+	}
+
+	if (pcm) {
+		ret = sdw_cdns_alloc_stream(cdns, &cdns->pcm, port, ch, dir);
+		if (ret)
+			goto out;
+
+		intel_pdi_shim_configure(sdw, port->pdi);
+		sdw_cdns_config_stream(cdns, port, ch, dir, port->pdi);
+
+		intel_pdi_alh_configure(sdw, port->pdi);
+
+	} else {
+		ret = sdw_cdns_alloc_stream(cdns, &cdns->pdm, port, ch, dir);
+	}
+
+out:
+	if (ret) {
+		port->assigned = false;
+		port = NULL;
+	}
+
+	return port;
+}
+
+static void intel_port_cleanup(struct sdw_cdns_dma_data *dma)
+{
+	int i;
+
+	for (i = 0; i < dma->nr_ports; i++) {
+		if (dma->port[i]) {
+			dma->port[i]->pdi->assigned = false;
+			dma->port[i]->pdi = NULL;
+			dma->port[i]->assigned = false;
+			dma->port[i] = NULL;
+		}
+	}
+}
+
+static int intel_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_cdns_dma_data *dma;
+	struct sdw_stream_config sconfig;
+	struct sdw_port_config *pconfig;
+	int ret, i, ch, dir;
+	bool pcm = true;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma)
+		return -EIO;
+
+	ch = params_channels(params);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		dir = SDW_DATA_DIR_RX;
+	else
+		dir = SDW_DATA_DIR_TX;
+
+	if (dma->stream_type == SDW_STREAM_PDM) {
+		/* TODO: Check whether PDM decimator is already in use */
+		dma->nr_ports = sdw_cdns_get_stream(cdns, &cdns->pdm, ch, dir);
+		pcm = false;
+	} else {
+		dma->nr_ports = sdw_cdns_get_stream(cdns, &cdns->pcm, ch, dir);
+	}
+
+	if (!dma->nr_ports) {
+		dev_err(dai->dev, "ports/resources not available");
+		return -EINVAL;
+	}
+
+	dma->port = kcalloc(dma->nr_ports, sizeof(*dma->port), GFP_KERNEL);
+	if (!dma->port)
+		return -ENOMEM;
+
+	for (i = 0; i < dma->nr_ports; i++) {
+		dma->port[i] = intel_alloc_port(sdw, ch, dir, pcm);
+		if (!dma->port[i]) {
+			ret = -EINVAL;
+			goto port_error;
+		}
+	}
+
+	/* Inform DSP about PDI stream number */
+	for (i = 0; i < dma->nr_ports; i++) {
+		ret = intel_config_stream(sdw, substream, dai, params,
+				dma->port[i]->pdi->intel_alh_id);
+		if (ret)
+			goto port_error;
+	}
+
+	sconfig.direction = dir;
+	sconfig.ch_count = ch;
+	sconfig.frame_rate = params_rate(params);
+	sconfig.type = dma->stream_type;
+
+	if (dma->stream_type == SDW_STREAM_PDM) {
+		sconfig.frame_rate *= 50;
+		sconfig.bps = 1;
+	} else {
+		sconfig.bps = snd_pcm_format_width(params_format(params));
+	}
+
+	/* Port configuration */
+	pconfig = kcalloc(dma->nr_ports, sizeof(*pconfig), GFP_KERNEL);
+	if (!pconfig) {
+		ret =  -ENOMEM;
+		goto port_error;
+	}
+
+	for (i = 0; i < dma->nr_ports; i++) {
+		pconfig[i].num = dma->port[i]->num;
+		pconfig[i].ch_mask = (1 << ch) - 1;
+	}
+
+	ret = sdw_stream_add_master(&cdns->bus, &sconfig,
+				pconfig, dma->nr_ports, dma->stream);
+	if (ret) {
+		dev_err(cdns->dev, "add master to stream failed:%d", ret);
+		goto stream_error;
+	}
+
+	kfree(pconfig);
+	return ret;
+
+stream_error:
+	kfree(pconfig);
+port_error:
+	intel_port_cleanup(dma);
+	kfree(dma->port);
+	return ret;
+}
+
+static int
+intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_cdns_dma_data *dma;
+	int ret;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma)
+		return -EIO;
+
+	ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
+	if (ret < 0)
+		dev_err(dai->dev, "remove master from stream %s failed: %d",
+							dma->stream->name, ret);
+
+	intel_port_cleanup(dma);
+	kfree(dma->port);
+	return ret;
+}
+
+static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
+					void *stream, int direction)
+{
+	return cdns_set_sdw_stream(dai, stream, true, direction);
+}
+
+static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
+					void *stream, int direction)
+{
+	return cdns_set_sdw_stream(dai, stream, false, direction);
+}
+
+static struct snd_soc_dai_ops intel_pcm_dai_ops = {
+	.hw_params = intel_hw_params,
+	.hw_free = intel_hw_free,
+	.shutdown = sdw_cdns_shutdown,
+	.set_sdw_stream = intel_pcm_set_sdw_stream,
+};
+
+static struct snd_soc_dai_ops intel_pdm_dai_ops = {
+	.hw_params = intel_hw_params,
+	.hw_free = intel_hw_free,
+	.shutdown = sdw_cdns_shutdown,
+	.set_sdw_stream = intel_pdm_set_sdw_stream,
+};
+
+static const struct snd_soc_component_driver dai_component = {
+	.name           = "soundwire",
+};
+
+static int intel_create_dai(struct sdw_cdns *cdns,
+			struct snd_soc_dai_driver *dais,
+			enum intel_pdi_type type,
+			u32 num, u32 off, u32 max_ch, bool pcm)
+{
+	int i;
+
+	if (num == 0)
+		return 0;
+
+	 /* TODO: Read supported rates/formats from hardware */
+	for (i = off; i < (off + num); i++) {
+		dais[i].name = kasprintf(GFP_KERNEL, "SDW%d Pin%d",
+					cdns->instance, i);
+		if (!dais[i].name)
+			return -ENOMEM;
+
+		if (type == INTEL_PDI_BD || type == INTEL_PDI_OUT) {
+			dais[i].playback.stream_name = kasprintf(GFP_KERNEL,
+							"SDW%d Tx%d",
+							cdns->instance, i);
+			if (!dais[i].playback.stream_name) {
+				kfree(dais[i].name);
+				return -ENOMEM;
+			}
+
+			dais[i].playback.channels_min = 1;
+			dais[i].playback.channels_max = max_ch;
+			dais[i].playback.rates = SNDRV_PCM_RATE_48000;
+			dais[i].playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		}
+
+
+		if (type == INTEL_PDI_BD || type == INTEL_PDI_IN) {
+			dais[i].capture.stream_name = kasprintf(GFP_KERNEL,
+							"SDW%d Rx%d",
+							cdns->instance, i);
+			if (!dais[i].capture.stream_name) {
+				kfree(dais[i].name);
+				kfree(dais[i].playback.stream_name);
+				return -ENOMEM;
+			}
+
+			dais[i].playback.channels_min = 1;
+			dais[i].playback.channels_max = max_ch;
+			dais[i].capture.rates = SNDRV_PCM_RATE_48000;
+			dais[i].capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		}
+
+		dais[i].id = SDW_DAI_ID_RANGE_START + i;
+
+		if (pcm)
+			dais[i].ops = &intel_pcm_dai_ops;
+		else
+			dais[i].ops = &intel_pdm_dai_ops;
+	}
+
+	return 0;
+}
+
+static int intel_register_dai(struct sdw_intel *sdw)
+{
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_cdns_streams *stream;
+	struct snd_soc_dai_driver *dais;
+	int num_dai, ret, off = 0;
+
+	/* DAIs are created based on total number of PDIs supported */
+	num_dai = cdns->pcm.num_pdi + cdns->pdm.num_pdi;
+
+	dais = devm_kcalloc(cdns->dev, num_dai, sizeof(*dais), GFP_KERNEL);
+	if (!dais)
+		return -ENOMEM;
+
+	/* Create PCM DAIs */
+	stream = &cdns->pcm;
+
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN,
+			stream->num_in, off, stream->num_ch_in, true);
+	if (ret)
+		return ret;
+
+	off += cdns->pcm.num_in;
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_OUT,
+			cdns->pcm.num_out, off, stream->num_ch_out, true);
+	if (ret)
+		return ret;
+
+	off += cdns->pcm.num_out;
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_BD,
+			cdns->pcm.num_bd, off, stream->num_ch_bd, true);
+	if (ret)
+		return ret;
+
+	/* Create PDM DAIs */
+	stream = &cdns->pdm;
+	off += cdns->pcm.num_bd;
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN,
+			cdns->pdm.num_in, off, stream->num_ch_in, false);
+	if (ret)
+		return ret;
+
+
+	off += cdns->pdm.num_in;
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_OUT,
+			cdns->pdm.num_out, off, stream->num_ch_out, false);
+	if (ret)
+		return ret;
+
+	off += cdns->pdm.num_bd;
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_BD,
+			cdns->pdm.num_bd, off, stream->num_ch_bd, false);
+	if (ret)
+		return ret;
+
+	return snd_soc_register_component(cdns->dev, &dai_component,
+				dais, num_dai);
+}
+
 static int intel_prop_read(struct sdw_bus *bus)
 {
 	/* Initialize with default handler to read all DisCo properties */
@@ -473,8 +822,18 @@ static int intel_probe(struct platform_device *pdev)
 		goto err_init;
 	}
 
+	/* Register DAIs */
+	ret = intel_register_dai(sdw);
+	if (ret) {
+		dev_err(sdw->cdns.dev, "DAI registration failed: %d", ret);
+		snd_soc_unregister_component(sdw->cdns.dev);
+		goto err_dai;
+	}
+
 	return 0;
 
+err_dai:
+	free_irq(sdw->res->irq, sdw);
 err_init:
 	sdw_delete_bus_master(&sdw->cdns.bus);
 err_master_reg:
@@ -488,6 +847,7 @@ static int intel_remove(struct platform_device *pdev)
 	sdw = platform_get_drvdata(pdev);
 
 	free_irq(sdw->res->irq, sdw);
+	snd_soc_unregister_component(sdw->cdns.dev);
 	sdw_delete_bus_master(&sdw->cdns.bus);
 
 	return 0;
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index ffa30d9535a2..c1a5bac6212e 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -10,6 +10,8 @@
  * @shim: Audio shim pointer
  * @alh: ALH (Audio Link Hub) pointer
  * @irq: Interrupt line
+ * @ops: Shim callback ops
+ * @arg: Shim callback ops argument
  *
  * This is set as pdata for each link instance.
  */
@@ -18,6 +20,8 @@ struct sdw_intel_link_res {
 	void __iomem *shim;
 	void __iomem *alh;
 	int irq;
+	const struct sdw_intel_ops *ops;
+	void *arg;
 };
 
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 6f2bb99526f2..d1ea6b4d0ad3 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -111,6 +111,9 @@ static struct sdw_intel_ctx
 		link->res.shim = res->mmio_base + SDW_SHIM_BASE;
 		link->res.alh = res->mmio_base + SDW_ALH_BASE;
 
+		link->res.ops = res->ops;
+		link->res.arg = res->arg;
+
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 
 		pdevinfo.parent = res->parent;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 4d9c3f86d0f0..d995b40cf8b1 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -38,6 +38,9 @@ struct sdw_slave;
 
 #define SDW_VALID_PORT_RANGE(n)		(n <= 14 && n >= 1)
 
+#define SDW_DAI_ID_RANGE_START		100
+#define SDW_DAI_ID_RANGE_END		200
+
 /**
  * enum sdw_slave_status - Slave status
  * @SDW_SLAVE_UNATTACHED: Slave is not attached with the bus.
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 4b37528f592d..2b9573b8aedd 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -5,17 +5,31 @@
 #define __SDW_INTEL_H
 
 /**
+ * struct sdw_intel_ops: Intel audio driver callback ops
+ *
+ * @config_stream: configure the stream with the hw_params
+ */
+struct sdw_intel_ops {
+	int (*config_stream)(void *arg, void *substream,
+			void *dai, void *hw_params, int stream_num);
+};
+
+/**
  * struct sdw_intel_res - Soundwire Intel resource structure
  * @mmio_base: mmio base of SoundWire registers
  * @irq: interrupt number
  * @handle: ACPI parent handle
  * @parent: parent device
+ * @ops: callback ops
+ * @arg: callback arg
  */
 struct sdw_intel_res {
 	void __iomem *mmio_base;
 	int irq;
 	acpi_handle handle;
 	struct device *parent;
+	const struct sdw_intel_ops *ops;
+	void *arg;
 };
 
 void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res);
-- 
2.7.4
