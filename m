From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: wcd9335: remove some unnecessary
	NULL checks
Date: Tue, 5 Feb 2019 09:58:54 +0000
Message-ID: <0eb6bff2-83fd-af03-13be-ff79f16e9e9a@linaro.org>
References: <20190205090927.GA20372@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D510267444
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 10:58:55 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id p6so2906591wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 05 Feb 2019 01:58:55 -0800 (PST)
In-Reply-To: <20190205090927.GA20372@kadam>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 05/02/2019 09:09, Dan Carpenter wrote:
> These are arrays, not pointers, and they can't be NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Thanks Dan,

There is already a patch on list to fix this:
https://patchwork.kernel.org/patch/10787281/

thanks,
srini

> ---
>   sound/soc/codecs/wcd9335.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> index 3878187bb512..981f88a5f615 100644
> --- a/sound/soc/codecs/wcd9335.c
> +++ b/sound/soc/codecs/wcd9335.c
> @@ -2001,20 +2001,16 @@ static int wcd9335_set_channel_map(struct snd_soc_dai *dai,
>   		return -EINVAL;
>   	}
>   
> -	if (wcd->rx_chs) {
> -		wcd->num_rx_port = rx_num;
> -		for (i = 0; i < rx_num; i++) {
> -			wcd->rx_chs[i].ch_num = rx_slot[i];
> -			INIT_LIST_HEAD(&wcd->rx_chs[i].list);
> -		}
> +	wcd->num_rx_port = rx_num;
> +	for (i = 0; i < rx_num; i++) {
> +		wcd->rx_chs[i].ch_num = rx_slot[i];
> +		INIT_LIST_HEAD(&wcd->rx_chs[i].list);
>   	}
>   
> -	if (wcd->tx_chs) {
> -		wcd->num_tx_port = tx_num;
> -		for (i = 0; i < tx_num; i++) {
> -			wcd->tx_chs[i].ch_num = tx_slot[i];
> -			INIT_LIST_HEAD(&wcd->tx_chs[i].list);
> -		}
> +	wcd->num_tx_port = tx_num;
> +	for (i = 0; i < tx_num; i++) {
> +		wcd->tx_chs[i].ch_num = tx_slot[i];
> +		INIT_LIST_HEAD(&wcd->tx_chs[i].list);
>   	}
>   
>   	return 0;
> 
