From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH v2 - AAF PCM plugin 5/7] aaf: Implement Capture
	mode support
Date: Wed, 24 Oct 2018 18:11:14 -0700
Message-ID: <20181025011116.12360-6-andre.guedes@intel.com>
References: <20181025011116.12360-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id E987A2679B0
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2018 03:11:53 +0200 (CEST)
In-Reply-To: <20181025011116.12360-1-andre.guedes@intel.com>
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
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This patch implements the capture mode support from the AAF plugin.
Simply put, this mode works as follows: AVTPDUs are received from the
network, the PCM samples are retrieved and presented to the alsa-lib
layer at the presentation time. In summary, the capture mode implements
a typical AVTP Listener.

Once the AAF device is put in running state, packet reception is
started. Every time an AVTPDU is received, the plugin checks if it is
valid (according to the stream configuration provided by the user) and
copies the PCM samples to the audio buffer. Note that at this moment,
the samples are not presented to the alsa-lib layer yet (i.e. hw_ptr is
not incremented).

The media clock starts at the presentation time from the first AVTPDU.
At every tick from the media clock, PCM samples are presented to the
alsa-lib layer.

Below follows some secondary discussion about this patch:

The functions aaf_mclk_start_playback() and aaf_mclk_start_capture()
have some common code. This patch does some code refactoring so the
common code is put in a new function (aaf_mclk_start) which is called
by both aaf_mclk_start_playback() and aaf_mclk_start_capture().

Also, the helper function aaf_inc_hw_ptr() is refactored so it can be
used to increment both aaf->hw_ptr and aaf->hw_virt_ptr.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 425 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 doc/aaf.txt   |   9 ++
 2 files changed, 400 insertions(+), 34 deletions(-)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index fba0752..147e5b0 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -28,6 +28,7 @@
 #include <linux/if_packet.h>
 #include <net/if.h>
 #include <string.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <sys/ioctl.h>
 #include <sys/timerfd.h>
@@ -46,6 +47,7 @@
 #define TAI_TO_UTC(t) (t - TAI_OFFSET)
 
 #define FD_COUNT_PLAYBACK 1
+#define FD_COUNT_CAPTURE  2
 
 typedef struct {
 	snd_pcm_ioplug_t io;
@@ -75,7 +77,10 @@ typedef struct {
 	snd_pcm_channel_area_t *payload_areas;
 
 	snd_pcm_uframes_t hw_ptr;
+	snd_pcm_uframes_t hw_virt_ptr;
 	snd_pcm_uframes_t boundary;
+
+	uint64_t prev_ptime;
 } snd_pcm_aaf_t;
 
 static unsigned int alsa_to_avtp_format(snd_pcm_format_t format)
@@ -122,6 +127,106 @@ static unsigned int alsa_to_avtp_rate(unsigned int rate)
 	}
 }
 
+static bool is_pdu_valid(struct avtp_stream_pdu *pdu, uint64_t streamid,
+			 unsigned int data_len, unsigned int format,
+			 unsigned int nsr, unsigned int channels,
+			 unsigned int depth)
+{
+	int res;
+	uint64_t val64;
+	uint32_t val32;
+	struct avtp_common_pdu *common = (struct avtp_common_pdu *) pdu;
+
+	res = avtp_pdu_get(common, AVTP_FIELD_SUBTYPE, &val32);
+	if (res < 0)
+		return false;
+	if (val32 != AVTP_SUBTYPE_AAF) {
+		pr_debug("Subtype mismatch: expected %u, got %u",
+			 AVTP_SUBTYPE_AAF, val32);
+		return false;
+	}
+
+	res = avtp_pdu_get(common, AVTP_FIELD_VERSION, &val32);
+	if (res < 0)
+		return false;
+	if (val32 != 0) {
+		pr_debug("Version mismatch: expected %u, got %u", 0, val32);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_STREAM_ID, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != streamid) {
+		pr_debug("Streamid mismatch: expected %lu, got %lu", streamid,
+			 val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_TV, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != 1) {
+		pr_debug("TV mismatch: expected %u, got %lu", 1, val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_SP, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != AVTP_AAF_PCM_SP_NORMAL) {
+		pr_debug("SP mismatch: expected %u, got %lu",
+			 AVTP_AAF_PCM_SP_NORMAL, val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_FORMAT, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != format) {
+		pr_debug("Format mismatch: expected %u, got %lu", format,
+			 val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_NSR, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != nsr) {
+		pr_debug("NSR mismatch: expected %u, got %lu", nsr, val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_CHAN_PER_FRAME, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != channels) {
+		pr_debug("Channels mismatch: expected %u, got %lu", channels,
+			 val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_BIT_DEPTH, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != depth) {
+		pr_debug("Bit depth mismatch: expected %u, got %lu", depth,
+			 val64);
+		return false;
+	}
+
+	res = avtp_aaf_pdu_get(pdu, AVTP_AAF_FIELD_STREAM_DATA_LEN, &val64);
+	if (res < 0)
+		return false;
+	if (val64 != data_len) {
+		pr_debug("Data len mismatch: expected %u, got %lu",
+			 data_len, val64);
+		return false;
+	}
+
+	return true;
+}
+
 static int aaf_load_config(snd_pcm_aaf_t *aaf, snd_config_t *conf)
 {
 	snd_config_iterator_t cur, next;
@@ -270,8 +375,27 @@ static int aaf_init_socket(snd_pcm_aaf_t *aaf)
 			goto err;
 		}
 	} else {
-		/* TODO: Implement Capture mode support. */
-		return -ENOTSUP;
+		struct packet_mreq mreq = { 0 };
+
+		res = bind(fd, (struct sockaddr *) &aaf->sk_addr,
+			   sizeof(aaf->sk_addr));
+		if (res < 0) {
+			SNDERR("Failed to bind socket");
+			res = -errno;
+			goto err;
+		}
+
+		mreq.mr_ifindex = req.ifr_ifindex;
+		mreq.mr_type = PACKET_MR_MULTICAST;
+		mreq.mr_alen = ETH_ALEN;
+		memcpy(&mreq.mr_address, aaf->addr, ETH_ALEN);
+		res = setsockopt(fd, SOL_PACKET, PACKET_ADD_MEMBERSHIP,
+				 &mreq, sizeof(struct packet_mreq));
+		if (res < 0) {
+			SNDERR("Failed to add multicast address");
+			res = -errno;
+			goto err;
+		}
 	}
 
 	aaf->sk_fd = fd;
@@ -444,35 +568,26 @@ err_free_buf:
 	return res;
 }
 
-static void aaf_inc_hw_ptr(snd_pcm_aaf_t *aaf, snd_pcm_uframes_t val)
+static void aaf_inc_ptr(snd_pcm_uframes_t *ptr, snd_pcm_uframes_t val,
+			snd_pcm_uframes_t boundary)
 {
-	aaf->hw_ptr += val;
+	*ptr += val;
 
-	if (aaf->hw_ptr >= aaf->boundary)
-		aaf->hw_ptr -= aaf->boundary;
+	if (*ptr > boundary)
+		*ptr -= boundary;
 }
 
-static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
+static int aaf_mclk_start(snd_pcm_aaf_t *aaf, uint64_t time, uint64_t period)
 {
 	int res;
-	struct timespec now;
 	struct itimerspec itspec;
 	uint64_t time_utc;
-	snd_pcm_ioplug_t *io = &aaf->io;
-
-	res = clock_gettime(CLOCK_TAI, &now);
-	if (res < 0) {
-		SNDERR("Failed to get time from clock");
-		return -errno;
-	}
 
 	aaf->timer_expirations = 0;
-	aaf->timer_period = (uint64_t)NSEC_PER_SEC * aaf->frames_per_pdu /
-			    io->rate;
-	aaf->timer_starttime = now.tv_sec * NSEC_PER_SEC + now.tv_nsec +
-			       aaf->timer_period;
+	aaf->timer_period = period;
+	aaf->timer_starttime = time;
 
-	time_utc = TAI_TO_UTC(aaf->timer_starttime);
+	time_utc = TAI_TO_UTC(time);
 	itspec.it_value.tv_sec = time_utc / NSEC_PER_SEC;
 	itspec.it_value.tv_nsec = time_utc % NSEC_PER_SEC;
 	itspec.it_interval.tv_sec = 0;
@@ -484,6 +599,65 @@ static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
 	return 0;
 }
 
+static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	struct timespec now;
+	uint64_t time, period;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	res = clock_gettime(CLOCK_TAI, &now);
+	if (res < 0) {
+		SNDERR("Failed to get time from clock");
+		return -errno;
+	}
+
+	period = (uint64_t)NSEC_PER_SEC * aaf->frames_per_pdu / io->rate;
+	time = now.tv_sec * NSEC_PER_SEC + now.tv_nsec + period;
+	res = aaf_mclk_start(aaf, time, period);
+	if (res < 0)
+		return res;
+
+	return 0;
+}
+
+static int aaf_mclk_start_capture(snd_pcm_aaf_t *aaf, uint32_t avtp_time)
+{
+	int res;
+	struct timespec tspec;
+	uint64_t now, ptime, period;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	res = clock_gettime(CLOCK_TAI, &tspec);
+	if (res < 0) {
+		SNDERR("Failed to get time from clock");
+		return -errno;
+	}
+
+	now = (uint64_t)tspec.tv_sec * NSEC_PER_SEC + tspec.tv_nsec;
+
+	/* The avtp_timestamp within AAF packet is the lower part (32
+	 * less-significant bits) from presentation time calculated by the
+	 * talker.
+	 */
+	ptime = (now & 0xFFFFFFFF00000000ULL) | avtp_time;
+
+	/* If 'ptime' is less than the 'now', it means the higher part
+	 * from 'ptime' needs to be incremented by 1 in order to recover the
+	 * presentation time set by the talker.
+	 */
+	if (ptime < now)
+		ptime += (1ULL << 32);
+
+	period = (uint64_t)NSEC_PER_SEC * aaf->frames_per_pdu / io->rate;
+	res = aaf_mclk_start(aaf, ptime, period);
+	if (res < 0)
+		return res;
+
+	aaf->prev_ptime = ptime;
+	return 0;
+}
+
 static int aaf_mclk_reset(snd_pcm_aaf_t *aaf)
 {
 	int res;
@@ -556,7 +730,124 @@ static int aaf_tx_pdu(snd_pcm_aaf_t *aaf)
 		return -EIO;
 	}
 
-	aaf_inc_hw_ptr(aaf, aaf->frames_per_pdu);
+	aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pdu, aaf->boundary);
+	return 0;
+}
+
+static int aaf_rx_pdu(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	ssize_t n;
+	uint64_t seq, avtp_time;
+	snd_pcm_uframes_t hw_avail;
+	snd_pcm_ioplug_t *io = &aaf->io;
+	snd_pcm_t *pcm = io->pcm;
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
+		/* If device is in DRAIN state, we shouldn't copy any more data
+		 * to audio buffer. So we are done here.
+		 */
+		return 0;
+	}
+
+	if (!is_pdu_valid(aaf->pdu, aaf->streamid,
+			  snd_pcm_frames_to_bytes(pcm, aaf->frames_per_pdu),
+			  alsa_to_avtp_format(io->format),
+			  alsa_to_avtp_rate(io->rate),
+			  io->channels, snd_pcm_format_width(io->format))) {
+		pr_debug("AVTPDU dropped: Bad field(s)");
+		return 0;
+	}
+
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_SEQ_NUM, &seq);
+	if (res < 0)
+		return res;
+	if (seq != aaf->pdu_seq) {
+		pr_debug("Sequence mismatch: expected %u, got %lu",
+			 aaf->pdu_seq, seq);
+		aaf->pdu_seq = seq;
+	}
+	aaf->pdu_seq++;
+
+	res = avtp_aaf_pdu_get(aaf->pdu, AVTP_AAF_FIELD_TIMESTAMP, &avtp_time);
+	if (res < 0)
+		return res;
+
+	if (aaf->timer_starttime == 0) {
+		res = aaf_mclk_start_capture(aaf, avtp_time);
+		if (res < 0)
+			return res;
+	} else {
+		uint64_t ptime = aaf->prev_ptime + aaf->timer_period;
+
+		if (avtp_time != ptime % (1ULL << 32)) {
+			pr_debug("Packet dropped: PT not expected");
+			return 0;
+		}
+
+		if (ptime < aaf_mclk_gettime(aaf)) {
+			pr_debug("Packet dropped: PT in the past");
+			return 0;
+		}
+
+		aaf->prev_ptime = ptime;
+	}
+
+	hw_avail = snd_pcm_ioplug_hw_avail(io, aaf->hw_virt_ptr, io->appl_ptr);
+	if (hw_avail < aaf->frames_per_pdu) {
+		/* If there isn't enough space available on buffer to copy the
+		 * samples from AVTPDU, it means we've reached an overrun
+		 * state.
+		 */
+		return -EPIPE;
+	}
+
+	res = snd_pcm_areas_copy_wrap(aaf->audiobuf_areas,
+				      (aaf->hw_virt_ptr % io->buffer_size),
+				      io->buffer_size, aaf->payload_areas,
+				      0, aaf->frames_per_pdu, io->channels,
+				      aaf->frames_per_pdu, io->format);
+	if (res < 0) {
+		SNDERR("Failed to copy data from AVTP payload");
+		return res;
+	}
+
+	aaf_inc_ptr(&aaf->hw_virt_ptr, aaf->frames_per_pdu, aaf->boundary);
+	return 0;
+}
+
+static int aaf_flush_rx_buf(snd_pcm_aaf_t *aaf)
+{
+	char *tmp;
+	ssize_t n;
+
+	tmp = malloc(aaf->pdu_size);
+	if (!tmp)
+		return -ENOMEM;
+
+	do {
+		n = recv(aaf->sk_fd, tmp, aaf->pdu_size, 0);
+	} while (n != -1);
+
+	if (errno != EAGAIN && errno != EWOULDBLOCK) {
+		/* Something unexpected has happened while flushing the socket
+		 * rx buffer so we return error.
+		 */
+		free(tmp);
+		return -errno;
+	}
+
+	free(tmp);
 	return 0;
 }
 
@@ -586,6 +877,43 @@ static int aaf_mclk_timeout_playback(snd_pcm_aaf_t *aaf)
 	return 0;
 }
 
+static int aaf_mclk_timeout_capture(snd_pcm_aaf_t *aaf)
+{
+	ssize_t n;
+	uint64_t expirations;
+	snd_pcm_sframes_t len;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	n = read(aaf->timer_fd, &expirations, sizeof(uint64_t));
+	if (n < 0) {
+		SNDERR("Failed to read() timer");
+		return -errno;
+	}
+
+	if (expirations != 1)
+		pr_debug("Missed %llu presentation time(s) ", expirations - 1);
+
+	while (expirations--) {
+		aaf->timer_expirations++;
+
+		len = aaf->hw_virt_ptr - aaf->hw_ptr;
+		if (len < 0)
+			len += aaf->boundary;
+
+		if ((snd_pcm_uframes_t) len > io->buffer_size) {
+			/* If the distance between hw virtual pointer and hw
+			 * pointer is greater than the buffer size, it means we
+			 * had an overrun error so -EPIPE is returned.
+			 */
+			return -EPIPE;
+		}
+
+		aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pdu, aaf->boundary);
+	}
+
+	return 0;
+}
+
 static int aaf_set_hw_constraint(snd_pcm_aaf_t *aaf)
 {
 	int res;
@@ -712,7 +1040,7 @@ static int aaf_poll_descriptors_count(snd_pcm_ioplug_t *io ATTRIBUTE_UNUSED)
 	if (io->stream == SND_PCM_STREAM_PLAYBACK)
 		return FD_COUNT_PLAYBACK;
 	else
-		return -ENOTSUP;
+		return FD_COUNT_CAPTURE;
 }
 
 static int aaf_poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfd,
@@ -727,8 +1055,13 @@ static int aaf_poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfd,
 		pfd[0].fd = aaf->timer_fd;
 		pfd[0].events = POLLIN;
 	} else {
-		/* TODO: Implement Capture mode support. */
-		return -ENOTSUP;
+		if (space != FD_COUNT_CAPTURE)
+			return -EINVAL;
+
+		pfd[0].fd = aaf->timer_fd;
+		pfd[0].events = POLLIN;
+		pfd[1].fd = aaf->sk_fd;
+		pfd[1].events = POLLIN;
 	}
 
 	return space;
@@ -752,8 +1085,22 @@ static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct pollfd *pfd,
 			*revents = POLLIN;
 		}
 	} else {
-		/* TODO: Implement Capture mode support. */
-		return -ENOTSUP;
+		if (nfds != FD_COUNT_CAPTURE)
+			return -EINVAL;
+
+		if (pfd[0].revents & POLLIN) {
+			res = aaf_mclk_timeout_capture(aaf);
+			if (res < 0)
+				return res;
+
+			*revents = POLLIN;
+		}
+
+		if (pfd[1].revents & POLLIN) {
+			res = aaf_rx_pdu(aaf);
+			if (res < 0)
+				return res;
+		}
 	}
 
 	return 0;
@@ -766,6 +1113,8 @@ static int aaf_prepare(snd_pcm_ioplug_t *io)
 
 	aaf->pdu_seq = 0;
 	aaf->hw_ptr = 0;
+	aaf->hw_virt_ptr = 0;
+	aaf->prev_ptime = 0;
 
 	res = aaf_mclk_reset(aaf);
 	if (res < 0)
@@ -781,13 +1130,17 @@ static int aaf_start(snd_pcm_ioplug_t *io)
 
 	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
 		res = aaf_mclk_start_playback(aaf);
-		if (res < 0)
-			return res;
 	} else {
-		/* TODO: Implement Capture mode support. */
-		return -ENOTSUP;
+		/* Discard any packet on socket buffer to ensure the plugin
+		 * process only packets that arrived after the device has
+		 * started.
+		 */
+		res = aaf_flush_rx_buf(aaf);
 	}
 
+	if (res < 0)
+		return res;
+
 	return 0;
 }
 
@@ -817,13 +1170,17 @@ static snd_pcm_sframes_t aaf_transfer(snd_pcm_ioplug_t *io,
 					      io->buffer_size, areas, offset,
 					      size, io->channels, size,
 					      io->format);
-		if (res < 0)
-			return res;
 	} else {
-		/* TODO: Implement Capture mode support. */
-		return -ENOTSUP;
+		res = snd_pcm_areas_copy_wrap(areas, offset, (offset + size),
+					      aaf->audiobuf_areas,
+					      (io->appl_ptr % io->buffer_size),
+					      io->buffer_size, io->channels,
+					      size, io->format);
 	}
 
+	if (res < 0)
+		return res;
+
 	return size;
 }
 
diff --git a/doc/aaf.txt b/doc/aaf.txt
index c278166..58d9c02 100644
--- a/doc/aaf.txt
+++ b/doc/aaf.txt
@@ -146,3 +146,12 @@ device 'aaf0' with your favorite alsa-utils tool.
 For example, to stream the pink noise generated by 'speaker-test', run:
 
 	$ speaker-test -F S16_BE -c 2 -r 48000 -D aaf0
+
+To receive the AAF stream generated by the command above, run the following
+command in another host:
+
+	$ arecord -t raw -f S16_BE -c 2 -r 48000 -D aaf0 -vv /dev/null
+
+If you want to playback the contents of the AAF stream, change the command-line
+above so the output from 'arecord' is redirected to 'aplay', or simply use the
+'alsaloop' tool.
-- 
2.14.4
