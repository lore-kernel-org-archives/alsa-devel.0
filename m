From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: Re: [PATCH] ALSA: ASoC: davinci-mcasp: clean ip
	davinci_hw_common_param()
Date: Fri, 08 Mar 2013 16:17:45 +0100
Message-ID: <1768046.agBYzFzXsK@ganymedes>
References: <1362748778-11076-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx07.lb01.inode.at [62.99.145.7])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C0E126172C
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 16:17:46 +0100 (CET)
In-Reply-To: <1362748778-11076-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Vaibhav Bedia <vaibhav.bedia@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday, March 08, 2013 14:19:38 Daniel Mack wrote:
> As pointed of by Vaibhav, commit 2952b27e2 ("ASoC: davinci-mcasp:
> Add support for multichannel playback") duplicated the logic of
> counting the active serializers. That can be avoided by shifting
> the code around a bit.
> 
> Also, drop two unused defines introduced by the same commit.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Michal Bachraty <michal.bachraty@streamunlimited.com>
> Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c | 34 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c
> b/sound/soc/davinci/davinci-mcasp.c index b386cad..8a9c0ee 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -237,8 +237,6 @@
>  #define RXSTATE		BIT(5)
>  #define SRMOD_MASK	3
>  #define SRMOD_INACTIVE	0
> -#define SRMOD_TX	1
> -#define SRMOD_RX	2
> 
>  /*
>   * DAVINCI_MCASP_LBCTL_REG - Loop Back Control Register Bits
> @@ -691,27 +689,6 @@ static int davinci_hw_common_param(struct
> davinci_audio_dev *dev, int stream, }
> 
>  	for (i = 0; i < dev->num_serializer; i++) {
> -		if (dev->serial_dir[i] == TX_MODE)
> -			tx_ser++;
> -		if (dev->serial_dir[i] == RX_MODE)
> -			rx_ser++;
> -	}
> -
> -	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> -		ser = tx_ser;
> -	else
> -		ser = rx_ser;
> -
> -	if (ser < max_active_serializers) {
> -		dev_warn(dev->dev, "stream has more channels (%d) than are "
> -			"enabled in mcasp (%d)\n", channels, ser * slots);
> -		return -EINVAL;
> -	}
> -
> -	tx_ser = 0;
> -	rx_ser = 0;
> -
> -	for (i = 0; i < dev->num_serializer; i++) {
>  		mcasp_set_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
>  					dev->serial_dir[i]);
>  		if (dev->serial_dir[i] == TX_MODE &&
> @@ -730,6 +707,17 @@ static int davinci_hw_common_param(struct
> davinci_audio_dev *dev, int stream, }
>  	}
> 
> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		ser = tx_ser;
> +	else
> +		ser = rx_ser;
> +
> +	if (ser < max_active_serializers) {
> +		dev_warn(dev->dev, "stream has more channels (%d) than are "
> +			"enabled in mcasp (%d)\n", channels, ser * slots);
> +		return -EINVAL;
> +	}
> +
>  	if (dev->txnumevt && stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  		if (dev->txnumevt * tx_ser > 64)
>  			dev->txnumevt = 1;

It works fine. Code is also ok.

Michal
