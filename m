From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v4 2/3] ALSA: hdac: Remove usage of struct
	hdac_ext_bus and use hdac_bus instead
Date: Fri, 22 Dec 2017 18:22:11 +0530
Message-ID: <1513947132-28089-3-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513947132-28089-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 823062678FF
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 13:47:40 +0100 (CET)
In-Reply-To: <1513947132-28089-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This patch removes the hdac_ext_bus structure. The legacy and
enhanced HDaudio capabilities can be handled in a backwards-compatible
way without separate definitions.

Follow-up patches in this series handle the driver definition.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 include/sound/hdaudio.h                |  16 +++
 include/sound/hdaudio_ext.h            |  74 +++++---------
 sound/hda/ext/hdac_ext_bus.c           |  27 +++--
 sound/hda/ext/hdac_ext_controller.c    |  55 +++++------
 sound/hda/ext/hdac_ext_stream.c        | 104 +++++++++----------
 sound/soc/codecs/hdac_hdmi.c           |  22 ++---
 sound/soc/intel/skylake/skl-messages.c |  50 +++++-----
 sound/soc/intel/skylake/skl-nhlt.c     |   8 +-
 sound/soc/intel/skylake/skl-pcm.c      | 112 ++++++++++-----------
 sound/soc/intel/skylake/skl-topology.c |  18 ++--
 sound/soc/intel/skylake/skl-topology.h |   6 +-
 sound/soc/intel/skylake/skl.c          | 176 +++++++++++++++------------------
 sound/soc/intel/skylake/skl.h          |   7 +-
 13 files changed, 305 insertions(+), 370 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 68169e3..25178a33 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -251,6 +251,12 @@ struct hdac_rb {
  * @mlcap: MultiLink capabilities pointer
  * @gtscap: gts capabilities pointer
  * @drsmcap: dma resume capabilities pointer
+ *
+ * Parameters required for enhanced capabilities
+ * @num_streams: streams supported
+ * @hlink_list: link list of HDA links
+ * @lock: lock for link mgmt
+ * @cmd_dma_state: state of cmd DMAs: CORB and RIRB
  */
 struct hdac_bus {
 	struct device *dev;
@@ -318,6 +324,16 @@ struct hdac_bus {
 	/* i915 component interface */
 	struct i915_audio_component *audio_component;
 	int i915_power_refcount;
+
+	/* parameters required for enhanced capabilities */
+	int num_streams;
+	int idx;
+
+	struct list_head hlink_list;
+
+	struct mutex lock;
+	bool cmd_dma_state;
+
 };
 
 int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index c1a5ad0..e5b0cd1 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -4,38 +4,14 @@
 
 #include <sound/hdaudio.h>
 
-/**
- * hdac_ext_bus: HDAC extended bus for extended HDA caps
- *
- * @bus: hdac bus
- * @num_streams: streams supported
- * @hlink_list: link list of HDA links
- * @lock: lock for link mgmt
- * @cmd_dma_state: state of cmd DMAs: CORB and RIRB
- */
-struct hdac_ext_bus {
-	struct hdac_bus bus;
-	int num_streams;
-	int idx;
-
-	struct list_head hlink_list;
-
-	struct mutex lock;
-	bool cmd_dma_state;
-};
-
-int snd_hdac_ext_bus_init(struct hdac_ext_bus *sbus, struct device *dev,
+int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 		      const struct hdac_bus_ops *ops,
 		      const struct hdac_io_ops *io_ops);
 
-void snd_hdac_ext_bus_exit(struct hdac_ext_bus *sbus);
-int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *sbus, int addr);
+void snd_hdac_ext_bus_exit(struct hdac_bus *bus);
+int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr);
 void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev);
-void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus);
-
-#define ebus_to_hbus(ebus)	(&(ebus)->bus)
-#define hbus_to_ebus(_bus) \
-	container_of(_bus, struct hdac_ext_bus, bus)
+void snd_hdac_ext_bus_device_remove(struct hdac_bus *bus);
 
 #define HDA_CODEC_REV_EXT_ENTRY(_vid, _rev, _name, drv_data) \
 	{ .vendor_id = (_vid), .rev_id = (_rev), .name = (_name), \
@@ -44,14 +20,14 @@ void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus);
 #define HDA_CODEC_EXT_ENTRY(_vid, _revid, _name, _drv_data) \
 	HDA_CODEC_REV_EXT_ENTRY(_vid, _revid, _name, _drv_data)
 
-void snd_hdac_ext_bus_ppcap_enable(struct hdac_ext_bus *chip, bool enable);
-void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_ext_bus *chip, bool enable);
+void snd_hdac_ext_bus_ppcap_enable(struct hdac_bus *chip, bool enable);
+void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_bus *chip, bool enable);
 
-void snd_hdac_ext_stream_spbcap_enable(struct hdac_ext_bus *chip,
+void snd_hdac_ext_stream_spbcap_enable(struct hdac_bus *chip,
 				 bool enable, int index);
 
-int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *bus);
-struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_ext_bus *bus,
+int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_bus *bus);
+struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_bus *bus,
 						const char *codec_name);
 
 enum hdac_ext_stream_type {
@@ -100,28 +76,28 @@ struct hdac_ext_stream {
 #define stream_to_hdac_ext_stream(s) \
 	container_of(s, struct hdac_ext_stream, hstream)
 
-void snd_hdac_ext_stream_init(struct hdac_ext_bus *bus,
+void snd_hdac_ext_stream_init(struct hdac_bus *bus,
 				struct hdac_ext_stream *stream, int idx,
 				int direction, int tag);
-int snd_hdac_ext_stream_init_all(struct hdac_ext_bus *ebus, int start_idx,
+int snd_hdac_ext_stream_init_all(struct hdac_bus *bus, int start_idx,
 		int num_stream, int dir);
-void snd_hdac_stream_free_all(struct hdac_ext_bus *ebus);
-void snd_hdac_link_free_all(struct hdac_ext_bus *ebus);
-struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_ext_bus *bus,
+void snd_hdac_stream_free_all(struct hdac_bus *bus);
+void snd_hdac_link_free_all(struct hdac_bus *bus);
+struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_bus *bus,
 					   struct snd_pcm_substream *substream,
 					   int type);
 void snd_hdac_ext_stream_release(struct hdac_ext_stream *azx_dev, int type);
-void snd_hdac_ext_stream_decouple(struct hdac_ext_bus *bus,
+void snd_hdac_ext_stream_decouple(struct hdac_bus *bus,
 				struct hdac_ext_stream *azx_dev, bool decouple);
-void snd_hdac_ext_stop_streams(struct hdac_ext_bus *sbus);
+void snd_hdac_ext_stop_streams(struct hdac_bus *bus);
 
-int snd_hdac_ext_stream_set_spib(struct hdac_ext_bus *ebus,
+int snd_hdac_ext_stream_set_spib(struct hdac_bus *bus,
 				 struct hdac_ext_stream *stream, u32 value);
-int snd_hdac_ext_stream_get_spbmaxfifo(struct hdac_ext_bus *ebus,
+int snd_hdac_ext_stream_get_spbmaxfifo(struct hdac_bus *bus,
 				 struct hdac_ext_stream *stream);
-void snd_hdac_ext_stream_drsm_enable(struct hdac_ext_bus *ebus,
+void snd_hdac_ext_stream_drsm_enable(struct hdac_bus *bus,
 				bool enable, int index);
-int snd_hdac_ext_stream_set_dpibr(struct hdac_ext_bus *ebus,
+int snd_hdac_ext_stream_set_dpibr(struct hdac_bus *bus,
 				struct hdac_ext_stream *stream, u32 value);
 int snd_hdac_ext_stream_set_lpib(struct hdac_ext_stream *stream, u32 value);
 
@@ -144,17 +120,15 @@ struct hdac_ext_link {
 
 int snd_hdac_ext_bus_link_power_up(struct hdac_ext_link *link);
 int snd_hdac_ext_bus_link_power_down(struct hdac_ext_link *link);
-int snd_hdac_ext_bus_link_power_up_all(struct hdac_ext_bus *ebus);
-int snd_hdac_ext_bus_link_power_down_all(struct hdac_ext_bus *ebus);
+int snd_hdac_ext_bus_link_power_up_all(struct hdac_bus *bus);
+int snd_hdac_ext_bus_link_power_down_all(struct hdac_bus *bus);
 void snd_hdac_ext_link_set_stream_id(struct hdac_ext_link *link,
 				 int stream);
 void snd_hdac_ext_link_clear_stream_id(struct hdac_ext_link *link,
 				 int stream);
 
-int snd_hdac_ext_bus_link_get(struct hdac_ext_bus *ebus,
-				struct hdac_ext_link *link);
-int snd_hdac_ext_bus_link_put(struct hdac_ext_bus *ebus,
-				struct hdac_ext_link *link);
+int snd_hdac_ext_bus_link_get(struct hdac_bus *bus, struct hdac_ext_link *link);
+int snd_hdac_ext_bus_link_put(struct hdac_bus *bus, struct hdac_ext_link *link);
 
 /* update register macro */
 #define snd_hdac_updatel(addr, reg, mask, val)		\
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 0e4823f..77547ed 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -87,7 +87,7 @@ static const struct hdac_io_ops hdac_ext_default_io = {
  *
  * Returns 0 if successful, or a negative error code.
  */
-int snd_hdac_ext_bus_init(struct hdac_ext_bus *ebus, struct device *dev,
+int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 			const struct hdac_bus_ops *ops,
 			const struct hdac_io_ops *io_ops)
 {
@@ -98,15 +98,15 @@ int snd_hdac_ext_bus_init(struct hdac_ext_bus *ebus, struct device *dev,
 	if (io_ops == NULL)
 		io_ops = &hdac_ext_default_io;
 
-	ret = snd_hdac_bus_init(&ebus->bus, dev, ops, io_ops);
+	ret = snd_hdac_bus_init(bus, dev, ops, io_ops);
 	if (ret < 0)
 		return ret;
 
-	INIT_LIST_HEAD(&ebus->hlink_list);
-	ebus->idx = idx++;
+	INIT_LIST_HEAD(&bus->hlink_list);
+	bus->idx = idx++;
 
-	mutex_init(&ebus->lock);
-	ebus->cmd_dma_state = true;
+	mutex_init(&bus->lock);
+	bus->cmd_dma_state = true;
 
 	return 0;
 }
@@ -116,10 +116,10 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_init);
  * snd_hdac_ext_bus_exit - clean up a HD-audio extended bus
  * @ebus: the pointer to extended bus object
  */
-void snd_hdac_ext_bus_exit(struct hdac_ext_bus *ebus)
+void snd_hdac_ext_bus_exit(struct hdac_bus *bus)
 {
-	snd_hdac_bus_exit(&ebus->bus);
-	WARN_ON(!list_empty(&ebus->hlink_list));
+	snd_hdac_bus_exit(bus);
+	WARN_ON(!list_empty(&bus->hlink_list));
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_exit);
 
@@ -135,10 +135,9 @@ static void default_release(struct device *dev)
  *
  * Returns zero for success or a negative error code.
  */
-int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *ebus, int addr)
+int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr)
 {
 	struct hdac_device *hdev = NULL;
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	char name[15];
 	int ret;
 
@@ -148,7 +147,7 @@ int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *ebus, int addr)
 
 	hdev->bus = bus;
 
-	snprintf(name, sizeof(name), "ehdaudio%dD%d", ebus->idx, addr);
+	snprintf(name, sizeof(name), "ehdaudio%dD%d", bus->idx, addr);
 
 	ret  = snd_hdac_device_init(hdev, bus, name, addr);
 	if (ret < 0) {
@@ -185,14 +184,14 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
  *
  * @ebus: HD-audio extended bus
  */
-void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus)
+void snd_hdac_ext_bus_device_remove(struct hdac_bus *bus)
 {
 	struct hdac_device *codec, *__codec;
 	/*
 	 * we need to remove all the codec devices objects created in the
 	 * snd_hdac_ext_bus_device_init
 	 */
-	list_for_each_entry_safe(codec, __codec, &ebus->bus.codec_list, list) {
+	list_for_each_entry_safe(codec, __codec, &bus->codec_list, list) {
 		snd_hdac_device_unregister(codec);
 		put_device(&codec->dev);
 	}
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 84f3b81..7277411 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -39,9 +39,8 @@
  * @ebus: HD-audio extended core bus
  * @enable: flag to turn on/off the capability
  */
-void snd_hdac_ext_bus_ppcap_enable(struct hdac_ext_bus *ebus, bool enable)
+void snd_hdac_ext_bus_ppcap_enable(struct hdac_bus *bus, bool enable)
 {
-	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->ppcap) {
 		dev_err(bus->dev, "Address of PP capability is NULL");
@@ -60,9 +59,8 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_ppcap_enable);
  * @ebus: HD-audio extended core bus
  * @enable: flag to enable/disable interrupt
  */
-void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_ext_bus *ebus, bool enable)
+void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_bus *bus, bool enable)
 {
-	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->ppcap) {
 		dev_err(bus->dev, "Address of PP capability is NULL\n");
@@ -89,12 +87,11 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_ppcap_int_enable);
  * in hlink_list of extended hdac bus
  * Note: this will be freed on bus exit by driver
  */
-int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *ebus)
+int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_bus *bus)
 {
 	int idx;
 	u32 link_count;
 	struct hdac_ext_link *hlink;
-	struct hdac_bus *bus = &ebus->bus;
 
 	link_count = readl(bus->mlcap + AZX_REG_ML_MLCD) + 1;
 
@@ -114,7 +111,7 @@ int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *ebus)
 		/* since link in On, update the ref */
 		hlink->ref_count = 1;
 
-		list_add_tail(&hlink->list, &ebus->hlink_list);
+		list_add_tail(&hlink->list, &bus->hlink_list);
 	}
 
 	return 0;
@@ -127,12 +124,12 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_get_ml_capabilities);
  * @ebus: HD-audio ext core bus
  */
 
-void snd_hdac_link_free_all(struct hdac_ext_bus *ebus)
+void snd_hdac_link_free_all(struct hdac_bus *bus)
 {
 	struct hdac_ext_link *l;
 
-	while (!list_empty(&ebus->hlink_list)) {
-		l = list_first_entry(&ebus->hlink_list, struct hdac_ext_link, list);
+	while (!list_empty(&bus->hlink_list)) {
+		l = list_first_entry(&bus->hlink_list, struct hdac_ext_link, list);
 		list_del(&l->list);
 		kfree(l);
 	}
@@ -144,7 +141,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_link_free_all);
  * @ebus: HD-audio extended core bus
  * @codec_name: codec name
  */
-struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_ext_bus *ebus,
+struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_bus *bus,
 						 const char *codec_name)
 {
 	int i;
@@ -153,10 +150,10 @@ struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_ext_bus *ebus,
 
 	if (sscanf(codec_name, "ehdaudio%dD%d", &bus_idx, &addr) != 2)
 		return NULL;
-	if (ebus->idx != bus_idx)
+	if (bus->idx != bus_idx)
 		return NULL;
 
-	list_for_each_entry(hlink, &ebus->hlink_list, list) {
+	list_for_each_entry(hlink, &bus->hlink_list, list) {
 		for (i = 0; i < HDA_MAX_CODECS; i++) {
 			if (hlink->lsdiid & (0x1 << addr))
 				return hlink;
@@ -219,12 +216,12 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down);
  * snd_hdac_ext_bus_link_power_up_all -power up all hda link
  * @ebus: HD-audio extended bus
  */
-int snd_hdac_ext_bus_link_power_up_all(struct hdac_ext_bus *ebus)
+int snd_hdac_ext_bus_link_power_up_all(struct hdac_bus *bus)
 {
 	struct hdac_ext_link *hlink = NULL;
 	int ret;
 
-	list_for_each_entry(hlink, &ebus->hlink_list, list) {
+	list_for_each_entry(hlink, &bus->hlink_list, list) {
 		snd_hdac_updatel(hlink->ml_addr,
 				AZX_REG_ML_LCTL, 0, AZX_MLCTL_SPA);
 		ret = check_hdac_link_power_active(hlink, true);
@@ -240,12 +237,12 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_up_all);
  * snd_hdac_ext_bus_link_power_down_all -power down all hda link
  * @ebus: HD-audio extended bus
  */
-int snd_hdac_ext_bus_link_power_down_all(struct hdac_ext_bus *ebus)
+int snd_hdac_ext_bus_link_power_down_all(struct hdac_bus *bus)
 {
 	struct hdac_ext_link *hlink = NULL;
 	int ret;
 
-	list_for_each_entry(hlink, &ebus->hlink_list, list) {
+	list_for_each_entry(hlink, &bus->hlink_list, list) {
 		snd_hdac_updatel(hlink->ml_addr, AZX_REG_ML_LCTL, AZX_MLCTL_SPA, 0);
 		ret = check_hdac_link_power_active(hlink, false);
 		if (ret < 0)
@@ -256,39 +253,39 @@ int snd_hdac_ext_bus_link_power_down_all(struct hdac_ext_bus *ebus)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down_all);
 
-int snd_hdac_ext_bus_link_get(struct hdac_ext_bus *ebus,
+int snd_hdac_ext_bus_link_get(struct hdac_bus *bus,
 				struct hdac_ext_link *link)
 {
 	int ret = 0;
 
-	mutex_lock(&ebus->lock);
+	mutex_lock(&bus->lock);
 
 	/*
 	 * if we move from 0 to 1, count will be 1 so power up this link
 	 * as well, also check the dma status and trigger that
 	 */
 	if (++link->ref_count == 1) {
-		if (!ebus->cmd_dma_state) {
-			snd_hdac_bus_init_cmd_io(&ebus->bus);
-			ebus->cmd_dma_state = true;
+		if (!bus->cmd_dma_state) {
+			snd_hdac_bus_init_cmd_io(bus);
+			bus->cmd_dma_state = true;
 		}
 
 		ret = snd_hdac_ext_bus_link_power_up(link);
 	}
 
-	mutex_unlock(&ebus->lock);
+	mutex_unlock(&bus->lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_get);
 
-int snd_hdac_ext_bus_link_put(struct hdac_ext_bus *ebus,
+int snd_hdac_ext_bus_link_put(struct hdac_bus *bus,
 				struct hdac_ext_link *link)
 {
 	int ret = 0;
 	struct hdac_ext_link *hlink;
 	bool link_up = false;
 
-	mutex_lock(&ebus->lock);
+	mutex_lock(&bus->lock);
 
 	/*
 	 * if we move from 1 to 0, count will be 0
@@ -301,7 +298,7 @@ int snd_hdac_ext_bus_link_put(struct hdac_ext_bus *ebus,
 		 * now check if all links are off, if so turn off
 		 * cmd dma as well
 		 */
-		list_for_each_entry(hlink, &ebus->hlink_list, list) {
+		list_for_each_entry(hlink, &bus->hlink_list, list) {
 			if (hlink->ref_count) {
 				link_up = true;
 				break;
@@ -309,12 +306,12 @@ int snd_hdac_ext_bus_link_put(struct hdac_ext_bus *ebus,
 		}
 
 		if (!link_up) {
-			snd_hdac_bus_stop_cmd_io(&ebus->bus);
-			ebus->cmd_dma_state = false;
+			snd_hdac_bus_stop_cmd_io(bus);
+			bus->cmd_dma_state = false;
 		}
 	}
 
-	mutex_unlock(&ebus->lock);
+	mutex_unlock(&bus->lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_put);
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index c96d7a7..1bd2757 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -25,7 +25,7 @@
 
 /**
  * snd_hdac_ext_stream_init - initialize each stream (aka device)
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  * @stream: HD-audio ext core stream object to initialize
  * @idx: stream index number
  * @direction: stream direction (SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CAPTURE)
@@ -34,18 +34,16 @@
  * initialize the stream, if ppcap is enabled then init those and then
  * invoke hdac stream initialization routine
  */
-void snd_hdac_ext_stream_init(struct hdac_ext_bus *ebus,
+void snd_hdac_ext_stream_init(struct hdac_bus *bus,
 				struct hdac_ext_stream *stream,
 				int idx, int direction, int tag)
 {
-	struct hdac_bus *bus = &ebus->bus;
-
 	if (bus->ppcap) {
 		stream->pphc_addr = bus->ppcap + AZX_PPHC_BASE +
 				AZX_PPHC_INTERVAL * idx;
 
 		stream->pplc_addr = bus->ppcap + AZX_PPLC_BASE +
-				AZX_PPLC_MULTI * ebus->num_streams +
+				AZX_PPLC_MULTI * bus->num_streams +
 				AZX_PPLC_INTERVAL * idx;
 	}
 
@@ -71,12 +69,12 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_init);
 /**
  * snd_hdac_ext_stream_init_all - create and initialize the stream objects
  *   for an extended hda bus
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  * @start_idx: start index for streams
  * @num_stream: number of streams to initialize
  * @dir: direction of streams
  */
-int snd_hdac_ext_stream_init_all(struct hdac_ext_bus *ebus, int start_idx,
+int snd_hdac_ext_stream_init_all(struct hdac_bus *bus, int start_idx,
 		int num_stream, int dir)
 {
 	int stream_tag = 0;
@@ -88,7 +86,7 @@ int snd_hdac_ext_stream_init_all(struct hdac_ext_bus *ebus, int start_idx,
 		if (!stream)
 			return -ENOMEM;
 		tag = ++stream_tag;
-		snd_hdac_ext_stream_init(ebus, stream, idx, dir, tag);
+		snd_hdac_ext_stream_init(bus, stream, idx, dir, tag);
 		idx++;
 	}
 
@@ -100,17 +98,16 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_init_all);
 /**
  * snd_hdac_stream_free_all - free hdac extended stream objects
  *
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  */
-void snd_hdac_stream_free_all(struct hdac_ext_bus *ebus)
+void snd_hdac_stream_free_all(struct hdac_bus *bus)
 {
 	struct hdac_stream *s, *_s;
 	struct hdac_ext_stream *stream;
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
 	list_for_each_entry_safe(s, _s, &bus->stream_list, list) {
 		stream = stream_to_hdac_ext_stream(s);
-		snd_hdac_ext_stream_decouple(ebus, stream, false);
+		snd_hdac_ext_stream_decouple(bus, stream, false);
 		list_del(&s->list);
 		kfree(stream);
 	}
@@ -119,15 +116,14 @@ EXPORT_SYMBOL_GPL(snd_hdac_stream_free_all);
 
 /**
  * snd_hdac_ext_stream_decouple - decouple the hdac stream
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  * @stream: HD-audio ext core stream object to initialize
  * @decouple: flag to decouple
  */
-void snd_hdac_ext_stream_decouple(struct hdac_ext_bus *ebus,
+void snd_hdac_ext_stream_decouple(struct hdac_bus *bus,
 				struct hdac_ext_stream *stream, bool decouple)
 {
 	struct hdac_stream *hstream = &stream->hstream;
-	struct hdac_bus *bus = &ebus->bus;
 	u32 val;
 	int mask = AZX_PPCTL_PROCEN(hstream->index);
 
@@ -251,19 +247,18 @@ void snd_hdac_ext_link_clear_stream_id(struct hdac_ext_link *link,
 EXPORT_SYMBOL_GPL(snd_hdac_ext_link_clear_stream_id);
 
 static struct hdac_ext_stream *
-hdac_ext_link_stream_assign(struct hdac_ext_bus *ebus,
+hdac_ext_link_stream_assign(struct hdac_bus *bus,
 				struct snd_pcm_substream *substream)
 {
 	struct hdac_ext_stream *res = NULL;
 	struct hdac_stream *stream = NULL;
-	struct hdac_bus *hbus = &ebus->bus;
 
-	if (!hbus->ppcap) {
-		dev_err(hbus->dev, "stream type not supported\n");
+	if (!bus->ppcap) {
+		dev_err(bus->dev, "stream type not supported\n");
 		return NULL;
 	}
 
-	list_for_each_entry(stream, &hbus->stream_list, list) {
+	list_for_each_entry(stream, &bus->stream_list, list) {
 		struct hdac_ext_stream *hstream = container_of(stream,
 						struct hdac_ext_stream,
 						hstream);
@@ -277,34 +272,33 @@ hdac_ext_link_stream_assign(struct hdac_ext_bus *ebus,
 		}
 
 		if (!hstream->link_locked) {
-			snd_hdac_ext_stream_decouple(ebus, hstream, true);
+			snd_hdac_ext_stream_decouple(bus, hstream, true);
 			res = hstream;
 			break;
 		}
 	}
 	if (res) {
-		spin_lock_irq(&hbus->reg_lock);
+		spin_lock_irq(&bus->reg_lock);
 		res->link_locked = 1;
 		res->link_substream = substream;
-		spin_unlock_irq(&hbus->reg_lock);
+		spin_unlock_irq(&bus->reg_lock);
 	}
 	return res;
 }
 
 static struct hdac_ext_stream *
-hdac_ext_host_stream_assign(struct hdac_ext_bus *ebus,
+hdac_ext_host_stream_assign(struct hdac_bus *bus,
 				struct snd_pcm_substream *substream)
 {
 	struct hdac_ext_stream *res = NULL;
 	struct hdac_stream *stream = NULL;
-	struct hdac_bus *hbus = &ebus->bus;
 
-	if (!hbus->ppcap) {
-		dev_err(hbus->dev, "stream type not supported\n");
+	if (!bus->ppcap) {
+		dev_err(bus->dev, "stream type not supported\n");
 		return NULL;
 	}
 
-	list_for_each_entry(stream, &hbus->stream_list, list) {
+	list_for_each_entry(stream, &bus->stream_list, list) {
 		struct hdac_ext_stream *hstream = container_of(stream,
 						struct hdac_ext_stream,
 						hstream);
@@ -313,17 +307,17 @@ hdac_ext_host_stream_assign(struct hdac_ext_bus *ebus,
 
 		if (!stream->opened) {
 			if (!hstream->decoupled)
-				snd_hdac_ext_stream_decouple(ebus, hstream, true);
+				snd_hdac_ext_stream_decouple(bus, hstream, true);
 			res = hstream;
 			break;
 		}
 	}
 	if (res) {
-		spin_lock_irq(&hbus->reg_lock);
+		spin_lock_irq(&bus->reg_lock);
 		res->hstream.opened = 1;
 		res->hstream.running = 0;
 		res->hstream.substream = substream;
-		spin_unlock_irq(&hbus->reg_lock);
+		spin_unlock_irq(&bus->reg_lock);
 	}
 
 	return res;
@@ -331,7 +325,7 @@ hdac_ext_host_stream_assign(struct hdac_ext_bus *ebus,
 
 /**
  * snd_hdac_ext_stream_assign - assign a stream for the PCM
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  * @substream: PCM substream to assign
  * @type: type of stream (coupled, host or link stream)
  *
@@ -346,27 +340,26 @@ hdac_ext_host_stream_assign(struct hdac_ext_bus *ebus,
  * the same stream object when it's used beforehand.  when a stream is
  * decoupled, it becomes a host stream and link stream.
  */
-struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_ext_bus *ebus,
+struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_bus *bus,
 					   struct snd_pcm_substream *substream,
 					   int type)
 {
 	struct hdac_ext_stream *hstream = NULL;
 	struct hdac_stream *stream = NULL;
-	struct hdac_bus *hbus = &ebus->bus;
 
 	switch (type) {
 	case HDAC_EXT_STREAM_TYPE_COUPLED:
-		stream = snd_hdac_stream_assign(hbus, substream);
+		stream = snd_hdac_stream_assign(bus, substream);
 		if (stream)
 			hstream = container_of(stream,
 					struct hdac_ext_stream, hstream);
 		return hstream;
 
 	case HDAC_EXT_STREAM_TYPE_HOST:
-		return hdac_ext_host_stream_assign(ebus, substream);
+		return hdac_ext_host_stream_assign(bus, substream);
 
 	case HDAC_EXT_STREAM_TYPE_LINK:
-		return hdac_ext_link_stream_assign(ebus, substream);
+		return hdac_ext_link_stream_assign(bus, substream);
 
 	default:
 		return NULL;
@@ -384,7 +377,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_assign);
 void snd_hdac_ext_stream_release(struct hdac_ext_stream *stream, int type)
 {
 	struct hdac_bus *bus = stream->hstream.bus;
-	struct hdac_ext_bus *ebus = hbus_to_ebus(bus);
 
 	switch (type) {
 	case HDAC_EXT_STREAM_TYPE_COUPLED:
@@ -393,13 +385,13 @@ void snd_hdac_ext_stream_release(struct hdac_ext_stream *stream, int type)
 
 	case HDAC_EXT_STREAM_TYPE_HOST:
 		if (stream->decoupled && !stream->link_locked)
-			snd_hdac_ext_stream_decouple(ebus, stream, false);
+			snd_hdac_ext_stream_decouple(bus, stream, false);
 		snd_hdac_stream_release(&stream->hstream);
 		break;
 
 	case HDAC_EXT_STREAM_TYPE_LINK:
 		if (stream->decoupled && !stream->hstream.opened)
-			snd_hdac_ext_stream_decouple(ebus, stream, false);
+			snd_hdac_ext_stream_decouple(bus, stream, false);
 		spin_lock_irq(&bus->reg_lock);
 		stream->link_locked = 0;
 		stream->link_substream = NULL;
@@ -415,16 +407,15 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_release);
 
 /**
  * snd_hdac_ext_stream_spbcap_enable - enable SPIB for a stream
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  * @enable: flag to enable/disable SPIB
  * @index: stream index for which SPIB need to be enabled
  */
-void snd_hdac_ext_stream_spbcap_enable(struct hdac_ext_bus *ebus,
+void snd_hdac_ext_stream_spbcap_enable(struct hdac_bus *bus,
 				 bool enable, int index)
 {
 	u32 mask = 0;
 	u32 register_mask = 0;
-	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->spbcap) {
 		dev_err(bus->dev, "Address of SPB capability is NULL\n");
@@ -446,14 +437,13 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_spbcap_enable);
 
 /**
  * snd_hdac_ext_stream_set_spib - sets the spib value of a stream
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  * @stream: hdac_ext_stream
  * @value: spib value to set
  */
-int snd_hdac_ext_stream_set_spib(struct hdac_ext_bus *ebus,
+int snd_hdac_ext_stream_set_spib(struct hdac_bus *bus,
 				 struct hdac_ext_stream *stream, u32 value)
 {
-	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->spbcap) {
 		dev_err(bus->dev, "Address of SPB capability is NULL\n");
@@ -468,15 +458,14 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_set_spib);
 
 /**
  * snd_hdac_ext_stream_get_spbmaxfifo - gets the spib value of a stream
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  * @stream: hdac_ext_stream
  *
  * Return maxfifo for the stream
  */
-int snd_hdac_ext_stream_get_spbmaxfifo(struct hdac_ext_bus *ebus,
+int snd_hdac_ext_stream_get_spbmaxfifo(struct hdac_bus *bus,
 				 struct hdac_ext_stream *stream)
 {
-	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->spbcap) {
 		dev_err(bus->dev, "Address of SPB capability is NULL\n");
@@ -490,11 +479,10 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_get_spbmaxfifo);
 
 /**
  * snd_hdac_ext_stop_streams - stop all stream if running
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  */
-void snd_hdac_ext_stop_streams(struct hdac_ext_bus *ebus)
+void snd_hdac_ext_stop_streams(struct hdac_bus *bus)
 {
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct hdac_stream *stream;
 
 	if (bus->chip_init) {
@@ -507,16 +495,15 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stop_streams);
 
 /**
  * snd_hdac_ext_stream_drsm_enable - enable DMA resume for a stream
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  * @enable: flag to enable/disable DRSM
  * @index: stream index for which DRSM need to be enabled
  */
-void snd_hdac_ext_stream_drsm_enable(struct hdac_ext_bus *ebus,
+void snd_hdac_ext_stream_drsm_enable(struct hdac_bus *bus,
 				bool enable, int index)
 {
 	u32 mask = 0;
 	u32 register_mask = 0;
-	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->drsmcap) {
 		dev_err(bus->dev, "Address of DRSM capability is NULL\n");
@@ -538,14 +525,13 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_drsm_enable);
 
 /**
  * snd_hdac_ext_stream_set_dpibr - sets the dpibr value of a stream
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  * @stream: hdac_ext_stream
  * @value: dpib value to set
  */
-int snd_hdac_ext_stream_set_dpibr(struct hdac_ext_bus *ebus,
+int snd_hdac_ext_stream_set_dpibr(struct hdac_bus *bus,
 				 struct hdac_ext_stream *stream, u32 value)
 {
-	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->drsmcap) {
 		dev_err(bus->dev, "Address of DRSM capability is NULL\n");
@@ -560,7 +546,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_set_dpibr);
 
 /**
  * snd_hdac_ext_stream_set_lpib - sets the lpib value of a stream
- * @ebus: HD-audio ext core bus
+ * @bus: HD-audio core bus
  * @stream: hdac_ext_stream
  * @value: lpib value to set
  */
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index a0a3efb..a8c6d0f 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1786,14 +1786,13 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 	 * hold the ref while we probe, also no need to drop the ref on
 	 * exit, we call pm_runtime_suspend() so that will do for us
 	 */
-	hlink = snd_hdac_ext_bus_get_link(hbus_to_ebus(hdev->bus),
-						dev_name(&hdev->dev));
+	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
 		dev_err(&hdev->dev, "hdac link not found\n");
 		return -EIO;
 	}
 
-	snd_hdac_ext_bus_link_get(hbus_to_ebus(hdev->bus), hlink);
+	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
 
 	ret = create_fill_widget_route_map(dapm);
 	if (ret < 0)
@@ -1970,14 +1969,13 @@ static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
 	const struct hda_device_id *hdac_id = hdac_get_device_id(hdev, hdrv);
 
 	/* hold the ref while we probe */
-	hlink = snd_hdac_ext_bus_get_link(hbus_to_ebus(hdev->bus),
-						dev_name(&hdev->dev));
+	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
 		dev_err(&hdev->dev, "hdac link not found\n");
 		return -EIO;
 	}
 
-	snd_hdac_ext_bus_link_get(hbus_to_ebus(hdev->bus), hlink);
+	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
 
 	hdmi_priv = devm_kzalloc(&hdev->dev, sizeof(*hdmi_priv), GFP_KERNEL);
 	if (hdmi_priv == NULL)
@@ -2030,7 +2028,7 @@ static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
 	ret = snd_soc_register_codec(&hdev->dev, &hdmi_hda_codec,
 					hdmi_dais, num_dais);
 
-	snd_hdac_ext_bus_link_put(hbus_to_ebus(hdev->bus), hlink);
+	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
 
 	return ret;
 }
@@ -2081,7 +2079,6 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
 	struct hdac_bus *bus = hdev->bus;
-	struct hdac_ext_bus *ebus = hbus_to_ebus(bus);
 	struct hdac_ext_link *hlink = NULL;
 	int err;
 
@@ -2106,13 +2103,13 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 		return err;
 	}
 
-	hlink = snd_hdac_ext_bus_get_link(ebus, dev_name(dev));
+	hlink = snd_hdac_ext_bus_get_link(bus, dev_name(dev));
 	if (!hlink) {
 		dev_err(dev, "hdac link not found\n");
 		return -EIO;
 	}
 
-	snd_hdac_ext_bus_link_put(ebus, hlink);
+	snd_hdac_ext_bus_link_put(bus, hlink);
 
 	return 0;
 }
@@ -2121,7 +2118,6 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
 	struct hdac_bus *bus = hdev->bus;
-	struct hdac_ext_bus *ebus = hbus_to_ebus(bus);
 	struct hdac_ext_link *hlink = NULL;
 	int err;
 
@@ -2131,13 +2127,13 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 	if (!bus)
 		return 0;
 
-	hlink = snd_hdac_ext_bus_get_link(ebus, dev_name(dev));
+	hlink = snd_hdac_ext_bus_get_link(bus, dev_name(dev));
 	if (!hlink) {
 		dev_err(dev, "hdac link not found\n");
 		return -EIO;
 	}
 
-	snd_hdac_ext_bus_link_get(ebus, hlink);
+	snd_hdac_ext_bus_link_get(bus, hlink);
 
 	err = snd_hdac_display_power(bus, true);
 	if (err < 0) {
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 81ee111..3c6d69a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -33,8 +33,7 @@
 static int skl_alloc_dma_buf(struct device *dev,
 		struct snd_dma_buffer *dmab, size_t size)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 
 	if (!bus)
 		return -ENODEV;
@@ -44,8 +43,7 @@ static int skl_alloc_dma_buf(struct device *dev,
 
 static int skl_free_dma_buf(struct device *dev, struct snd_dma_buffer *dmab)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 
 	if (!bus)
 		return -ENODEV;
@@ -89,8 +87,7 @@ void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable)
 static int skl_dsp_setup_spib(struct device *dev, unsigned int size,
 				int stream_tag, int enable)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	struct hdac_stream *stream = snd_hdac_get_stream(bus,
 			SNDRV_PCM_STREAM_PLAYBACK, stream_tag);
 	struct hdac_ext_stream *estream;
@@ -100,10 +97,10 @@ static int skl_dsp_setup_spib(struct device *dev, unsigned int size,
 
 	estream = stream_to_hdac_ext_stream(stream);
 	/* enable/disable SPIB for this hdac stream */
-	snd_hdac_ext_stream_spbcap_enable(ebus, enable, stream->index);
+	snd_hdac_ext_stream_spbcap_enable(bus, enable, stream->index);
 
 	/* set the spib value */
-	snd_hdac_ext_stream_set_spib(ebus, estream, size);
+	snd_hdac_ext_stream_set_spib(bus, estream, size);
 
 	return 0;
 }
@@ -111,8 +108,7 @@ static int skl_dsp_setup_spib(struct device *dev, unsigned int size,
 static int skl_dsp_prepare(struct device *dev, unsigned int format,
 			unsigned int size, struct snd_dma_buffer *dmab)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	struct hdac_ext_stream *estream;
 	struct hdac_stream *stream;
 	struct snd_pcm_substream substream;
@@ -124,7 +120,7 @@ static int skl_dsp_prepare(struct device *dev, unsigned int format,
 	memset(&substream, 0, sizeof(substream));
 	substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
 
-	estream = snd_hdac_ext_stream_assign(ebus, &substream,
+	estream = snd_hdac_ext_stream_assign(bus, &substream,
 					HDAC_EXT_STREAM_TYPE_HOST);
 	if (!estream)
 		return -ENODEV;
@@ -143,9 +139,8 @@ static int skl_dsp_prepare(struct device *dev, unsigned int format,
 
 static int skl_dsp_trigger(struct device *dev, bool start, int stream_tag)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	struct hdac_stream *stream;
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
 	if (!bus)
 		return -ENODEV;
@@ -163,10 +158,9 @@ static int skl_dsp_trigger(struct device *dev, bool start, int stream_tag)
 static int skl_dsp_cleanup(struct device *dev,
 		struct snd_dma_buffer *dmab, int stream_tag)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	struct hdac_stream *stream;
 	struct hdac_ext_stream *estream;
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
 	if (!bus)
 		return -ENODEV;
@@ -270,8 +264,7 @@ const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
 int skl_init_dsp(struct skl *skl)
 {
 	void __iomem *mmio_base;
-	struct hdac_ext_bus *ebus = &skl->ebus;
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = skl_to_bus(skl);
 	struct skl_dsp_loader_ops loader_ops;
 	int irq = bus->irq;
 	const struct skl_dsp_ops *ops;
@@ -279,8 +272,8 @@ int skl_init_dsp(struct skl *skl)
 	int ret;
 
 	/* enable ppcap interrupt */
-	snd_hdac_ext_bus_ppcap_enable(&skl->ebus, true);
-	snd_hdac_ext_bus_ppcap_int_enable(&skl->ebus, true);
+	snd_hdac_ext_bus_ppcap_enable(bus, true);
+	snd_hdac_ext_bus_ppcap_int_enable(bus, true);
 
 	/* read the BAR of the ADSP MMIO */
 	mmio_base = pci_ioremap_bar(skl->pci, 4);
@@ -335,12 +328,11 @@ int skl_init_dsp(struct skl *skl)
 
 int skl_free_dsp(struct skl *skl)
 {
-	struct hdac_ext_bus *ebus = &skl->ebus;
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = skl_to_bus(skl);
 	struct skl_sst *ctx = skl->skl_sst;
 
 	/* disable  ppcap interrupt */
-	snd_hdac_ext_bus_ppcap_int_enable(&skl->ebus, false);
+	snd_hdac_ext_bus_ppcap_int_enable(bus, false);
 
 	ctx->dsp_ops->cleanup(bus->dev, ctx);
 
@@ -383,10 +375,11 @@ int skl_suspend_late_dsp(struct skl *skl)
 int skl_suspend_dsp(struct skl *skl)
 {
 	struct skl_sst *ctx = skl->skl_sst;
+	struct hdac_bus *bus = skl_to_bus(skl);
 	int ret;
 
 	/* if ppcap is not supported return 0 */
-	if (!skl->ebus.bus.ppcap)
+	if (!bus->ppcap)
 		return 0;
 
 	ret = skl_dsp_sleep(ctx->dsp);
@@ -394,8 +387,8 @@ int skl_suspend_dsp(struct skl *skl)
 		return ret;
 
 	/* disable ppcap interrupt */
-	snd_hdac_ext_bus_ppcap_int_enable(&skl->ebus, false);
-	snd_hdac_ext_bus_ppcap_enable(&skl->ebus, false);
+	snd_hdac_ext_bus_ppcap_int_enable(bus, false);
+	snd_hdac_ext_bus_ppcap_enable(bus, false);
 
 	return 0;
 }
@@ -403,15 +396,16 @@ int skl_suspend_dsp(struct skl *skl)
 int skl_resume_dsp(struct skl *skl)
 {
 	struct skl_sst *ctx = skl->skl_sst;
+	struct hdac_bus *bus = skl_to_bus(skl);
 	int ret;
 
 	/* if ppcap is not supported return 0 */
-	if (!skl->ebus.bus.ppcap)
+	if (!bus->ppcap)
 		return 0;
 
 	/* enable ppcap interrupt */
-	snd_hdac_ext_bus_ppcap_enable(&skl->ebus, true);
-	snd_hdac_ext_bus_ppcap_int_enable(&skl->ebus, true);
+	snd_hdac_ext_bus_ppcap_enable(bus, true);
+	snd_hdac_ext_bus_ppcap_int_enable(bus, true);
 
 	/* check if DSP 1st boot is done */
 	if (skl->skl_sst->is_first_boot == true)
diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 56d30a5..ba26511 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -139,7 +139,7 @@ struct nhlt_specific_cfg
 {
 	struct nhlt_fmt *fmt;
 	struct nhlt_endpoint *epnt;
-	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
+	struct hdac_bus *bus = skl_to_bus(skl);
 	struct device *dev = bus->dev;
 	struct nhlt_specific_cfg *sp_config;
 	struct nhlt_acpi_table *nhlt = skl->nhlt;
@@ -226,7 +226,7 @@ static void skl_nhlt_trim_space(char *trim)
 int skl_nhlt_update_topology_bin(struct skl *skl)
 {
 	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
-	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
+	struct hdac_bus *bus = skl_to_bus(skl);
 	struct device *dev = bus->dev;
 
 	dev_dbg(dev, "oem_id %.6s, oem_table_id %8s oem_revision %d\n",
@@ -246,8 +246,8 @@ static ssize_t skl_nhlt_platform_id_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct skl *skl = bus_to_skl(bus);
 	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
 	char platform_id[32];
 
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 8d0895b..02cdb1c 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -67,16 +67,15 @@ struct hdac_ext_stream *get_hdac_ext_stream(struct snd_pcm_substream *substream)
 	return substream->runtime->private_data;
 }
 
-static struct hdac_ext_bus *get_bus_ctx(struct snd_pcm_substream *substream)
+static struct hdac_bus *get_bus_ctx(struct snd_pcm_substream *substream)
 {
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 	struct hdac_stream *hstream = hdac_stream(stream);
 	struct hdac_bus *bus = hstream->bus;
-
-	return hbus_to_ebus(bus);
+	return bus;
 }
 
-static int skl_substream_alloc_pages(struct hdac_ext_bus *ebus,
+static int skl_substream_alloc_pages(struct hdac_bus *bus,
 				 struct snd_pcm_substream *substream,
 				 size_t size)
 {
@@ -95,7 +94,7 @@ static int skl_substream_free_pages(struct hdac_bus *bus,
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static void skl_set_pcm_constrains(struct hdac_ext_bus *ebus,
+static void skl_set_pcm_constrains(struct hdac_bus *bus,
 				 struct snd_pcm_runtime *runtime)
 {
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
@@ -105,9 +104,9 @@ static void skl_set_pcm_constrains(struct hdac_ext_bus *ebus,
 				     20, 178000000);
 }
 
-static enum hdac_ext_stream_type skl_get_host_stream_type(struct hdac_ext_bus *ebus)
+static enum hdac_ext_stream_type skl_get_host_stream_type(struct hdac_bus *bus)
 {
-	if ((ebus_to_hbus(ebus))->ppcap)
+	if (bus->ppcap)
 		return HDAC_EXT_STREAM_TYPE_HOST;
 	else
 		return HDAC_EXT_STREAM_TYPE_COUPLED;
@@ -123,9 +122,9 @@ static enum hdac_ext_stream_type skl_get_host_stream_type(struct hdac_ext_bus *e
 static void skl_set_suspend_active(struct snd_pcm_substream *substream,
 					 struct snd_soc_dai *dai, bool enable)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_bus *bus = dev_get_drvdata(dai->dev);
 	struct snd_soc_dapm_widget *w;
-	struct skl *skl = ebus_to_skl(ebus);
+	struct skl *skl = bus_to_skl(bus);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		w = dai->playback_widget;
@@ -140,8 +139,7 @@ static void skl_set_suspend_active(struct snd_pcm_substream *substream,
 
 int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	unsigned int format_val;
 	struct hdac_stream *hstream;
 	struct hdac_ext_stream *stream;
@@ -153,7 +151,7 @@ int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 		return -EINVAL;
 
 	stream = stream_to_hdac_ext_stream(hstream);
-	snd_hdac_ext_stream_decouple(ebus, stream, true);
+	snd_hdac_ext_stream_decouple(bus, stream, true);
 
 	format_val = snd_hdac_calc_stream_format(params->s_freq,
 			params->ch, params->format, params->host_bps, 0);
@@ -177,8 +175,7 @@ int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 
 int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	unsigned int format_val;
 	struct hdac_stream *hstream;
 	struct hdac_ext_stream *stream;
@@ -190,7 +187,7 @@ int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 		return -EINVAL;
 
 	stream = stream_to_hdac_ext_stream(hstream);
-	snd_hdac_ext_stream_decouple(ebus, stream, true);
+	snd_hdac_ext_stream_decouple(bus, stream, true);
 	format_val = snd_hdac_calc_stream_format(params->s_freq, params->ch,
 					params->format, params->link_bps, 0);
 
@@ -201,7 +198,7 @@ int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 
 	snd_hdac_ext_link_stream_setup(stream, format_val);
 
-	list_for_each_entry(link, &ebus->hlink_list, list) {
+	list_for_each_entry(link, &bus->hlink_list, list) {
 		if (link->index == params->link_index)
 			snd_hdac_ext_link_set_stream_id(link,
 					hstream->stream_tag);
@@ -215,7 +212,7 @@ int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 static int skl_pcm_open(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_bus *bus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *stream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct skl_dma_params *dma_params;
@@ -224,12 +221,12 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
-	stream = snd_hdac_ext_stream_assign(ebus, substream,
-					skl_get_host_stream_type(ebus));
+	stream = snd_hdac_ext_stream_assign(bus, substream,
+					skl_get_host_stream_type(bus));
 	if (stream == NULL)
 		return -EBUSY;
 
-	skl_set_pcm_constrains(ebus, runtime);
+	skl_set_pcm_constrains(bus, runtime);
 
 	/*
 	 * disable WALLCLOCK timestamps for capture streams
@@ -285,7 +282,7 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_bus *bus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct skl_pipe_params p_params = {0};
@@ -293,7 +290,7 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
 	int ret, dma_id;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
-	ret = skl_substream_alloc_pages(ebus, substream,
+	ret = skl_substream_alloc_pages(bus, substream,
 					  params_buffer_bytes(params));
 	if (ret < 0)
 		return ret;
@@ -327,14 +324,14 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_bus *bus = dev_get_drvdata(dai->dev);
 	struct skl_dma_params *dma_params = NULL;
-	struct skl *skl = ebus_to_skl(ebus);
+	struct skl *skl = bus_to_skl(bus);
 	struct skl_module_cfg *mconfig;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
-	snd_hdac_ext_stream_release(stream, skl_get_host_stream_type(ebus));
+	snd_hdac_ext_stream_release(stream, skl_get_host_stream_type(bus));
 
 	dma_params = snd_soc_dai_get_dma_data(dai, substream);
 	/*
@@ -364,7 +361,7 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 static int skl_pcm_hw_free(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_bus *bus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
@@ -372,7 +369,7 @@ static int skl_pcm_hw_free(struct snd_pcm_substream *substream,
 	snd_hdac_stream_cleanup(hdac_stream(stream));
 	hdac_stream(stream)->prepared = 0;
 
-	return skl_substream_free_pages(ebus_to_hbus(ebus), substream);
+	return skl_substream_free_pages(bus, substream);
 }
 
 static int skl_be_hw_params(struct snd_pcm_substream *substream,
@@ -392,8 +389,7 @@ static int skl_be_hw_params(struct snd_pcm_substream *substream,
 static int skl_decoupled_trigger(struct snd_pcm_substream *substream,
 		int cmd)
 {
-	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = get_bus_ctx(substream);
 	struct hdac_ext_stream *stream;
 	int start;
 	unsigned long cookie;
@@ -442,7 +438,7 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct skl *skl = get_skl_ctx(dai->dev);
 	struct skl_sst *ctx = skl->skl_sst;
 	struct skl_module_cfg *mconfig;
-	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	struct hdac_bus *bus = get_bus_ctx(substream);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 	struct snd_soc_dapm_widget *w;
 	int ret;
@@ -464,9 +460,9 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			 * dpib & lpib position to resume before starting the
 			 * DMA
 			 */
-			snd_hdac_ext_stream_drsm_enable(ebus, true,
+			snd_hdac_ext_stream_drsm_enable(bus, true,
 						hdac_stream(stream)->index);
-			snd_hdac_ext_stream_set_dpibr(ebus, stream,
+			snd_hdac_ext_stream_set_dpibr(bus, stream,
 							stream->lpib);
 			snd_hdac_ext_stream_set_lpib(stream, stream->lpib);
 		}
@@ -500,14 +496,14 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 		ret = skl_decoupled_trigger(substream, cmd);
 		if ((cmd == SNDRV_PCM_TRIGGER_SUSPEND) && !w->ignore_suspend) {
 			/* save the dpib and lpib positions */
-			stream->dpib = readl(ebus->bus.remap_addr +
+			stream->dpib = readl(bus->remap_addr +
 					AZX_REG_VS_SDXDPIB_XBASE +
 					(AZX_REG_VS_SDXDPIB_XINTERVAL *
 					hdac_stream(stream)->index));
 
 			stream->lpib = snd_hdac_stream_get_pos_lpib(
 							hdac_stream(stream));
-			snd_hdac_ext_stream_decouple(ebus, stream, false);
+			snd_hdac_ext_stream_decouple(bus, stream, false);
 		}
 		break;
 
@@ -518,11 +514,12 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
+
 static int skl_link_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_bus *bus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *link_dev;
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
@@ -530,14 +527,14 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	struct hdac_ext_link *link;
 	int stream_tag;
 
-	link_dev = snd_hdac_ext_stream_assign(ebus, substream,
+	link_dev = snd_hdac_ext_stream_assign(bus, substream,
 					HDAC_EXT_STREAM_TYPE_LINK);
 	if (!link_dev)
 		return -EBUSY;
 
 	snd_soc_dai_set_dma_data(dai, substream, (void *)link_dev);
 
-	link = snd_hdac_ext_bus_get_link(ebus, codec_dai->component->name);
+	link = snd_hdac_ext_bus_get_link(bus, codec_dai->component->name);
 	if (!link)
 		return -EINVAL;
 
@@ -582,7 +579,7 @@ static int skl_link_pcm_trigger(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_stream *link_dev =
 				snd_soc_dai_get_dma_data(dai, substream);
-	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	struct hdac_bus *bus = get_bus_ctx(substream);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 
 	dev_dbg(dai->dev, "In %s cmd=%d\n", __func__, cmd);
@@ -598,7 +595,7 @@ static int skl_link_pcm_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_STOP:
 		snd_hdac_ext_link_stream_clear(link_dev);
 		if (cmd == SNDRV_PCM_TRIGGER_SUSPEND)
-			snd_hdac_ext_stream_decouple(ebus, stream, false);
+			snd_hdac_ext_stream_decouple(bus, stream, false);
 		break;
 
 	default:
@@ -610,7 +607,7 @@ static int skl_link_pcm_trigger(struct snd_pcm_substream *substream,
 static int skl_link_hw_free(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_bus *bus = dev_get_drvdata(dai->dev);
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	struct hdac_ext_stream *link_dev =
 				snd_soc_dai_get_dma_data(dai, substream);
@@ -620,7 +617,7 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 
 	link_dev->link_prepared = 0;
 
-	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec_dai->component->name);
+	link = snd_hdac_ext_bus_get_link(bus, rtd->codec_dai->component->name);
 	if (!link)
 		return -EINVAL;
 
@@ -1002,8 +999,7 @@ static int skl_platform_open(struct snd_pcm_substream *substream)
 static int skl_coupled_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
-	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = get_bus_ctx(substream);
 	struct hdac_ext_stream *stream;
 	struct snd_pcm_substream *s;
 	bool start;
@@ -1076,9 +1072,9 @@ static int skl_coupled_trigger(struct snd_pcm_substream *substream,
 static int skl_platform_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
-	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	struct hdac_bus *bus = get_bus_ctx(substream);
 
-	if (!(ebus_to_hbus(ebus))->ppcap)
+	if (!bus->ppcap)
 		return skl_coupled_trigger(substream, cmd);
 
 	return 0;
@@ -1088,7 +1084,7 @@ static snd_pcm_uframes_t skl_platform_pcm_pointer
 			(struct snd_pcm_substream *substream)
 {
 	struct hdac_ext_stream *hstream = get_hdac_ext_stream(substream);
-	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	struct hdac_bus *bus = get_bus_ctx(substream);
 	unsigned int pos;
 
 	/*
@@ -1113,12 +1109,12 @@ static snd_pcm_uframes_t skl_platform_pcm_pointer
 	 */
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		pos = readl(ebus->bus.remap_addr + AZX_REG_VS_SDXDPIB_XBASE +
+		pos = readl(bus->remap_addr + AZX_REG_VS_SDXDPIB_XBASE +
 				(AZX_REG_VS_SDXDPIB_XINTERVAL *
 				hdac_stream(hstream)->index));
 	} else {
 		udelay(20);
-		readl(ebus->bus.remap_addr +
+		readl(bus->remap_addr +
 				AZX_REG_VS_SDXDPIB_XBASE +
 				(AZX_REG_VS_SDXDPIB_XINTERVAL *
 				 hdac_stream(hstream)->index));
@@ -1203,11 +1199,11 @@ static void skl_pcm_free(struct snd_pcm *pcm)
 static int skl_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *dai = rtd->cpu_dai;
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_bus *bus = dev_get_drvdata(dai->dev);
 	struct snd_pcm *pcm = rtd->pcm;
 	unsigned int size;
 	int retval = 0;
-	struct skl *skl = ebus_to_skl(ebus);
+	struct skl *skl = bus_to_skl(bus);
 
 	if (dai->driver->playback.channels_min ||
 		dai->driver->capture.channels_min) {
@@ -1315,19 +1311,19 @@ static int skl_populate_modules(struct skl *skl)
 
 static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(platform->dev);
-	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = dev_get_drvdata(platform->dev);
+	struct skl *skl = bus_to_skl(bus);
 	const struct skl_dsp_ops *ops;
 	int ret;
 
 	pm_runtime_get_sync(platform->dev);
-	if ((ebus_to_hbus(ebus))->ppcap) {
+	if (bus->ppcap) {
 		skl->platform = platform;
 
 		/* init debugfs */
 		skl->debugfs = skl_debugfs_init(skl);
 
-		ret = skl_tplg_init(platform, ebus);
+		ret = skl_tplg_init(platform, bus);
 		if (ret < 0) {
 			dev_err(platform->dev, "Failed to init topology!\n");
 			return ret;
@@ -1377,10 +1373,10 @@ static const struct snd_soc_component_driver skl_component = {
 int skl_platform_register(struct device *dev)
 {
 	int ret;
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
-	struct skl *skl = ebus_to_skl(ebus);
 	struct snd_soc_dai_driver *dais;
 	int num_dais = ARRAY_SIZE(skl_platform_dai);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
+	struct skl *skl = bus_to_skl(bus);
 
 	INIT_LIST_HEAD(&skl->ppl_list);
 	INIT_LIST_HEAD(&skl->bind_list);
@@ -1428,8 +1424,8 @@ int skl_platform_register(struct device *dev)
 
 int skl_platform_unregister(struct device *dev)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
-	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
+	struct skl *skl = bus_to_skl(bus);
 	struct skl_module_deferred_bind *modules, *tmp;
 
 	if (!list_empty(&skl->bind_list)) {
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 28bc16a..dc461e1 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2772,9 +2772,8 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 				struct snd_soc_tplg_dapm_widget *tplg_w)
 {
 	int ret;
-	struct hdac_ext_bus *ebus = snd_soc_component_get_drvdata(cmpnt);
-	struct skl *skl = ebus_to_skl(ebus);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = snd_soc_component_get_drvdata(cmpnt);
+	struct skl *skl = bus_to_skl(bus);
 	struct skl_module_cfg *mconfig;
 
 	if (!tplg_w->priv.size)
@@ -2880,8 +2879,7 @@ static int skl_tplg_control_load(struct snd_soc_component *cmpnt,
 	struct soc_bytes_ext *sb;
 	struct snd_soc_tplg_bytes_control *tplg_bc;
 	struct snd_soc_tplg_enum_control *tplg_ec;
-	struct hdac_ext_bus *ebus  = snd_soc_component_get_drvdata(cmpnt);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus  = snd_soc_component_get_drvdata(cmpnt);
 	struct soc_enum *se;
 
 	switch (hdr->ops.info) {
@@ -3365,9 +3363,8 @@ static int skl_tplg_get_manifest_data(struct snd_soc_tplg_manifest *manifest,
 static int skl_manifest_load(struct snd_soc_component *cmpnt,
 				struct snd_soc_tplg_manifest *manifest)
 {
-	struct hdac_ext_bus *ebus = snd_soc_component_get_drvdata(cmpnt);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = snd_soc_component_get_drvdata(cmpnt);
+	struct skl *skl = bus_to_skl(bus);
 
 	/* proceed only if we have private data defined */
 	if (manifest->priv.size == 0)
@@ -3456,12 +3453,11 @@ static void skl_tplg_set_pipe_type(struct skl *skl, struct skl_pipe *pipe)
 /*
  * SKL topology init routine
  */
-int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
+int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_bus *bus)
 {
 	int ret;
 	const struct firmware *fw;
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	struct skl *skl = ebus_to_skl(ebus);
+	struct skl *skl = bus_to_skl(bus);
 	struct skl_pipeline *ppl;
 
 	ret = request_firmware(&fw, skl->tplg_name, bus->dev);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index b649651..3aa17b7 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -449,9 +449,9 @@ enum skl_channel {
 
 static inline struct skl *get_skl_ctx(struct device *dev)
 {
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 
-	return ebus_to_skl(ebus);
+	return bus_to_skl(bus);
 }
 
 int skl_tplg_be_update_params(struct snd_soc_dai *dai,
@@ -461,7 +461,7 @@ int skl_dsp_set_dma_control(struct skl_sst *ctx, u32 *caps,
 void skl_tplg_set_be_dmic_config(struct snd_soc_dai *dai,
 	struct skl_pipe_params *params, int stream);
 int skl_tplg_init(struct snd_soc_platform *platform,
-				struct hdac_ext_bus *ebus);
+				struct hdac_bus *ebus);
 struct skl_module_cfg *skl_tplg_fe_get_cpr_module(
 		struct snd_soc_dai *dai, int stream);
 int skl_tplg_update_pipe_params(struct device *dev,
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index a89592b..6fc2173 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -54,7 +54,7 @@ static void skl_update_pci_byte(struct pci_dev *pci, unsigned int reg,
 
 static void skl_init_pci(struct skl *skl)
 {
-	struct hdac_ext_bus *ebus = &skl->ebus;
+	struct hdac_bus *bus = skl_to_bus(skl);
 
 	/*
 	 * Clear bits 0-2 of PCI register TCSEL (at offset 0x44)
@@ -63,7 +63,7 @@ static void skl_init_pci(struct skl *skl)
 	 * codecs.
 	 * The PCI register TCSEL is defined in the Intel manuals.
 	 */
-	dev_dbg(ebus_to_hbus(ebus)->dev, "Clearing TCSEL\n");
+	dev_dbg(bus->dev, "Clearing TCSEL\n");
 	skl_update_pci_byte(skl->pci, AZX_PCIREG_TCSEL, 0x07, 0);
 }
 
@@ -113,8 +113,7 @@ static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
 void skl_update_d0i3c(struct device *dev, bool enable)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = pci_get_drvdata(pci);
 	u8 reg;
 	int timeout = 50;
 
@@ -164,8 +163,7 @@ static void skl_stream_update(struct hdac_bus *bus, struct hdac_stream *hstr)
 
 static irqreturn_t skl_interrupt(int irq, void *dev_id)
 {
-	struct hdac_ext_bus *ebus = dev_id;
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = dev_id;
 	u32 status;
 
 	if (!pm_runtime_active(bus->dev))
@@ -194,8 +192,7 @@ static irqreturn_t skl_interrupt(int irq, void *dev_id)
 
 static irqreturn_t skl_threaded_handler(int irq, void *dev_id)
 {
-	struct hdac_ext_bus *ebus = dev_id;
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = dev_id;
 	u32 status;
 
 	status = snd_hdac_chip_readl(bus, INTSTS);
@@ -205,16 +202,15 @@ static irqreturn_t skl_threaded_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int skl_acquire_irq(struct hdac_ext_bus *ebus, int do_disconnect)
+static int skl_acquire_irq(struct hdac_bus *bus, int do_disconnect)
 {
-	struct skl *skl = ebus_to_skl(ebus);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl *skl = bus_to_skl(bus);
 	int ret;
 
 	ret = request_threaded_irq(skl->pci->irq, skl_interrupt,
 			skl_threaded_handler,
 			IRQF_SHARED,
-			KBUILD_MODNAME, ebus);
+			KBUILD_MODNAME, bus);
 	if (ret) {
 		dev_err(bus->dev,
 			"unable to grab IRQ %d, disabling device\n",
@@ -231,21 +227,20 @@ static int skl_acquire_irq(struct hdac_ext_bus *ebus, int do_disconnect)
 static int skl_suspend_late(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct skl *skl = bus_to_skl(bus);
 
 	return skl_suspend_late_dsp(skl);
 }
 
 #ifdef CONFIG_PM
-static int _skl_suspend(struct hdac_ext_bus *ebus)
+static int _skl_suspend(struct hdac_bus *bus)
 {
-	struct skl *skl = ebus_to_skl(ebus);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl *skl = bus_to_skl(bus);
 	struct pci_dev *pci = to_pci_dev(bus->dev);
 	int ret;
 
-	snd_hdac_ext_bus_link_power_down_all(ebus);
+	snd_hdac_ext_bus_link_power_down_all(bus);
 
 	ret = skl_suspend_dsp(skl);
 	if (ret < 0)
@@ -262,10 +257,9 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 	return 0;
 }
 
-static int _skl_resume(struct hdac_ext_bus *ebus)
+static int _skl_resume(struct hdac_bus *bus)
 {
-	struct skl *skl = ebus_to_skl(ebus);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl *skl = bus_to_skl(bus);
 
 	skl_init_pci(skl);
 	skl_init_chip(bus, true);
@@ -281,9 +275,8 @@ static int _skl_resume(struct hdac_ext_bus *ebus)
 static int skl_suspend(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct skl *skl  = ebus_to_skl(ebus);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct skl *skl  = bus_to_skl(bus);
 	int ret = 0;
 
 	/*
@@ -292,15 +285,15 @@ static int skl_suspend(struct device *dev)
 	 */
 	if (skl->supend_active) {
 		/* turn off the links and stop the CORB/RIRB DMA if it is On */
-		snd_hdac_ext_bus_link_power_down_all(ebus);
+		snd_hdac_ext_bus_link_power_down_all(bus);
 
-		if (ebus->cmd_dma_state)
-			snd_hdac_bus_stop_cmd_io(&ebus->bus);
+		if (bus->cmd_dma_state)
+			snd_hdac_bus_stop_cmd_io(bus);
 
 		enable_irq_wake(bus->irq);
 		pci_save_state(pci);
 	} else {
-		ret = _skl_suspend(ebus);
+		ret = _skl_suspend(bus);
 		if (ret < 0)
 			return ret;
 		skl->skl_sst->fw_loaded = false;
@@ -319,9 +312,8 @@ static int skl_suspend(struct device *dev)
 static int skl_resume(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct skl *skl  = ebus_to_skl(ebus);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct skl *skl  = bus_to_skl(bus);
 	struct hdac_ext_link *hlink = NULL;
 	int ret;
 
@@ -341,32 +333,32 @@ static int skl_resume(struct device *dev)
 	 */
 	if (skl->supend_active) {
 		pci_restore_state(pci);
-		snd_hdac_ext_bus_link_power_up_all(ebus);
+		snd_hdac_ext_bus_link_power_up_all(bus);
 		disable_irq_wake(bus->irq);
 		/*
 		 * turn On the links which are On before active suspend
 		 * and start the CORB/RIRB DMA if On before
 		 * active suspend.
 		 */
-		list_for_each_entry(hlink, &ebus->hlink_list, list) {
+		list_for_each_entry(hlink, &bus->hlink_list, list) {
 			if (hlink->ref_count)
 				snd_hdac_ext_bus_link_power_up(hlink);
 		}
 
-		if (ebus->cmd_dma_state)
-			snd_hdac_bus_init_cmd_io(&ebus->bus);
 		ret = 0;
+		if (bus->cmd_dma_state)
+			snd_hdac_bus_init_cmd_io(bus);
 	} else {
-		ret = _skl_resume(ebus);
+		ret = _skl_resume(bus);
 
 		/* turn off the links which are off before suspend */
-		list_for_each_entry(hlink, &ebus->hlink_list, list) {
+		list_for_each_entry(hlink, &bus->hlink_list, list) {
 			if (!hlink->ref_count)
 				snd_hdac_ext_bus_link_power_down(hlink);
 		}
 
-		if (!ebus->cmd_dma_state)
-			snd_hdac_bus_stop_cmd_io(&ebus->bus);
+		if (!bus->cmd_dma_state)
+			snd_hdac_bus_stop_cmd_io(bus);
 	}
 
 	return ret;
@@ -377,23 +369,21 @@ static int skl_resume(struct device *dev)
 static int skl_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = pci_get_drvdata(pci);
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
-	return _skl_suspend(ebus);
+	return _skl_suspend(bus);
 }
 
 static int skl_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = pci_get_drvdata(pci);
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
-	return _skl_resume(ebus);
+	return _skl_resume(bus);
 }
 #endif /* CONFIG_PM */
 
@@ -406,20 +396,19 @@ static const struct dev_pm_ops skl_pm = {
 /*
  * destructor
  */
-static int skl_free(struct hdac_ext_bus *ebus)
+static int skl_free(struct hdac_bus *bus)
 {
-	struct skl *skl  = ebus_to_skl(ebus);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl *skl  = bus_to_skl(bus);
 
 	skl->init_done = 0; /* to be sure */
 
-	snd_hdac_ext_stop_streams(ebus);
+	snd_hdac_ext_stop_streams(bus);
 
 	if (bus->irq >= 0)
-		free_irq(bus->irq, (void *)ebus);
+		free_irq(bus->irq, (void *)bus);
 	snd_hdac_bus_free_stream_pages(bus);
-	snd_hdac_stream_free_all(ebus);
-	snd_hdac_link_free_all(ebus);
+	snd_hdac_stream_free_all(bus);
+	snd_hdac_link_free_all(bus);
 
 	if (bus->remap_addr)
 		iounmap(bus->remap_addr);
@@ -427,11 +416,11 @@ static int skl_free(struct hdac_ext_bus *ebus)
 	pci_release_regions(skl->pci);
 	pci_disable_device(skl->pci);
 
-	snd_hdac_ext_bus_exit(ebus);
+	snd_hdac_ext_bus_exit(bus);
 
 	cancel_work_sync(&skl->probe_work);
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
-		snd_hdac_i915_exit(&ebus->bus);
+		snd_hdac_i915_exit(bus);
 
 	return 0;
 }
@@ -455,7 +444,7 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
 
 static int skl_machine_device_register(struct skl *skl, void *driver_data)
 {
-	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
+	struct hdac_bus *bus = skl_to_bus(skl);
 	struct platform_device *pdev;
 	struct snd_soc_acpi_mach *mach = driver_data;
 	int ret;
@@ -499,7 +488,7 @@ static void skl_machine_device_unregister(struct skl *skl)
 
 static int skl_dmic_device_register(struct skl *skl)
 {
-	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
+	struct hdac_bus *bus = skl_to_bus(skl);
 	struct platform_device *pdev;
 	int ret;
 
@@ -598,9 +587,8 @@ static void skl_clock_device_unregister(struct skl *skl)
 /*
  * Probe the given codec address
  */
-static int probe_codec(struct hdac_ext_bus *ebus, int addr)
+static int probe_codec(struct hdac_bus *bus, int addr)
 {
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res = -1;
@@ -613,13 +601,12 @@ static int probe_codec(struct hdac_ext_bus *ebus, int addr)
 		return -EIO;
 	dev_dbg(bus->dev, "codec #%d probed OK\n", addr);
 
-	return snd_hdac_ext_bus_device_init(ebus, addr);
+	return snd_hdac_ext_bus_device_init(bus, addr);
 }
 
 /* Codec initialization */
-static void skl_codec_create(struct hdac_ext_bus *ebus)
+static void skl_codec_create(struct hdac_bus *bus)
 {
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	int c, max_slots;
 
 	max_slots = HDA_MAX_CODECS;
@@ -627,7 +614,7 @@ static void skl_codec_create(struct hdac_ext_bus *ebus)
 	/* First try to probe all given codec slots */
 	for (c = 0; c < max_slots; c++) {
 		if ((bus->codec_mask & (1 << c))) {
-			if (probe_codec(ebus, c) < 0) {
+			if (probe_codec(bus, c) < 0) {
 				/*
 				 * Some BIOSen give you wrong codec addresses
 				 * that don't exist
@@ -677,8 +664,7 @@ static int skl_i915_init(struct hdac_bus *bus)
 static void skl_probe_work(struct work_struct *work)
 {
 	struct skl *skl = container_of(work, struct skl, probe_work);
-	struct hdac_ext_bus *ebus = &skl->ebus;
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = skl_to_bus(skl);
 	struct hdac_ext_link *hlink = NULL;
 	int err;
 
@@ -699,7 +685,7 @@ static void skl_probe_work(struct work_struct *work)
 		dev_info(bus->dev, "no hda codecs found!\n");
 
 	/* create codec instances */
-	skl_codec_create(ebus);
+	skl_codec_create(bus);
 
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
 		err = snd_hdac_display_power(bus, false);
@@ -716,8 +702,8 @@ static void skl_probe_work(struct work_struct *work)
 	/*
 	 * we are done probing so decrement link counts
 	 */
-	list_for_each_entry(hlink, &ebus->hlink_list, list)
-		snd_hdac_ext_bus_link_put(ebus, hlink);
+	list_for_each_entry(hlink, &bus->hlink_list, list)
+		snd_hdac_ext_bus_link_put(bus, hlink);
 
 	/* configure PM */
 	pm_runtime_put_noidle(bus->dev);
@@ -739,7 +725,7 @@ static int skl_create(struct pci_dev *pci,
 		      struct skl **rskl)
 {
 	struct skl *skl;
-	struct hdac_ext_bus *ebus;
+	struct hdac_bus *bus;
 
 	int err;
 
@@ -754,23 +740,22 @@ static int skl_create(struct pci_dev *pci,
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
-	ebus = &skl->ebus;
-	snd_hdac_ext_bus_init(ebus, &pci->dev, &bus_core_ops, io_ops);
-	ebus->bus.use_posbuf = 1;
+
+	bus = skl_to_bus(skl);
+	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops);
+	bus->use_posbuf = 1;
 	skl->pci = pci;
 	INIT_WORK(&skl->probe_work, skl_probe_work);
-
-	ebus->bus.bdl_pos_adj = 0;
+	bus->bdl_pos_adj = 0;
 
 	*rskl = skl;
 
 	return 0;
 }
 
-static int skl_first_init(struct hdac_ext_bus *ebus)
+static int skl_first_init(struct hdac_bus *bus)
 {
-	struct skl *skl = ebus_to_skl(ebus);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl *skl = bus_to_skl(bus);
 	struct pci_dev *pci = skl->pci;
 	int err;
 	unsigned short gcap;
@@ -791,7 +776,7 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 
 	snd_hdac_bus_parse_capabilities(bus);
 
-	if (skl_acquire_irq(ebus, 0) < 0)
+	if (skl_acquire_irq(bus, 0) < 0)
 		return -EBUSY;
 
 	pci_set_master(pci);
@@ -815,14 +800,14 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 	if (!pb_streams && !cp_streams)
 		return -EIO;
 
-	ebus->num_streams = cp_streams + pb_streams;
+	bus->num_streams = cp_streams + pb_streams;
 
 	/* initialize streams */
 	snd_hdac_ext_stream_init_all
-		(ebus, 0, cp_streams, SNDRV_PCM_STREAM_CAPTURE);
+		(bus, 0, cp_streams, SNDRV_PCM_STREAM_CAPTURE);
 	start_idx = cp_streams;
 	snd_hdac_ext_stream_init_all
-		(ebus, start_idx, pb_streams, SNDRV_PCM_STREAM_PLAYBACK);
+		(bus, start_idx, pb_streams, SNDRV_PCM_STREAM_PLAYBACK);
 
 	err = snd_hdac_bus_alloc_stream_pages(bus);
 	if (err < 0)
@@ -838,7 +823,6 @@ static int skl_probe(struct pci_dev *pci,
 		     const struct pci_device_id *pci_id)
 {
 	struct skl *skl;
-	struct hdac_ext_bus *ebus = NULL;
 	struct hdac_bus *bus = NULL;
 	int err;
 
@@ -847,10 +831,9 @@ static int skl_probe(struct pci_dev *pci,
 	if (err < 0)
 		return err;
 
-	ebus = &skl->ebus;
-	bus = ebus_to_hbus(ebus);
+	bus = skl_to_bus(skl);
 
-	err = skl_first_init(ebus);
+	err = skl_first_init(bus);
 	if (err < 0)
 		goto out_free;
 
@@ -871,7 +854,7 @@ static int skl_probe(struct pci_dev *pci,
 
 	skl_nhlt_update_topology_bin(skl);
 
-	pci_set_drvdata(skl->pci, ebus);
+	pci_set_drvdata(skl->pci, bus);
 
 	skl_dmic_data.dmic_num = skl_get_dmic_geo(skl);
 
@@ -896,7 +879,7 @@ static int skl_probe(struct pci_dev *pci,
 
 	}
 	if (bus->mlcap)
-		snd_hdac_ext_bus_get_ml_capabilities(ebus);
+		snd_hdac_ext_bus_get_ml_capabilities(bus);
 
 	snd_hdac_bus_stop_chip(bus);
 
@@ -918,31 +901,30 @@ static int skl_probe(struct pci_dev *pci,
 out_nhlt_free:
 	skl_nhlt_free(skl->nhlt);
 out_free:
-	skl_free(ebus);
+	skl_free(bus);
 
 	return err;
 }
 
 static void skl_shutdown(struct pci_dev *pci)
 {
-	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus = pci_get_drvdata(pci);
 	struct hdac_stream *s;
 	struct hdac_ext_stream *stream;
 	struct skl *skl;
 
-	if (ebus == NULL)
+	if (bus == NULL)
 		return;
 
-	skl = ebus_to_skl(ebus);
+	skl = bus_to_skl(bus);
 
 	if (!skl->init_done)
 		return;
 
-	snd_hdac_ext_stop_streams(ebus);
+	snd_hdac_ext_stop_streams(bus);
 	list_for_each_entry(s, &bus->stream_list, list) {
 		stream = stream_to_hdac_ext_stream(s);
-		snd_hdac_ext_stream_decouple(ebus, stream, false);
+		snd_hdac_ext_stream_decouple(bus, stream, false);
 	}
 
 	snd_hdac_bus_stop_chip(bus);
@@ -950,15 +932,15 @@ static void skl_shutdown(struct pci_dev *pci)
 
 static void skl_remove(struct pci_dev *pci)
 {
-	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct skl *skl = bus_to_skl(bus);
 
 	release_firmware(skl->tplg);
 
 	pm_runtime_get_noresume(&pci->dev);
 
 	/* codec removal, invoke bus_device_remove */
-	snd_hdac_ext_bus_device_remove(ebus);
+	snd_hdac_ext_bus_device_remove(bus);
 
 	skl->debugfs = NULL;
 	skl_platform_unregister(&pci->dev);
@@ -968,7 +950,7 @@ static void skl_remove(struct pci_dev *pci)
 	skl_clock_device_unregister(skl);
 	skl_nhlt_remove_sysfs(skl);
 	skl_nhlt_free(skl->nhlt);
-	skl_free(ebus);
+	skl_free(bus);
 	dev_set_drvdata(&pci->dev, NULL);
 }
 
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 46dda88..f3a48a4 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -63,7 +63,7 @@ struct skl_fw_config {
 };
 
 struct skl {
-	struct hdac_ext_bus ebus;
+	struct hdac_bus hbus;
 	struct pci_dev *pci;
 
 	unsigned int init_done:1; /* delayed init status */
@@ -96,9 +96,8 @@ struct skl {
 	struct skl_fw_config cfg;
 };
 
-#define skl_to_ebus(s)	(&(s)->ebus)
-#define ebus_to_skl(sbus) \
-	container_of(sbus, struct skl, sbus)
+#define skl_to_bus(s)  (&(s)->hbus)
+#define bus_to_skl(bus) container_of(bus, struct skl, hbus)
 
 /* to pass dai dma data */
 struct skl_dma_params {
-- 
2.7.4
