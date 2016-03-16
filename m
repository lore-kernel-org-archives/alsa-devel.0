From: walter harms <wharms@bfs.de>
Subject: Re: [patch] ALSA: mixart: silence an uninitialized variable warning
Date: Wed, 16 Mar 2016 09:22:53 +0100
Message-ID: <56E917DD.3050901@bfs.de>
References: <20160316074213.GC12860@mwanda>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20160316074213.GC12860@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Quentin Lambert <lambert.quentin@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



Am 16.03.2016 08:42, schrieb Dan Carpenter:
> We could print the uninitialized value of "stat" in the error message.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
> index bc81b9f..25c0ddd 100644
> --- a/sound/pci/mixart/mixart.c
> +++ b/sound/pci/mixart/mixart.c
> @@ -132,7 +132,7 @@ static int mixart_set_pipe_state(struct mixart_mgr *mgr,
>  	}
>  
>  	if(start) {
> -		u32 stat;
> +		u32 stat = 0;
>  
>  		group_state.pipe_count = 0; /* in case of start same command once again with pipe_count=0 */
>  

@maintainer:
can someone please fix/remove the comment here ? it read like if (pipe_count==0) pipe_count = 0.

just my 2 cents,

re,
 wh

> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
