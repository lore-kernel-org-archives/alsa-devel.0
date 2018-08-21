From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
 mode support
Date: Mon, 20 Aug 2018 22:37:31 -0500
Message-ID: <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C4EC26766C
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 05:37:34 +0200 (CEST)
In-Reply-To: <20180821010653.15838-4-andre.guedes@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andre Guedes <andre.guedes@intel.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On 8/20/18 8:06 PM, Andre Guedes wrote:
> This patch implements the playback mode support from the AAF plugin.
> Simply put, this mode works as follows: PCM samples provided by alsa-lib
> layer are encapsulated into AVTP packets and transmitted through the
> network. In summary, the playback mode implements a typical AVTP Talker.
> 
> When the AAF device is put in running state, its media clock is started.
> At every tick from the media clock, audio frames are consumed from the
> audio buffer, encapsulated into an AVTP packet, and transmitted to the
> network. The presentation time from each AVTP packet is calculated
> taking in consideration the maximum transit time and time uncertainty
> values configured by the user.
> 
> Below follows some discussion about implementation details:
> 
> Even though only one file descriptor is used to implement the playback
> mode, this patch doesn't leverage ioplug->poll_fd but defines poll
> callbacks instead. The reason is these callbacks will be required to
> support capture mode (to be implemented by upcoming patch).
> 
> The TSN data plane interface is the AF_PACKET socket family so the
> plugin uses an AF_PACKET socket to send/receive AVTP packets. Linux
> requires CAP_NET_RAW capability in order to open an AF_PACKET socket so
> the application that instantiates the plugin must have it. For further
> info about AF_PACKET socket family see packet(7).
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>   aaf/pcm_aaf.c | 611 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   doc/aaf.txt   |  40 ++++
>   2 files changed, 651 insertions(+)
> 
> diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
> index 4c6f031..72f6652 100644
> --- a/aaf/pcm_aaf.c
> +++ b/aaf/pcm_aaf.c
> @@ -20,13 +20,30 @@
>   
>   #include <alsa/asoundlib.h>
>   #include <alsa/pcm_external.h>
> +#include <arpa/inet.h>
> +#include <avtp.h>
> +#include <avtp_aaf.h>
> +#include <limits.h>
>   #include <linux/if.h>
>   #include <linux/if_ether.h>
> +#include <linux/if_packet.h>
>   #include <string.h>
>   #include <stdint.h>
> +#include <sys/ioctl.h>
> +#include <sys/timerfd.h>
>   
> +#ifdef AAF_DEBUG
> +#define pr_debug(...) SNDERR(__VA_ARGS__)
> +#else
> +#define pr_debug(...) (void)0
> +#endif
> +
> +#define CLOCK_REF		CLOCK_REALTIME

You should probably comment on why you use CLOCK_REALTIME for something 
that is driven by a media clock that's completely unrelated to 
CLOCK_REALTIME?

> +#define NSEC_PER_SEC		1000000000ULL
>   #define NSEC_PER_USEC		1000ULL
>   
> +#define FD_COUNT_PLAYBACK	1
> +
>   typedef struct {
>   	snd_pcm_ioplug_t io;
>   
> @@ -37,8 +54,74 @@ typedef struct {
>   	int mtt;
>   	int t_uncertainty;
>   	int frames_per_pkt;
> +
> +	int sk_fd;
> +	int timer_fd;
> +
> +	struct sockaddr_ll sk_addr;
> +
> +	char *audiobuf;
> +
> +	struct avtp_stream_pdu *pdu;
> +	int pdu_size;
> +	uint8_t pdu_seq;
> +
> +	uint64_t mclk_start_time;
> +	uint64_t mclk_period;
> +	uint64_t mclk_ticks;
> +
> +	snd_pcm_channel_area_t *audiobuf_areas;
> +	snd_pcm_channel_area_t *payload_areas;
> +
> +	snd_pcm_sframes_t hw_ptr;
> +	snd_pcm_sframes_t buffer_size;
> +	snd_pcm_sframes_t boundary;
>   } snd_pcm_aaf_t;
>   
> +static unsigned int alsa_to_avtp_format(snd_pcm_format_t format)
> +{
> +	switch (format) {
> +	case SND_PCM_FORMAT_S16_BE:

we usually use S16_LE? I can't recall when I last used S16_BE...

> +		return AVTP_AAF_FORMAT_INT_16BIT;
> +	case SND_PCM_FORMAT_S24_3BE:

this means 3 bytes without padding to 32-bit word, is this your 
definition as well?

> +		return AVTP_AAF_FORMAT_INT_24BIT;
> +	case SND_PCM_FORMAT_S32_BE:
> +		return AVTP_AAF_FORMAT_INT_32BIT;
> +	case SND_PCM_FORMAT_FLOAT_BE:
> +		return AVTP_AAF_FORMAT_FLOAT_32BIT;
> +	default:
> +		return AVTP_AAF_FORMAT_USER;
> +	}
> +}
> +
> +static unsigned int alsa_to_avtp_rate(unsigned int rate)
> +{
> +	switch (rate) {
> +	case 8000:
> +		return AVTP_AAF_PCM_NSR_8KHZ;
> +	case 16000:
> +		return AVTP_AAF_PCM_NSR_16KHZ;
> +	case 24000:
> +		return AVTP_AAF_PCM_NSR_24KHZ;
> +	case 32000:
> +		return AVTP_AAF_PCM_NSR_32KHZ;
> +	case 44100:
> +		return AVTP_AAF_PCM_NSR_44_1KHZ;
> +	case 48000:
> +		return AVTP_AAF_PCM_NSR_48KHZ;
> +	case 88200:
> +		return AVTP_AAF_PCM_NSR_88_2KHZ;
> +	case 96000:
> +		return AVTP_AAF_PCM_NSR_96KHZ;
> +	case 176400:
> +		return AVTP_AAF_PCM_NSR_176_4KHZ;
> +	case 192000:
> +		return AVTP_AAF_PCM_NSR_192KHZ;

You should align avtp_aaf definitions with ALSA, you are missing quite a 
few frequencies. e.g. 11.025, 64, 384kHz. If this is intentional add a 
comment to explain the restrictions.

> +	default:
> +		return AVTP_AAF_PCM_NSR_USER;
> +	}
> +}
> +
>   static int aaf_load_config(snd_pcm_aaf_t *aaf, snd_config_t *conf)
>   {
>   	snd_config_iterator_t cur, next;
> @@ -147,6 +230,327 @@ err:
>   	return -EINVAL;
>   }
>   
> +static int aaf_init_socket(snd_pcm_aaf_t *aaf)
> +{
> +	int fd, res;
> +	struct ifreq req;
> +
> +	fd = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_TSN));
> +	if (fd < 0) {
> +		SNDERR("Failed to open AF_PACKET socket");
> +		return -errno;
> +	}
> +
> +	snprintf(req.ifr_name, sizeof(req.ifr_name), "%s", aaf->ifname);
> +	res = ioctl(fd, SIOCGIFINDEX, &req);
> +	if (res < 0) {
> +		SNDERR("Failed to get network interface index");
> +		res = -errno;
> +		goto err;
> +	}
> +
> +	aaf->sk_addr.sll_family = AF_PACKET;
> +	aaf->sk_addr.sll_protocol = htons(ETH_P_TSN);
> +	aaf->sk_addr.sll_halen = ETH_ALEN;
> +	aaf->sk_addr.sll_ifindex = req.ifr_ifindex;
> +	memcpy(&aaf->sk_addr.sll_addr, aaf->addr, ETH_ALEN);
> +
> +	res = setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &aaf->prio,
> +			 sizeof(aaf->prio));
> +	if (res < 0) {
> +		SNDERR("Failed to set socket priority");
> +		res = -errno;
> +		goto err;
> +	}
> +
> +	aaf->sk_fd = fd;
> +	return 0;
> +
> +err:
> +	close(fd);
> +	return res;
> +}
> +
> +static int aaf_init_timer(snd_pcm_aaf_t *aaf)
> +{
> +	int fd;
> +
> +	fd = timerfd_create(CLOCK_REF, 0);
> +	if (fd < 0)
> +		return -errno;
> +
> +	aaf->timer_fd = fd;
> +	return 0;
> +}
> +
> +static int aaf_init_pdu(snd_pcm_aaf_t *aaf)
> +{
> +	int res;
> +	struct avtp_stream_pdu *pdu;
> +	ssize_t frame_size, payload_size, pdu_size;
> +	snd_pcm_ioplug_t *io = &aaf->io;
> +
> +	frame_size = snd_pcm_format_size(io->format, io->channels);
> +	if (frame_size < 0)
> +		return frame_size;
> +
> +	payload_size = frame_size * aaf->frames_per_pkt;
> +	pdu_size = sizeof(*pdu) + payload_size;
> +	pdu = calloc(1, pdu_size);
> +	if (!pdu)
> +		return -ENOMEM;
> +
> +	res = avtp_aaf_pdu_init(pdu);
> +	if (res < 0)
> +		goto err;
> +
> +	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_TV, 1);
> +	if (res < 0)
> +		goto err;
> +
> +	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_STREAM_ID, aaf->streamid);
> +	if (res < 0)
> +		goto err;
> +
> +	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_FORMAT,
> +			       alsa_to_avtp_format(io->format));
> +	if (res < 0)
> +		goto err;
> +
> +	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_NSR,
> +			       alsa_to_avtp_rate(io->rate));
> +	if (res < 0)
> +		goto err;
> +
> +	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_CHAN_PER_FRAME,
> +			       io->channels);
> +	if (res < 0)
> +		goto err;
> +
> +	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_BIT_DEPTH,
> +			       snd_pcm_format_width(io->format));
> +	if (res < 0)
> +		goto err;
> +
> +	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_STREAM_DATA_LEN,
> +			       payload_size);
> +	if (res < 0)
> +		goto err;
> +
> +	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_SP, AVTP_AAF_PCM_SP_NORMAL);
> +	if (res < 0)
> +		goto err;
> +
> +	aaf->pdu = pdu;
> +	aaf->pdu_size = pdu_size;
> +	aaf->pdu_seq = 0;
> +	return 0;
> +
> +err:
> +	free(pdu);
> +	return res;
> +}
> +
> +static int aaf_init_audio_buffer(snd_pcm_aaf_t *aaf)
> +{
> +	char *audiobuf;
> +	ssize_t frame_size, audiobuf_size;
> +	snd_pcm_ioplug_t *io = &aaf->io;
> +
> +	frame_size = snd_pcm_format_size(io->format, io->channels);
> +	if (frame_size < 0)
> +		return frame_size;
> +
> +	audiobuf_size = frame_size * aaf->buffer_size;
> +	audiobuf = calloc(1, audiobuf_size);
> +	if (!audiobuf)
> +		return -ENOMEM;
> +
> +	aaf->audiobuf = audiobuf;
> +	return 0;
> +}
> +
> +static int aaf_init_areas(snd_pcm_aaf_t *aaf)
> +{
> +	snd_pcm_channel_area_t *audiobuf_areas, *payload_areas;
> +	ssize_t sample_size, frame_size;
> +	snd_pcm_ioplug_t *io = &aaf->io;
> +
> +	sample_size = snd_pcm_format_size(io->format, 1);
> +	if (sample_size < 0)
> +		return sample_size;
> +
> +	frame_size = sample_size * io->channels;
> +
> +	audiobuf_areas = calloc(io->channels, sizeof(snd_pcm_channel_area_t));
> +	if (!audiobuf_areas)
> +		return -ENOMEM;
> +
> +	payload_areas = calloc(io->channels, sizeof(snd_pcm_channel_area_t));
> +	if (!payload_areas) {
> +		free(audiobuf_areas);
> +		return -ENOMEM;
> +	}
> +
> +	for (unsigned int i = 0; i < io->channels; i++) {
> +		audiobuf_areas[i].addr = aaf->audiobuf;
> +		audiobuf_areas[i].first = i * sample_size * 8;
> +		audiobuf_areas[i].step = frame_size * 8;
> +
> +		payload_areas[i].addr = aaf->pdu->avtp_payload;
> +		payload_areas[i].first = i * sample_size * 8;
> +		payload_areas[i].step = frame_size * 8;

not sure what 8 represents here?

> +	}
> +
> +	aaf->audiobuf_areas = audiobuf_areas;
> +	aaf->payload_areas = payload_areas;
> +	return 0;
> +}
> +
> +static void aaf_inc_hw_ptr(snd_pcm_aaf_t *aaf, snd_pcm_sframes_t val)
> +{
> +	aaf->hw_ptr += val;
> +
> +	if (aaf->hw_ptr >= aaf->boundary)
> +		aaf->hw_ptr -= aaf->boundary;
> +}
> +
> +static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
> +{
> +	int res;
> +	struct timespec now;
> +	struct itimerspec itspec;
> +	snd_pcm_ioplug_t *io = &aaf->io;
> +
> +	res = clock_gettime(CLOCK_REF, &now);
> +	if (res < 0) {
> +		SNDERR("Failed to get time from clock");
> +		return -errno;
> +	}
> +
> +	aaf->mclk_period = (NSEC_PER_SEC * aaf->frames_per_pkt) / io->rate;

is this always an integer? If not, don't you have a systematic 
arithmetic error?

> +	aaf->mclk_ticks = 0;
> +	aaf->mclk_start_time = now.tv_sec * NSEC_PER_SEC + now.tv_nsec +
> +			       aaf->mclk_period;
> +
> +	itspec.it_value.tv_sec = aaf->mclk_start_time / NSEC_PER_SEC;
> +	itspec.it_value.tv_nsec = aaf->mclk_start_time % NSEC_PER_SEC;
> +	itspec.it_interval.tv_sec = 0;
> +	itspec.it_interval.tv_nsec = aaf->mclk_period;
> +	res = timerfd_settime(aaf->timer_fd, TFD_TIMER_ABSTIME, &itspec, NULL);
> +	if (res < 0)
> +		return -errno;
> +
> +	return 0;
> +}
> +
> +static int aaf_mclk_reset(snd_pcm_aaf_t *aaf)
> +{
> +	aaf->mclk_start_time = 0;
> +	aaf->mclk_period = 0;
> +	aaf->mclk_ticks = 0;
> +
> +	if (aaf->timer_fd != -1) {
> +		int res;
> +		struct itimerspec itspec = { 0 };
> +
> +		res = timerfd_settime(aaf->timer_fd, 0, &itspec, NULL);
> +		if (res < 0) {
> +			SNDERR("Failed to stop media clock");
> +			return res;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static uint64_t aaf_mclk_gettime(snd_pcm_aaf_t *aaf)
> +{
> +	return aaf->mclk_start_time + aaf->mclk_period * aaf->mclk_ticks;
> +}
> +
> +static int aaf_tx_pdu(snd_pcm_aaf_t *aaf)
> +{
> +	int res;
> +	uint64_t ptime;
> +	snd_pcm_sframes_t n;
> +	snd_pcm_ioplug_t *io = &aaf->io;
> +	snd_pcm_t *pcm = io->pcm;
> +	struct avtp_stream_pdu *pdu = aaf->pdu;
> +
> +	n = aaf->buffer_size - snd_pcm_avail(pcm);
> +	if (n == 0) {
> +		/* If there is no data in audio buffer to be transmitted,
> +		 * we reached an underrun state.
> +		 */
> +		return -EPIPE;
> +	}
> +	if (n < aaf->frames_per_pkt) {
> +		/* If there isn't enough frames to fill the AVTP packet, we
> +		 * drop them. This behavior is suggested by IEEE 1722-2016
> +		 * spec, section 7.3.5.
> +		 */
> +		aaf_inc_hw_ptr(aaf, n);
> +		return 0;
> +	}
> +
> +	res = snd_pcm_areas_copy_wrap(aaf->payload_areas, 0,
> +				      aaf->frames_per_pkt,
> +				      aaf->audiobuf_areas,
> +				      aaf->hw_ptr % aaf->buffer_size,
> +				      aaf->buffer_size, io->channels,
> +				      aaf->frames_per_pkt, io->format);
> +	if (res < 0) {
> +		SNDERR("Failed to copy data to AVTP payload");
> +		return res;
> +	}
> +
> +	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_SEQ_NUM, aaf->pdu_seq++);
> +	if (res < 0)
> +		return res;
> +
> +	ptime = aaf_mclk_gettime(aaf) + aaf->mtt + aaf->t_uncertainty;
> +	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_TIMESTAMP, ptime);
> +	if (res < 0)
> +		return res;
> +
> +	n = sendto(aaf->sk_fd, aaf->pdu, aaf->pdu_size, 0,
> +		   (struct sockaddr *) &aaf->sk_addr,
> +		   sizeof(aaf->sk_addr));
> +	if (n < 0 || n != aaf->pdu_size) {
> +		SNDERR("Failed to send AAF PDU");
> +		return -EIO;
> +	}
> +
> +	aaf_inc_hw_ptr(aaf, aaf->frames_per_pkt);
> +	return 0;
> +}
> +
> +static int aaf_mclk_timeout_playback(snd_pcm_aaf_t *aaf)
> +{
> +	int res;
> +	ssize_t n;
> +	uint64_t expirations;
> +
> +	n = read(aaf->timer_fd, &expirations, sizeof(uint64_t));
> +	if (n < 0) {
> +		SNDERR("Failed to read() timer");
> +		return -errno;
> +	}
> +
> +	if (expirations != 1)
> +		pr_debug("Missed %llu tx interval(s) ", expirations - 1);
> +
> +	while (expirations--) {
> +		res = aaf_tx_pdu(aaf);
> +		if (res < 0)
> +			return res;
> +		aaf->mclk_ticks++;
> +	}
> +
> +	return 0;
> +}
> +
>   static int aaf_close(snd_pcm_ioplug_t *io)
>   {
>   	snd_pcm_aaf_t *aaf = io->private_data;
> @@ -159,26 +563,223 @@ static int aaf_close(snd_pcm_ioplug_t *io)
>   	return 0;
>   }
>   
> +static int aaf_hw_params(snd_pcm_ioplug_t *io,
> +			 snd_pcm_hw_params_t *params ATTRIBUTE_UNUSED)
> +{
> +	int res;
> +	snd_pcm_aaf_t *aaf = io->private_data;
> +
> +	if (io->access != SND_PCM_ACCESS_RW_INTERLEAVED)
> +		return -ENOTSUP;
> +
> +	if (io->buffer_size > LONG_MAX)
> +		return -EINVAL;
> +
> +	/* XXX: We might want to support Little Endian format in future. To
> +	 * achieve that, we need to convert LE samples to BE before
> +	 * transmitting them.
> +	 */
> +	switch (io->format) {
> +	case SND_PCM_FORMAT_S16_BE:
> +	case SND_PCM_FORMAT_S24_3BE:
> +	case SND_PCM_FORMAT_S32_BE:
> +	case SND_PCM_FORMAT_FLOAT_BE:
> +		break;
> +	default:
> +		return -ENOTSUP;
> +	}
> +
> +	switch (io->rate) {
> +	case 8000:
> +	case 16000:
> +	case 24000:
> +	case 32000:
> +	case 44100:
> +	case 48000:
> +	case 88200:
> +	case 96000:
> +	case 176400:
> +	case 192000:
> +		break;
> +	default:
> +		return -ENOTSUP;
> +	}
> +
> +	aaf->buffer_size = io->buffer_size;
> +
> +	res = aaf_init_pdu(aaf);
> +	if (res < 0)
> +		return res;
> +
> +	res = aaf_init_audio_buffer(aaf);
> +	if (res < 0)
> +		goto err_free_pdu;
> +
> +	res = aaf_init_areas(aaf);
> +	if (res < 0)
> +		goto err_free_audiobuf;
> +
> +	return 0;
> +
> +err_free_audiobuf:
> +	free(aaf->audiobuf);
> +err_free_pdu:
> +	free(aaf->pdu);
> +	return res;
> +}
> +
> +static int aaf_hw_free(snd_pcm_ioplug_t *io)
> +{
> +	snd_pcm_aaf_t *aaf = io->private_data;
> +
> +	free(aaf->audiobuf_areas);
> +	free(aaf->payload_areas);
> +	free(aaf->audiobuf);
> +	free(aaf->pdu);
> +	return 0;
> +}
> +
> +static int aaf_sw_params(snd_pcm_ioplug_t *io, snd_pcm_sw_params_t *params)
> +{
> +	int res;
> +	snd_pcm_uframes_t boundary;
> +	snd_pcm_aaf_t *aaf = io->private_data;
> +
> +	res = snd_pcm_sw_params_get_boundary(params, &boundary);
> +	if (res < 0)
> +		return res;
> +
> +	if (boundary > LONG_MAX)
> +		return -EINVAL;
> +
> +	aaf->boundary = boundary;
> +	return 0;
> +}
> +
>   static snd_pcm_sframes_t aaf_pointer(snd_pcm_ioplug_t *io)
>   {
> +	snd_pcm_aaf_t *aaf = io->private_data;
> +
> +	return aaf->hw_ptr;
> +}
> +
> +static int aaf_poll_descriptors_count(snd_pcm_ioplug_t *io ATTRIBUTE_UNUSED)
> +{
> +	return FD_COUNT_PLAYBACK;
> +}
> +
> +static int aaf_poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfd,
> +				unsigned int space)
> +{
> +	snd_pcm_aaf_t *aaf = io->private_data;
> +
> +	if (space != FD_COUNT_PLAYBACK)
> +		return -EINVAL;
> +
> +	pfd[0].fd = aaf->timer_fd;
> +	pfd[0].events = POLLIN;
> +	return space;
> +}
> +
> +static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct pollfd *pfd,
> +			    unsigned int nfds, unsigned short *revents)
> +{
> +	int res;
> +	snd_pcm_aaf_t *aaf = io->private_data;
> +
> +	if (nfds != FD_COUNT_PLAYBACK)
> +		return -EINVAL;
> +
> +	if (pfd[0].revents & POLLIN) {
> +		res = aaf_mclk_timeout_playback(aaf);
> +		if (res < 0)
> +			return res;
> +
> +		*revents = POLLIN;
> +	}

I couldn't figure out how you use playback events and your timer. When 
there are two audio clock sources or timers that's usually where the fun 
begins.

> +
> +	return 0;
> +}
> +
> +static int aaf_prepare(snd_pcm_ioplug_t *io)
> +{
> +	int res;
> +	snd_pcm_aaf_t *aaf = io->private_data;
> +
> +	aaf->hw_ptr = 0;
> +	res = aaf_mclk_reset(aaf);
> +	if (res < 0)
> +		return res;
> +
>   	return 0;
>   }
>   
>   static int aaf_start(snd_pcm_ioplug_t *io)
>   {
> +	int res;
> +	snd_pcm_aaf_t *aaf = io->private_data;
> +
> +	res = aaf_init_socket(aaf);
> +	if (res < 0)
> +		return res;
> +
> +	res = aaf_init_timer(aaf);
> +	if (res < 0)
> +		goto err_close_sk;
> +
> +	res = aaf_mclk_start_playback(aaf);
> +	if (res < 0)
> +		goto err_close_timer;
> +
>   	return 0;
> +
> +err_close_timer:
> +	close(aaf->timer_fd);
> +err_close_sk:
> +	close(aaf->sk_fd);
> +	return res;
>   }
>   
>   static int aaf_stop(snd_pcm_ioplug_t *io)
>   {
> +	snd_pcm_aaf_t *aaf = io->private_data;
> +
> +	close(aaf->timer_fd);
> +	close(aaf->sk_fd);
>   	return 0;
>   }
>   
> +static snd_pcm_sframes_t aaf_transfer(snd_pcm_ioplug_t *io,
> +				      const snd_pcm_channel_area_t *areas,
> +				      snd_pcm_uframes_t offset,
> +				      snd_pcm_uframes_t size)
> +{
> +	int res;
> +	snd_pcm_aaf_t *aaf = io->private_data;
> +
> +	res = snd_pcm_areas_copy_wrap(aaf->audiobuf_areas,
> +				      (io->appl_ptr % aaf->buffer_size),
> +				      aaf->buffer_size, areas, offset, size,
> +				      io->channels, size, io->format);
> +	if (res < 0)
> +		return res;
> +
> +	return size;
> +}
> +
>   static const snd_pcm_ioplug_callback_t aaf_callback = {
>   	.close = aaf_close,
> +	.hw_params = aaf_hw_params,
> +	.hw_free = aaf_hw_free,
> +	.sw_params = aaf_sw_params,
>   	.pointer = aaf_pointer,
> +	.poll_descriptors_count = aaf_poll_descriptors_count,
> +	.poll_descriptors = aaf_poll_descriptors,
> +	.poll_revents = aaf_poll_revents,
> +	.prepare = aaf_prepare,
>   	.start = aaf_start,
>   	.stop = aaf_stop,
> +	.transfer = aaf_transfer,
>   };
>   
>   SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
> @@ -186,12 +787,21 @@ SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
>   	snd_pcm_aaf_t *aaf;
>   	int res;
>   
> +	/* For now the plugin only supports Playback mode i.e. AAF Talker
> +	 * functionality.
> +	 */
> +	if (stream != SND_PCM_STREAM_PLAYBACK)
> +		return -EINVAL;
> +
>   	aaf = calloc(1, sizeof(*aaf));
>   	if (!aaf) {
>   		SNDERR("Failed to allocate memory");
>   		return -ENOMEM;
>   	}
>   
> +	aaf->sk_fd = -1;
> +	aaf->timer_fd = -1;
> +
>   	res = aaf_load_config(aaf, conf);
>   	if (res < 0)
>   		goto err;
> @@ -200,6 +810,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
>   	aaf->io.name = "AVTP Audio Format (AAF) Plugin";
>   	aaf->io.callback = &aaf_callback;
>   	aaf->io.private_data = aaf;
> +	aaf->io.flags = SND_PCM_IOPLUG_FLAG_BOUNDARY_WA;
>   	res = snd_pcm_ioplug_create(&aaf->io, name, stream, mode);
>   	if (res < 0) {
>   		SNDERR("Failed to create ioplug instance");
> diff --git a/doc/aaf.txt b/doc/aaf.txt
> index 24ea888..b1a3f43 100644
> --- a/doc/aaf.txt
> +++ b/doc/aaf.txt
> @@ -9,6 +9,46 @@ to transmit/receive audio samples through a Time-Sensitive Network (TSN)
>   capable network. The plugin enables media applications to easily implement AVTP
>   Talker and Listener functionalities.
>   
> +AVTP is designed to take advantage of generalized Precision Time Protocol
> +(gPTP) and Forwarding and Queuing Enhancements for Time-Sensitive Streams
> +(FQTSS).
> +
> +gPTP ensures AVTP talkers and listeners share the same time reference so the
> +presentation time from AVTP can be used to inform when PCM samples should be
> +presented to the application layer. Thus, in order to work properly, the plugin
> +requires the system clock is synchronized with the PTP time. Such functionality
> +is provided by ptp4l and phc2sys from Linuxptp project
> +(linuxptp.sourceforge.net). ptp4l and phc2sys can be set up in many different
> +ways, below we provide an example. For further information check ptp4l(8) and
> +phc2sys(8).
> +
> +On PTP master host run the following commands. Replace $IFNAME by your PTP
> +capable NIC name. The gPTP.cfg file mentioned below can be found in
> +/usr/share/doc/linuxptp/ (depending on your distro).
> +	$ ptp4l -f gPTP.cfg -i $IFNAME
> +	$ phc2sys -f gPTP.cfg -c $IFNAME -s CLOCK_REALTIME -w
> +
> +On PTP slave host run:
> +	$ ptp4l -f gPTP.cfg -i $IFNAME -s
> +	$ phc2sys -f gPTP.cfg -a -r
> +
> +FQTSS provides bandwidth reservation and traffic prioritization for the AVTP
> +stream. Thus, in order to work properly, the plugin requires FQTSS to be
> +configured properly. The FQTSS features is supported by Linux Traffic Control
> +system through the mpqrio and cbs qdiscs. Below we provide an example to
> +configure those qdiscs in order to transmit an AAF stream with 48 kHz sampling
> +rate, 16-bit sample size, stereo. For further information on how to configure
> +it check tc-mqprio(8) and tc-cbs(8) man pages.
> +
> +Configure mpqrio (replace $HANDLE_ID by an unused handle ID):
> +	$ tc qdisc add dev $IFNAME parent root handle $HANDLE_ID mqprio \
> +			num_tc 3 map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
> +			queues 1@0 1@1 2@2 hw 0
> +
> +Configure cbs:
> +	$ tc qdisc replace dev $IFNAME parent $HANDLE_ID:1 cbs idleslope 5760 \
> +			sendslope -994240 hicredit 9 locredit -89 offload 1
> +
>   Dependency
>   ----------
>   
> 
