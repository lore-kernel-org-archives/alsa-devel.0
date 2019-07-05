From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] ALSA: cs4281: remove redundant assignment to variable
 val and remove a goto
Date: Fri, 05 Jul 2019 12:20:10 +0200
Message-ID: <5D1F245A.7030203@bfs.de>
References: <20190705095704.26050-1-colin.king@canonical.com>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190705095704.26050-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



Am 05.07.2019 11:57, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable val is being assigned with a value that is never
> read and it is being updated later with a new value. The
> assignment is redundant and can be removed.  Also remove a
> goto statement and a label and replace with a break statement.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/pci/cs4281.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
> index a2cce3ecda6f..04c712647853 100644
> --- a/sound/pci/cs4281.c
> +++ b/sound/pci/cs4281.c
> @@ -694,7 +694,7 @@ static int snd_cs4281_trigger(struct snd_pcm_substream *substream, int cmd)
>  
>  static unsigned int snd_cs4281_rate(unsigned int rate, unsigned int *real_rate)
>  {
> -	unsigned int val = ~0;
> +	unsigned int val;
>  	
>  	if (real_rate)
>  		*real_rate = rate;
> @@ -707,9 +707,8 @@ static unsigned int snd_cs4281_rate(unsigned int rate, unsigned int *real_rate)
>  	case 44100:	return 1;
>  	case 48000:	return 0;
>  	default:
> -		goto __variable;
> +		break;
>  	}
> -      __variable:
>  	val = 1536000 / rate;
>  	if (real_rate)
>  		*real_rate = 1536000 / val;
		^^^^^^^^^^^^^^^^^^^^^^^^^

this is confusing. is
*real_rate = rate
intended here ? (like above)

val could be eliminated by using

return  1536000 / rate ;

re,
 wh
