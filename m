From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 4/7] aaf: Refactor AVTPDU
	reception routines
Date: Fri,  7 Dec 2018 17:55:47 -0800
Message-ID: <20181208015550.20268-5-andre.guedes@intel.com>
References: <20181208015550.20268-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F3CAF267D4E
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

This patch does some code refactoring in the AVTPDU reception
routines in order to prepare the code to support the transmission
offload mechanism that will be added by upcoming patches. No
functionality is added or removed by this patch.

In summary, the function aaf_rx_pdu() is broken down into smaller, new
functions and some code is moved to is_pdu_valid(). Below follows more
details about the code refactoring.

The function aaf_rx_pdu() was renamed to aaf_socket_new_data() which
reads the socket and dispatches the AVTPDU in case the PCM device isn't
in DRAIN state. Function aaf_dispatch_pdu() simply reads the subtype
field from the AVTPDU and dispatches it according. For now, only AAF
PDUs are supported. Finally, the aaf_dispatch_pdu_aaf() handles AAF
AVTPDUs which means to check if the AVTPDU is valid, copies the PCM
samples from the payload to the audio buffer, and start the media clock
in case it hasn't been started already.

The function is_pdu_valid() is moved around to avoid forward
declaration. Code to validate the sequence number and presentation time
from the AVTPDU which used to be in aaf_rx_pdu() is moved into
is_pdu_valid().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 320 +++++++++++++++++++++++++++++---------------------
 1 file changed, 183 insertions(+), 137 deletions(-)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index 1ad1586..49d5bed 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -129,106 +129,6 @@ static unsigned int alsa_to_avtp_rate(unsigned int rate)
 	}
 }
 
-static bool is_pdu_valid(struct avtp_stream_pdu *pdu, uint64_t streamid,
-			 unsigned int data_len, unsigned int format,
-			 unsigned int nsr, unsigned int channels,
-			 unsigned int depth)
-{
-	int res;
-	uint64_t val64;
-	uint32_t val32;
-	struct avtp_common_pdu *common = (struct avtp_common_pdu *) pdu;
-
-	res = avtp_pdu_get(common, AVTP_FIELD_SUBTYPE, &val32);
-	if (res < 0)
-		return false;
-	if (val32 != AVTP_SUBTYPE_AAF) {
-		pr_debug("Subtype mismatch: expected %u, got %u",
-			 AVTP_SUBTYPE_AAF, val32);
-		return false;
-	}
-
-	res = avtp_pdu_get(common, AVTP_FIELD_VERSION, &val32);
-	if (res < 0)
-		return false;
-	if (val32 != 0) {
-		pr_debug("Version mismatch: expected %u, got %u", 0, val32);
-		return false;
-	}
-
-	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_STREAM_ID, &val64);
-	if (res < 0)
-		return false;
-	if (val64 != streamid) {
-		pr_debug("Streamid mismatch: expected %lu, got %lu", streamid,
-			 val64);
-		return false;
-	}
-
-	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_TV, &val64);
-	if (res < 0)
-		return false;
-	if (val64 != 1) {
-		pr_debug("TV mismatch: expected %u, got %lu", 1, val64);
-		return false;
-	}
-
-	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_SP, &val64);
-	if (res < 0)
-		return false;
-	if (val64 != AVTP_AAF_PCM_SP_NORMAL) {
-		pr_debug("SP mismatch: expected %u, got %lu",
-			 AVTP_AAF_PCM_SP_NORMAL, val64);
-		return false;
-	}
-
-	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_FORMAT, &val64);
-	if (res < 0)
-		return false;
-	if (val64 != format) {
-		pr_debug("Format mismatch: expected %u, got %lu", format,
-			 val64);
-		return false;
-	}
-
-	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_NSR, &val64);
-	if (res < 0)
-		return false;
-	if (val64 != nsr) {
-		pr_debug("NSR mismatch: expected %u, got %lu", nsr, val64);
-		return false;
-	}
-
-	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_CHAN_PER_FRAME, &val64);
-	if (res < 0)
-		return false;
-	if (val64 != channels) {
-		pr_debug("Channels mismatch: expected %u, got %lu", channels,
-			 val64);
-		return false;
-	}
-
-	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_BIT_DEPTH, &val64);
-	if (res < 0)
-		return false;
-	if (val64 != depth) {
-		pr_debug("Bit depth mismatch: expected %u, got %lu", depth,
-			 val64);
-		return false;
-	}
-
-	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_STREAM_DATA_LEN, &val64);
-	if (res < 0)
-		return false;
-	if (val64 != data_len) {
-		pr_debug("Data len mismatch: expected %u, got %lu",
-			 data_len, val64);
-		return false;
-	}
-
-	return true;
-}
-
 static int aaf_load_config(snd_pcm_aaf_t *aaf, snd_config_t *conf)
 {
 	snd_config_iterator_t cur, next;
@@ -741,66 +641,134 @@ static bool is_ptime_valid(snd_pcm_aaf_t *aaf, uint32_t avtp_time)
 	return true;
 }
 
-static int aaf_rx_pdu(snd_pcm_aaf_t *aaf)
+static bool is_pdu_valid(snd_pcm_aaf_t *aaf)
 {
 	int res;
-	ssize_t n;
-	uint64_t seq, avtp_time;
-	snd_pcm_uframes_t hw_avail;
+	uint64_t val64;
+	uint32_t val32;
 	snd_pcm_ioplug_t *io = &aaf->io;
 	snd_pcm_t *pcm = io->pcm;
+	const uint64_t data_len = snd_pcm_frames_to_bytes(pcm, aaf->frames_per_pdu);
+	const uint64_t format = alsa_to_avtp_format(io->format);
+	const uint64_t nsr = alsa_to_avtp_rate(io->rate);
+	const uint64_t depth = snd_pcm_format_width(io->format);
+	struct avtp_common_pdu *common = (struct avtp_common_pdu *) aaf->pdu;
 
-	n = recv(aaf->sk_fd, aaf->pdu, aaf->pdu_size, 0);
-	if (n < 0) {
-		SNDERR("Failed to receive data");
-		return -errno;
+	res = avtp_pdu_get(common, AVTP_FIELD_VERSION, &val32);
+	if (res < 0)
+		return false;
+	if (val32 != 0) {
+		pr_debug("Version mismatch: expected %u, got %u", 0, val32);
+		return false;
 	}
-	if (n != aaf->pdu_size) {
-		pr_debug("AVTPDU dropped: Invalid size");
-		return 0;
+
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_STREAM_ID, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != aaf->streamid) {
+		pr_debug("Streamid mismatch: expected %lu, got %lu",
+			 aaf->streamid,	val64);
+		return false;
 	}
 
-	if (io->state == SND_PCM_STATE_DRAINING) {
-		/* If device is in DRAIN state, we shouldn't copy any more data
-		 * to audio buffer. So we are done here.
-		 */
-		return 0;
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_TV, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != 1) {
+		pr_debug("TV mismatch: expected %u, got %lu", 1, val64);
+		return false;
 	}
 
-	if (!is_pdu_valid(aaf->pdu, aaf->streamid,
-			  snd_pcm_frames_to_bytes(pcm, aaf->frames_per_pdu),
-			  alsa_to_avtp_format(io->format),
-			  alsa_to_avtp_rate(io->rate),
-			  io->channels, snd_pcm_format_width(io->format))) {
-		pr_debug("AVTPDU dropped: Bad field(s)");
-		return 0;
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_SP, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != AVTP_AAF_PCM_SP_NORMAL) {
+		pr_debug("SP mismatch: expected %u, got %lu",
+			 AVTP_AAF_PCM_SP_NORMAL, val64);
+		return false;
 	}
 
-	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_SEQ_NUM, &seq);
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_FORMAT, &val64);
 	if (res < 0)
-		return res;
-	if (seq != aaf->pdu_seq) {
+		return false;
+	if (val64 != format) {
+		pr_debug("Format mismatch: expected %u, got %lu", format,
+			 val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_NSR, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != nsr) {
+		pr_debug("NSR mismatch: expected %u, got %lu", nsr, val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_CHAN_PER_FRAME, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != io->channels) {
+		pr_debug("Channels mismatch: expected %u, got %lu",
+			 io->channels, val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_BIT_DEPTH, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != depth) {
+		pr_debug("Bit depth mismatch: expected %u, got %lu", depth,
+			 val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_STREAM_DATA_LEN, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != data_len) {
+		pr_debug("Data len mismatch: expected %u, got %lu",
+			 data_len, val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_SEQ_NUM, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != aaf->pdu_seq) {
 		pr_debug("Sequence mismatch: expected %u, got %lu",
-			 aaf->pdu_seq, seq);
-		aaf->pdu_seq = seq;
+			 aaf->pdu_seq, val64);
+		aaf->pdu_seq = val64;
 	}
 	aaf->pdu_seq++;
 
-	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_TIMESTAMP, &avtp_time);
-	if (res < 0)
-		return res;
+	if (aaf->timer_starttime) {
+		/* If media clock has started, it means we have already
+		 * received an AVTPDU, so we are able to check if the
+		 * Presentation Time from this AVTPDU is valid.
+		 */
+		uint64_t avtp_time;
 
-	if (aaf->timer_starttime == 0) {
-		res = aaf_mclk_start_capture(aaf, avtp_time);
+		res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_TIMESTAMP,
+				       &avtp_time);
 		if (res < 0)
-			return res;
-	} else {
+			return false;
+
 		if (!is_ptime_valid(aaf, avtp_time)) {
 			pr_debug("Packet dropped: PT not valid");
-			return 0;
+			return false;
 		}
 	}
 
+	return true;
+}
+
+static int aaf_copy_pdu_payload(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	snd_pcm_uframes_t hw_avail;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
 	hw_avail = snd_pcm_ioplug_hw_avail(io, aaf->hw_virt_ptr, io->appl_ptr);
 	if (hw_avail < aaf->frames_per_pdu) {
 		/* If there isn't enough space available on buffer to copy the
@@ -824,6 +792,84 @@ static int aaf_rx_pdu(snd_pcm_aaf_t *aaf)
 	return 0;
 }
 
+static int aaf_dispatch_pdu_aaf(snd_pcm_aaf_t *aaf)
+{
+	int res;
+
+	if (!is_pdu_valid(aaf)) {
+		pr_debug("AAF PDU dropped: Bad field(s)");
+		return 0;
+	}
+
+	res = aaf_copy_pdu_payload(aaf);
+	if (res < 0)
+		return res;
+
+	if (aaf->timer_starttime == 0) {
+		/* If the media clock has not been started yet (which means
+		 * this is the first AAF PDU received by the plugin), we start
+		 * it.
+		 */
+		uint64_t avtp_time;
+
+		res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_TIMESTAMP,
+				       &avtp_time);
+		if (res < 0)
+			return res;
+
+		res = aaf_mclk_start_capture(aaf, avtp_time);
+		if (res < 0)
+			return res;
+	}
+
+	return 0;
+}
+
+static int aaf_dispatch_pdu(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	uint32_t subtype;
+	struct avtp_common_pdu *common = (struct avtp_common_pdu *) aaf->pdu;
+
+	res = avtp_pdu_get(common, AVTP_FIELD_SUBTYPE, &subtype);
+	if (res < 0)
+		return res;
+
+	switch (subtype) {
+	case AVTP_SUBTYPE_AAF:
+		return aaf_dispatch_pdu_aaf(aaf);
+	default:
+		pr_debug("AVTPDU dropped: subtype not supported");
+		return 0;
+	}
+}
+
+static int aaf_socket_new_data(snd_pcm_aaf_t *aaf)
+{
+	ssize_t n;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	n = recv(aaf->sk_fd, aaf->pdu, aaf->pdu_size, 0);
+	if (n < 0) {
+		SNDERR("Failed to receive data");
+		return -errno;
+	}
+	if (n != aaf->pdu_size) {
+		pr_debug("AVTPDU dropped: Invalid size");
+		return 0;
+	}
+
+	if (io->state == SND_PCM_STATE_DRAINING) {
+		/* If device is in DRAIN state, there is no point in
+		 * dispatching the AVTPDU just received so we are done
+		 * here.
+		 */
+		return 0;
+	}
+
+	return aaf_dispatch_pdu(aaf);
+}
+
 static int aaf_flush_rx_buf(snd_pcm_aaf_t *aaf)
 {
 	char *tmp;
@@ -1125,7 +1171,7 @@ static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct pollfd *pfd,
 		}
 
 		if (pfd[1].revents & POLLIN) {
-			res = aaf_rx_pdu(aaf);
+			res = aaf_socket_new_data(aaf);
 			if (res < 0)
 				return res;
 		}
-- 
2.19.1
