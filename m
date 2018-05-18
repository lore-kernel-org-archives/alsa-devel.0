From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: dice: fix a bounds check in
 snd_dice_detect_tcelectronic_formats()
Date: Fri, 18 May 2018 20:36:23 +0900
Message-ID: <eec1b86f-a5f8-6c8d-fce6-a0f9c2629b52@sakamocchi.jp>
References: <20180518091607.GA32078@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D5F3D266F4E
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 13:36:31 +0200 (CEST)
In-Reply-To: <20180518091607.GA32078@mwanda>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On May 18 2018 18:16, Dan Carpenter wrote:
> The "entry" pointer is always non-NULL so this test for out of bounds
> won't work.
> 
> Fixes: f1f0f330b1d0 ("ALSA: dice: add parameters of stream formats for models produced by TC Electronic")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/sound/firewire/dice/dice-tcelectronic.c b/sound/firewire/dice/dice-tcelectronic.c
> index af8203b9d1a6..e134a5110c6c 100644
> --- a/sound/firewire/dice/dice-tcelectronic.c
> +++ b/sound/firewire/dice/dice-tcelectronic.c
> @@ -75,13 +75,12 @@ int snd_dice_detect_tcelectronic_formats(struct snd_dice *dice)
>   		}
>   	}
>   
> -	entry = NULL;
>   	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
>   		entry = entries + i;
>   		if (entry->model_id == model_id)
>   			break;
>   	}
> -	if (!entry)
> +	if (i == ARRAY_SIZE(entries))
>   		return -ENODEV;
>   
>   	memcpy(dice->tx_pcm_chs, entry->spec->tx_pcm_chs,

Oops, indeed.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
