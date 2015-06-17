From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ALSA: HDA: add hda link cleanup routine
Date: Wed, 17 Jun 2015 11:20:17 +0530
Message-ID: <1434520218-14556-2-git-send-email-vinod.koul@intel.com>
References: <1434520218-14556-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B4A53265A58
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 07:48:48 +0200 (CEST)
In-Reply-To: <1434520218-14556-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

In HDA extended bus the HDA link objects are created when multilink
capabilities are parsed. We need a routine which free up these link objects
for a bus. So add snd_hdac_link_free_all routine

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h         |  1 +
 sound/hda/ext/hdac_ext_controller.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 877661629322..0f89df1511dc 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -90,6 +90,7 @@ void snd_hdac_ext_stream_init(struct hdac_ext_bus *bus,
 int snd_hdac_ext_stream_init_all(struct hdac_ext_bus *ebus, int start_idx,
 		int num_stream, int dir);
 void snd_hdac_stream_free_all(struct hdac_ext_bus *ebus);
+void snd_hdac_link_free_all(struct hdac_ext_bus *ebus);
 struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_ext_bus *bus,
 					   struct snd_pcm_substream *substream,
 					   int type);
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index adffc89541c9..b2da19b60f4e 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -194,6 +194,24 @@ int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *ebus)
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_get_ml_capabilities);
 
 /**
+ * snd_hdac_link_free_all- free hdac extended link objects
+ *
+ * @ebus: HD-audio ext core bus
+ */
+
+void snd_hdac_link_free_all(struct hdac_ext_bus *ebus)
+{
+	struct hdac_ext_link *l;
+
+	while (!list_empty(&ebus->hlink_list)) {
+		l = list_first_entry(&ebus->hlink_list, struct hdac_ext_link, list);
+		list_del(&l->list);
+		kfree(l);
+	}
+}
+EXPORT_SYMBOL_GPL(snd_hdac_link_free_all);
+
+/**
  * snd_hdac_ext_bus_get_link_index - get link based on codec name
  * @ebus: HD-audio extended core bus
  * @codec_name: codec name
-- 
1.9.1
