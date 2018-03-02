From: <twischer@de.adit-jv.com>
Subject: [PATCH - PCM 2/3] pcm: ioplug: Provide hw_avail helper
	function for plugins
Date: Fri, 2 Mar 2018 17:21:12 +0100
Message-ID: <1520007674-14618-2-git-send-email-twischer@de.adit-jv.com>
References: <s5hfu5jizsv.wl-tiwai@suse.de>
 <1520007674-14618-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 91681267440
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 17:21:46 +0100 (CET)
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

This function can be called without calling snd_pcm_avail_update().

The call to snd_pcm_avail_update() can take some time.
Therefore some developers would not like to call it from a real-time
context (e.g. from JACK client context).

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/include/pcm_ioplug.h b/include/pcm_ioplug.h
index e75f973..778d9c6 100644
--- a/include/pcm_ioplug.h
+++ b/include/pcm_ioplug.h
@@ -234,6 +234,9 @@ int snd_pcm_ioplug_set_param_list(snd_pcm_ioplug_t *io, int type, unsigned int n
 /* change PCM status */
 int snd_pcm_ioplug_set_state(snd_pcm_ioplug_t *ioplug, snd_pcm_state_t state);
 
+/* calucalte the available frames */
+snd_pcm_uframes_t snd_pcm_ioplug_hw_avail(const snd_pcm_ioplug_t* const ioplug, const snd_pcm_uframes_t hw_ptr, const snd_pcm_uframes_t appl_ptr);
+
 /** \} */
 
 #endif /* __ALSA_PCM_IOPLUG_H */
diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 9970646..a0cb778 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -1148,3 +1148,27 @@ int snd_pcm_ioplug_set_state(snd_pcm_ioplug_t *ioplug, snd_pcm_state_t state)
 	ioplug->state = state;
 	return 0;
 }
+
+/**
+ * \brief Get the available frames. This function can be used to calculate the
+ * the available frames before calling #snd_pcm_avail_update()
+ * \param ioplug the ioplug handle
+ * \param hw_ptr hardware pointer in frames
+ * \param appl_ptr application pointer in frames
+ * \return available frames for the hardware
+ */
+snd_pcm_uframes_t snd_pcm_ioplug_hw_avail(const snd_pcm_ioplug_t* const ioplug,
+                                          const snd_pcm_uframes_t hw_ptr,
+                                          const snd_pcm_uframes_t appl_ptr)
+{
+	/* available data/space which can be transfered by the user application */
+	const snd_pcm_uframes_t user_avail = __snd_pcm_avail(ioplug->pcm, hw_ptr,
+	                                                     appl_ptr);
+
+	if (user_avail > ioplug->pcm->buffer_size) {
+		/* there was an Xrun */
+		return 0;
+	}
+	/* available data/space which can be transfered by the DMA */
+	return ioplug->pcm->buffer_size - user_avail;
+}
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 3d95e17..b695b92 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -467,10 +467,12 @@ static inline int snd_pcm_check_error(snd_pcm_t *pcm, int err)
 	return err;
 }
 
-static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t *pcm)
+static inline snd_pcm_uframes_t __snd_pcm_playback_avail(snd_pcm_t *pcm,
+                                                       const snd_pcm_uframes_t hw_ptr,
+                                                       const snd_pcm_uframes_t appl_ptr)
 {
 	snd_pcm_sframes_t avail;
-	avail = *pcm->hw.ptr + pcm->buffer_size - *pcm->appl.ptr;
+	avail = hw_ptr + pcm->buffer_size - appl_ptr;
 	if (avail < 0)
 		avail += pcm->boundary;
 	else if ((snd_pcm_uframes_t) avail >= pcm->boundary)
@@ -478,21 +480,40 @@ static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t *pcm)
 	return avail;
 }
 
-static inline snd_pcm_uframes_t snd_pcm_mmap_capture_avail(snd_pcm_t *pcm)
+static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t *pcm)
+{
+	return __snd_pcm_playback_avail(pcm, *pcm->hw.ptr, *pcm->appl.ptr);
+}
+
+static inline snd_pcm_uframes_t __snd_pcm_capture_avail(snd_pcm_t *pcm,
+                                                      const snd_pcm_uframes_t hw_ptr,
+                                                      const snd_pcm_uframes_t appl_ptr)
 {
 	snd_pcm_sframes_t avail;
-	avail = *pcm->hw.ptr - *pcm->appl.ptr;
+	avail = hw_ptr - appl_ptr;
 	if (avail < 0)
 		avail += pcm->boundary;
 	return avail;
 }
 
-static inline snd_pcm_uframes_t snd_pcm_mmap_avail(snd_pcm_t *pcm)
+static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t *pcm)
+{
+	return __snd_pcm_capture_avail(pcm, *pcm->hw.ptr, *pcm->appl.ptr);
+}
+
+static inline snd_pcm_uframes_t __snd_pcm_avail(snd_pcm_t *pcm,
+                                                const snd_pcm_uframes_t hw_ptr,
+                                                const snd_pcm_uframes_t appl_ptr)
 {
 	if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
-		return snd_pcm_mmap_playback_avail(pcm);
+		return snd_pcm_playback_avail(pcm, hw_ptr, appl_ptr);
 	else
-		return snd_pcm_mmap_capture_avail(pcm);
+		return snd_pcm_capture_avail(pcm, hw_ptr, appl_ptr);
+}
+
+static inline snd_pcm_uframes_t snd_pcm_mmap_avail(snd_pcm_t *pcm)
+{
+	return __snd_pcm_avail(pcm, *pcm->hw.ptr, *pcm->appl.ptr);
 }
 
 static inline snd_pcm_sframes_t snd_pcm_mmap_playback_hw_avail(snd_pcm_t *pcm)
-- 
2.7.4
