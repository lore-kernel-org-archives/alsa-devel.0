From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: bebob: Use a signed return type for
 get_formation_index
Date: Tue, 26 Jan 2016 08:17:45 +0900
Message-ID: <56A6AD19.1090800@sakamocchi.jp>
References: <1453757423-9076-1-git-send-email-tanure@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D962260575
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 00:17:49 +0100 (CET)
In-Reply-To: <1453757423-9076-1-git-send-email-tanure@linux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Tanure <tanure@linux.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Jan 26 2016 06:30, Lucas Tanure wrote:
> The return type "unsigned int" was used by the get_formation_index function
> despite of the aspect that it will eventually return a negative	error code.
> So, change to signed int and get index by reference in the parameters.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  sound/firewire/bebob/bebob_stream.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
> index 926e5dc..79940e3 100644
> --- a/sound/firewire/bebob/bebob_stream.c
> +++ b/sound/firewire/bebob/bebob_stream.c
> @@ -47,14 +47,15 @@ static const unsigned int bridgeco_freq_table[] = {
>  	[6] = 0x07,
>  };
>  
> -static unsigned int
> -get_formation_index(unsigned int rate)
> +static int
> +get_formation_index(unsigned int rate, unsigned int *index)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(snd_bebob_rate_table); i++) {
>  		if (snd_bebob_rate_table[i] == rate)
> -			return i;
> +			*index = i;
> +			return 0;
>  	}
>  	return -EINVAL;
>  }
> @@ -425,7 +426,9 @@ make_both_connections(struct snd_bebob *bebob, unsigned int rate)
>  		goto end;
>  
>  	/* confirm params for both streams */
> -	index = get_formation_index(rate);
> +	err = get_formation_index(rate, &index);
> +	if (err < 0)
> +		goto end;
>  	pcm_channels = bebob->tx_stream_formations[index].pcm;
>  	midi_channels = bebob->tx_stream_formations[index].midi;
>  	err = amdtp_am824_set_parameters(&bebob->tx_stream, rate,

Indeed, it's my mistake.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

This should go for -stable and 4.5-rc2.
CC: stable@vger.kernel.org


Regards

Takashi Sakamoto
