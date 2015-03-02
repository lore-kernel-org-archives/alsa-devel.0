From: Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: simple-card: Add support for samplerate
 and samplewidth constraints
Date: Mon, 02 Mar 2015 13:35:04 -0600
Message-ID: <54F4BB68.4030501@linux.intel.com>
References: <cover.1425303942.git.jsarha@ti.com> <9d01aa0d0bf48d8b41d5086a7e6c9ec08c2b9c48.1425303942.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9d01aa0d0bf48d8b41d5086a7e6c9ec08c2b9c48.1425303942.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Jyri,

On 3/2/15 8:14 AM, Jyri Sarha wrote:
>
>   Optional dai-link subnode properties:
>
> +- samplewidth-constraints		: List of integers describing supported
> +					  sample widths in number of bits.

There are quite a few platforms where the number of bits for valid audio 
bits differs from the number of bits per slot, e.g. 24 bits with 25 bit 
slots, or 24 bits in 32 bit slots. How would this be represented? This 
concept is present for the TDM case but not the simple one.
-Pierre

> +- rate-constraints			: List of integers describing supported
> +					  sample samplerates in Hz.
>   - format				: CPU/CODEC common audio format.
>   					  "i2s", "right_j", "left_j" , "dsp_a"

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
