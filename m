From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ALSA: hda: add hdac_ext stream creation
	and cleanup routines
Date: Wed, 17 Jun 2015 11:20:16 +0530
Message-ID: <1434520218-14556-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E3E93265A3F
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 07:48:47 +0200 (CEST)
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

HDAC extended core should create streams for an extended bus and also free
up those on cleanup. So introduce snd_hdac_ext_stream_init_all and
snd_hdac_stream_free_all routines

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h     |  3 +++
 sound/hda/ext/hdac_ext_stream.c | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 202350a8eddb..877661629322 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -87,6 +87,9 @@ struct hdac_ext_stream {
 void snd_hdac_ext_stream_init(struct hdac_ext_bus *bus,
 				struct hdac_ext_stream *stream, int idx,
 				int direction, int tag);
+int snd_hdac_ext_stream_init_all(struct hdac_ext_bus *ebus, int start_idx,
+		int num_stream, int dir);
+void snd_hdac_stream_free_all(struct hdac_ext_bus *ebus);
 struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_ext_bus *bus,
 					   struct snd_pcm_substream *substream,
 					   int type);
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 0677bb65a494..f8ffbdbb450d 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/slab.h>
 #include <sound/pcm.h>
 #include <sound/hda_register.h>
 #include <sound/hdaudio_ext.h>
@@ -54,6 +55,55 @@ void snd_hdac_ext_stream_init(struct hdac_ext_bus *ebus,
 EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_init);
 
 /**
+ * snd_hdac_ext_stream_init_all - create and initialize the stream objects
+ *   for an extended hda bus
+ * @ebus: HD-audio ext core bus
+ * @start_idx: start index for streams
+ * @num_stream: number of streams to initialize
+ * @dir: direction of streams
+ */
+int snd_hdac_ext_stream_init_all(struct hdac_ext_bus *ebus, int start_idx,
+		int num_stream, int dir)
+{
+	int stream_tag = 0;
+	int i, tag, idx = start_idx;
+
+	for (i = 0; i < num_stream; i++) {
+		struct hdac_ext_stream *stream =
+				kzalloc(sizeof(*stream), GFP_KERNEL);
+		if (!stream)
+			return -ENOMEM;
+		tag = ++stream_tag;
+		snd_hdac_ext_stream_init(ebus, stream, idx, dir, tag);
+		idx++;
+	}
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_init_all);
+
+/**
+ * snd_hdac_stream_free_all - free hdac extended stream objects
+ *
+ * @ebus: HD-audio ext core bus
+ */
+void snd_hdac_stream_free_all(struct hdac_ext_bus *ebus)
+{
+	struct hdac_stream *s;
+	struct hdac_ext_stream *stream;
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+
+	while (!list_empty(&bus->stream_list)) {
+		s = list_first_entry(&bus->stream_list, struct hdac_stream, list);
+		stream = stream_to_hdac_ext_stream(s);
+		list_del(&s->list);
+		kfree(stream);
+	}
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_free_all);
+
+/**
  * snd_hdac_ext_stream_decouple - decouple the hdac stream
  * @ebus: HD-audio ext core bus
  * @stream: HD-audio ext core stream object to initialize
-- 
1.9.1
