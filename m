From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC - AAF PCM plugin 5/5] aaf: Implement Capture
 mode support
Date: Tue, 21 Aug 2018 14:17:48 +0900
Message-ID: <4cf623b4-ccf1-e67a-7d77-e440d4ae97c3@sakamocchi.jp>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-6-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f66.google.com (mail-pl0-f66.google.com
 [209.85.160.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 48DEF2676C7
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 07:17:53 +0200 (CEST)
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so8230062plo.1
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2018 22:17:52 -0700 (PDT)
In-Reply-To: <20180821010653.15838-6-andre.guedes@intel.com>
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

Hi,

On Aug 21 2018 10:06, Andre Guedes wrote:
> This patch implements the capture mode support from the AAF plugin.
> Simply put, this mode works as follows: AVTP packets are received from
> the network, the PCM samples are retrieved and presented to the alsa-lib
> layer at the presentation time. In summary, the capture mode implements
> a typical AVTP Listener.
> 
> Once the AAF device is put in running state, packet reception is
> started. Every time an AVTP packet is received the plugin checks if it
> is valid (according to the stream configuration provided by the user)
> and copies the PCM samples to the audio buffer. Note that at this
> moment, the samples are not presented to the alsa-lib layer (i.e.
> hw_ptr is not updated).
> 
> When the first AVTP packet is received, the media clock is set to start
> at the presentation time from that packet. At every tick from the media
> clock, PCM samples are presented to the alsa-lib layer.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>   aaf/pcm_aaf.c | 358 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 338 insertions(+), 20 deletions(-)
> 
> diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
> index e098247..b5bee57 100644
> --- a/aaf/pcm_aaf.c
> +++ b/aaf/pcm_aaf.c
> ...
> @@ -561,6 +819,42 @@ static int aaf_mclk_timeout_playback(snd_pcm_aaf_t *aaf)
>   	return 0;
>   }
>   
> +static int aaf_mclk_timeout_capture(snd_pcm_aaf_t *aaf)
> +{
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
> +		pr_debug("Missed %llu presentation time(s) ", expirations - 1);
> +
> +	while (expirations--) {
> +		snd_pcm_sframes_t len;
> +
> +		aaf_inc_ptr(&aaf->hw_ptr, aaf->frames_per_pkt, aaf->boundary);
> +
> +		len = aaf->hw_virt_ptr - aaf->hw_ptr;
> +		if (len < 0)
> +			len += aaf->boundary;
> +		if (len > aaf->buffer_size) {
> +			/* If the distance between hw virtual pointer and hw
> +			 * pointer is greater than the buffer size, it means we
> +			 * had an overrun error so -EPIPE is returned.
> +			 */
> +			return -EPIPE;
> +		}
> +
> +		aaf->mclk_ticks++;
> +	}
> +
> +	return 0;
> +}

In your code, -EPIPE can be returned in a call of 
'snd_pcm_poll_revents()'. In this case, typical applications follow 
recovery process below:

->snd_pcm_poll_revents()
->snd_pcm_prepare()
->snd_pcm_start()

In this case, status of corresponding PCM substream is reset (see 
'snd_pcm_ioplug_prepare()'). In my opinion, in this case, backend is 
expected to stop data streaming, then initialize hardware and restart 
data streaming. In your driver, timer_fd/sk_fd is leaked. It's better to
release them by checking status of PCM substream in .prepare callback.


Regards

Takashi Sakamoto
