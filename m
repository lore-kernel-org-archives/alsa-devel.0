From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC] compress: add support for gapless playback
Date: Tue, 05 Feb 2013 20:44:42 -0600
Message-ID: <5111C39A.6020805@linux.intel.com>
References: <1360074085-562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 24C18261987
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 03:44:46 +0100 (CET)
In-Reply-To: <1360074085-562-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


> +Gapless Playback
> +================
> +When playing thru an album, the decoders have the ability to skip the encoder
> +delay and padding and directly move from one track content to another. The end
> +user can perceive this as gapless playback as we dont have silence while
> +switching from one track to another

You want to clarify that there might be low-intensity noises due to 
encoding. Perfect gapless is difficult to reach with all types of 
compressed data, but works fine with most music content.
Also you want to mention that this metadata is extracted from ID3/MP4 
headers and are not present by default in the bitstream, hence the need 
for a new interface to pass this information to the DSP.

> +- set_metadata
> +This routine sets the encoder delay and encoder padding. This can be used by
> +decoder to strip the silence

You did not specify that this needs to be set before the first write of 
the next track.

> +
> +- partial drain
> +This is called when end of file is reached. The userspace can inform DSP that
> +EOF is reached and now DSP can start skipping padding delay. Also next write
> +data would belong to next track

DSP skips padding delay after decoding all samples in the track, not as 
soon as EOF is reached.
A sequence as seen from userspace might be useful here to avoid random 
interpretations of the API semantics.

>   /**
> + * struct snd_compr_metadata: compressed stream metadata
> + * @encoder_delay: no of samples inserted by the encoder at the beginning
> + * of the track
> + * @encoder_padding: no of samples appended by the encoder at the end
> + * of the track
> + */
> +struct snd_compr_metadata {
> +	 __u32 encoder_delay;
> +	 __u32 encoder_padding;
> +};

You need to pad this structure with reserved bytes for future 
evolutions. Things like ReplayGain, etc, might be of interest for some 
implementations. Let's not be cheap here


> +static int
> +snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
> +{
> +	struct snd_compr_metadata *metadata;
> +	int retval;
> +
> +	if (!stream->ops->set_metadata)
> +		return -ENXIO;

Is this really a fatal error? Or do we want to mandate that gapless be 
supported by all implementations?
