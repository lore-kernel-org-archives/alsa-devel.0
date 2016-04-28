From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ALSA: hdac: add link pm and ref counting
Date: Thu, 28 Apr 2016 19:30:58 +0530
Message-ID: <1461852059-20518-2-git-send-email-vinod.koul@intel.com>
References: <1461852059-20518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 94861266D5A
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:55:13 +0200 (CEST)
In-Reply-To: <1461852059-20518-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The HDA links can be switched off when not is use, similarly
command DMA can be stopped as well. This calls for a reference
counting mechanism on the link by it's users to manage the link
power. The DMA can be turned off when all links are off

For this we add two APIs
	snd_hdac_ext_bus_link_get
	snd_hdac_ext_bus_link_put

They help users to turn up/down link and manage the DMA as well

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h         | 13 ++++++++
 sound/hda/ext/hdac_ext_bus.c        |  3 ++
 sound/hda/ext/hdac_ext_controller.c | 62 +++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 07fa59237feb..59f8a6eaac62 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -14,6 +14,8 @@
  * @gtscap: gts capabilities pointer
  * @drsmcap: dma resume capabilities pointer
  * @hlink_list: link list of HDA links
+ * @lock: lock for link mgmt
+ * @cmd_io: state of cmd_io
  */
 struct hdac_ext_bus {
 	struct hdac_bus bus;
@@ -27,6 +29,9 @@ struct hdac_ext_bus {
 	void __iomem *drsmcap;
 
 	struct list_head hlink_list;
+
+	spinlock_t lock;
+	int cmd_io;
 };
 
 int snd_hdac_ext_bus_init(struct hdac_ext_bus *sbus, struct device *dev,
@@ -142,6 +147,9 @@ struct hdac_ext_link {
 	void __iomem *ml_addr; /* link output stream reg pointer */
 	u32 lcaps;   /* link capablities */
 	u16 lsdiid;  /* link sdi identifier */
+
+	int ref_count;
+
 	struct list_head list;
 };
 
@@ -154,6 +162,11 @@ void snd_hdac_ext_link_set_stream_id(struct hdac_ext_link *link,
 void snd_hdac_ext_link_clear_stream_id(struct hdac_ext_link *link,
 				 int stream);
 
+int snd_hdac_ext_bus_link_get(struct hdac_ext_bus *ebus,
+				struct hdac_ext_link *link);
+int snd_hdac_ext_bus_link_put(struct hdac_ext_bus *ebus,
+				struct hdac_ext_link *link);
+
 /* update register macro */
 #define snd_hdac_updatel(addr, reg, mask, val)		\
 	writel(((readl(addr + reg) & ~(mask)) | (val)), \
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 64de0a3d6d93..43ad6f17771f 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -105,6 +105,9 @@ int snd_hdac_ext_bus_init(struct hdac_ext_bus *ebus, struct device *dev,
 	INIT_LIST_HEAD(&ebus->hlink_list);
 	ebus->idx = idx++;
 
+	spin_lock_init(&ebus->lock);
+	ebus->cmd_io = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_init);
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 548cc1e4114b..df7835178248 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -186,6 +186,9 @@ int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *ebus)
 		hlink->lcaps  = readl(hlink->ml_addr + AZX_REG_ML_LCAP);
 		hlink->lsdiid = readw(hlink->ml_addr + AZX_REG_ML_LSDIID);
 
+		/* since link in On, update the ref */
+		hlink->ref_count = 1;
+
 		list_add_tail(&hlink->list, &ebus->hlink_list);
 	}
 
@@ -327,3 +330,62 @@ int snd_hdac_ext_bus_link_power_down_all(struct hdac_ext_bus *ebus)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down_all);
+
+int snd_hdac_ext_bus_link_get(struct hdac_ext_bus *ebus,
+				struct hdac_ext_link *link)
+{
+	int ret = 0;
+
+	spin_lock(&ebus->lock);
+
+	/*
+	 * if we move from 0 to 1, count will be 1 so power up this link
+	 * as well, also check the dma status and trigger that
+	 */
+	if (++link->ref_count == 1) {
+		if (!ebus->cmd_io) {
+			snd_hdac_bus_init_cmd_io(&ebus->bus);
+			ebus->cmd_io = 1;
+		}
+
+		ret = snd_hdac_ext_bus_link_power_up(link);
+	}
+
+	spin_unlock(&ebus->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_get);
+
+int snd_hdac_ext_bus_link_put(struct hdac_ext_bus *ebus,
+				struct hdac_ext_link *link)
+{
+	int ret = 0, state = 0;
+	struct hdac_ext_link *hlink = NULL;
+
+	spin_lock(&ebus->lock);
+
+	/*
+	 * if we move from 1 to 0, count will be 0
+	 * so power down this link as well
+	 */
+	if (--link->ref_count == 0) {
+		ret = snd_hdac_ext_bus_link_power_down(link);
+
+		/*
+		 * now check if all links are off, if so turn off
+		 * cmd dma as well
+		 */
+		list_for_each_entry(hlink, &ebus->hlink_list, list) {
+			if (hlink->ref_count)
+				state++;
+		}
+		if (!state) {
+			snd_hdac_bus_stop_cmd_io(&ebus->bus);
+			ebus->cmd_io = 0;
+		}
+	}
+
+	spin_unlock(&ebus->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_put);
-- 
1.9.1
