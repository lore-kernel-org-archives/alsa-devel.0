From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 3/7] aaf: Refactor AVTPDU
	transmission routines
Date: Fri,  7 Dec 2018 17:55:46 -0800
Message-ID: <20181208015550.20268-4-andre.guedes@intel.com>
References: <20181208015550.20268-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 812A8267D44
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

This patch does some code refactoring in the AVTPDU transmission
routines in order to prepare the code to support the transmission
offload mechanism that will be added by upcoming patches. No
functionality is added or removed by this patch.

In summary, code from aaf_tx_pdu() is moved into aaf_mclk_timeout_
playback() and into a new function introduced by this patch called
aaf_tx_pdus(). Below follows more details about the code refactoring.

The function aaf_tx_pdu() is modified so it only takes care of setting
the payload, sequence number and presentation time from the AVTPDU, and
sending it to the kernel.

The new function aaf_tx_pdus() calculates the presentation time from
each AVTPDU and calls aaf_tx_pdu() multiple times, according to the pdu
count argument.

Finally, the function aaf_mclk_timeout_playback() now checks if there
are frames available to the "hardware" and takes care of moving the
hardware pointer forward.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 54 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index 8410dcf..1ad1586 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -661,28 +661,18 @@ static uint64_t aaf_mclk_gettime(snd_pcm_aaf_t *aaf)
 	       (aaf->timer_expirations - 1);
 }
 
-static int aaf_tx_pdu(snd_pcm_aaf_t *aaf)
+static int aaf_tx_pdu(snd_pcm_aaf_t *aaf, snd_pcm_uframes_t ptr,
+		      uint64_t ptime)
 {
 	int res;
-	uint64_t ptime;
 	ssize_t n;
-	snd_pcm_uframes_t hw_avail;
 	snd_pcm_ioplug_t *io = &aaf->io;
 	struct avtp_stream_pdu *pdu = aaf->pdu;
 
-	hw_avail = snd_pcm_ioplug_hw_avail(io, aaf->hw_ptr, io->appl_ptr);
-	if (hw_avail < aaf->frames_per_pdu) {
-		/* If the number of available frames is less than number of
-		 * frames needed to fill an AVTPDU, we reached an underrun
-		 * state.
-		 */
-		return -EPIPE;
-	}
-
 	res = snd_pcm_areas_copy_wrap(aaf->payload_areas, 0,
 				      aaf->frames_per_pdu,
 				      aaf->audiobuf_areas,
-				      (aaf->hw_ptr % io->buffer_size),
+				      (ptr % io->buffer_size),
 				      io->buffer_size, io->channels,
 				      aaf->frames_per_pdu, io->format);
 	if (res < 0) {
@@ -694,7 +684,6 @@ static int aaf_tx_pdu(snd_pcm_aaf_t *aaf)
 	if (res < 0)
 		return res;
 
-	ptime = aaf_mclk_gettime(aaf) + aaf->mtt + aaf->t_uncertainty;
 	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_TIMESTAMP, ptime);
 	if (res < 0)
 		return res;
@@ -707,7 +696,27 @@ static int aaf_tx_pdu(snd_pcm_aaf_t *aaf)
 		return -EIO;
 	}
 
-	aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pdu, aaf->boundary);
+	return 0;
+}
+
+static int aaf_tx_pdus(snd_pcm_aaf_t *aaf, int pdu_count)
+{
+	int res;
+	uint64_t ptime;
+	snd_pcm_uframes_t ptr;
+
+	ptime = aaf_mclk_gettime(aaf) + aaf->mtt + aaf->t_uncertainty;
+	ptr = aaf->hw_ptr;
+
+	while (pdu_count--) {
+		res = aaf_tx_pdu(aaf, ptr, ptime);
+		if (res < 0)
+			return res;
+
+		ptime += aaf->timer_period;
+		ptr += aaf->frames_per_pdu;
+	}
+
 	return 0;
 }
 
@@ -845,6 +854,8 @@ static int aaf_mclk_timeout_playback(snd_pcm_aaf_t *aaf)
 	int res;
 	ssize_t n;
 	uint64_t expirations;
+	snd_pcm_uframes_t hw_avail;
+	snd_pcm_ioplug_t *io = &aaf->io;
 
 	n = read(aaf->timer_fd, &expirations, sizeof(uint64_t));
 	if (n < 0) {
@@ -858,9 +869,20 @@ static int aaf_mclk_timeout_playback(snd_pcm_aaf_t *aaf)
 	while (expirations--) {
 		aaf->timer_expirations++;
 
-		res = aaf_tx_pdu(aaf);
+		hw_avail = snd_pcm_ioplug_hw_avail(io, aaf->hw_ptr, io->appl_ptr);
+		if (hw_avail < aaf->frames_per_pdu) {
+			/* If the number of available frames is less than
+			 * number of frames needed to fill an AVTPDU, we
+			 * reached an underrun state.
+			 */
+			return -EPIPE;
+		}
+
+		res = aaf_tx_pdus(aaf, 1);
 		if (res < 0)
 			return res;
+
+		aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pdu, aaf->boundary);
 	}
 
 	return 0;
-- 
2.19.1
