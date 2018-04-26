From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 05/11] ALSA: dice: enable to change current
 sampling transmission frequency
Date: Thu, 26 Apr 2018 20:01:28 +0900
Message-ID: <f45c6f3a-e0d3-668b-3fbd-5ab2012c288f@sakamocchi.jp>
References: <20180424234234.6063-1-o-takashi@sakamocchi.jp>
 <20180424234234.6063-6-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 03C942676AB
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:01:33 +0200 (CEST)
In-Reply-To: <20180424234234.6063-6-o-takashi@sakamocchi.jp>
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
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Apr 25 2018 08:42, Takashi Sakamoto wrote:
> @@ -300,10 +333,9 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
>   			"fail to get sampling rate\n");
>   		return err;
>   	}
> -	if (rate == 0)
> +
> +	if (rate != 0)
>   		rate = curr_rate;

Oops. I realized that the condition change is my mistake... This night I 
repost revised version, sorry...

> -	if (rate != curr_rate)
> -		return -EINVAL;
>   
>   	/* Judge to need to restart streams. */
>   	for (i = 0; i < MAX_STREAMS; i++) {
> @@ -318,7 +350,7 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
>   				break;
>   		}
>   	}
> -	need_to_start = (i < MAX_STREAMS);
> +	need_to_start = (rate != curr_rate || i < MAX_STREAMS);
>   
>   	if (need_to_start) {
>   		/* Stop transmission. */
> @@ -327,7 +359,7 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
>   		stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
>   		release_resources(dice);
>   
> -		err = ensure_phase_lock(dice);
> +		err = ensure_phase_lock(dice, rate);
>   		if (err < 0) {
>   			dev_err(&dice->unit->device,
>   				"fail to ensure phase lock\n");
> 

Thanks

Takashi Sakamoto
