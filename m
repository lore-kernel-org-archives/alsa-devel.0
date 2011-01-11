From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda: Disable 4/6 channels on some
 NVIDIA	GPUs.
Date: Tue, 11 Jan 2011 19:11:53 +0200
Message-ID: <4D2C8F59.4040507@iki.fi>
References: <1294676371-1401-1-git-send-email-ndaga@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135])
	by alsa0.perex.cz (Postfix) with ESMTP id D14DA103A42
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 18:11:56 +0100 (CET)
In-Reply-To: <1294676371-1401-1-git-send-email-ndaga@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin Daga <ndaga@nvidia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10.01.2011 18:19, Nitin Daga wrote:
> Added hardware constraint in patch_hdmi.c to disable
> channels 4/6 which are not supported by some older
> NVIDIA GPUs.

And 3/5/7, which do not seem to work either with my 0x0007.

However, 3/5/7 do not work with my 0x000b system either, is this a hw
limitation as well (that should be added to the driver) or is there a
bug in the HDA driver for uneven channel counts?

(I looked at the HDA specification and it does seem to allow
odd-numbered channel counts)

Strangely, on both of my systems speaker-test -c5 fails with an error:

$ speaker-test -Dhdmi -c5

speaker-test 1.0.23

Playback device is hdmi
Stream parameters are 48000Hz, S16_LE, 5 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 128 to 419392
Period size range from 64 to 209664
Using max buffer size 419392
Periods = 4
Unable to set nperiods 4 for playback: No such file or directory
Setting of hwparams failed: No such file or directory

While -c3 and -c7 run fine but no sound is received.


> Signed-off-by: Nitin Daga <ndaga@nvidia.com>
> Acked-By: Stephen Warren <swarren@nvidia.com>
> ---
>  pci/hda/patch_hdmi.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/pci/hda/patch_hdmi.c b/pci/hda/patch_hdmi.c
> index d3e49aa..ddde59b 100644
> --- a/pci/hda/patch_hdmi.c
> +++ b/pci/hda/patch_hdmi.c
> @@ -1166,11 +1166,53 @@ static int nvhdmi_7x_init(struct hda_codec *codec)
>  	return 0;
>  }
>  
> +static unsigned int channels_2_6_8[] = {
> +	2, 6, 8
> +};
> +
> +static unsigned int channels_2_8[] = {
> +	2, 8
> +};
> +
> +static struct snd_pcm_hw_constraint_list hw_constraints_2_6_8_channels = {
> +	.count = ARRAY_SIZE(channels_2_6_8),
> +	.list = channels_2_6_8,
> +	.mask = 0,
> +};
> +
> +static struct snd_pcm_hw_constraint_list hw_constraints_2_8_channels = {
> +	.count = ARRAY_SIZE(channels_2_8),
> +	.list = channels_2_8,
> +	.mask = 0,
> +};
> +
>  static int simple_playback_pcm_open(struct hda_pcm_stream *hinfo,
>  				    struct hda_codec *codec,
>  				    struct snd_pcm_substream *substream)
>  {
>  	struct hdmi_spec *spec = codec->spec;
> +	struct snd_pcm_hw_constraint_list *hw_constraints_channels = NULL;
> +
> +	switch (codec->preset->id) {
> +	case 0x10de0002:
> +	case 0x10de0003:
> +	case 0x10de0005:
> +	case 0x10de0006:
> +		hw_constraints_channels = &hw_constraints_2_8_channels;
> +		break;
> +	case 0x10de0007:
> +		hw_constraints_channels = &hw_constraints_2_6_8_channels;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (hw_constraints_channels != NULL) {
> +		snd_pcm_hw_constraint_list(substream->runtime, 0,
> +				SNDRV_PCM_HW_PARAM_CHANNELS,
> +				hw_constraints_channels);
> +	}
> +
>  	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
>  }
>  


-- 
Anssi Hannula
