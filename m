From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 2/5] ALSA: hda: Add api to program stripe
	control bits
Date: Fri, 11 Jan 2019 22:52:05 +0530
Message-ID: <1547227328-32558-3-git-send-email-spujar@nvidia.com>
References: <1547227328-32558-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DCB426797E
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 18:22:36 +0100 (CET)
In-Reply-To: <1547227328-32558-1-git-send-email-spujar@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Controllers and codecs can support striping of audio out across
multiple SDO lines. The number of supported SDO lines can be
specific to chip. GCAP register can be read to know the maximum
supported SDO lines.

snd_hdac_get_stream_stripe_ctl() is exposed to program stripe bits
on controller and codec side.
stripe value: 0 for 1SDO, 1 for 2SDO, 2 for 4SDO lines, etc.,

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
---
 include/sound/hdaudio.h |  3 +++
 sound/hda/hdac_stream.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index b4fa1c7..45f944d 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -539,6 +539,9 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
 			  unsigned int streams);
 void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
 				      unsigned int streams);
+int snd_hdac_get_stream_stripe_ctl(struct hdac_bus *bus,
+				struct snd_pcm_substream *substream);
+
 /*
  * macros for easy use
  */
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index eee4223..b403b05 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -13,6 +13,40 @@
 #include "trace.h"
 
 /**
+ * snd_hdac_get_stream_stripe_ctl - get stripe control value
+ * @bus: HD-audio core bus
+ * @substream: PCM substream
+ */
+int snd_hdac_get_stream_stripe_ctl(struct hdac_bus *bus,
+				   struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int channels = runtime->channels,
+		     rate = runtime->rate,
+		     bits_per_sample = runtime->sample_bits,
+		     max_sdo_lines, value, sdo_line;
+
+	/* T_AZA_GCAP_NSDO is 1:2 bitfields in GCAP */
+	max_sdo_lines = snd_hdac_chip_readl(bus, GCAP) & AZX_GCAP_NSDO;
+
+	/* following is from HD audio spec */
+	for (sdo_line = max_sdo_lines; sdo_line > 0; sdo_line >>= 1) {
+		if (rate > 48000)
+			value = (channels * bits_per_sample *
+					(rate / 48000)) / sdo_line;
+		else
+			value = channels * bits_per_sample / sdo_line;
+
+		if (value >= 8)
+			break;
+	}
+
+	/* stripe value: 0 for 1SDO, 1 for 2SDO, 2 for 4SDO lines */
+	return sdo_line >> 1;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_get_stream_stripe_ctl);
+
+/**
  * snd_hdac_stream_init - initialize each stream (aka device)
  * @bus: HD-audio core bus
  * @azx_dev: HD-audio core stream object to initialize
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
