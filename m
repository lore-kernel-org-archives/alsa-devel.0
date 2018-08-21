From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
	mode support
Date: Tue, 21 Aug 2018 13:31:43 +0900
Message-ID: <80240cb0-4443-b75e-876f-edc0c5e1327d@sakamocchi.jp>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f66.google.com (mail-pl0-f66.google.com
 [209.85.160.66])
 by alsa0.perex.cz (Postfix) with ESMTP id E375B2676C7
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 06:31:47 +0200 (CEST)
Received: by mail-pl0-f66.google.com with SMTP id p4-v6so4605811pll.8
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2018 21:31:47 -0700 (PDT)
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

Hi,

On Aug 21 2018 10:06, Andre Guedes wrote:
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
> ...
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
> ...
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

In a design of ALSA external plugin SDK[1], you can apply constrains to 
available hw_params/sw_params by a call of 
'snd_pcm_ioplug_set_param_minmax()' and 
'snd_pcm_ioplug_set_param_list()' at entry point. If you program error 
path at .hw_params callback for unexpected parameters, it's better to 
apply constants in advance.

Do you have any reason not to do it? Is it difficult to retrieve 
capabilities of target AVTP end station in the entry point?

[1] http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_external_plugins.html


Regards

Takashi Sakamoto
