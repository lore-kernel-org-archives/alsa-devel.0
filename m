From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/3] ALSA: hdac: Add
	snd_hdac_get_hdac_stream()
Date: Sun, 23 Aug 2015 11:52:51 +0530
Message-ID: <1440310971-14849-3-git-send-email-vinod.koul@intel.com>
References: <1440310971-14849-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2443A260499
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2015 08:20:45 +0200 (CEST)
In-Reply-To: <1440310971-14849-1-git-send-email-vinod.koul@intel.com>
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

From: Jeeja KP <jeeja.kp@intel.com>

Add a helper to find the stream using stream tag and direction.
This is useful for drivers to query stream based on stream tag
and direction, fox example while downloading FW thru DSP loader
code

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h |  2 ++
 sound/hda/hdac_stream.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 23a44c39c51c..49bc836fcd84 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -438,6 +438,8 @@ void snd_hdac_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
 struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
 					   struct snd_pcm_substream *substream);
 void snd_hdac_stream_release(struct hdac_stream *azx_dev);
+struct hdac_stream *snd_hdac_get_stream(struct hdac_bus *bus,
+					int dir, int stream_tag);
 
 int snd_hdac_stream_setup(struct hdac_stream *azx_dev);
 void snd_hdac_stream_cleanup(struct hdac_stream *azx_dev);
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 4c15d0accc9e..8981159813ef 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -286,6 +286,28 @@ void snd_hdac_stream_release(struct hdac_stream *azx_dev)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_release);
 
+/**
+ * snd_hdac_get_stream - return hdac_stream based on stream_tag and
+ * direction
+ *
+ * @bus: HD-audio core bus
+ * @dir: direction for the stream to be found
+ * @stream_tag: stream tag for stream to be found
+ */
+struct hdac_stream *snd_hdac_get_stream(struct hdac_bus *bus,
+					int dir, int stream_tag)
+{
+	struct hdac_stream *s;
+
+	list_for_each_entry(s, &bus->stream_list, list) {
+		if (s->direction == dir && s->stream_tag == stream_tag)
+			return s;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_get_stream);
+
 /*
  * set up a BDL entry
  */
-- 
1.9.1
