From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 09/13] ASoC: Intel: Skylake: Add topology core
	init and handlers
Date: Fri,  7 Aug 2015 23:52:25 +0530
Message-ID: <1438971749-874-10-git-send-email-subhransu.s.prusty@intel.com>
References: <1438971749-874-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 69FC62650C0
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 20:23:31 +0200 (CEST)
In-Reply-To: <1438971749-874-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

The SKL driver does not code DSP topology in driver. It uses the newly
added ASoC topology core to parse the topology information (controls,
widgets and map) from topology binary. We add init routine to invoke
topology load and callback for topology creation.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c       | 236 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-tplg-interface.h |  78 +++++++++
 2 files changed, 314 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 7f3c54a..511f912 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1026,3 +1026,239 @@ int skl_tplg_set_fe_pipeline_state(struct snd_soc_dai *dai, bool start,
 
 	return 0;
 }
+
+const struct snd_soc_tplg_widget_events skl_tplg_widget_ops[] = {
+	{SKL_MIXER_EVENT, skl_tplg_mixer_event},
+	{SKL_VMIXER_EVENT, skl_tplg_vmixer_event},
+	{SKL_PGA_EVENT, skl_tplg_pga_event},
+};
+
+/*
+ * The topology binary passes the pin info for a module so initialize the pin
+ * info passed into module instance
+ */
+static void skl_fill_module_pin_info(struct device *dev,
+			struct skl_module_pin *m_pin,
+			int max_pin)
+{
+	int i;
+
+	for (i = 0; i < max_pin; i++) {
+		m_pin[i].id.module_id = 0;
+		m_pin[i].id.instance_id = 0;
+		m_pin[i].in_use = false;
+		m_pin[i].is_dynamic = true;
+		m_pin[i].pin_index = i;
+	}
+}
+
+/*
+ * Add pipeline from topology binary into driver pipeline list
+ *
+ * If already added we return that instance
+ * Otherwise we create a new instance and add into driver list
+ */
+static struct skl_pipe *skl_tplg_add_pipe(struct device *dev,
+						struct skl *skl,
+						struct skl_dfw_pipe *dfw_pipe)
+{
+	struct skl_pipeline  *ppl;
+	struct skl_pipe *pipe;
+	struct skl_pipe_params *params;
+
+	list_for_each_entry(ppl, &skl->ppl_list, node) {
+		if (ppl->pipe->ppl_id == dfw_pipe->pipe_id)
+			return ppl->pipe;
+	}
+
+	ppl = devm_kzalloc(dev, sizeof(*ppl), GFP_KERNEL);
+	if (!ppl)
+		return NULL;
+
+	pipe  = devm_kzalloc(dev, sizeof(*pipe), GFP_KERNEL);
+	if (!pipe)
+		return NULL;
+
+	params = devm_kzalloc(dev, sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return NULL;
+
+	pipe->ppl_id = dfw_pipe->pipe_id;
+	pipe->memory_pages = dfw_pipe->memory_pages;
+	pipe->pipe_priority = dfw_pipe->pipe_priority;
+	pipe->conn_type = dfw_pipe->conn_type;
+	pipe->state = SKL_PIPE_INVALID;
+	pipe->p_params = params;
+	INIT_LIST_HEAD(&pipe->w_list);
+
+	ppl->pipe = pipe;
+	list_add(&ppl->node, &skl->ppl_list);
+
+	return ppl->pipe;
+}
+
+static void skl_tplg_dump_widget_info(struct device *dev,
+					struct skl_dfw_module *dfw_cfg,
+					struct snd_soc_tplg_dapm_widget *w)
+{
+	dev_dbg(dev, "widget  Info for widget=%s\n", w->name);
+	dev_dbg(dev, "In%s pvt_data_len=%d\n", __func__, w->priv.size);
+	dev_dbg(dev, "copying widget private data\n");
+
+	dev_dbg(dev, "module id = %d\n", dfw_cfg->module_id);
+	dev_dbg(dev, "module instance = %d\n", dfw_cfg->instance_id);
+	dev_dbg(dev, "mcps = %d\n", dfw_cfg->max_mcps);
+	dev_dbg(dev, "ibs = %d\n", dfw_cfg->ibs);
+	dev_dbg(dev, "obs = %d\n", dfw_cfg->obs);
+	dev_dbg(dev, "core_id=%d\n", dfw_cfg->core_id);
+}
+
+/*
+ * Topology core widget load callback
+ *
+ * This is used to save the private data for each widget which gives
+ * information to the driver about module and pipeline parameters which DSP
+ * FW expects like ids, resource values, formats etc
+ */
+static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
+					struct snd_soc_dapm_widget *w,
+					struct snd_soc_tplg_dapm_widget *tplg_w)
+{
+	int ret;
+	struct hdac_ext_bus *ebus  = snd_soc_component_get_drvdata(cmpnt);
+	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl_module_cfg *mconfig;
+	struct skl_pipe *pipe;
+	struct skl_dfw_module *dfw_config = (struct skl_dfw_module *) tplg_w->priv.data;
+
+	skl_tplg_dump_widget_info(bus->dev, dfw_config, tplg_w);
+
+	if (!tplg_w->priv.size)
+		goto bind_event;
+
+	mconfig = devm_kzalloc(bus->dev, sizeof(*mconfig), GFP_KERNEL);
+
+	if (!mconfig)
+		return -ENOMEM;
+
+	w->priv = mconfig;
+	mconfig->id.module_id = dfw_config->module_id;
+	mconfig->id.instance_id = dfw_config->instance_id;
+	mconfig->mcps = dfw_config->max_mcps;
+	mconfig->ibs = dfw_config->ibs;
+	mconfig->obs = dfw_config->obs;
+	mconfig->core_id = dfw_config->core_id;
+	mconfig->max_in_queue = dfw_config->max_in_queue;
+	mconfig->max_out_queue = dfw_config->max_out_queue;
+	mconfig->is_loadable = dfw_config->is_loadable;
+	mconfig->in_fmt.channels  = dfw_config->in_fmt.channels;
+	mconfig->in_fmt.s_freq = dfw_config->in_fmt.freq;
+	mconfig->in_fmt.bit_depth = dfw_config->in_fmt.bit_depth;
+	mconfig->in_fmt.valid_bit_depth = dfw_config->in_fmt.valid_bit_depth;
+	mconfig->in_fmt.ch_cfg = dfw_config->in_fmt.ch_cfg;
+	mconfig->out_fmt.channels  = dfw_config->out_fmt.channels;
+	mconfig->out_fmt.s_freq = dfw_config->out_fmt.freq;
+	mconfig->out_fmt.bit_depth = dfw_config->out_fmt.bit_depth;
+	mconfig->out_fmt.valid_bit_depth = dfw_config->out_fmt.valid_bit_depth;
+	mconfig->out_fmt.ch_cfg = dfw_config->out_fmt.ch_cfg;
+	mconfig->params_fixup = dfw_config->params_fixup;
+	mconfig->converter = dfw_config->converter;
+	mconfig->m_type = dfw_config->module_type;
+	mconfig->vbus_id = dfw_config->vbus_id;
+
+	pipe =	skl_tplg_add_pipe(bus->dev, skl, &dfw_config->pipe);
+	if (pipe)
+		mconfig->pipe = pipe;
+
+	mconfig->dev_type =  dfw_config->dev_type;
+	mconfig->hw_conn_type = dfw_config->hw_conn_type;
+	mconfig->time_slot =  dfw_config->time_slot;
+	mconfig->formats_config.caps_size = dfw_config->caps.caps_size;
+
+	mconfig->m_in_pin = devm_kzalloc(bus->dev, (mconfig->max_in_queue) *
+						sizeof(*mconfig->m_in_pin),
+						GFP_KERNEL);
+	if (!mconfig->m_in_pin)
+		return -ENOMEM;
+
+	mconfig->m_out_pin = devm_kzalloc(bus->dev, (mconfig->max_in_queue) *
+						sizeof(*mconfig->m_out_pin),
+						GFP_KERNEL);
+	if (!mconfig->m_out_pin)
+		return -ENOMEM;
+
+	skl_fill_module_pin_info(bus->dev, mconfig->m_in_pin,
+				mconfig->max_in_queue);
+	skl_fill_module_pin_info(bus->dev, mconfig->m_out_pin,
+				mconfig->max_out_queue);
+
+	if (mconfig->formats_config.caps_size == 0)
+		goto bind_event;
+
+	mconfig->formats_config.caps = (u32 *)devm_kzalloc(bus->dev,
+				mconfig->formats_config.caps_size, GFP_KERNEL);
+
+	if (mconfig->formats_config.caps == NULL)
+		return -ENOMEM;
+
+	memcpy(mconfig->formats_config.caps, dfw_config->caps.caps,
+						 dfw_config->caps.caps_size);
+
+bind_event:
+	if (tplg_w->event_type == 0) {
+		dev_info(bus->dev, "ASoC: No event handler required\n");
+		return 0;
+	}
+
+	ret = snd_soc_tplg_widget_bind_event(w, skl_tplg_widget_ops,
+			ARRAY_SIZE(skl_tplg_widget_ops), tplg_w->event_type);
+
+	if (ret) {
+		dev_err(bus->dev, "%s: No matching event handlers found for %d\n",
+					__func__, tplg_w->event_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_tplg_ops skl_tplg_ops  = {
+	.widget_load = skl_tplg_widget_load,
+};
+
+/* This will be read from topology manifest, currently defined here */
+#define SKL_MAX_MCPS 30000000
+#define SKL_FW_MAX_MEM 1000000
+
+/*
+ * SKL topology init routine
+ */
+int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
+{
+	int ret;
+	const struct firmware *fw;
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl *skl = ebus_to_skl(ebus);
+
+	dev_dbg(bus->dev, "In%s req firmware topology bin\n",  __func__);
+	ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
+	if (fw == NULL) {
+		dev_err(bus->dev, "config firmware request failed with %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(bus->dev, "In%s soc fw load_platform\n", __func__);
+	/* Index is for each config load */
+	ret = snd_soc_tplg_component_load(&platform->component, &skl_tplg_ops, fw, 0);
+
+	if (ret < 0) {
+		dev_err(bus->dev, "tplg component load failed%d\n", ret);
+		return -EINVAL;
+	}
+
+	skl->resource.max_mcps = SKL_MAX_MCPS;
+	skl->resource.max_mem = SKL_FW_MAX_MEM;
+
+	return 0;
+}
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index a506898..b258c90 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -19,6 +19,27 @@
 #ifndef __HDA_TPLG_INTERFACE_H__
 #define __HDA_TPLG_INTERFACE_H__
 
+/* Default types range from 0~12. type can range from 0 to 0xff
+ * SST types start at higher to avoid any overlapping in future */
+#define SOC_CONTROL_TYPE_HDA_SST_ALGO_PARAMS	200
+#define SOC_CONTROL_TYPE_HDA_SST_MUX		201
+#define SOC_CONTROL_TYPE_HDA_SST_MIX		201
+#define SOC_CONTROL_TYPE_HDA_SST_BYTE		203
+
+#define HDA_SST_CFG_MAX	900 /* size of copier cfg*/
+#define MAX_IN_QUEUE 8
+#define MAX_OUT_QUEUE 8
+
+/* Event types goes here */
+/* Reserve event type 0 for no event handlers */
+enum skl_event_types {
+	SKL_EVENT_NONE = 0,
+	SKL_MIXER_EVENT,
+	SKL_MUX_EVENT,
+	SKL_VMIXER_EVENT,
+	SKL_PGA_EVENT
+};
+
 /**
  * enum skl_ch_cfg - channel configuration
  *
@@ -85,4 +106,61 @@ enum skl_dev_type {
 	SKL_DEVICE_HDALINK = 0x4,
 	SKL_DEVICE_NONE
 };
+
+struct skl_dfw_module_pin {
+	u16 module_id;
+	u16 instance_id;
+	u8 pin_id;
+	bool is_dynamic;
+} __packed;
+
+struct skl_dfw_module_fmt {
+	u32 channels;
+	u32 freq;
+	u32 bit_depth;
+	u32 valid_bit_depth;
+	u32 ch_cfg;
+} __packed;
+
+struct skl_dfw_module_caps {
+	u32 caps_size;
+	u32 caps[HDA_SST_CFG_MAX];
+};
+
+struct skl_dfw_pipe {
+	u8 pipe_id;
+	u8 pipe_priority;
+	u16 conn_type;
+	u32 memory_pages;
+} __packed;
+
+struct skl_dfw_module {
+	u16 module_id;
+	u16 instance_id;
+	u32 max_mcps;
+	u8 core_id;
+	u8 max_in_queue;
+	u8 max_out_queue;
+	u8 is_loadable;
+	u8 conn_type;
+	u8 dev_type;
+	u8 hw_conn_type;
+	u8 time_slot;
+	u32 obs;
+	u32 ibs;
+	u32 params_fixup;
+	u32 converter;
+	u32 module_type;
+	u32 vbus_id;
+	struct skl_dfw_pipe pipe;
+	struct skl_dfw_module_fmt in_fmt;
+	struct skl_dfw_module_fmt out_fmt;
+	struct skl_dfw_module_caps caps;
+} __packed;
+
+struct skl_dfw_algo_data {
+	u32 max;
+	char *params;
+} __packed;
+
 #endif
-- 
2.4.3
