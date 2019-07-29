From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] sound: dmasound_atari: Mark expected switch
 fall-through
Date: Mon, 29 Jul 2019 14:48:31 -0700
Message-ID: <201907291448.E375AA59F@keescook>
References: <20190729205454.GA5084@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190729205454.GA5084@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 29, 2019 at 03:54:54PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: m68k):
> 
> sound/oss/dmasound/dmasound_atari.c: warning: this statement may fall
> through [-Wimplicit-fallthrough=]:  => 1449:24
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes in v2:
>  - Update code so switch and case statements are at the same indent.
> 
>  sound/oss/dmasound/dmasound_atari.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
> index 83653683fd68..823ccfa089b2 100644
> --- a/sound/oss/dmasound/dmasound_atari.c
> +++ b/sound/oss/dmasound/dmasound_atari.c
> @@ -1432,25 +1432,25 @@ static int FalconMixerIoctl(u_int cmd, u_long arg)
>  {
>  	int data;
>  	switch (cmd) {
> -	    case SOUND_MIXER_READ_RECMASK:
> +	case SOUND_MIXER_READ_RECMASK:
>  		return IOCTL_OUT(arg, SOUND_MASK_MIC);
> -	    case SOUND_MIXER_READ_DEVMASK:
> +	case SOUND_MIXER_READ_DEVMASK:
>  		return IOCTL_OUT(arg, SOUND_MASK_VOLUME | SOUND_MASK_MIC | SOUND_MASK_SPEAKER);
> -	    case SOUND_MIXER_READ_STEREODEVS:
> +	case SOUND_MIXER_READ_STEREODEVS:
>  		return IOCTL_OUT(arg, SOUND_MASK_VOLUME | SOUND_MASK_MIC);
> -	    case SOUND_MIXER_READ_VOLUME:
> +	case SOUND_MIXER_READ_VOLUME:
>  		return IOCTL_OUT(arg,
>  			VOLUME_ATT_TO_VOXWARE(dmasound.volume_left) |
>  			VOLUME_ATT_TO_VOXWARE(dmasound.volume_right) << 8);
> -	    case SOUND_MIXER_READ_CAPS:
> +	case SOUND_MIXER_READ_CAPS:
>  		return IOCTL_OUT(arg, SOUND_CAP_EXCL_INPUT);
> -	    case SOUND_MIXER_WRITE_MIC:
> +	case SOUND_MIXER_WRITE_MIC:
>  		IOCTL_IN(arg, data);
>  		tt_dmasnd.input_gain =
>  			RECLEVEL_VOXWARE_TO_GAIN(data & 0xff) << 4 |
>  			RECLEVEL_VOXWARE_TO_GAIN(data >> 8 & 0xff);
> -		/* fall thru, return set value */
> -	    case SOUND_MIXER_READ_MIC:
> +		/* fall through - return set value */
> +	case SOUND_MIXER_READ_MIC:
>  		return IOCTL_OUT(arg,
>  			RECLEVEL_GAIN_TO_VOXWARE(tt_dmasnd.input_gain >> 4 & 0xf) |
>  			RECLEVEL_GAIN_TO_VOXWARE(tt_dmasnd.input_gain & 0xf) << 8);
> -- 
> 2.22.0
> 

-- 
Kees Cook
