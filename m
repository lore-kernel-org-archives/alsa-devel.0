From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK IO plug 1/1] pcm: ioplug: Provide avail
	helper function for plugins
Date: Tue, 3 Jul 2018 13:58:05 +0200
Message-ID: <1530619087-971-2-git-send-email-twischer@de.adit-jv.com>
References: <1530619087-971-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1530619087-971-1-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

This function can be called without calling snd_pcm_avail_update().

The call to snd_pcm_avail_update() can take some time.
Therefore some developers would not like to call it from a real-time
context (e.g. from JACK client context).

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/include/pcm_ioplug.h b/include/pcm_ioplug.h
index c1310e3..b16fc8b 100644
--- a/include/pcm_ioplug.h
+++ b/include/pcm_ioplug.h
@@ -235,6 +235,9 @@ int snd_pcm_ioplug_set_param_list(snd_pcm_ioplug_t *io, int type, unsigned int n
 int snd_pcm_ioplug_set_state(snd_pcm_ioplug_t *ioplug, snd_pcm_state_t state);
 
 /* calucalte the available frames */
+snd_pcm_uframes_t snd_pcm_ioplug_avail(const snd_pcm_ioplug_t * const ioplug,
+				       const snd_pcm_uframes_t hw_ptr,
+				       const snd_pcm_uframes_t appl_ptr);
 snd_pcm_uframes_t snd_pcm_ioplug_hw_avail(const snd_pcm_ioplug_t * const ioplug,
 					  const snd_pcm_uframes_t hw_ptr,
 					  const snd_pcm_uframes_t appl_ptr);
diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 4d44ae2..6d52c27 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -1221,6 +1221,21 @@ int snd_pcm_ioplug_set_state(snd_pcm_ioplug_t *ioplug, snd_pcm_state_t state)
  * \param ioplug the ioplug handle
  * \param hw_ptr hardware pointer in frames
  * \param appl_ptr application pointer in frames
+ * \return available frames for the application
+ */
+snd_pcm_uframes_t snd_pcm_ioplug_avail(const snd_pcm_ioplug_t * const ioplug,
+				       const snd_pcm_uframes_t hw_ptr,
+				       const snd_pcm_uframes_t appl_ptr)
+{
+	return __snd_pcm_avail(ioplug->pcm, hw_ptr, appl_ptr);
+}
+
+/**
+ * \brief Get the available frames. This function can be used to calculate the
+ * the available frames before calling #snd_pcm_avail_update()
+ * \param ioplug the ioplug handle
+ * \param hw_ptr hardware pointer in frames
+ * \param appl_ptr application pointer in frames
  * \return available frames for the hardware
  */
 snd_pcm_uframes_t snd_pcm_ioplug_hw_avail(const snd_pcm_ioplug_t * const ioplug,
@@ -1230,8 +1245,9 @@ snd_pcm_uframes_t snd_pcm_ioplug_hw_avail(const snd_pcm_ioplug_t * const ioplug,
 	/* available data/space which can be transferred by the user
 	 * application
 	 */
-	const snd_pcm_uframes_t user_avail = __snd_pcm_avail(ioplug->pcm,
-							     hw_ptr, appl_ptr);
+	const snd_pcm_uframes_t user_avail = snd_pcm_ioplug_avail(ioplug,
+								  hw_ptr,
+								  appl_ptr);
 
 	if (user_avail > ioplug->pcm->buffer_size) {
 		/* there was an Xrun */
-- 
2.7.4
