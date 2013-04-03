From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 1/2] ALSA: hda - Add fixed codec delay to
	runtime delay.
Date: Wed,  3 Apr 2013 08:30:03 -0700
Message-ID: <1365003004-7680-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f74.google.com (mail-oa0-f74.google.com
 [209.85.219.74])
 by alsa0.perex.cz (Postfix) with ESMTP id A102A265D6D
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 17:30:15 +0200 (CEST)
Received: by mail-oa0-f74.google.com with SMTP id k14so401278oag.1
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 08:30:14 -0700 (PDT)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, ian_minett@creativelabs.com
List-Id: alsa-devel@alsa-project.org

Allow a codec to specify a delay in addition to the delay before
samples are passed through DMA.  Some codecs have large processing
delays because of built-in DSPs that require codec-side buffers of
many milliseconds.  Default to zero delay if the codec doesn't specify
a callback to get the processing delay.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_codec.c | 17 +++++++++++++++++
 sound/pci/hda/hda_codec.h |  4 ++++
 sound/pci/hda/hda_intel.c |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 17286b3..1d792dd 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3724,6 +3724,23 @@ void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_set_power_to_all);
 
+/**
+ * snd_hda_codec_processing_delay - get the fixed delay through the codec
+ * @codec: HD-audio codec
+ * @stream: playback or capture
+ *
+ * This is needed for codecs that contain DSPs that cause long delays.
+ */
+unsigned int snd_hda_codec_processing_delay(struct hda_codec *codec,
+					    unsigned int stream)
+{
+	if (codec->patch_ops.get_processing_delay)
+		return codec->patch_ops.get_processing_delay(codec, stream);
+
+	return 0;
+}
+EXPORT_SYMBOL_HDA(snd_hda_codec_processing_delay);
+
 /*
  *  supported power states check
  */
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 23ca172..23bd1e7 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -725,6 +725,8 @@ struct hda_codec_ops {
 	int (*check_power_status)(struct hda_codec *codec, hda_nid_t nid);
 #endif
 	void (*reboot_notify)(struct hda_codec *codec);
+	unsigned int (*get_processing_delay)(struct hda_codec *codec,
+					     unsigned int stream);
 };
 
 /* record for amp information cache */
@@ -1063,6 +1065,8 @@ void snd_hda_get_codec_name(struct hda_codec *codec, char *name, int namelen);
 void snd_hda_bus_reboot_notify(struct hda_bus *bus);
 void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 				    unsigned int power_state);
+unsigned int snd_hda_codec_processing_delay(struct hda_codec *codec,
+					    unsigned int stream);
 
 int snd_hda_lock_devices(struct hda_bus *bus);
 void snd_hda_unlock_devices(struct hda_bus *bus);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 418bfc0..422bfaf 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2349,6 +2349,7 @@ static unsigned int azx_get_position(struct azx *chip,
 				     struct azx_dev *azx_dev,
 				     bool with_check)
 {
+	struct azx_pcm *apcm = snd_pcm_substream_chip(azx_dev->substream);
 	unsigned int pos;
 	int stream = azx_dev->substream->stream;
 	int delay = 0;
@@ -2400,6 +2401,7 @@ static unsigned int azx_get_position(struct azx *chip,
 			chip->driver_caps &= ~AZX_DCAPS_COUNT_LPIB_DELAY;
 		}
 		azx_dev->substream->runtime->delay =
+			snd_hda_codec_processing_delay(apcm->codec, stream) +
 			bytes_to_frames(azx_dev->substream->runtime, delay);
 	}
 	trace_azx_get_position(chip, azx_dev, pos, delay);
-- 
1.8.1.5
