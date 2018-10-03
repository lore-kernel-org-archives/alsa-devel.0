From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 3/7] aaf: Implement Playback
	mode support
Date: Wed,  3 Oct 2018 16:45:43 -0700
Message-ID: <20181003234547.16839-4-andre.guedes@intel.com>
References: <20181003234547.16839-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B069267819
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 01:46:53 +0200 (CEST)
In-Reply-To: <20181003234547.16839-1-andre.guedes@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This patch implements the playback mode support from the AAF plugin.
Simply put, this mode works as follows: PCM samples provided by alsa-lib
layer are encapsulated into AVTPDUs and transmitted through the network.
In summary, the playback mode implements a typical AVTP Talker.

When the AAF device is put in running state, its media clock is started.
At every tick from the media clock, audio frames are consumed from the
audio buffer, encapsulated into an AVTPDU, and transmitted to the
network. The presentation time from each AVTPDU is calculated taking in
consideration the maximum transit time and time uncertainty values
configured by the user.

Below follows some discussion about implementation details:

AVTP protocol doesn't support all formats and rates available in ALSA so
the plugin sets some constraints to ensure only supported configurations
are used (see aaf_set_hw_constraint function).

The plugin implements a media clock which is the source from AVTP
timestamps. The AVTP timestamp is based on PTP time which uses
International Atomic Time (TAI) coordinate system. The media clock is
implemented through a periodic timer using timerfd infrastructure so the
plugin requires that system clock and PTP clock are synchronized
(instructions on how to sync these clocks are provided in doc/aaf.txt).
CLOCK_TAI clockid isn't currently supported by timerfd so the timer fd
is created using CLOCK_REALTIME and the start time is converted from TAI
to UTC.

Even though only one file descriptor is used to implement the playback
mode, this patch doesn't leverage ioplug->poll_fd but defines poll
callbacks instead. The reason is these callbacks will be required to
support capture mode (to be implemented by upcoming patch).

The TSN data plane interface is the AF_PACKET socket family so the
plugin uses an AF_PACKET socket to send/receive AVTPDUs. Linux requires
CAP_NET_RAW capability in order to open an AF_PACKET socket so the
application that instantiates the plugin must have it. For further info
about AF_PACKET socket family see packet(7).

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 646 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/aaf.txt   |  72 +++++++
 2 files changed, 718 insertions(+)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index 32db15e..8f8bcfd 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -20,12 +20,32 @@
 
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
+#include <arpa/inet.h>
+#include <avtp.h>
+#include <avtp_aaf.h>
+#include <limits.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
+#include <linux/if_packet.h>
 #include <string.h>
 #include <stdint.h>
+#include <sys/ioctl.h>
+#include <sys/timerfd.h>
+
+#ifdef AAF_DEBUG
+#define pr_debug(...) SNDERR(__VA_ARGS__)
+#else
+#define pr_debug(...) (void)0
+#endif
+
+#define ARRAY_SIZE(a) (sizeof(a)/sizeof((a)[0]))
 
 #define NSEC_PER_USEC 1000
+#define NSEC_PER_SEC  1000000000
+#define TAI_OFFSET    (37ULL * NSEC_PER_SEC)
+#define TAI_TO_UTC(t) (t - TAI_OFFSET)
+
+#define FD_COUNT_PLAYBACK 1
 
 typedef struct {
 	snd_pcm_ioplug_t io;
@@ -37,8 +57,71 @@ typedef struct {
 	int mtt;
 	int t_uncertainty;
 	snd_pcm_uframes_t frames_per_pdu;
+
+	int sk_fd;
+	int timer_fd;
+
+	struct sockaddr_ll sk_addr;
+
+	struct avtp_stream_pdu *pdu;
+	int pdu_size;
+	uint8_t pdu_seq;
+
+	uint64_t mclk_start_time;
+	uint64_t mclk_period;
+	uint64_t mclk_ticks;
+
+	snd_pcm_channel_area_t *audiobuf_areas;
+	snd_pcm_channel_area_t *payload_areas;
+
+	snd_pcm_uframes_t hw_ptr;
+	snd_pcm_uframes_t boundary;
 } snd_pcm_aaf_t;
 
+static unsigned int alsa_to_avtp_format(snd_pcm_format_t format)
+{
+	switch (format) {
+	case SND_PCM_FORMAT_S16_BE:
+		return AVTP_AAF_FORMAT_INT_16BIT;
+	case SND_PCM_FORMAT_S24_3BE:
+		return AVTP_AAF_FORMAT_INT_24BIT;
+	case SND_PCM_FORMAT_S32_BE:
+		return AVTP_AAF_FORMAT_INT_32BIT;
+	case SND_PCM_FORMAT_FLOAT_BE:
+		return AVTP_AAF_FORMAT_FLOAT_32BIT;
+	default:
+		return AVTP_AAF_FORMAT_USER;
+	}
+}
+
+static unsigned int alsa_to_avtp_rate(unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return AVTP_AAF_PCM_NSR_8KHZ;
+	case 16000:
+		return AVTP_AAF_PCM_NSR_16KHZ;
+	case 24000:
+		return AVTP_AAF_PCM_NSR_24KHZ;
+	case 32000:
+		return AVTP_AAF_PCM_NSR_32KHZ;
+	case 44100:
+		return AVTP_AAF_PCM_NSR_44_1KHZ;
+	case 48000:
+		return AVTP_AAF_PCM_NSR_48KHZ;
+	case 88200:
+		return AVTP_AAF_PCM_NSR_88_2KHZ;
+	case 96000:
+		return AVTP_AAF_PCM_NSR_96KHZ;
+	case 176400:
+		return AVTP_AAF_PCM_NSR_176_4KHZ;
+	case 192000:
+		return AVTP_AAF_PCM_NSR_192KHZ;
+	default:
+		return AVTP_AAF_PCM_NSR_USER;
+	}
+}
+
 static int aaf_load_config(snd_pcm_aaf_t *aaf, snd_config_t *conf)
 {
 	snd_config_iterator_t cur, next;
@@ -152,6 +235,393 @@ err:
 	return -EINVAL;
 }
 
+static int aaf_init_socket(snd_pcm_aaf_t *aaf)
+{
+	int fd, res;
+	struct ifreq req;
+
+	fd = socket(AF_PACKET, SOCK_DGRAM|SOCK_NONBLOCK, htons(ETH_P_TSN));
+	if (fd < 0) {
+		SNDERR("Failed to open AF_PACKET socket");
+		return -errno;
+	}
+
+	snprintf(req.ifr_name, sizeof(req.ifr_name), "%s", aaf->ifname);
+	res = ioctl(fd, SIOCGIFINDEX, &req);
+	if (res < 0) {
+		SNDERR("Failed to get network interface index");
+		res = -errno;
+		goto err;
+	}
+
+	aaf->sk_addr.sll_family = AF_PACKET;
+	aaf->sk_addr.sll_protocol = htons(ETH_P_TSN);
+	aaf->sk_addr.sll_halen = ETH_ALEN;
+	aaf->sk_addr.sll_ifindex = req.ifr_ifindex;
+	memcpy(&aaf->sk_addr.sll_addr, aaf->addr, ETH_ALEN);
+
+	res = setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &aaf->prio,
+			 sizeof(aaf->prio));
+	if (res < 0) {
+		SNDERR("Failed to set socket priority");
+		res = -errno;
+		goto err;
+	}
+
+	aaf->sk_fd = fd;
+	return 0;
+
+err:
+	close(fd);
+	return res;
+}
+
+static int aaf_init_timer(snd_pcm_aaf_t *aaf)
+{
+	int fd;
+
+	fd = timerfd_create(CLOCK_REALTIME, TFD_NONBLOCK);
+	if (fd < 0)
+		return -errno;
+
+	aaf->timer_fd = fd;
+	return 0;
+}
+
+static int aaf_init_pdu(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	struct avtp_stream_pdu *pdu;
+	ssize_t frame_size, payload_size, pdu_size;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	frame_size = snd_pcm_format_size(io->format, io->channels);
+	if (frame_size < 0)
+		return frame_size;
+
+	payload_size = frame_size * aaf->frames_per_pdu;
+	pdu_size = sizeof(*pdu) + payload_size;
+	pdu = calloc(1, pdu_size);
+	if (!pdu)
+		return -ENOMEM;
+
+	res = avtp_aaf_pdu_init(pdu);
+	if (res < 0)
+		goto err;
+
+	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_TV, 1);
+	if (res < 0)
+		goto err;
+
+	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_STREAM_ID, aaf->streamid);
+	if (res < 0)
+		goto err;
+
+	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_FORMAT,
+			       alsa_to_avtp_format(io->format));
+	if (res < 0)
+		goto err;
+
+	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_NSR,
+			       alsa_to_avtp_rate(io->rate));
+	if (res < 0)
+		goto err;
+
+	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_CHAN_PER_FRAME,
+			       io->channels);
+	if (res < 0)
+		goto err;
+
+	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_BIT_DEPTH,
+			       snd_pcm_format_width(io->format));
+	if (res < 0)
+		goto err;
+
+	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_STREAM_DATA_LEN,
+			       payload_size);
+	if (res < 0)
+		goto err;
+
+	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_SP, AVTP_AAF_PCM_SP_NORMAL);
+	if (res < 0)
+		goto err;
+
+	aaf->pdu = pdu;
+	aaf->pdu_size = pdu_size;
+	return 0;
+
+err:
+	free(pdu);
+	return res;
+}
+
+static int aaf_init_areas(snd_pcm_aaf_t *aaf, snd_pcm_channel_area_t *areas,
+			  void *buf)
+{
+	ssize_t sample_size, frame_size;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	sample_size = snd_pcm_format_size(io->format, 1);
+	if (sample_size < 0)
+		return sample_size;
+
+	frame_size = sample_size * io->channels;
+
+	for (unsigned int i = 0; i < io->channels; i++) {
+		areas[i].addr = buf;
+		areas[i].first = i * sample_size * 8;
+		areas[i].step = frame_size * 8;
+	}
+
+	return 0;
+}
+
+static int aaf_init_payload_areas(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	snd_pcm_channel_area_t *areas;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	areas = calloc(io->channels, sizeof(snd_pcm_channel_area_t));
+	if (!areas)
+		return -ENOMEM;
+
+	res = aaf_init_areas(aaf, areas, aaf->pdu->avtp_payload);
+	if (res < 0)
+		goto err;
+
+	aaf->payload_areas = areas;
+	return 0;
+
+err:
+	free(areas);
+	return res;
+}
+
+static int aaf_init_audiobuf_areas(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	char *buf;
+	ssize_t frame_size;
+	snd_pcm_channel_area_t *areas;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	frame_size = snd_pcm_format_size(io->format, io->channels);
+	if (frame_size < 0)
+		return frame_size;
+
+	buf = calloc(io->buffer_size, frame_size);
+	if (!buf)
+		return -ENOMEM;
+
+	areas = calloc(io->channels, sizeof(snd_pcm_channel_area_t));
+	if (!areas) {
+		res = -ENOMEM;
+		goto err_free_buf;
+	}
+
+	res = aaf_init_areas(aaf, areas, buf);
+	if (res < 0)
+		goto err_free_areas;
+
+	aaf->audiobuf_areas = areas;
+	return 0;
+
+err_free_areas:
+	free(areas);
+err_free_buf:
+	free(buf);
+	return res;
+}
+
+static void aaf_inc_hw_ptr(snd_pcm_aaf_t *aaf, snd_pcm_uframes_t val)
+{
+	aaf->hw_ptr += val;
+
+	if (aaf->hw_ptr >= aaf->boundary)
+		aaf->hw_ptr -= aaf->boundary;
+}
+
+static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	struct timespec now;
+	struct itimerspec itspec;
+	uint64_t time_utc;
+	snd_pcm_ioplug_t *io = &aaf->io;
+
+	res = clock_gettime(CLOCK_TAI, &now);
+	if (res < 0) {
+		SNDERR("Failed to get time from clock");
+		return -errno;
+	}
+
+	aaf->mclk_period = (uint64_t)NSEC_PER_SEC * aaf->frames_per_pdu /
+			   io->rate;
+	aaf->mclk_ticks = 0;
+	aaf->mclk_start_time = now.tv_sec * NSEC_PER_SEC + now.tv_nsec +
+			       aaf->mclk_period;
+
+	time_utc = TAI_TO_UTC(aaf->mclk_start_time);
+	itspec.it_value.tv_sec = time_utc / NSEC_PER_SEC;
+	itspec.it_value.tv_nsec = time_utc % NSEC_PER_SEC;
+	itspec.it_interval.tv_sec = 0;
+	itspec.it_interval.tv_nsec = aaf->mclk_period;
+	res = timerfd_settime(aaf->timer_fd, TFD_TIMER_ABSTIME, &itspec, NULL);
+	if (res < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int aaf_mclk_reset(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	struct itimerspec itspec = { 0 };
+
+	res = timerfd_settime(aaf->timer_fd, 0, &itspec, NULL);
+	if (res < 0) {
+		SNDERR("Failed to stop media clock");
+		return res;
+	}
+
+	aaf->mclk_start_time = 0;
+	aaf->mclk_period = 0;
+	aaf->mclk_ticks = 0;
+	return 0;
+}
+
+static uint64_t aaf_mclk_gettime(snd_pcm_aaf_t *aaf)
+{
+	return aaf->mclk_start_time + aaf->mclk_period * aaf->mclk_ticks;
+}
+
+static int aaf_tx_pdu(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	uint64_t ptime;
+	ssize_t n;
+	snd_pcm_uframes_t hw_avail;
+	snd_pcm_ioplug_t *io = &aaf->io;
+	struct avtp_stream_pdu *pdu = aaf->pdu;
+
+	hw_avail = snd_pcm_ioplug_hw_avail(io, aaf->hw_ptr, io->appl_ptr);
+	if (hw_avail == 0) {
+		/* If there is no frames available for transmission, we reached
+		 * an underrun state.
+		 */
+		return -EPIPE;
+	}
+	if (hw_avail < aaf->frames_per_pdu) {
+		/* If there isn't enough frames to fill the AVTPDU, we drop
+		 * them. This behavior is suggested by IEEE 1722-2016 spec,
+		 * section 7.3.5.
+		 */
+		aaf_inc_hw_ptr(aaf, hw_avail);
+		return 0;
+	}
+
+	res = snd_pcm_areas_copy_wrap(aaf->payload_areas, 0,
+				      aaf->frames_per_pdu,
+				      aaf->audiobuf_areas,
+				      (aaf->hw_ptr % io->buffer_size),
+				      io->buffer_size, io->channels,
+				      aaf->frames_per_pdu, io->format);
+	if (res < 0) {
+		SNDERR("Failed to copy data to AVTP payload");
+		return res;
+	}
+
+	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_SEQ_NUM, aaf->pdu_seq++);
+	if (res < 0)
+		return res;
+
+	ptime = aaf_mclk_gettime(aaf) + aaf->mtt + aaf->t_uncertainty;
+	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_TIMESTAMP, ptime);
+	if (res < 0)
+		return res;
+
+	n = sendto(aaf->sk_fd, aaf->pdu, aaf->pdu_size, 0,
+		   (struct sockaddr *) &aaf->sk_addr,
+		   sizeof(aaf->sk_addr));
+	if (n < 0 || n != aaf->pdu_size) {
+		SNDERR("Failed to send AAF PDU");
+		return -EIO;
+	}
+
+	aaf_inc_hw_ptr(aaf, aaf->frames_per_pdu);
+	return 0;
+}
+
+static int aaf_mclk_timeout_playback(snd_pcm_aaf_t *aaf)
+{
+	int res;
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
+		pr_debug("Missed %llu tx interval(s) ", expirations - 1);
+
+	while (expirations--) {
+		res = aaf_tx_pdu(aaf);
+		if (res < 0)
+			return res;
+		aaf->mclk_ticks++;
+	}
+
+	return 0;
+}
+
+static int aaf_set_hw_constraint(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	snd_pcm_ioplug_t *io = &aaf->io;
+	const unsigned int accesses[] = {
+		SND_PCM_ACCESS_RW_INTERLEAVED,
+	};
+	const unsigned int formats[] = {
+		SND_PCM_FORMAT_S16_BE,
+		SND_PCM_FORMAT_S24_3BE,
+		SND_PCM_FORMAT_S32_BE,
+		SND_PCM_FORMAT_FLOAT_BE,
+	};
+	const unsigned int rates[] = {
+		8000,
+		16000,
+		24000,
+		32000,
+		44100,
+		48000,
+		88200,
+		96000,
+		176400,
+		192000,
+	};
+
+	res = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS,
+					    ARRAY_SIZE(accesses), accesses);
+	if (res < 0)
+		return res;
+
+	res = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT,
+					    ARRAY_SIZE(formats), formats);
+	if (res < 0)
+		return res;
+
+	res = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_RATE,
+					    ARRAY_SIZE(rates), rates);
+	if (res < 0)
+		return res;
+
+	return 0;
+}
+
 static int aaf_close(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_aaf_t *aaf = io->private_data;
@@ -164,26 +634,185 @@ static int aaf_close(snd_pcm_ioplug_t *io)
 	return 0;
 }
 
+static int aaf_hw_params(snd_pcm_ioplug_t *io,
+			 snd_pcm_hw_params_t *params ATTRIBUTE_UNUSED)
+{
+	int res;
+	snd_pcm_aaf_t *aaf = io->private_data;
+
+	res = aaf_init_socket(aaf);
+	if (res < 0)
+		return res;
+
+	res = aaf_init_timer(aaf);
+	if (res < 0)
+		goto err_close_sk;
+
+	res = aaf_init_pdu(aaf);
+	if (res < 0)
+		goto err_close_timer;
+
+	res = aaf_init_payload_areas(aaf);
+	if (res < 0)
+		goto err_free_pdu;
+
+	res = aaf_init_audiobuf_areas(aaf);
+	if (res < 0)
+		goto err_free_payload_areas;
+
+	return 0;
+
+err_free_payload_areas:
+	free(aaf->payload_areas);
+err_free_pdu:
+	free(aaf->pdu);
+err_close_timer:
+	close(aaf->timer_fd);
+err_close_sk:
+	close(aaf->sk_fd);
+	return res;
+}
+
+static int aaf_hw_free(snd_pcm_ioplug_t *io)
+{
+	snd_pcm_aaf_t *aaf = io->private_data;
+
+	close(aaf->sk_fd);
+	close(aaf->timer_fd);
+	free(aaf->pdu);
+	free(aaf->payload_areas);
+	free(aaf->audiobuf_areas->addr);
+	free(aaf->audiobuf_areas);
+	return 0;
+}
+
+static int aaf_sw_params(snd_pcm_ioplug_t *io, snd_pcm_sw_params_t *params)
+{
+	int res;
+	snd_pcm_aaf_t *aaf = io->private_data;
+
+	res = snd_pcm_sw_params_get_boundary(params, &aaf->boundary);
+	if (res < 0)
+		return res;
+
+	return 0;
+}
+
 static snd_pcm_sframes_t aaf_pointer(snd_pcm_ioplug_t *io)
 {
+	snd_pcm_aaf_t *aaf = io->private_data;
+
+	return aaf->hw_ptr;
+}
+
+static int aaf_poll_descriptors_count(snd_pcm_ioplug_t *io ATTRIBUTE_UNUSED)
+{
+	return FD_COUNT_PLAYBACK;
+}
+
+static int aaf_poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfd,
+				unsigned int space)
+{
+	snd_pcm_aaf_t *aaf = io->private_data;
+
+	if (space != FD_COUNT_PLAYBACK)
+		return -EINVAL;
+
+	pfd[0].fd = aaf->timer_fd;
+	pfd[0].events = POLLIN;
+	return space;
+}
+
+static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct pollfd *pfd,
+			    unsigned int nfds, unsigned short *revents)
+{
+	int res;
+	snd_pcm_aaf_t *aaf = io->private_data;
+
+	if (nfds != FD_COUNT_PLAYBACK)
+		return -EINVAL;
+
+	if (pfd[0].revents & POLLIN) {
+		res = aaf_mclk_timeout_playback(aaf);
+		if (res < 0)
+			return res;
+
+		*revents = POLLIN;
+	}
+
+	return 0;
+}
+
+static int aaf_prepare(snd_pcm_ioplug_t *io)
+{
+	int res;
+	snd_pcm_aaf_t *aaf = io->private_data;
+
+	aaf->pdu_seq = 0;
+	aaf->hw_ptr = 0;
+
+	res = aaf_mclk_reset(aaf);
+	if (res < 0)
+		return res;
+
 	return 0;
 }
 
 static int aaf_start(snd_pcm_ioplug_t *io)
 {
+	int res;
+	snd_pcm_aaf_t *aaf = io->private_data;
+
+	res = aaf_mclk_start_playback(aaf);
+	if (res < 0)
+		return res;
+
 	return 0;
 }
 
 static int aaf_stop(snd_pcm_ioplug_t *io)
 {
+	int res;
+	snd_pcm_aaf_t *aaf = io->private_data;
+
+	res = aaf_mclk_reset(aaf);
+	if (res < 0)
+		return res;
+
 	return 0;
 }
 
+static snd_pcm_sframes_t aaf_transfer(snd_pcm_ioplug_t *io,
+				      const snd_pcm_channel_area_t *areas,
+				      snd_pcm_uframes_t offset,
+				      snd_pcm_uframes_t size)
+{
+	int res;
+	snd_pcm_aaf_t *aaf = io->private_data;
+
+	res = snd_pcm_areas_copy_wrap(aaf->audiobuf_areas,
+				      (io->appl_ptr % io->buffer_size),
+				      io->buffer_size, areas, offset, size,
+				      io->channels, size, io->format);
+	if (res < 0)
+		return res;
+
+	return size;
+}
+
 static const snd_pcm_ioplug_callback_t aaf_callback = {
 	.close = aaf_close,
+	.hw_params = aaf_hw_params,
+	.hw_free = aaf_hw_free,
+	.sw_params = aaf_sw_params,
 	.pointer = aaf_pointer,
+	.poll_descriptors_count = aaf_poll_descriptors_count,
+	.poll_descriptors = aaf_poll_descriptors,
+	.poll_revents = aaf_poll_revents,
+	.prepare = aaf_prepare,
 	.start = aaf_start,
 	.stop = aaf_stop,
+	.transfer = aaf_transfer,
 };
 
 SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
@@ -191,12 +820,21 @@ SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
 	snd_pcm_aaf_t *aaf;
 	int res;
 
+	/* For now the plugin only supports Playback mode i.e. AAF Talker
+	 * functionality.
+	 */
+	if (stream != SND_PCM_STREAM_PLAYBACK)
+		return -EINVAL;
+
 	aaf = calloc(1, sizeof(*aaf));
 	if (!aaf) {
 		SNDERR("Failed to allocate memory");
 		return -ENOMEM;
 	}
 
+	aaf->sk_fd = -1;
+	aaf->timer_fd = -1;
+
 	res = aaf_load_config(aaf, conf);
 	if (res < 0)
 		goto err;
@@ -205,12 +843,20 @@ SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
 	aaf->io.name = "AVTP Audio Format (AAF) Plugin";
 	aaf->io.callback = &aaf_callback;
 	aaf->io.private_data = aaf;
+	aaf->io.flags = SND_PCM_IOPLUG_FLAG_BOUNDARY_WA;
 	res = snd_pcm_ioplug_create(&aaf->io, name, stream, mode);
 	if (res < 0) {
 		SNDERR("Failed to create ioplug instance");
 		goto err;
 	}
 
+	res = aaf_set_hw_constraint(aaf);
+	if (res < 0) {
+		SNDERR("Failed to set hw constraints");
+		snd_pcm_ioplug_delete(&aaf->io);
+		goto err;
+	}
+
 	*pcmp = aaf->io.pcm;
 	return 0;
 
diff --git a/doc/aaf.txt b/doc/aaf.txt
index d817249..ac9dd9d 100644
--- a/doc/aaf.txt
+++ b/doc/aaf.txt
@@ -9,6 +9,78 @@ to transmit/receive audio samples through a Time-Sensitive Network (TSN)
 capable network. The plugin enables media applications to easily implement AVTP
 Talker and Listener functionalities.
 
+AVTP is designed to take advantage of generalized Precision Time Protocol
+(gPTP) and Forwarding and Queuing Enhancements for Time-Sensitive Streams
+(FQTSS). gPTP ensures AVTP talkers and listeners share the same time reference
+so the presentation time from AVTP can be used to inform when PCM samples
+should be presented to the application layer. FQTSS provides bandwidth
+reservation and traffic prioritization for the AVTP stream.
+
+gPTP functionality is provided by the Linuxptp project while FQTSS
+functionality is provided by Linux Traffic Control system since kernel version
+4.15.
+
+gPTP Setup
+----------
+
+The Linuxptp project provides the ptp4l daemon, which synchronizes the PTP
+clock from NIC, and the pmc tool which communicates with ptp4l to get/set
+some runtime settings. The project also provides the phc2sys daemon which
+synchronizes the PTP clock and system clock.
+
+The AAF Plugin requires system clock is synchronized with PTP clock and TAI
+offset is properly set in the kernel. ptp4l and phc2sys can be set up in many
+different ways, below we provide an example that fullfils the plugin
+requirements. For further information check ptp4l(8) and phc2sys(8).
+
+In the following instructions, replace $IFNAME by your PTP capable NIC
+interface. The gPTP.cfg file mentioned below can be found in /usr/share/
+doc/linuxptp/ (depending on your distro).
+
+Synchronize PTP clock with PTP time:
+
+	$ ptp4l -f gPTP.cfg -i $IFNAME
+
+Enable TAI offset to be automatically set by phc2sys:
+
+	$ pmc -u -t 1 -b 0 'SET GRANDMASTER_SETTINGS_NP \
+		clockClass 248 clockAccuracy 0xfe \
+		offsetScaledLogVariance 0xffff \
+		currentUtcOffset 37 leap61 0 leap59 0 \
+		currentUtcOffsetValid 1 p pTimescale 1 \
+		timeTraceable 1 frequencyTraceable 0 timeSource 0xa0'
+
+Synchronize system clock with PTP clock:
+
+	$ phc2sys -f gPTP.cfg -s $IFNAME -c CLOCK_REALTIME -w
+
+The commands above should be run on both AVTP Talker and Listener hosts.
+
+FQTSS Setup
+-----------
+
+The Linux Traffic Control system provides the mqprio and cbs qdiscs which
+enable FQTSS on Linux. Below we provide an example to configure those qdiscs in
+order to transmit an AAF stream with 48 kHz sampling rate, 16-bit sample size,
+stereo. For further information on how to configure these qdiscs check
+tc-mqprio(8) and tc-cbs(8) man pages.
+
+On the host that will run as AVTP Talker (i.e. plugin in playback mode), run
+the following commands:
+
+Configure mpqrio qdisc (replace $HANDLE_ID by an unused handle ID):
+
+	$ tc qdisc add dev $IFNAME parent root handle $HANDLE_ID mqprio \
+			num_tc 3 map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
+			queues 1@0 1@1 2@2 hw 0
+
+Configure cbs qdisc:
+
+	$ tc qdisc replace dev $IFNAME parent $HANDLE_ID:1 cbs idleslope 5760 \
+			sendslope -994240 hicredit 9 locredit -89 offload 1
+
+No FQTSS configuration is required at the host running as AVTP Listener.
+
 Plugin Dependencies
 -------------------
 
-- 
2.14.4
