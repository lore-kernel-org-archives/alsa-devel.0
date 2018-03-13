From: <twischer@de.adit-jv.com>
Subject: [PATCH - PCM 2/2] pcm: Provide areas_copy function
	which handles buffer wrap around
Date: Tue, 13 Mar 2018 09:34:43 +0100
Message-ID: <1520930084-17449-3-git-send-email-twischer@de.adit-jv.com>
References: <1520007674-14618-4-git-send-email-twischer@de.adit-jv.com>
 <1520930084-17449-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id DBD27267198
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 09:35:33 +0100 (CET)
In-Reply-To: <1520930084-17449-1-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

The already existing areas_copy functions do not care about
the end of the source and destination buffer.
Therefore the caller has to take care
that the requested offset+size is not exceeding any buffer limit.

This additional function will take care about the end of an buffer
and will continue at the beginning of the buffer.
For example this is required when copying between buffers with
different sizes (not multiple of).
This is often the case in IO plugins like the JACK plugin.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/include/pcm.h b/include/pcm.h
index 2619c8c..e2a5343 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -1147,6 +1147,15 @@ int snd_pcm_area_copy(const snd_pcm_channel_area_t *dst_channel, snd_pcm_uframes
 int snd_pcm_areas_copy(const snd_pcm_channel_area_t *dst_channels, snd_pcm_uframes_t dst_offset,
 		       const snd_pcm_channel_area_t *src_channels, snd_pcm_uframes_t src_offset,
 		       unsigned int channels, snd_pcm_uframes_t frames, snd_pcm_format_t format);
+int snd_pcm_areas_copy_wrap(const snd_pcm_channel_area_t *dst_channels,
+			    snd_pcm_uframes_t dst_offset,
+			    const snd_pcm_uframes_t dst_size,
+			    const snd_pcm_channel_area_t *src_channels,
+			    snd_pcm_uframes_t src_offset,
+			    const snd_pcm_uframes_t src_size,
+			    const unsigned int channels,
+			    snd_pcm_uframes_t frames,
+			    const snd_pcm_format_t format);
 
 /** \} */
 
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index d53ed98..ed47cb5 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -3289,6 +3289,55 @@ int snd_pcm_areas_copy(const snd_pcm_channel_area_t *dst_areas, snd_pcm_uframes_
 	return 0;
 }
 
+/**
+ * \brief Copy one or more areas
+ * \param dst_areas destination areas specification (one for each channel)
+ * \param dst_offset offset in frames inside destination area
+ * \param dst_size size in frames of the destination buffer
+ * \param src_areas source areas specification (one for each channel)
+ * \param src_offset offset in frames inside source area
+ * \param dst_size size in frames of the source buffer
+ * \param channels channels count
+ * \param frames frames to copy
+ * \param format PCM sample format
+ * \return 0 on success otherwise a negative error code
+ */
+int snd_pcm_areas_copy_wrap(const snd_pcm_channel_area_t *dst_channels,
+			    snd_pcm_uframes_t dst_offset,
+			    const snd_pcm_uframes_t dst_size,
+			    const snd_pcm_channel_area_t *src_channels,
+			    snd_pcm_uframes_t src_offset,
+			    const snd_pcm_uframes_t src_size,
+			    const unsigned int channels,
+			    snd_pcm_uframes_t frames,
+			    const snd_pcm_format_t format)
+{
+	while (frames > 0) {
+		int err;
+		snd_pcm_uframes_t xfer = frames;
+		/* do not write above the destination buffer */
+		if ((dst_offset + xfer) > dst_size)
+			xfer = dst_size - dst_offset;
+		/* do not read from above the source buffer */
+		if ((src_offset + xfer) > src_size)
+			xfer = src_size - src_offset;
+		err = snd_pcm_areas_copy(dst_channels, dst_offset, src_channels,
+					 src_offset, channels, xfer, format);
+		if (err < 0)
+			return err;
+
+		dst_offset += xfer;
+		if (dst_offset >= dst_size)
+			dst_offset = 0;
+		src_offset += xfer;
+		if (src_offset >= src_size)
+			src_offset = 0;
+		frames -= xfer;
+	}
+
+	return 0;
+}
+
 static void dump_one_param(snd_pcm_hw_params_t *params, unsigned int k, snd_output_t *out)
 {
 	snd_output_printf(out, "%s: ", snd_pcm_hw_param_name(k));
-- 
2.7.4
