From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 10/13] soundwire: cdns: Add port routines
Date: Mon, 16 Apr 2018 20:53:38 +0530
Message-ID: <1523892221-16169-11-git-send-email-vinod.koul@intel.com>
References: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DD16267645
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 17:19:38 +0200 (CEST)
In-Reply-To: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
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

Add support for Cadence port management and implement
master port ops.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/cadence_master.c | 244 +++++++++++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h | 100 +++++++++++++++
 drivers/soundwire/intel.c          |   1 +
 3 files changed, 345 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index b0c09efd8f83..15d87c67d006 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -669,6 +669,121 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 }
 EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
+static int cdns_allocate_pdi(struct sdw_cdns *cdns,
+			struct sdw_cdns_pdi **stream,
+			u32 num, u32 pdi_offset)
+{
+	struct sdw_cdns_pdi *pdi;
+	int i;
+
+	if (!num)
+		return 0;
+
+	pdi = devm_kcalloc(cdns->dev, num, sizeof(*pdi), GFP_KERNEL);
+	if (!pdi)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		pdi[i].num = i + pdi_offset;
+		pdi[i].assigned = false;
+	}
+
+	*stream = pdi;
+	return 0;
+}
+
+/**
+ * sdw_cdns_pdi_init: PDI initialization routine
+ *
+ * @cdns: Cadence instance
+ * @config: Stream configurations
+ */
+int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
+			struct sdw_cdns_stream_config config)
+{
+	struct sdw_cdns_streams *stream;
+	int offset, i, ret;
+
+	cdns->pcm.num_bd = config.pcm_bd;
+	cdns->pcm.num_in = config.pcm_in;
+	cdns->pcm.num_out = config.pcm_out;
+	cdns->pdm.num_bd = config.pdm_bd;
+	cdns->pdm.num_in = config.pdm_in;
+	cdns->pdm.num_out = config.pdm_out;
+
+	/* Allocate PDIs for PCMs */
+	stream = &cdns->pcm;
+
+	/* First two PDIs are reserved for bulk transfers */
+	stream->num_bd -= CDNS_PCM_PDI_OFFSET;
+	offset = CDNS_PCM_PDI_OFFSET;
+
+	ret = cdns_allocate_pdi(cdns, &stream->bd,
+				stream->num_bd, offset);
+	if (ret)
+		return ret;
+
+	offset += stream->num_bd;
+
+	ret = cdns_allocate_pdi(cdns, &stream->in,
+				stream->num_in, offset);
+	if (ret)
+		return ret;
+
+
+	offset += stream->num_in;
+
+	ret = cdns_allocate_pdi(cdns, &stream->out,
+				stream->num_out, offset);
+	if (ret)
+		return ret;
+
+	/* Update total number of PCM PDIs */
+	stream->num_pdi = stream->num_bd + stream->num_in + stream->num_out;
+	cdns->num_ports = stream->num_pdi;
+
+	/* Allocate PDIs for PDMs */
+	stream = &cdns->pdm;
+	offset = CDNS_PDM_PDI_OFFSET;
+	ret = cdns_allocate_pdi(cdns, &stream->bd,
+				stream->num_bd, offset);
+	if (ret)
+		return ret;
+
+	offset += stream->num_bd;
+
+	ret = cdns_allocate_pdi(cdns, &stream->in,
+				stream->num_in, offset);
+	if (ret)
+		return ret;
+
+	offset += stream->num_in;
+
+	ret = cdns_allocate_pdi(cdns, &stream->out,
+				stream->num_out, offset);
+	if (ret)
+		return ret;
+
+	/* Update total number of PDM PDIs */
+	stream->num_pdi = stream->num_bd + stream->num_in + stream->num_out;
+	cdns->num_ports += stream->num_pdi;
+
+	cdns->ports = devm_kcalloc(cdns->dev, cdns->num_ports,
+				sizeof(*cdns->ports), GFP_KERNEL);
+	if (!cdns->ports) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	for (i = 0; i < cdns->num_ports; i++) {
+		cdns->ports[i].assigned = false;
+		cdns->ports[i].num = i + 1; /* Port 0 reserved for bulk */
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_cdns_pdi_init);
+
 /**
  * sdw_cdns_init() - Cadence initialization
  * @cdns: Cadence instance
@@ -730,6 +845,134 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 }
 EXPORT_SYMBOL(sdw_cdns_init);
 
+int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	int mcp_clkctrl_off, mcp_clkctrl;
+	int divider;
+
+	if (!params->curr_dr_freq) {
+		dev_err(cdns->dev, "NULL curr_dr_freq");
+		return -EINVAL;
+	}
+
+	divider	= (params->max_dr_freq / params->curr_dr_freq) - 1;
+
+	if (params->next_bank)
+		mcp_clkctrl_off = CDNS_MCP_CLK_CTRL1;
+	else
+		mcp_clkctrl_off = CDNS_MCP_CLK_CTRL0;
+
+	mcp_clkctrl = cdns_readl(cdns, mcp_clkctrl_off);
+	mcp_clkctrl |= divider;
+	cdns_writel(cdns, mcp_clkctrl_off, mcp_clkctrl);
+
+	return 0;
+}
+EXPORT_SYMBOL(cdns_bus_conf);
+
+static int cdns_port_params(struct sdw_bus *bus,
+		struct sdw_port_params *p_params, unsigned int bank)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	int dpn_config = 0, dpn_config_off;
+
+	if (bank)
+		dpn_config_off = CDNS_DPN_B1_CONFIG(p_params->num);
+	else
+		dpn_config_off = CDNS_DPN_B0_CONFIG(p_params->num);
+
+	dpn_config = cdns_readl(cdns, dpn_config_off);
+
+	dpn_config |= ((p_params->bps - 1) <<
+				SDW_REG_SHIFT(CDNS_DPN_CONFIG_WL));
+	dpn_config |= (p_params->flow_mode <<
+				SDW_REG_SHIFT(CDNS_DPN_CONFIG_PORT_FLOW));
+	dpn_config |= (p_params->data_mode <<
+				SDW_REG_SHIFT(CDNS_DPN_CONFIG_PORT_DAT));
+
+	cdns_writel(cdns, dpn_config_off, dpn_config);
+
+	return 0;
+}
+
+static int cdns_transport_params(struct sdw_bus *bus,
+			struct sdw_transport_params *t_params,
+			enum sdw_reg_bank bank)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	int dpn_offsetctrl = 0, dpn_offsetctrl_off;
+	int dpn_config = 0, dpn_config_off;
+	int dpn_hctrl = 0, dpn_hctrl_off;
+	int num = t_params->port_num;
+	int dpn_samplectrl_off;
+
+	/*
+	 * Note: Only full data port is supported on the Master side for
+	 * both PCM and PDM ports.
+	 */
+
+	if (bank) {
+		dpn_config_off = CDNS_DPN_B1_CONFIG(num);
+		dpn_samplectrl_off = CDNS_DPN_B1_SAMPLE_CTRL(num);
+		dpn_hctrl_off = CDNS_DPN_B1_HCTRL(num);
+		dpn_offsetctrl_off = CDNS_DPN_B1_OFFSET_CTRL(num);
+	} else {
+		dpn_config_off = CDNS_DPN_B0_CONFIG(num);
+		dpn_samplectrl_off = CDNS_DPN_B0_SAMPLE_CTRL(num);
+		dpn_hctrl_off = CDNS_DPN_B0_HCTRL(num);
+		dpn_offsetctrl_off = CDNS_DPN_B0_OFFSET_CTRL(num);
+	}
+
+	dpn_config = cdns_readl(cdns, dpn_config_off);
+
+	dpn_config |= (t_params->blk_grp_ctrl <<
+				SDW_REG_SHIFT(CDNS_DPN_CONFIG_BGC));
+	dpn_config |= (t_params->blk_pkg_mode <<
+				SDW_REG_SHIFT(CDNS_DPN_CONFIG_BPM));
+	cdns_writel(cdns, dpn_config_off, dpn_config);
+
+	dpn_offsetctrl |= (t_params->offset1 <<
+				SDW_REG_SHIFT(CDNS_DPN_OFFSET_CTRL_1));
+	dpn_offsetctrl |= (t_params->offset2 <<
+				SDW_REG_SHIFT(CDNS_DPN_OFFSET_CTRL_2));
+	cdns_writel(cdns, dpn_offsetctrl_off,  dpn_offsetctrl);
+
+	dpn_hctrl |= (t_params->hstart <<
+				SDW_REG_SHIFT(CDNS_DPN_HCTRL_HSTART));
+	dpn_hctrl |= (t_params->hstop << SDW_REG_SHIFT(CDNS_DPN_HCTRL_HSTOP));
+	dpn_hctrl |= (t_params->lane_ctrl <<
+				SDW_REG_SHIFT(CDNS_DPN_HCTRL_LCTRL));
+
+	cdns_writel(cdns, dpn_hctrl_off, dpn_hctrl);
+	cdns_writel(cdns, dpn_samplectrl_off, (t_params->sample_interval - 1));
+
+	return 0;
+}
+
+static int cdns_port_enable(struct sdw_bus *bus,
+		struct sdw_enable_ch *enable_ch, unsigned int bank)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	int dpn_chnen_off, ch_mask;
+
+	if (bank)
+		dpn_chnen_off = CDNS_DPN_B1_CH_EN(enable_ch->port_num);
+	else
+		dpn_chnen_off = CDNS_DPN_B0_CH_EN(enable_ch->port_num);
+
+	ch_mask = enable_ch->ch_mask * enable_ch->enable;
+	cdns_writel(cdns, dpn_chnen_off, ch_mask);
+
+	return 0;
+}
+
+static const struct sdw_master_port_ops cdns_port_ops = {
+	.dpn_set_port_params = cdns_port_params,
+	.dpn_set_port_transport_params = cdns_transport_params,
+	.dpn_port_enable_ch = cdns_port_enable,
+};
+
 /**
  * sdw_cdns_probe() - Cadence probe routine
  * @cdns: Cadence instance
@@ -737,6 +980,7 @@ EXPORT_SYMBOL(sdw_cdns_init);
 int sdw_cdns_probe(struct sdw_cdns *cdns)
 {
 	init_completion(&cdns->tx_complete);
+	cdns->bus.port_ops = &cdns_port_ops;
 
 	return 0;
 }
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 3ec74fa5f4f9..98a17f57918f 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -5,6 +5,92 @@
 #define __SDW_CADENCE_H
 
 /**
+ * struct sdw_cdns_pdi: PDI (Physical Data Interface) instance
+ *
+ * @assigned: pdi assigned
+ * @num: pdi number
+ * @intel_alh_id: link identifier
+ * @l_ch_num: low channel for PDI
+ * @h_ch_num: high channel for PDI
+ * @ch_count: total channel count for PDI
+ * @dir: data direction
+ * @type: stream type, PDM or PCM
+ */
+struct sdw_cdns_pdi {
+	bool assigned;
+	int num;
+	int intel_alh_id;
+	int l_ch_num;
+	int h_ch_num;
+	int ch_count;
+	enum sdw_data_direction dir;
+	enum sdw_stream_type type;
+};
+
+/**
+ * struct sdw_cdns_port: Cadence port structure
+ *
+ * @num: port number
+ * @assigned: port assigned
+ * @ch: channel count
+ * @direction: data port direction
+ * @pdi: pdi for this port
+ */
+struct sdw_cdns_port {
+	unsigned int num;
+	bool assigned;
+	unsigned int ch;
+	enum sdw_data_direction direction;
+	struct sdw_cdns_pdi *pdi;
+};
+
+/**
+ * struct sdw_cdns_streams: Cadence stream data structure
+ *
+ * @num_bd: number of bidirectional streams
+ * @num_in: number of input streams
+ * @num_out: number of output streams
+ * @num_ch_bd: number of bidirectional stream channels
+ * @num_ch_bd: number of input stream channels
+ * @num_ch_bd: number of output stream channels
+ * @num_pdi: total number of PDIs
+ * @bd: bidirectional streams
+ * @in: input streams
+ * @out: output streams
+ */
+struct sdw_cdns_streams {
+	unsigned int num_bd;
+	unsigned int num_in;
+	unsigned int num_out;
+	unsigned int num_ch_bd;
+	unsigned int num_ch_in;
+	unsigned int num_ch_out;
+	unsigned int num_pdi;
+	struct sdw_cdns_pdi *bd;
+	struct sdw_cdns_pdi *in;
+	struct sdw_cdns_pdi *out;
+};
+
+/**
+ * struct sdw_cdns_stream_config: stream configuration
+ *
+ * @pcm_bd: number of bidirectional PCM streams supported
+ * @pcm_in: number of input PCM streams supported
+ * @pcm_out: number of output PCM streams supported
+ * @pdm_bd: number of bidirectional PDM streams supported
+ * @pdm_in: number of input PDM streams supported
+ * @pdm_out: number of output PDM streams supported
+ */
+struct sdw_cdns_stream_config {
+	unsigned int pcm_bd;
+	unsigned int pcm_in;
+	unsigned int pcm_out;
+	unsigned int pdm_bd;
+	unsigned int pdm_in;
+	unsigned int pdm_out;
+};
+
+/**
  * struct sdw_cdns - Cadence driver context
  * @dev: Linux device
  * @bus: Bus handle
@@ -12,6 +98,10 @@
  * @response_buf: SoundWire response buffer
  * @tx_complete: Tx completion
  * @defer: Defer pointer
+ * @ports: Data ports
+ * @num_ports: Total number of data ports
+ * @pcm: PCM streams
+ * @pdm: PDM streams
  * @registers: Cadence registers
  * @link_up: Link status
  * @msg_count: Messages sent on bus
@@ -25,6 +115,12 @@ struct sdw_cdns {
 	struct completion tx_complete;
 	struct sdw_defer *defer;
 
+	struct sdw_cdns_port *ports;
+	int num_ports;
+
+	struct sdw_cdns_streams pcm;
+	struct sdw_cdns_streams pdm;
+
 	void __iomem *registers;
 
 	bool link_up;
@@ -42,6 +138,8 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id);
 irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 
 int sdw_cdns_init(struct sdw_cdns *cdns);
+int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
+			struct sdw_cdns_stream_config config);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
 
 enum sdw_command_response
@@ -53,4 +151,6 @@ cdns_xfer_msg_defer(struct sdw_bus *bus,
 
 enum sdw_command_response
 cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
+
+int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params);
 #endif /* __SDW_CADENCE_H */
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index aa0c60133de5..a64f87a08cfd 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -257,6 +257,7 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.xfer_msg = cdns_xfer_msg,
 	.xfer_msg_defer = cdns_xfer_msg_defer,
 	.reset_page_addr = cdns_reset_page_addr,
+	.set_bus_conf = cdns_bus_conf,
 };
 
 /*
-- 
2.7.4
