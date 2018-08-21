From: Andre Guedes <andre.guedes@intel.com>
Subject: [RFC - AAF PCM plugin 5/5] aaf: Implement Capture mode
	support
Date: Mon, 20 Aug 2018 18:06:53 -0700
Message-ID: <20180821010653.15838-6-andre.guedes@intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id D3B6126766E
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 03:07:08 +0200 (CEST)
In-Reply-To: <20180821010653.15838-1-andre.guedes@intel.com>
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
Cc: liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This patch implements the capture mode support from the AAF plugin.
Simply put, this mode works as follows: AVTP packets are received from
the network, the PCM samples are retrieved and presented to the alsa-lib
layer at the presentation time. In summary, the capture mode implements
a typical AVTP Listener.

Once the AAF device is put in running state, packet reception is
started. Every time an AVTP packet is received the plugin checks if it
is valid (according to the stream configuration provided by the user)
and copies the PCM samples to the audio buffer. Note that at this
moment, the samples are not presented to the alsa-lib layer (i.e.
hw_ptr is not updated).

When the first AVTP packet is received, the media clock is set to start
at the presentation time from that packet. At every tick from the media
clock, PCM samples are presented to the alsa-lib layer.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 358 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 338 insertions(+), 20 deletions(-)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index e098247..b5bee57 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -28,6 +28,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <string.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <sys/ioctl.h>
 #include <sys/timerfd.h>
@@ -43,6 +44,7 @@
 #define NSEC_PER_USEC		1000ULL
 
 #define FD_COUNT_PLAYBACK	1
+#define FD_COUNT_CAPTURE	2
 
 typedef struct {
 	snd_pcm_ioplug_t io;
@@ -70,10 +72,13 @@ typedef struct {
 	uint64_t mclk_period;
 	uint64_t mclk_ticks;
 
+	uint64_t pkt_count;
+
 	snd_pcm_channel_area_t *audiobuf_areas;
 	snd_pcm_channel_area_t *payload_areas;
 
 	snd_pcm_sframes_t hw_ptr;
+	snd_pcm_sframes_t hw_virt_ptr;
 	snd_pcm_sframes_t buffer_size;
 	snd_pcm_sframes_t boundary;
 } snd_pcm_aaf_t;
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
@@ -265,8 +370,27 @@ static int aaf_init_socket(snd_pcm_aaf_t *aaf)
 			goto err;
 		}
 	} else {
-		/* TODO: Implement Capture mode support. */
-		return -ENOTSUP;
+		struct packet_mreq mreq;
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
@@ -417,12 +541,13 @@ static int aaf_init_areas(snd_pcm_aaf_t *aaf)
 	return 0;
 }
 
-static void aaf_inc_hw_ptr(snd_pcm_aaf_t *aaf, snd_pcm_sframes_t val)
+static void aaf_inc_ptr(snd_pcm_sframes_t *ptr, snd_pcm_sframes_t val,
+			snd_pcm_sframes_t boundary)
 {
-	aaf->hw_ptr += val;
+	*ptr += val;
 
-	if (aaf->hw_ptr >= aaf->boundary)
-		aaf->hw_ptr -= aaf->boundary;
+	if (*ptr > boundary)
+		*ptr -= boundary;
 }
 
 static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
@@ -454,6 +579,52 @@ static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
 	return 0;
 }
 
+static int aaf_mclk_start_capture(snd_pcm_aaf_t *aaf, uint32_t avtp_time)
+{
+	int res;
+	struct timespec tspec;
+	struct itimerspec itspec;
+	uint64_t ptime, now;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	res = clock_gettime(CLOCK_REF, &tspec);
+	if (res < 0) {
+		SNDERR("Failed to get time from clock");
+		return -errno;
+	}
+
+	now = (tspec.tv_sec * NSEC_PER_SEC) + tspec.tv_nsec;
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
+	aaf->mclk_period = (NSEC_PER_SEC * aaf->frames_per_pkt) / io->rate;
+	aaf->mclk_ticks = 0;
+	aaf->mclk_start_time = ptime;
+
+	itspec.it_value.tv_sec = aaf->mclk_start_time / NSEC_PER_SEC;
+	itspec.it_value.tv_nsec = aaf->mclk_start_time % NSEC_PER_SEC;
+	itspec.it_interval.tv_sec = 0;
+	itspec.it_interval.tv_nsec = aaf->mclk_period;
+	res = timerfd_settime(aaf->timer_fd, TFD_TIMER_ABSTIME, &itspec, NULL);
+	if (res < 0) {
+		SNDERR("Failed to set timer");
+		return -errno;
+	}
+
+	return 0;
+}
+
 static int aaf_mclk_reset(snd_pcm_aaf_t *aaf)
 {
 	aaf->mclk_start_time = 0;
@@ -500,7 +671,7 @@ static int aaf_tx_pdu(snd_pcm_aaf_t *aaf)
 		 * drop them. This behavior is suggested by IEEE 1722-2016
 		 * spec, section 7.3.5.
 		 */
-		aaf_inc_hw_ptr(aaf, n);
+		aaf_inc_ptr(&aaf->hw_ptr, n, aaf->boundary);
 		return 0;
 	}
 
@@ -532,7 +703,94 @@ static int aaf_tx_pdu(snd_pcm_aaf_t *aaf)
 		return -EIO;
 	}
 
-	aaf_inc_hw_ptr(aaf, aaf->frames_per_pkt);
+	aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pkt, aaf->boundary);
+	return 0;
+}
+
+static int aaf_rx_pdu(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	ssize_t n;
+	uint64_t seq, avtp_time;
+	snd_pcm_sframes_t len;
+	snd_pcm_ioplug_t *io = &aaf->io;
+	snd_pcm_t *pcm = io->pcm;
+
+	n = recv(aaf->sk_fd, aaf->pdu, aaf->pdu_size, 0);
+	if (n < 0 || n != aaf->pdu_size) {
+		SNDERR("Failed to receive data");
+		return -EIO;
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
+			  snd_pcm_frames_to_bytes(pcm, aaf->frames_per_pkt),
+			  alsa_to_avtp_format(io->format),
+			  alsa_to_avtp_rate(io->rate),
+			  io->channels, snd_pcm_format_width(io->format)))
+		return 0;
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
+	if (aaf->mclk_start_time == 0) {
+		res = aaf_mclk_start_capture(aaf, avtp_time);
+		if (res < 0)
+			return res;
+	} else {
+		uint64_t ptime = aaf->mclk_start_time + aaf->mclk_period *
+				 aaf->pkt_count;
+
+		if (avtp_time != ptime % (1ULL << 32)) {
+			pr_debug("Packet dropped: PT not expected");
+			return 0;
+		}
+		if (ptime < aaf_mclk_gettime(aaf)) {
+			pr_debug("Packet dropped: PT in the past");
+			return 0;
+		}
+	}
+
+	res = snd_pcm_areas_copy_wrap(aaf->audiobuf_areas,
+				      aaf->hw_virt_ptr % aaf->buffer_size,
+				      aaf->buffer_size, aaf->payload_areas,
+				      0, aaf->frames_per_pkt, io->channels,
+				      aaf->frames_per_pkt, io->format);
+	if (res < 0) {
+		SNDERR("Failed to copy data from AVTP payload");
+		return res;
+	}
+
+	aaf_inc_ptr(&aaf->hw_virt_ptr, aaf->frames_per_pkt, aaf->boundary);
+
+	len = aaf->hw_virt_ptr - io->appl_ptr;
+	if (len < 0)
+		len += aaf->boundary;
+	if (len > aaf->buffer_size) {
+		/* If the distance between hw virtual pointer and application
+		 * pointer is greater than the buffer size, it means we had an
+		 * overrun error so -EPIPE is returned.
+		 */
+		return -EPIPE;
+	}
+
 	return 0;
 }
 
@@ -561,6 +819,42 @@ static int aaf_mclk_timeout_playback(snd_pcm_aaf_t *aaf)
 	return 0;
 }
 
+static int aaf_mclk_timeout_capture(snd_pcm_aaf_t *aaf)
+{
+	ssize_t n;
+	uint64_t expirations;
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
+		snd_pcm_sframes_t len;
+
+		aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pkt, aaf->boundary);
+
+		len = aaf->hw_virt_ptr - aaf->hw_ptr;
+		if (len < 0)
+			len += aaf->boundary;
+		if (len > aaf->buffer_size) {
+			/* If the distance between hw virtual pointer and hw
+			 * pointer is greater than the buffer size, it means we
+			 * had an overrun error so -EPIPE is returned.
+			 */
+			return -EPIPE;
+		}
+
+		aaf->mclk_ticks++;
+	}
+
+	return 0;
+}
+
 static int aaf_close(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_aaf_t *aaf = io->private_data;
@@ -678,7 +972,7 @@ static int aaf_poll_descriptors_count(snd_pcm_ioplug_t *io ATTRIBUTE_UNUSED)
 	if (io->stream == SND_PCM_STREAM_PLAYBACK)
 		return FD_COUNT_PLAYBACK;
 	else
-		return -ENOTSUP;
+		return FD_COUNT_CAPTURE;
 }
 
 static int aaf_poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfd,
@@ -693,8 +987,13 @@ static int aaf_poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfd,
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
@@ -718,8 +1017,23 @@ static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct pollfd *pfd,
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
+			aaf->pkt_count++;
+		}
 	}
 
 	return 0;
@@ -731,6 +1045,8 @@ static int aaf_prepare(snd_pcm_ioplug_t *io)
 	snd_pcm_aaf_t *aaf = io->private_data;
 
 	aaf->hw_ptr = 0;
+	aaf->hw_virt_ptr = 0;
+	aaf->pkt_count = 0;
 	res = aaf_mclk_reset(aaf);
 	if (res < 0)
 		return res;
@@ -783,18 +1099,20 @@ static snd_pcm_sframes_t aaf_transfer(snd_pcm_ioplug_t *io,
 	int res;
 	snd_pcm_aaf_t *aaf = io->private_data;
 
-	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+	if (io->stream == SND_PCM_STREAM_PLAYBACK)
 		res = snd_pcm_areas_copy_wrap(aaf->audiobuf_areas,
 					      (io->appl_ptr % aaf->buffer_size),
 					      aaf->buffer_size, areas, offset,
 					      size, io->channels, size,
 					      io->format);
-		if (res < 0)
-			return res;
-	} else {
-		/* TODO: Implement Capture mode support. */
-		return -ENOTSUP;
-	}
+	else
+		res = snd_pcm_areas_copy_wrap(areas, offset, (offset + size),
+					      aaf->audiobuf_areas,
+					      (io->appl_ptr % aaf->buffer_size),
+					      aaf->buffer_size, io->channels,
+					      size, io->format);
+	if (res < 0)
+		return res;
 
 	return size;
 }
-- 
2.14.4
