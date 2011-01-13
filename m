From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda: Disable odd numbered channels
 on	HDMI controllers.
Date: Thu, 13 Jan 2011 22:42:39 +0200
Message-ID: <4D2F63BF.8000308@iki.fi>
References: <1294949987-11389-1-git-send-email-ndaga@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
	[83.102.40.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BED5E103B06
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 21:42:43 +0100 (CET)
In-Reply-To: <1294949987-11389-1-git-send-email-ndaga@nvidia.com>
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

On 13.01.2011 22:19, Nitin Daga wrote:
> Added code in hda_intel.c to disable odd numbered channels
> not supported by HDMI controllers.
> 
> Signed-off-by: Nitin Daga <ndaga@nvidia.com>
> Acked-By: Stephen Warren <swarren@nvidia.com>
> ---
>  pci/hda/hda_intel.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/pci/hda/hda_intel.c b/pci/hda/hda_intel.c
> index a78ea34..293c685 100644
> --- a/pci/hda/hda_intel.c
> +++ b/pci/hda/hda_intel.c
> @@ -1539,6 +1539,16 @@ struct azx_pcm {
>  	struct hda_pcm_stream *hinfo[2];
>  };
>  
> +static unsigned int channels_2_4_6_8[] = {
> +	2, 4, 6, 8
> +};
> +
> +static struct snd_pcm_hw_constraint_list hw_constraints_2_4_6_8_channels = {
> +	.count = ARRAY_SIZE(channels_2_4_6_8),
> +	.list = channels_2_4_6_8,
> +	.mask = 0,
> +};

Hmm, can't these be const? OTOH none of the other drivers use const for
snd_pcm_hw_constraint_list either, so I guess it is ok.

>  static int azx_pcm_open(struct snd_pcm_substream *substream)
>  {
>  	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
> @@ -1566,6 +1576,9 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
>  				   128);
>  	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
>  				   128);
> +	snd_pcm_hw_constraint_list(runtime, 0,
> +				   SNDRV_PCM_HW_PARAM_CHANNELS,
> +				   &hw_constraints_2_4_6_8_channels);

This would seem simpler and more generic (there are codecs that have
over 8 channels):
snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, 2);

However, either of those would AFAICS break Si3054 Modem codec which is
mono-only.

Maybe just add the constraint to patch_hdmi.c?
Or use the patch as is but add 1, 10, 12, 14, 16 (or so) to the allowed
channel counts list.

Not really sure what is the preferred approach, though.

>  	snd_hda_power_up(apcm->codec);
>  	err = hinfo->ops.open(hinfo, apcm->codec, substream);
>  	if (err < 0) {

-- 
Anssi Hannula
