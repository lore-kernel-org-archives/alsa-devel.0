From: <twischer@de.adit-jv.com>
Subject: [PATCH - PCM 3/3] pcm: Provide areas_copy function
	which handles buffer wrap around
Date: Fri, 2 Mar 2018 17:21:13 +0100
Message-ID: <1520007674-14618-3-git-send-email-twischer@de.adit-jv.com>
References: <s5hfu5jizsv.wl-tiwai@suse.de>
 <1520007674-14618-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B12126743A
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 17:22:00 +0100 (CET)
In-Reply-To: <1520007674-14618-1-git-send-email-twischer@de.adit-jv.com>
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

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/include/pcm.h b/include/pcm.h
index 2619c8c..d880a1c 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -1147,6 +1147,9 @@ int snd_pcm_area_copy(const snd_pcm_channel_area_t *dst_channel, snd_pcm_uframes
 int snd_pcm_areas_copy(const snd_pcm_channel_area_t *dst_channels, snd_pcm_uframes_t dst_offset,
 		       const snd_pcm_channel_area_t *src_channels, snd_pcm_uframes_t src_offset,
 		       unsigned int channels, snd_pcm_uframes_t frames, snd_pcm_format_t format);
+int snd_pcm_areas_copy_wrap(const snd_pcm_channel_area_t *dst_channels, snd_pcm_uframes_t dst_offset, const snd_pcm_uframes_t dst_size,
+		       const snd_pcm_channel_area_t *src_channels, snd_pcm_uframes_t src_offset, const snd_pcm_uframes_t src_size,
+		       const unsigned int channels, snd_pcm_uframes_t frames, const snd_pcm_format_t format);
 
 /** \} */
 
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index d53ed98..77898db 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -3289,6 +3289,36 @@ int snd_pcm_areas_copy(const snd_pcm_channel_area_t *dst_areas, snd_pcm_uframes_
 	return 0;
 }
 
+int snd_pcm_areas_copy_wrap(const snd_pcm_channel_area_t *dst_channels, snd_pcm_uframes_t dst_offset, const snd_pcm_uframes_t dst_size,
+		       const snd_pcm_channel_area_t *src_channels, snd_pcm_uframes_t src_offset, const snd_pcm_uframes_t src_size,
+		       const unsigned int channels, snd_pcm_uframes_t frames, const snd_pcm_format_t format)
+{
+	while (frames > 0) {
+		int err;
+		snd_pcm_uframes_t xfer = frames;
+		/* do not write above the destination buffer */
+		if ( (dst_offset + xfer) > dst_size )
+			xfer = dst_size - dst_offset;
+		/* do not read from above the source buffer */
+		if ( (src_offset + xfer) > src_size )
+			xfer = src_size - src_offset;
+		err = snd_pcm_areas_copy(dst_channels, dst_offset, src_channels,
+		                              src_offset, channels, xfer, format);
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
