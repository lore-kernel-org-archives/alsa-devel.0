From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 6/7] aaf: Tx multiple AVTPDUs
	per media clock tick
Date: Fri,  7 Dec 2018 17:55:49 -0800
Message-ID: <20181208015550.20268-7-andre.guedes@intel.com>
References: <20181208015550.20268-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id D0BC6267D2F
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 03:02:24 +0100 (CET)
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

In order to implement the transmission offload mechanism, we need to
change the way the plugin behaves so, instead of sending only one
AVTPDU, it sends several AVTPDUs at every media clock tick.

To achieve that, this patch changes the plugin so it consumes the audio
buffer in chunks of period size instead of in frames_per_pdu. The number
of AVTPDUs sent at every media clock tick is calculated by dividing the
period size by the number of frames per AVTPDU. To ensure that number is
not fractional, the plugin requires that the period size is multiple of
the plugin configuration 'frames_per_pdu'.

For the sake of consistency, the capture mode is also changed so the
plugin presents audio frames to the alsa-lib layer in chunks of period
size as well.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 44 +++++++++++++++++++++++++++++++-------------
 doc/aaf.txt   |  7 ++++---
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index 1d7ebca..284cbfd 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -83,6 +83,8 @@ typedef struct {
 	snd_pcm_uframes_t boundary;
 
 	uint64_t prev_ptime;
+
+	int pdu_period;
 } snd_pcm_aaf_t;
 
 static unsigned int alsa_to_avtp_format(snd_pcm_format_t format)
@@ -489,7 +491,7 @@ static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
 		return -errno;
 	}
 
-	period = (uint64_t)NSEC_PER_SEC * aaf->frames_per_pdu / io->rate;
+	period = (uint64_t)NSEC_PER_SEC * io->period_size / io->rate;
 	time = now.tv_sec * NSEC_PER_SEC + now.tv_nsec + period;
 	res = aaf_mclk_start(aaf, time, period);
 	if (res < 0)
@@ -502,7 +504,7 @@ static int aaf_mclk_start_capture(snd_pcm_aaf_t *aaf, uint32_t avtp_time)
 {
 	int res;
 	struct timespec tspec;
-	uint64_t now, ptime, period;
+	uint64_t now, ptime, time, period;
 	snd_pcm_ioplug_t *io = &aaf->io;
 
 	res = clock_gettime(CLOCK_TAI, &tspec);
@@ -526,8 +528,9 @@ static int aaf_mclk_start_capture(snd_pcm_aaf_t *aaf, uint32_t avtp_time)
 	if (ptime < now)
 		ptime += (1ULL << 32);
 
-	period = (uint64_t)NSEC_PER_SEC * aaf->frames_per_pdu / io->rate;
-	res = aaf_mclk_start(aaf, ptime, period);
+	period = (uint64_t)NSEC_PER_SEC * io->period_size / io->rate;
+	time = ptime + period;
+	res = aaf_mclk_start(aaf, time, period);
 	if (res < 0)
 		return res;
 
@@ -613,7 +616,7 @@ static int aaf_tx_pdus(snd_pcm_aaf_t *aaf, int pdu_count)
 		if (res < 0)
 			return res;
 
-		ptime += aaf->timer_period;
+		ptime += aaf->pdu_period;
 		ptr += aaf->frames_per_pdu;
 	}
 
@@ -622,7 +625,7 @@ static int aaf_tx_pdus(snd_pcm_aaf_t *aaf, int pdu_count)
 
 static bool is_ptime_valid(snd_pcm_aaf_t *aaf, uint32_t avtp_time)
 {
-	const uint64_t exp_ptime = aaf->prev_ptime + aaf->timer_period;
+	const uint64_t exp_ptime = aaf->prev_ptime + aaf->pdu_period;
 	const uint64_t lower_bound = exp_ptime - aaf->ptime_tolerance;
 	const uint64_t upper_bound = exp_ptime + aaf->ptime_tolerance;
 	const uint64_t ptime = (exp_ptime & 0xFFFFFFFF00000000ULL) | avtp_time;
@@ -899,22 +902,23 @@ static int aaf_tx_frames(snd_pcm_aaf_t *aaf)
 {
 	int res;
 	snd_pcm_uframes_t hw_avail;
+	int pdu_count;
 	snd_pcm_ioplug_t *io = &aaf->io;
 
 	hw_avail = snd_pcm_ioplug_hw_avail(io, aaf->hw_ptr, io->appl_ptr);
-	if (hw_avail < aaf->frames_per_pdu) {
-		/* If the number of available frames is less than number of
-		 * frames needed to fill an AVTPDU, we reached an underrun
-		 * state.
+	if (hw_avail < io->period_size) {
+		/* If the number of available frames is less than the period
+		 * size, we reached an underrun state.
 		 */
 		return -EPIPE;
 	}
 
-	res = aaf_tx_pdus(aaf, 1);
+	pdu_count = io->period_size / aaf->frames_per_pdu;
+	res = aaf_tx_pdus(aaf, pdu_count);
 	if (res < 0)
 		return res;
 
-	aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pdu, aaf->boundary);
+	aaf_inc_ptr(&aaf->hw_ptr, io->period_size, aaf->boundary);
 	return 0;
 }
 
@@ -935,7 +939,7 @@ static int aaf_present_frames(snd_pcm_aaf_t *aaf)
 		return -EPIPE;
 	}
 
-	aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pdu, aaf->boundary);
+	aaf_inc_ptr(&aaf->hw_ptr, io->period_size, aaf->boundary);
 	return 0;
 }
 
@@ -1071,8 +1075,22 @@ static int aaf_hw_params(snd_pcm_ioplug_t *io,
 	if (res < 0)
 		goto err_free_pdu;
 
+	if (io->period_size % aaf->frames_per_pdu) {
+		/* The plugin requires that the period size is multiple of the
+		 * configuration frames_per_pdu. Return error if this
+		 * requirement isn't satisfied.
+		 */
+		SNDERR("Period size must be multiple of frames_per_pdu");
+		res = -EINVAL;
+		goto err_free_areas;
+	}
+
+	aaf->pdu_period = (uint64_t)NSEC_PER_SEC * aaf->frames_per_pdu /
+			  io->rate;
 	return 0;
 
+err_free_areas:
+	free(aaf->payload_areas);
 err_free_pdu:
 	free(aaf->pdu);
 err_close_timer:
diff --git a/doc/aaf.txt b/doc/aaf.txt
index e72eba2..e12a6f6 100644
--- a/doc/aaf.txt
+++ b/doc/aaf.txt
@@ -147,16 +147,17 @@ below:
 	}
 
 Put the above to ~/.asoundrc (or /etc/asound.conf), and use the AAF PCM virtual
-device 'aaf0' with your favorite alsa-utils tool.
+device 'aaf0' with your favorite alsa-utils tool. Note that the plugin requires
+the period size is multiple of the 'frames_per_pdu' configuration.
 
 For example, to stream the pink noise generated by 'speaker-test', run:
 
-	$ speaker-test -F S16_BE -c 2 -r 48000 -D aaf0
+	$ speaker-test -F S16_BE -c 2 -r 48000 -D aaf0 -p 12500
 
 To receive the AAF stream generated by the command above, run the following
 command in another host:
 
-	$ arecord -t raw -f S16_BE -c 2 -r 48000 -D aaf0 -vv /dev/null
+	$ arecord -t raw -f S16_BE -c 2 -r 48000 -D aaf0 -vv /dev/null -F 12500
 
 If you want to playback the contents of the AAF stream, change the command-line
 above so the output from 'arecord' is redirected to 'aplay', or simply use the
-- 
2.19.1
