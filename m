From: walter harms <wharms@bfs.de>
Subject: Re: [patch] ALSA: dice: fix array limits in dice_proc_read()
Date: Fri, 29 Nov 2013 10:48:28 +0100
Message-ID: <529862EC.60104@bfs.de>
References: <20131129081409.GA3490@elgon.mountain>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20131129081409.GA3490@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



Am 29.11.2013 09:14, schrieb Dan Carpenter:
> The array limits are supposed to be in units of u32 instead of in bytes.
> The current code has a potential array overflow.
> 
> Fixes: c614475b0ea9 ('ALSA: dice: add a proc file to show device information')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
> index 57bcd31fcc12..c0aa64941cee 100644
> --- a/sound/firewire/dice.c
> +++ b/sound/firewire/dice.c
> @@ -1019,7 +1019,7 @@ static void dice_proc_read(struct snd_info_entry *entry,
>  
>  	if (dice_proc_read_mem(dice, &tx_rx_header, sections[2], 2) < 0)
>  		return;
> -	quadlets = min_t(u32, tx_rx_header.size, sizeof(buf.tx));
> +	quadlets = min_t(u32, tx_rx_header.size, sizeof(buf.tx) / 4);

it is a bit late but ...

sizeof(buf.tx) / 4  looks like ARRAY_SIZE(buf.tx)

If yes i suggest ARRAY_SIZE() because it gets rid of the "magic" 4.

re,
 wh


>  	for (stream = 0; stream < tx_rx_header.number; ++stream) {
>  		if (dice_proc_read_mem(dice, &buf.tx, sections[2] + 2 +
>  				       stream * tx_rx_header.size,
> @@ -1045,7 +1045,7 @@ static void dice_proc_read(struct snd_info_entry *entry,
>  
>  	if (dice_proc_read_mem(dice, &tx_rx_header, sections[4], 2) < 0)
>  		return;
> -	quadlets = min_t(u32, tx_rx_header.size, sizeof(buf.rx));
> +	quadlets = min_t(u32, tx_rx_header.size, sizeof(buf.rx) / 4);
>  	for (stream = 0; stream < tx_rx_header.number; ++stream) {
>  		if (dice_proc_read_mem(dice, &buf.rx, sections[4] + 2 +
>  				       stream * tx_rx_header.size,
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
