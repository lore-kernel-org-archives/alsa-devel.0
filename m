From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 2/5] ALSA: convert users to core
	bus_parse_capabilities
Date: Wed,  3 Aug 2016 21:36:11 +0530
Message-ID: <1470240374-20018-3-git-send-email-vinod.koul@intel.com>
References: <1470240374-20018-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 448F82675F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2016 17:59:24 +0200 (CEST)
In-Reply-To: <1470240374-20018-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Now that we have the bus parse capabilities moved to core, we need to
convert users.

The SKL driver and HDA extended lib needs to converted in single patch,
otherwise we regress on the functionality.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_controller.c    | 16 ++++++------
 sound/hda/ext/hdac_ext_stream.c        | 46 +++++++++++++++++-----------------
 sound/soc/intel/skylake/skl-messages.c |  4 +--
 sound/soc/intel/skylake/skl-pcm.c      |  8 +++---
 sound/soc/intel/skylake/skl.c          |  6 ++---
 5 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 860f8cad6602..cd65e007e864 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -118,15 +118,15 @@ void snd_hdac_ext_bus_ppcap_enable(struct hdac_ext_bus *ebus, bool enable)
 {
 	struct hdac_bus *bus = &ebus->bus;
 
-	if (!ebus->ppcap) {
+	if (!bus->ppcap) {
 		dev_err(bus->dev, "Address of PP capability is NULL");
 		return;
 	}
 
 	if (enable)
-		snd_hdac_updatel(ebus->ppcap, AZX_REG_PP_PPCTL, 0, AZX_PPCTL_GPROCEN);
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, 0, AZX_PPCTL_GPROCEN);
 	else
-		snd_hdac_updatel(ebus->ppcap, AZX_REG_PP_PPCTL, AZX_PPCTL_GPROCEN, 0);
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, AZX_PPCTL_GPROCEN, 0);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_ppcap_enable);
 
@@ -139,15 +139,15 @@ void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_ext_bus *ebus, bool enable)
 {
 	struct hdac_bus *bus = &ebus->bus;
 
-	if (!ebus->ppcap) {
+	if (!bus->ppcap) {
 		dev_err(bus->dev, "Address of PP capability is NULL\n");
 		return;
 	}
 
 	if (enable)
-		snd_hdac_updatel(ebus->ppcap, AZX_REG_PP_PPCTL, 0, AZX_PPCTL_PIE);
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, 0, AZX_PPCTL_PIE);
 	else
-		snd_hdac_updatel(ebus->ppcap, AZX_REG_PP_PPCTL, AZX_PPCTL_PIE, 0);
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, AZX_PPCTL_PIE, 0);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_ppcap_int_enable);
 
@@ -171,7 +171,7 @@ int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *ebus)
 	struct hdac_ext_link *hlink;
 	struct hdac_bus *bus = &ebus->bus;
 
-	link_count = readl(ebus->mlcap + AZX_REG_ML_MLCD) + 1;
+	link_count = readl(bus->mlcap + AZX_REG_ML_MLCD) + 1;
 
 	dev_dbg(bus->dev, "In %s Link count: %d\n", __func__, link_count);
 
@@ -181,7 +181,7 @@ int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *ebus)
 			return -ENOMEM;
 		hlink->index = idx;
 		hlink->bus = bus;
-		hlink->ml_addr = ebus->mlcap + AZX_ML_BASE +
+		hlink->ml_addr = bus->mlcap + AZX_ML_BASE +
 					(AZX_ML_INTERVAL * idx);
 		hlink->lcaps  = readl(hlink->ml_addr + AZX_REG_ML_LCAP);
 		hlink->lsdiid = readw(hlink->ml_addr + AZX_REG_ML_LSDIID);
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 626f3bb24c55..2441273adcef 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -40,27 +40,27 @@ void snd_hdac_ext_stream_init(struct hdac_ext_bus *ebus,
 {
 	struct hdac_bus *bus = &ebus->bus;
 
-	if (ebus->ppcap) {
-		stream->pphc_addr = ebus->ppcap + AZX_PPHC_BASE +
+	if (bus->ppcap) {
+		stream->pphc_addr = bus->ppcap + AZX_PPHC_BASE +
 				AZX_PPHC_INTERVAL * idx;
 
-		stream->pplc_addr = ebus->ppcap + AZX_PPLC_BASE +
+		stream->pplc_addr = bus->ppcap + AZX_PPLC_BASE +
 				AZX_PPLC_MULTI * ebus->num_streams +
 				AZX_PPLC_INTERVAL * idx;
 	}
 
-	if (ebus->spbcap) {
-		stream->spib_addr = ebus->spbcap + AZX_SPB_BASE +
+	if (bus->spbcap) {
+		stream->spib_addr = bus->spbcap + AZX_SPB_BASE +
 					AZX_SPB_INTERVAL * idx +
 					AZX_SPB_SPIB;
 
-		stream->fifo_addr = ebus->spbcap + AZX_SPB_BASE +
+		stream->fifo_addr = bus->spbcap + AZX_SPB_BASE +
 					AZX_SPB_INTERVAL * idx +
 					AZX_SPB_MAXFIFO;
 	}
 
-	if (ebus->drsmcap)
-		stream->dpibr_addr = ebus->drsmcap + AZX_DRSM_BASE +
+	if (bus->drsmcap)
+		stream->dpibr_addr = bus->drsmcap + AZX_DRSM_BASE +
 					AZX_DRSM_INTERVAL * idx;
 
 	stream->decoupled = false;
@@ -131,10 +131,10 @@ void snd_hdac_ext_stream_decouple(struct hdac_ext_bus *ebus,
 
 	spin_lock_irq(&bus->reg_lock);
 	if (decouple)
-		snd_hdac_updatel(ebus->ppcap, AZX_REG_PP_PPCTL, 0,
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, 0,
 				AZX_PPCTL_PROCEN(hstream->index));
 	else
-		snd_hdac_updatel(ebus->ppcap, AZX_REG_PP_PPCTL,
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL,
 					AZX_PPCTL_PROCEN(hstream->index), 0);
 	stream->decoupled = decouple;
 	spin_unlock_irq(&bus->reg_lock);
@@ -255,7 +255,7 @@ hdac_ext_link_stream_assign(struct hdac_ext_bus *ebus,
 	struct hdac_stream *stream = NULL;
 	struct hdac_bus *hbus = &ebus->bus;
 
-	if (!ebus->ppcap) {
+	if (!hbus->ppcap) {
 		dev_err(hbus->dev, "stream type not supported\n");
 		return NULL;
 	}
@@ -296,7 +296,7 @@ hdac_ext_host_stream_assign(struct hdac_ext_bus *ebus,
 	struct hdac_stream *stream = NULL;
 	struct hdac_bus *hbus = &ebus->bus;
 
-	if (!ebus->ppcap) {
+	if (!hbus->ppcap) {
 		dev_err(hbus->dev, "stream type not supported\n");
 		return NULL;
 	}
@@ -423,21 +423,21 @@ void snd_hdac_ext_stream_spbcap_enable(struct hdac_ext_bus *ebus,
 	u32 register_mask = 0;
 	struct hdac_bus *bus = &ebus->bus;
 
-	if (!ebus->spbcap) {
+	if (!bus->spbcap) {
 		dev_err(bus->dev, "Address of SPB capability is NULL");
 		return;
 	}
 
 	mask |= (1 << index);
 
-	register_mask = readl(ebus->spbcap + AZX_REG_SPB_SPBFCCTL);
+	register_mask = readl(bus->spbcap + AZX_REG_SPB_SPBFCCTL);
 
 	mask |= register_mask;
 
 	if (enable)
-		snd_hdac_updatel(ebus->spbcap, AZX_REG_SPB_SPBFCCTL, 0, mask);
+		snd_hdac_updatel(bus->spbcap, AZX_REG_SPB_SPBFCCTL, 0, mask);
 	else
-		snd_hdac_updatel(ebus->spbcap, AZX_REG_SPB_SPBFCCTL, mask, 0);
+		snd_hdac_updatel(bus->spbcap, AZX_REG_SPB_SPBFCCTL, mask, 0);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_spbcap_enable);
 
@@ -452,7 +452,7 @@ int snd_hdac_ext_stream_set_spib(struct hdac_ext_bus *ebus,
 {
 	struct hdac_bus *bus = &ebus->bus;
 
-	if (!ebus->spbcap) {
+	if (!bus->spbcap) {
 		dev_err(bus->dev, "Address of SPB capability is NULL");
 		return -EINVAL;
 	}
@@ -475,7 +475,7 @@ int snd_hdac_ext_stream_get_spbmaxfifo(struct hdac_ext_bus *ebus,
 {
 	struct hdac_bus *bus = &ebus->bus;
 
-	if (!ebus->spbcap) {
+	if (!bus->spbcap) {
 		dev_err(bus->dev, "Address of SPB capability is NULL");
 		return -EINVAL;
 	}
@@ -515,21 +515,21 @@ void snd_hdac_ext_stream_drsm_enable(struct hdac_ext_bus *ebus,
 	u32 register_mask = 0;
 	struct hdac_bus *bus = &ebus->bus;
 
-	if (!ebus->drsmcap) {
+	if (!bus->drsmcap) {
 		dev_err(bus->dev, "Address of DRSM capability is NULL");
 		return;
 	}
 
 	mask |= (1 << index);
 
-	register_mask = readl(ebus->drsmcap + AZX_REG_SPB_SPBFCCTL);
+	register_mask = readl(bus->drsmcap + AZX_REG_SPB_SPBFCCTL);
 
 	mask |= register_mask;
 
 	if (enable)
-		snd_hdac_updatel(ebus->drsmcap, AZX_REG_DRSM_CTL, 0, mask);
+		snd_hdac_updatel(bus->drsmcap, AZX_REG_DRSM_CTL, 0, mask);
 	else
-		snd_hdac_updatel(ebus->drsmcap, AZX_REG_DRSM_CTL, mask, 0);
+		snd_hdac_updatel(bus->drsmcap, AZX_REG_DRSM_CTL, mask, 0);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_drsm_enable);
 
@@ -544,7 +544,7 @@ int snd_hdac_ext_stream_set_dpibr(struct hdac_ext_bus *ebus,
 {
 	struct hdac_bus *bus = &ebus->bus;
 
-	if (!ebus->drsmcap) {
+	if (!bus->drsmcap) {
 		dev_err(bus->dev, "Address of DRSM capability is NULL");
 		return -EINVAL;
 	}
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 44ab595ce21a..83a731fc884e 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -296,7 +296,7 @@ int skl_suspend_dsp(struct skl *skl)
 	int ret;
 
 	/* if ppcap is not supported return 0 */
-	if (!skl->ebus.ppcap)
+	if (!skl->ebus.bus.ppcap)
 		return 0;
 
 	ret = skl_dsp_sleep(ctx->dsp);
@@ -316,7 +316,7 @@ int skl_resume_dsp(struct skl *skl)
 	int ret;
 
 	/* if ppcap is not supported return 0 */
-	if (!skl->ebus.ppcap)
+	if (!skl->ebus.bus.ppcap)
 		return 0;
 
 	/* enable ppcap interrupt */
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 6e05bf8622f7..5ae86c227d45 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -106,7 +106,7 @@ static void skl_set_pcm_constrains(struct hdac_ext_bus *ebus,
 
 static enum hdac_ext_stream_type skl_get_host_stream_type(struct hdac_ext_bus *ebus)
 {
-	if (ebus->ppcap)
+	if ((ebus_to_hbus(ebus))->ppcap)
 		return HDAC_EXT_STREAM_TYPE_HOST;
 	else
 		return HDAC_EXT_STREAM_TYPE_COUPLED;
@@ -188,7 +188,7 @@ static int skl_get_format(struct snd_pcm_substream *substream,
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	int format_val = 0;
 
-	if (ebus->ppcap) {
+	if ((ebus_to_hbus(ebus))->ppcap) {
 		struct snd_pcm_runtime *runtime = substream->runtime;
 
 		format_val = snd_hdac_calc_stream_format(runtime->rate,
@@ -1020,7 +1020,7 @@ static int skl_platform_pcm_trigger(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
 
-	if (!ebus->ppcap)
+	if ((ebus_to_hbus(ebus))->ppcap)
 		return skl_coupled_trigger(substream, cmd);
 
 	return 0;
@@ -1144,7 +1144,7 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 	struct skl *skl = ebus_to_skl(ebus);
 	int ret;
 
-	if (ebus->ppcap) {
+	if ((ebus_to_hbus(ebus))->ppcap) {
 		ret = skl_tplg_init(platform, ebus);
 		if (ret < 0) {
 			dev_err(platform->dev, "Failed to init topology!\n");
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index cd59536a761d..a893ca13be8e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -587,7 +587,7 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 		return -ENXIO;
 	}
 
-	snd_hdac_ext_bus_parse_capabilities(ebus);
+	snd_hdac_bus_parse_capabilities(bus);
 
 	if (skl_acquire_irq(ebus, 0) < 0)
 		return -EBUSY;
@@ -682,7 +682,7 @@ static int skl_probe(struct pci_dev *pci,
 	skl_dmic_data.dmic_num = skl_get_dmic_geo(skl);
 
 	/* check if dsp is there */
-	if (ebus->ppcap) {
+	if (bus->ppcap) {
 		err = skl_machine_device_register(skl,
 				  (void *)pci_id->driver_data);
 		if (err < 0)
@@ -696,7 +696,7 @@ static int skl_probe(struct pci_dev *pci,
 		skl->skl_sst->enable_miscbdcge = skl_enable_miscbdcge;
 
 	}
-	if (ebus->mlcap)
+	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(ebus);
 
 	/* create device for soc dmic */
-- 
1.9.1
