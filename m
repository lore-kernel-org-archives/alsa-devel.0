From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 5/7] aaf: Refactor timeout
	routines
Date: Fri,  7 Dec 2018 17:55:48 -0800
Message-ID: <20181208015550.20268-6-andre.guedes@intel.com>
References: <20181208015550.20268-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C5213267D34
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 03:02:22 +0100 (CET)
In-Reply-To: <20181208015550.20268-1-andre.guedes@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The functions aaf_mclk_timeout_playback() and aaf_mclk_timeout_capture()
have some common code so this patch does a code refactoring by moving
the shared code into a new function called aaf_timer_timeout().

After the refactoring, aaf_mclk_timeout_playback() and aaf_mclk_timeout_
capture() ended up having no code related to timeout so they were
renamed to better represent what they really do (send frames and present
frames, respectively).

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 87 ++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 42 deletions(-)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index 49d5bed..1d7ebca 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -895,51 +895,64 @@ static int aaf_flush_rx_buf(snd_pcm_aaf_t *aaf)
 	return 0;
 }
 
-static int aaf_mclk_timeout_playback(snd_pcm_aaf_t *aaf)
+static int aaf_tx_frames(snd_pcm_aaf_t *aaf)
 {
 	int res;
-	ssize_t n;
-	uint64_t expirations;
 	snd_pcm_uframes_t hw_avail;
 	snd_pcm_ioplug_t *io = &aaf->io;
 
-	n = read(aaf->timer_fd, &expirations, sizeof(uint64_t));
-	if (n < 0) {
-		SNDERR("Failed to read() timer");
-		return -errno;
+	hw_avail = snd_pcm_ioplug_hw_avail(io, aaf->hw_ptr, io->appl_ptr);
+	if (hw_avail < aaf->frames_per_pdu) {
+		/* If the number of available frames is less than number of
+		 * frames needed to fill an AVTPDU, we reached an underrun
+		 * state.
+		 */
+		return -EPIPE;
 	}
 
-	if (expirations != 1)
-		pr_debug("Missed %llu tx interval(s) ", expirations - 1);
+	res = aaf_tx_pdus(aaf, 1);
+	if (res < 0)
+		return res;
 
-	while (expirations--) {
-		aaf->timer_expirations++;
+	aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pdu, aaf->boundary);
+	return 0;
+}
 
-		hw_avail = snd_pcm_ioplug_hw_avail(io, aaf->hw_ptr, io->appl_ptr);
-		if (hw_avail < aaf->frames_per_pdu) {
-			/* If the number of available frames is less than
-			 * number of frames needed to fill an AVTPDU, we
-			 * reached an underrun state.
-			 */
-			return -EPIPE;
-		}
+static int aaf_present_frames(snd_pcm_aaf_t *aaf)
+{
+	snd_pcm_sframes_t len;
+	snd_pcm_ioplug_t *io = &aaf->io;
 
-		res = aaf_tx_pdus(aaf, 1);
-		if (res < 0)
-			return res;
+	len = aaf->hw_virt_ptr - aaf->hw_ptr;
+	if (len < 0)
+		len += aaf->boundary;
 
-		aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pdu, aaf->boundary);
+	if ((snd_pcm_uframes_t) len > io->buffer_size) {
+		/* If the distance between hw virtual pointer and hw
+		 * pointer is greater than the buffer size, it means we
+		 * had an overrun error so -EPIPE is returned.
+		 */
+		return -EPIPE;
 	}
 
+	aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pdu, aaf->boundary);
 	return 0;
 }
 
-static int aaf_mclk_timeout_capture(snd_pcm_aaf_t *aaf)
+static int aaf_process_frames(snd_pcm_aaf_t *aaf)
 {
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	return (io->stream == SND_PCM_STREAM_PLAYBACK) ?
+	       aaf_tx_frames(aaf) :
+	       aaf_present_frames(aaf);
+}
+
+static int aaf_timer_timeout(snd_pcm_aaf_t *aaf)
+{
+	int res;
 	ssize_t n;
 	uint64_t expirations;
-	snd_pcm_sframes_t len;
-	snd_pcm_ioplug_t *io = &aaf->io;
 
 	n = read(aaf->timer_fd, &expirations, sizeof(uint64_t));
 	if (n < 0) {
@@ -948,24 +961,14 @@ static int aaf_mclk_timeout_capture(snd_pcm_aaf_t *aaf)
 	}
 
 	if (expirations != 1)
-		pr_debug("Missed %llu presentation time(s) ", expirations - 1);
+		pr_debug("Missed %llu expirations ", expirations - 1);
 
 	while (expirations--) {
 		aaf->timer_expirations++;
 
-		len = aaf->hw_virt_ptr - aaf->hw_ptr;
-		if (len < 0)
-			len += aaf->boundary;
-
-		if ((snd_pcm_uframes_t) len > io->buffer_size) {
-			/* If the distance between hw virtual pointer and hw
-			 * pointer is greater than the buffer size, it means we
-			 * had an overrun error so -EPIPE is returned.
-			 */
-			return -EPIPE;
-		}
-
-		aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pdu, aaf->boundary);
+		res = aaf_process_frames(aaf);
+		if (res < 0)
+			return res;
 	}
 
 	return 0;
@@ -1152,7 +1155,7 @@ static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct pollfd *pfd,
 			return -EINVAL;
 
 		if (pfd[0].revents & POLLIN) {
-			res = aaf_mclk_timeout_playback(aaf);
+			res = aaf_timer_timeout(aaf);
 			if (res < 0)
 				return res;
 
@@ -1163,7 +1166,7 @@ static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct pollfd *pfd,
 			return -EINVAL;
 
 		if (pfd[0].revents & POLLIN) {
-			res = aaf_mclk_timeout_capture(aaf);
+			res = aaf_timer_timeout(aaf);
 			if (res < 0)
 				return res;
 
-- 
2.19.1
