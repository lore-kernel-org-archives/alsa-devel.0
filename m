From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH 10/10] ALSA: xen: Use standard
 pcm_format_to_bits() for ALSA format bits
Date: Mon, 30 Jul 2018 10:35:58 +0300
Message-ID: <cdf3db6c-e6dc-68c1-258f-106365cf5647@gmail.com>
References: <mailman.653.1532553863.753.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 710DA267365
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 09:36:01 +0200 (CEST)
Received: by mail-lf1-f42.google.com with SMTP id f135-v6so7412678lfg.10
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 00:36:01 -0700 (PDT)
In-Reply-To: <mailman.653.1532553863.753.alsa-devel@alsa-project.org>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: xen-devel <xen-devel@lists.xenproject.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello, Takashi!
> Date: Wed, 25 Jul 2018 23:19:45 +0200
> From: Takashi Iwai <tiwai@suse.de>
> To: alsa-devel@alsa-project.org
> Subject: [alsa-devel] [PATCH 10/10] ALSA: xen: Use standard
> 	pcm_format_to_bits() for ALSA format bits
> Message-ID: <20180725211945.19222-11-tiwai@suse.de>
>
> The open codes with the bit shift in xen_snd_front_alsa.c give sparse
> warnings as the PCM format type is with __bitwise.
> There is already a standard macro to get the format bits, so let's use
> it instead.
>
> This fixes sparse warnings like:
>    sound/xen/xen_snd_front_alsa.c:191:47: warning: restricted snd_pcm_format_t degrades to integer
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/xen/xen_snd_front_alsa.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
> index 5a2bd70a2fa1..129180e17db1 100644
> --- a/sound/xen/xen_snd_front_alsa.c
> +++ b/sound/xen/xen_snd_front_alsa.c
> @@ -188,7 +188,7 @@ static u64 to_sndif_formats_mask(u64 alsa_formats)
>   
>   	mask = 0;
>   	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
> -		if (1 << ALSA_SNDIF_FORMATS[i].alsa & alsa_formats)
> +		if (pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa) & alsa_formats)
>   			mask |= 1 << ALSA_SNDIF_FORMATS[i].sndif;
>   
>   	return mask;
> @@ -202,7 +202,7 @@ static u64 to_alsa_formats_mask(u64 sndif_formats)
>   	mask = 0;
>   	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
>   		if (1 << ALSA_SNDIF_FORMATS[i].sndif & sndif_formats)
> -			mask |= 1 << ALSA_SNDIF_FORMATS[i].alsa;
> +			mask |= pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa);
>   
>   	return mask;
>   }
Thank you for your patch,
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Thank you,
Oleksandr
