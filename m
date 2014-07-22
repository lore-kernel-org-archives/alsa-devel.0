From: "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>
Subject: Re: [PATCH] pcm: plugin_ops.h: Add S24_3LE support in
	gets_label
Date: Tue, 22 Jul 2014 02:29:46 +0000
Message-ID: <5651ad8f9a7c463b846b0ca2217d12f5@BY2PR03MB332.namprd03.prod.outlook.com>
References: <1405937415-9828-1-git-send-email-shengjiu.wang@freescale.com>
 <s5hk377ndel.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BA162654AF
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 04:30:03 +0200 (CEST)
In-Reply-To: <s5hk377ndel.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Yes,  I will add it.

Best regards
Wang shengjiu

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Monday, July 21, 2014 7:46 PM
To: Wang Shengjiu-B02247
Cc: perex@perex.cz; alsa-devel@alsa-project.org
Subject: Re: [PATCH] pcm: plugin_ops.h: Add S24_3LE support in gets_label

At Mon, 21 Jul 2014 18:10:15 +0800,
Shengjiu Wang wrote:
> 
> When route_policy is average, src format is S24_3LE, the get_idx will 
> exceed length of table gets_label. So add items for S24_3LE in the table.

A good catch.  But the plugin supports also 18 and 20 bits.  They have to be covered as well.  Could you revise the patch?


thanks,

Takashi

> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
>  src/pcm/plugin_ops.h |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/src/pcm/plugin_ops.h b/src/pcm/plugin_ops.h index 
> 21535c9..e02d198 100644
> --- a/src/pcm/plugin_ops.h
> +++ b/src/pcm/plugin_ops.h
> @@ -670,7 +670,7 @@ getu_1234_C321: sample = bswap_32(as_u32c(src) ^ 
> 0x80); goto GETU_END;
>  
>  #ifdef GETS_LABELS
>  /* width endswap sign_toggle */
> -static void *const gets_labels[4 * 2 * 2] = {
> +static void *const gets_labels[4 * 2 * 2 + 4 * 1] = {
>  	&&gets_1_1,		/*  8h ->  8h */
>  	&&gets_1_9,		/*  8h ^>  8h */
>  	&&gets_1_1,		/*  8s ->  8h */
> @@ -687,6 +687,11 @@ static void *const gets_labels[4 * 2 * 2] = {
>  	&&gets_1234_9234,	/* 32h ^> 32h */
>  	&&gets_1234_4321,	/* 32s -> 32h */
>  	&&gets_1234_C321,	/* 32s ^> 32h */
> +	/* 3bytes format */
> +	&&gets_123_0123,	/* 24h -> 24h */
> +	&&gets_123_0923,	/* 24h ^> 24h */
> +	&&gets_123_0321,	/* 24s -> 24h */
> +	&&gets_123_0B21,	/* 24s ^> 24h */
>  };
>  #endif
>  
> @@ -706,6 +711,10 @@ gets_1234_1234: sample = as_s32c(src); goto 
> GETS_END;
>  gets_1234_9234: sample = (int32_t)(as_s32c(src) ^ 0x80000000); goto 
> GETS_END;
>  gets_1234_4321: sample = (int32_t)bswap_32(as_s32c(src)); goto 
> GETS_END;
>  gets_1234_C321: sample = (int32_t)bswap_32(as_s32c(src) ^ 0x80); goto 
> GETS_END;
> +gets_123_0123: sample = sx24(_get_triple(src)); goto GETS_END;
> +gets_123_0923: sample = sx24(_get_triple(src) ^ 0x800000); goto 
> +GETS_END;
> +gets_123_0321: sample = sx24(_get_triple_s(src)); goto GETS_END;
> +gets_123_0B21: sample = sx24(_get_triple_s(src) ^ 0x800000); goto 
> +GETS_END;
>  }
>  #endif
>  
> --
> 1.7.9.5
> 
