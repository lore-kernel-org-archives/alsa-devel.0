From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 11/13] soundwire: cdns: Add stream routines
Date: Thu,  5 Apr 2018 22:18:22 +0530
Message-ID: <1522946904-2089-12-git-send-email-vinod.koul@intel.com>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 904AF2676AB
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 18:44:33 +0200 (CEST)
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

Add support for Cadence stream initialization and implement
stream APIs.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/cadence_master.c | 180 +++++++++++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h |  43 +++++++++
 2 files changed, 223 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 89a4ae86d36a..9400327c9fe2 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -13,6 +13,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
 #include "bus.h"
 #include "cadence_master.h"
 
@@ -998,5 +1000,183 @@ int sdw_cdns_probe(struct sdw_cdns *cdns)
 }
 EXPORT_SYMBOL(sdw_cdns_probe);
 
+int cdns_set_sdw_stream(struct snd_soc_dai *dai,
+		void *stream, bool pcm, int direction)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_cdns_dma_data *dma;
+
+	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	if (pcm)
+		dma->stream_type = SDW_STREAM_PCM;
+	else
+		dma->stream_type = SDW_STREAM_PDM;
+
+	dma->bus = &cdns->bus;
+	dma->link_id = cdns->instance;
+
+	dma->stream = stream;
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+		dai->playback_dma_data = dma;
+	else
+		dai->capture_dma_data = dma;
+
+	return 0;
+
+}
+EXPORT_SYMBOL(cdns_set_sdw_stream);
+
+static struct sdw_cdns_pdi *cdns_find_pdi(struct sdw_cdns *cdns,
+		unsigned int num, struct sdw_cdns_pdi *pdi)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		if (pdi[i].assigned == true)
+			continue;
+		pdi[i].assigned = true;
+		return &pdi[i];
+	}
+
+	return NULL;
+}
+
+/**
+ * sdw_cdns_config_stream: Configure a stream
+ *
+ * @cdns: Cadence instance
+ * @port: Cadence data port
+ * @ch: Channel count
+ * @dir: Data direction
+ * @pdi: PDI to be used
+ */
+void sdw_cdns_config_stream(struct sdw_cdns *cdns,
+				struct sdw_cdns_port *port,
+				u32 ch, u32 dir, struct sdw_cdns_pdi *pdi)
+{
+	u32 offset, val = 0;
+
+	if (dir == SDW_DATA_DIR_RX)
+		val = CDNS_PORTCTRL_DIRN;
+
+	offset = CDNS_PORTCTRL + port->num * CDNS_PORT_OFFSET;
+	cdns_updatel(cdns, offset, CDNS_PORTCTRL_DIRN, val);
+
+	val = port->num;
+	val |= ((1 << ch) - 1) << SDW_REG_SHIFT(CDNS_PDI_CONFIG_CHANNEL);
+	cdns_writel(cdns, CDNS_PDI_CONFIG(pdi->num), val);
+}
+EXPORT_SYMBOL(sdw_cdns_config_stream);
+
+static int cdns_get_pdi(struct sdw_cdns *cdns,
+		struct sdw_cdns_pdi *pdi,
+		unsigned int num, u32 ch)
+{
+	int i, pdis = 0;
+	u32 ch_count = ch;
+
+	for (i = 0; i < num; i++) {
+		if (pdi[i].assigned == true)
+			continue;
+
+		if (pdi[i].ch_count < ch_count)
+			ch_count -= pdi[i].ch_count;
+		else
+			ch_count = 0;
+
+		pdis++;
+
+		if (!ch_count)
+			break;
+	}
+
+	if (ch_count)
+		return 0;
+
+	return pdis;
+}
+
+/**
+ * sdw_cdns_get_stream: Get stream information
+ *
+ * @cdns: Cadence instance
+ * @stream: Stream to be allocated
+ * @ch: Channel count
+ * @dir: Data direction
+ */
+int sdw_cdns_get_stream(struct sdw_cdns *cdns,
+			struct sdw_cdns_streams *stream,
+			u32 ch, u32 dir)
+{
+	int pdis = 0;
+
+	if (dir == SDW_DATA_DIR_RX)
+		pdis = cdns_get_pdi(cdns, stream->in, stream->num_in, ch);
+	else
+		pdis = cdns_get_pdi(cdns, stream->out, stream->num_out, ch);
+
+	/* check if we found PDI, else find in bi-directional */
+	if (!pdis)
+		pdis = cdns_get_pdi(cdns, stream->bd, stream->num_bd, ch);
+
+	return pdis;
+}
+EXPORT_SYMBOL(sdw_cdns_get_stream);
+
+/**
+ * sdw_cdns_alloc_stream: Allocate a stream
+ *
+ * @cdns: Cadence instance
+ * @stream: Stream to be allocated
+ * @port: Cadence data port
+ * @ch: Channel count
+ * @dir: Data direction
+ */
+int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
+			struct sdw_cdns_streams *stream,
+			struct sdw_cdns_port *port, u32 ch, u32 dir)
+{
+	struct sdw_cdns_pdi *pdi = NULL;
+
+	if (dir == SDW_DATA_DIR_RX)
+		pdi = cdns_find_pdi(cdns, stream->num_in, stream->in);
+	else
+		pdi = cdns_find_pdi(cdns, stream->num_out, stream->out);
+
+	/* check if we found a PDI, else find in bi-directional */
+	if (!pdi)
+		pdi = cdns_find_pdi(cdns, stream->num_bd, stream->bd);
+
+	if (!pdi)
+		return -EIO;
+
+	port->pdi = pdi;
+	pdi->l_ch_num = 0;
+	pdi->h_ch_num = ch - 1;
+	pdi->dir = dir;
+	pdi->ch_count = ch;
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_cdns_alloc_stream);
+
+void sdw_cdns_shutdown(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai)
+{
+	struct sdw_cdns_dma_data *dma;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma)
+		return;
+
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+	kfree(dma);
+}
+EXPORT_SYMBOL(sdw_cdns_shutdown);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Cadence Soundwire Library");
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 98a17f57918f..eb902b19c5a4 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 // Copyright(c) 2015-17 Intel Corporation.
+#include <sound/soc.h>
 
 #ifndef __SDW_CADENCE_H
 #define __SDW_CADENCE_H
@@ -91,6 +92,26 @@ struct sdw_cdns_stream_config {
 };
 
 /**
+ * struct sdw_cdns_dma_data: Cadence DMA data
+ *
+ * @name: SoundWire stream name
+ * @nr_ports: Number of ports
+ * @port: Ports
+ * @bus: Bus handle
+ * @stream_type: Stream type
+ * @link_id: Master link id
+ */
+struct sdw_cdns_dma_data {
+	char *name;
+	struct sdw_stream_runtime *stream;
+	int nr_ports;
+	struct sdw_cdns_port **port;
+	struct sdw_bus *bus;
+	enum sdw_stream_type stream_type;
+	int link_id;
+};
+
+/**
  * struct sdw_cdns - Cadence driver context
  * @dev: Linux device
  * @bus: Bus handle
@@ -142,6 +163,25 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 			struct sdw_cdns_stream_config config);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
 
+int sdw_cdns_get_stream(struct sdw_cdns *cdns,
+			struct sdw_cdns_streams *stream,
+			u32 ch, u32 dir);
+int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
+			struct sdw_cdns_streams *stream,
+			struct sdw_cdns_port *port, u32 ch, u32 dir);
+void sdw_cdns_config_stream(struct sdw_cdns *cdns, struct sdw_cdns_port *port,
+			u32 ch, u32 dir, struct sdw_cdns_pdi *pdi);
+
+void sdw_cdns_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai);
+int sdw_cdns_pcm_set_stream(struct snd_soc_dai *dai,
+				void *stream, int direction);
+int sdw_cdns_pdm_set_stream(struct snd_soc_dai *dai,
+				void *stream, int direction);
+
+enum sdw_command_response
+cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
+
 enum sdw_command_response
 cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg);
 
@@ -153,4 +193,7 @@ enum sdw_command_response
 cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
 
 int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params);
+
+int cdns_set_sdw_stream(struct snd_soc_dai *dai,
+		void *stream, bool pcm, int direction);
 #endif /* __SDW_CADENCE_H */
-- 
2.7.4
