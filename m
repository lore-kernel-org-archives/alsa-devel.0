From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 12/13] soundwire: intel: Add stream
	initialization
Date: Thu,  5 Apr 2018 22:18:23 +0530
Message-ID: <1522946904-2089-13-git-send-email-vinod.koul@intel.com>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id EC6A12676C7
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 18:44:37 +0200 (CEST)
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

Add Intel stream init routines which initialize the Physical
Data Interface (PDI), Audio Link Hub (ALH) and Audio shim.
Also add bank switch routines.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/intel.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index a64f87a08cfd..279cbd51cdfa 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -9,6 +9,8 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_intel.h>
@@ -234,6 +236,150 @@ static int intel_shim_init(struct sdw_intel *sdw)
 	return ret;
 }
 
+/*
+ * PDI routines
+ */
+static void intel_pdi_init(struct sdw_intel *sdw,
+			struct sdw_cdns_stream_config *config)
+{
+	void __iomem *shim = sdw->res->shim;
+	unsigned int link_id = sdw->instance;
+	int pcm_cap, pdm_cap;
+
+	/* PCM Stream Capability */
+	pcm_cap = intel_readw(shim, SDW_SHIM_PCMSCAP(link_id));
+
+	config->pcm_bd = (pcm_cap & SDW_SHIM_PCMSCAP_BSS) >>
+					SDW_REG_SHIFT(SDW_SHIM_PCMSCAP_BSS);
+	config->pcm_in = (pcm_cap & SDW_SHIM_PCMSCAP_ISS) >>
+					SDW_REG_SHIFT(SDW_SHIM_PCMSCAP_ISS);
+	config->pcm_out = (pcm_cap & SDW_SHIM_PCMSCAP_OSS) >>
+					SDW_REG_SHIFT(SDW_SHIM_PCMSCAP_OSS);
+
+	/* PDM Stream Capability */
+	pdm_cap = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
+
+	config->pdm_bd = (pdm_cap & SDW_SHIM_PDMSCAP_BSS) >>
+					SDW_REG_SHIFT(SDW_SHIM_PDMSCAP_BSS);
+	config->pdm_in = (pdm_cap & SDW_SHIM_PDMSCAP_ISS) >>
+					SDW_REG_SHIFT(SDW_SHIM_PDMSCAP_ISS);
+	config->pdm_out = (pdm_cap & SDW_SHIM_PDMSCAP_OSS) >>
+					SDW_REG_SHIFT(SDW_SHIM_PDMSCAP_OSS);
+}
+
+static int
+intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
+{
+	void __iomem *shim = sdw->res->shim;
+	unsigned int link_id = sdw->instance;
+	int count;
+
+	if (pcm) {
+
+		count = intel_readw(shim, SDW_SHIM_PCMSYCHC(link_id, pdi_num));
+	} else {
+		count = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
+		count = ((count & SDW_SHIM_PDMSCAP_CPSS) >>
+					SDW_REG_SHIFT(SDW_SHIM_PDMSCAP_CPSS));
+	}
+
+	/* zero based values for channel count in register */
+	count++;
+
+	return count;
+}
+
+static int intel_pdi_get_ch_update(struct sdw_intel *sdw,
+				struct sdw_cdns_pdi *pdi,
+				unsigned int num_pdi,
+				unsigned int *num_ch, bool pcm)
+{
+	int i, ch_count = 0;
+
+	for (i = 0; i < num_pdi; i++) {
+		pdi->ch_count = intel_pdi_get_ch_cap(sdw, pdi->num, pcm);
+		ch_count += pdi->ch_count;
+		pdi++;
+	}
+
+	*num_ch = ch_count;
+	return 0;
+}
+
+static int intel_pdi_stream_ch_update(struct sdw_intel *sdw,
+				struct sdw_cdns_streams *stream, bool pcm)
+{
+	intel_pdi_get_ch_update(sdw, stream->bd, stream->num_bd,
+			&stream->num_ch_bd, pcm);
+
+	intel_pdi_get_ch_update(sdw, stream->in, stream->num_in,
+			&stream->num_ch_in, pcm);
+
+	intel_pdi_get_ch_update(sdw, stream->out, stream->num_out,
+			&stream->num_ch_out, pcm);
+
+	return 0;
+}
+
+static int intel_pdi_ch_update(struct sdw_intel *sdw)
+{
+	/* First update PCM streams followed by PDM streams */
+	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pcm, true);
+	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pdm, false);
+
+	return 0;
+}
+
+static void
+intel_pdi_shim_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
+{
+	void __iomem *shim = sdw->res->shim;
+	unsigned int link_id = sdw->instance;
+	int pdi_conf = 0;
+
+	pdi->intel_alh_id = (link_id * 16) + pdi->num + 5;
+
+	/*
+	 * Program stream parameters to stream SHIM register
+	 * This is applicable for PCM stream only.
+	 */
+	if (pdi->type != SDW_STREAM_PCM)
+		return;
+
+	if (pdi->dir == SDW_DATA_DIR_RX)
+		pdi_conf |= SDW_SHIM_PCMSYCM_DIR;
+	else
+		pdi_conf &= ~(SDW_SHIM_PCMSYCM_DIR);
+
+	pdi_conf |= (pdi->intel_alh_id <<
+			SDW_REG_SHIFT(SDW_SHIM_PCMSYCM_STREAM));
+	pdi_conf |= (pdi->l_ch_num << SDW_REG_SHIFT(SDW_SHIM_PCMSYCM_LCHN));
+	pdi_conf |= (pdi->h_ch_num << SDW_REG_SHIFT(SDW_SHIM_PCMSYCM_HCHN));
+
+	intel_writew(shim, SDW_SHIM_PCMSYCHM(link_id, pdi->num), pdi_conf);
+}
+
+static void
+intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
+{
+	void __iomem *alh = sdw->res->alh;
+	unsigned int link_id = sdw->instance;
+	unsigned int conf;
+
+	pdi->intel_alh_id = (link_id * 16) + pdi->num + 5;
+
+	/* Program Stream config ALH register */
+	conf = intel_readl(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id));
+
+	conf |= (SDW_ALH_STRMZCFG_DMAT_VAL <<
+			SDW_REG_SHIFT(SDW_ALH_STRMZCFG_DMAT));
+
+	conf |= ((pdi->ch_count - 1) <<
+			SDW_REG_SHIFT(SDW_ALH_STRMZCFG_CHN));
+
+	intel_writel(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id), conf);
+}
+
 static int intel_prop_read(struct sdw_bus *bus)
 {
 	/* Initialize with default handler to read all DisCo properties */
@@ -265,6 +411,7 @@ static struct sdw_master_ops sdw_intel_ops = {
  */
 static int intel_probe(struct platform_device *pdev)
 {
+	struct sdw_cdns_stream_config config;
 	struct sdw_intel *sdw;
 	int ret;
 
@@ -287,6 +434,9 @@ static int intel_probe(struct platform_device *pdev)
 	sdw_intel_ops.read_prop = intel_prop_read;
 	sdw->cdns.bus.ops = &sdw_intel_ops;
 
+	sdw_intel_ops.read_prop = intel_prop_read;
+	sdw->cdns.bus.ops = &sdw_intel_ops;
+
 	platform_set_drvdata(pdev, sdw);
 
 	ret = sdw_add_bus_master(&sdw->cdns.bus);
@@ -304,9 +454,15 @@ static int intel_probe(struct platform_device *pdev)
 		goto err_init;
 
 	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
+
+	/* Read the PDI config and initialize cadence PDI */
+	intel_pdi_init(sdw, &config);
+	ret = sdw_cdns_pdi_init(&sdw->cdns, config);
 	if (ret)
 		goto err_init;
 
+	intel_pdi_ch_update(sdw);
+
 	/* Acquire IRQ */
 	ret = request_threaded_irq(sdw->res->irq, sdw_cdns_irq,
 			sdw_cdns_thread, IRQF_SHARED, KBUILD_MODNAME,
-- 
2.7.4
