From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 2/2] ALSA: hda - add generic functions to
	set hdac stream params
Date: Fri, 17 Apr 2015 17:58:58 +0530
Message-ID: <1429273738-24666-3-git-send-email-vinod.koul@intel.com>
References: <1429273738-24666-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E60A826058D
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 14:34:09 +0200 (CEST)
In-Reply-To: <1429273738-24666-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This will be used by hda controller driver to
setup stream params in prepare. This function will
setup the bdl and periods.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h |    2 ++
 sound/hda/hdac_stream.c |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index d05931fc6f28..6a2e030c836c 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -418,6 +418,8 @@ void snd_hdac_stream_release(struct hdac_stream *azx_dev);
 int snd_hdac_stream_setup(struct hdac_stream *azx_dev);
 void snd_hdac_stream_cleanup(struct hdac_stream *azx_dev);
 int snd_hdac_stream_setup_periods(struct hdac_stream *azx_dev);
+int snd_hdac_stream_set_params(struct hdac_stream *azx_dev,
+				unsigned int format_val);
 void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start);
 void snd_hdac_stream_clear(struct hdac_stream *azx_dev);
 void snd_hdac_stream_stop(struct hdac_stream *azx_dev);
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 9ffff6d9ba8e..1ba0462ef7ca 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -394,6 +394,44 @@ int snd_hdac_stream_setup_periods(struct hdac_stream *azx_dev)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_setup_periods);
 
+/* snd_hdac_stream_set_params - set stream parameters
+ * @azx_dev: HD-audio core stream for which parameters are to be set
+ * @format_val: format value parameter
+ *
+ * Setup the HD-audio core stream parameters from substream of the stream
+ * and passed format value
+ */
+int snd_hdac_stream_set_params(struct hdac_stream *azx_dev,
+				 unsigned int format_val)
+{
+
+	unsigned int bufsize, period_bytes;
+	struct snd_pcm_substream *substream = azx_dev->substream;
+	struct snd_pcm_runtime *runtime;
+	int err;
+
+	if (!substream)
+		return -EINVAL;
+	runtime = substream->runtime;
+	bufsize = snd_pcm_lib_buffer_bytes(substream);
+	period_bytes = snd_pcm_lib_period_bytes(substream);
+
+	if (bufsize != azx_dev->bufsize ||
+	    period_bytes != azx_dev->period_bytes ||
+	    format_val != azx_dev->format_val ||
+	    runtime->no_period_wakeup != azx_dev->no_period_wakeup) {
+		azx_dev->bufsize = bufsize;
+		azx_dev->period_bytes = period_bytes;
+		azx_dev->format_val = format_val;
+		azx_dev->no_period_wakeup = runtime->no_period_wakeup;
+		err = snd_hdac_stream_setup_periods(azx_dev);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_stream_set_params);
+
 static cycle_t azx_cc_read(const struct cyclecounter *cc)
 {
 	struct hdac_stream *azx_dev = container_of(cc, struct hdac_stream, cc);
-- 
1.7.9.5
