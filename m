From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] ALSA: drivers: make array 'names' const, reduces object
 code size
Date: Mon, 27 Nov 2017 15:55:28 +0100
Message-ID: <5A1C2760.1030704@bfs.de>
References: <20171127125851.10076-1-colin.king@canonical.com>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171127125851.10076-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



Am 27.11.2017 13:58, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate array 'names' on the stack but instead make them static.
> Makes the object code smaller by 50 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   21237	   9192	   1120	  31549	   7b3d	linux/sound/drivers/dummy.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   21095	   9280	   1120	  31495	   7b07	linux/sound/drivers/dummy.o
> 
> (gcc version 7.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/drivers/dummy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
> index 7b2b1f766b00..69db45bc0197 100644
> --- a/sound/drivers/dummy.c
> +++ b/sound/drivers/dummy.c
> @@ -830,7 +830,7 @@ static int snd_dummy_capsrc_put(struct snd_kcontrol *kcontrol, struct snd_ctl_el
>  static int snd_dummy_iobox_info(struct snd_kcontrol *kcontrol,
>  				struct snd_ctl_elem_info *info)
>  {
> -	const char *const names[] = { "None", "CD Player" };
> +	static const char *const names[] = { "None", "CD Player" };
>  
>  	return snd_ctl_enum_info(info, 1, 2, names);
>  }

nitpick: while here
   snd_ctl_enum_info(info, 1, ARRAY_SIZE(names), names);

just my 2 cents,
re,
 wh
