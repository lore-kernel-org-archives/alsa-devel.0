From: "Roy Huang" <royhuang9@gmail.com>
Subject: [PATCH]fix mmap emulation bug of recording doesn't work
Date: Wed, 4 Jul 2007 13:51:53 +0800
Message-ID: <afe668f90707032251v693c78a6g37e2e009ec13f3b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 731251038B8
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 07:51:55 +0200 (CEST)
Received: by ik-out-1112.google.com with SMTP id b35so1651337ika
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 22:51:54 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Record doesn't work if enabling mmap emulation and rate conversion
needed, this patch fix this bug.

diff -uNr alsa-lib-1.0.14a/src/pcm/pcm_hw.c alsa-lib-new/src/pcm/pcm_hw.c
--- alsa-lib-1.0.14a/src/pcm/pcm_hw.c	2007-06-11 16:53:13.000000000 +0800
+++ alsa-lib-new/src/pcm/pcm_hw.c	2007-07-04 12:16:31.000000000 +0800
@@ -96,6 +96,7 @@
 	int shadow_appl_ptr: 1,
 	    avail_update_flag: 1,
 	    mmap_shm: 1;
+	snd_pcm_uframes_t hw_ptr;
 	snd_pcm_uframes_t appl_ptr;
 	/* restricted parameters */
 	snd_pcm_format_t format;
@@ -373,7 +374,9 @@
 	if (pcm->stream == SND_PCM_STREAM_CAPTURE) {
 		if (hw->mmap_shm) {
 			hw->shadow_appl_ptr = 1;
+			hw->hw_ptr = 0;
 			hw->appl_ptr = 0;
+			snd_pcm_set_hw_ptr(pcm, &hw->hw_ptr, -1, 0);
 			snd_pcm_set_appl_ptr(pcm, &hw->appl_ptr, -1, 0);
 		} else {
 			hw->shadow_appl_ptr = 0;
@@ -949,28 +952,91 @@
 	return size;
 }

+static inline snd_pcm_uframes_t snd_pcm_hw_capture_avail(snd_pcm_t *pcm)
+{
+	snd_pcm_sframes_t avail;
+	snd_pcm_hw_t *hw = pcm->private_data;
+
+	avail = hw->mmap_status->hw_ptr - hw->mmap_control->appl_ptr;
+	if (avail < 0)
+		avail += pcm->boundary;
+	return avail;
+}
+
+static snd_pcm_sframes_t snd_pcm_hw_read_mmap(snd_pcm_t *pcm,
snd_pcm_uframes_t size)
+{
+	snd_pcm_uframes_t xfer = 0;
+	snd_pcm_sframes_t err = 0;
+	snd_pcm_hw_t *hw = pcm->private_data;
+	if (! size)
+		return 0;
+	while (xfer < size) {
+		snd_pcm_uframes_t frames = size - xfer;
+		snd_pcm_uframes_t appl_offset = hw->mmap_control->appl_ptr %
pcm->buffer_size;
+		snd_pcm_uframes_t cont = pcm->buffer_size - appl_offset;
+		if (cont < frames)
+			frames = cont;
+		switch (pcm->access) {
+		case SND_PCM_ACCESS_MMAP_INTERLEAVED:
+		{
+			const snd_pcm_channel_area_t *a = snd_pcm_mmap_areas(pcm);
+			char *buf = snd_pcm_channel_area_addr(a, appl_offset);
+			err = _snd_pcm_readi(pcm, buf, frames);
+			if (err >= 0)
+				frames = err;
+			break;
+		}
+		case SND_PCM_ACCESS_MMAP_NONINTERLEAVED:
+		{
+			snd_pcm_uframes_t channels = pcm->channels;
+			unsigned int c;
+			void *bufs[channels];
+			const snd_pcm_channel_area_t *areas = snd_pcm_mmap_areas(pcm);
+			for (c = 0; c < channels; ++c) {
+				const snd_pcm_channel_area_t *a = &areas[c];
+				bufs[c] = snd_pcm_channel_area_addr(a, appl_offset);
+			}
+			err = _snd_pcm_readn(pcm->fast_op_arg, bufs, frames);
+			if (err >= 0)
+				frames = err;
+		}
+		default:
+			SNDMSG("invalid access type %d", pcm->access);
+			return -EINVAL;
+		}
+		if (err < 0)
+			break;
+		xfer += frames;
+	}
+	if (xfer > 0)
+		return xfer;
+	return err;
+}
+
 static snd_pcm_sframes_t snd_pcm_hw_avail_update(snd_pcm_t *pcm)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
-	snd_pcm_uframes_t avail;
+	snd_pcm_uframes_t avail, xfer_avail;

 	sync_ptr(hw, 0);
 	if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
 		avail = snd_pcm_mmap_playback_avail(pcm);
 	} else {
 		avail = snd_pcm_mmap_capture_avail(pcm);
-		if (avail > 0 && hw->mmap_shm) {
+		if (avail < pcm->avail_min && hw->mmap_shm) {
 			snd_pcm_sframes_t err;
-			snd_pcm_hw_t *hw = pcm->private_data;
-			hw->avail_update_flag = 1;
-			err = snd_pcm_read_mmap(pcm, avail);
-			hw->avail_update_flag = 0;
-			if (err < 0)
-				return err;
-			if ((snd_pcm_uframes_t)err != avail)
-				SNDMSG("short read %ld for avail %ld", err, avail);
-			return err;
-		}
+			xfer_avail = snd_pcm_hw_capture_avail(pcm);
+			xfer_avail -= xfer_avail % pcm->xfer_align;
+			if (xfer_avail > 0) {
+				hw->avail_update_flag = 1;
+				err = snd_pcm_hw_read_mmap(pcm, xfer_avail);
+				hw->avail_update_flag = 0;
+				if (err < 0)
+					return err;
+				hw->hw_ptr += err;
+				avail = snd_pcm_mmap_capture_avail(pcm);
+			}
+		}
 	}
 	switch (FAST_PCM_STATE(hw)) {
 	case SNDRV_PCM_STATE_RUNNING:
