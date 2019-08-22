From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH] ALSA: usb-audio: Check mixer unit bitmap
 yet more strictly
Date: Thu, 22 Aug 2019 10:31:48 +0200
Message-ID: <20190822103148.0f947980@xxx>
References: <20190822073207.8696-1-tiwai@suse.de>
 <20190822073207.8696-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 210A1F80147
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 10:27:23 +0200 (CEST)
In-Reply-To: <20190822073207.8696-2-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 22 Aug 2019 09:32:03 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> The bmControls (for UAC1) or bmMixerControls (for UAC2/3) bitmap has a
> variable size depending on both input and output pins.  Its size is to
> fit with input * output bits.  The problem is that the input size
> can't be determined simply from the unit descriptor itself but it
> needs to parse the whole connected sources.  Although the
> uac_mixer_unit_get_channels() tries to check some possible overflow of
> this bitmap, it's incomplete due to the lack of the  evaluation of
> input pins.
> 
> For covering possible overflows, this patch adds the bitmap overflow
> check in the loop of input pins in parse_audio_mixer_unit().
> 
> Fixes: 0bfe5e434e66 ("ALSA: usb-audio: Check mixer unit descriptors
> more strictly") Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/mixer.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index b5927c3d5bc0..27ee68a507a2 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -739,7 +739,6 @@ static int uac_mixer_unit_get_channels(struct
> mixer_build *state, struct uac_mixer_unit_descriptor *desc)
>  {
>  	int mu_channels;
> -	void *c;
>  
>  	if (desc->bLength < sizeof(*desc))
>  		return -EINVAL;
> @@ -762,13 +761,6 @@ static int uac_mixer_unit_get_channels(struct
> mixer_build *state, break;
>  	}
>  
> -	if (!mu_channels)
> -		return 0;
> -
> -	c = uac_mixer_unit_bmControls(desc, state->mixer->protocol);
> -	if (c - (void *)desc + (mu_channels - 1) / 8 >=
> desc->bLength)
> -		return 0; /* no bmControls -> skip */
> -
>  	return mu_channels;
>  }
>  
> @@ -2009,6 +2001,29 @@ static int parse_audio_feature_unit(struct
> mixer_build *state, int unitid,
>   * Mixer Unit
>   */
>  
> +/* check whether the given in/out overflows bmMixerControls matrix */
> +static bool mixer_bitmap_overflow(struct uac_mixer_unit_descriptor
> *desc,
> +				  int protocol, int num_ins, int
> num_outs) +{
> +	u8 *hdr = (u8 *)desc;
> +	u8 *c = uac_mixer_unit_bmControls(desc, protocol);
> +	size_t rest; /* remaining bytes after bmMixerControls */
> +
> +	switch (protocol) {
> +	case UAC_VERSION_1:
> +	default:

Won't this trigger implicit fall through warning?

> +		rest = 1; /* iMixer */
> +	case UAC_VERSION_2:
> +		rest = 2; /* bmControls + iMixer */
> +	case UAC_VERSION_3:
> +		rest = 6; /* bmControls + wMixerDescrStr */
> +		break;
> +	}
> +
> +	/* overflow? */
> +	return c + (num_ins * num_outs + 7) / 8 + rest > hdr +
> hdr[0]; +}
> +
>  /*
>   * build a mixer unit control
>   *
> @@ -2137,6 +2152,9 @@ static int parse_audio_mixer_unit(struct
> mixer_build *state, int unitid, if (err < 0)
>  			return err;
>  		num_ins += iterm.channels;
> +		if (mixer_bitmap_overflow(desc,
> state->mixer->protocol,
> +					  num_ins, num_outs))
> +			break;
>  		for (; ich < num_ins; ich++) {
>  			int och, ich_has_controls = 0;
>  
