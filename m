From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/3] ALSA: bebob: Use common error handling code in
 snd_bebob_stream_start_duplex()
Date: Sun, 24 Sep 2017 12:50:37 +0900
Message-ID: <a1dee732-f5c4-5b35-9f82-553fc8ce430d@sakamocchi.jp>
References: <85f95150-9cec-7a53-7692-837ba543e1ec@users.sourceforge.net>
 <541f0f9f-fc87-f65b-bbd8-fec5d45d5d2e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <541f0f9f-fc87-f65b-bbd8-fec5d45d5d2e@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 6 2017 19:22, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 6 Sep 2017 11:40:53 +0200
> 
> Add jump targets so that a bit of exception handling can be better reused
> at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   sound/firewire/bebob/bebob_stream.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
> index 4d3034a68bdf..bc9e42b6368e 100644
> --- a/sound/firewire/bebob/bebob_stream.c
> +++ b/sound/firewire/bebob/bebob_stream.c
> ...
> @@ -666,9 +661,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
>   		if (err < 0) {
>   			dev_err(&bebob->unit->device,
>   				"fail to run AMDTP slave stream:%d\n", err);
> -			amdtp_stream_stop(&bebob->rx_stream);
> -			break_both_connections(bebob);
> -			goto end;
> +			goto stop_rx_stream;
>   		}
>   
>   		/* wait first callback */

After the above code block, we have below code block.

658 /* start slave if needed */
659 if (!amdtp_stream_running(&bebob->tx_stream)) {
660     err = start_stream(bebob, &bebob->tx_stream, rate);
661     if (err < 0) {
662         dev_err(&bebob->unit->device,
663                 "fail to run AMDTP slave stream:%d\n", err);
664         goto stop_rx_stream;
665     }
666
667     /* wait first callback */
668     if (!amdtp_stream_wait_callback(&bebob->tx_stream,
669                                     CALLBACK_TIMEOUT)) {
670         amdtp_stream_stop(&bebob->tx_stream);
671         amdtp_stream_stop(&bebob->rx_stream);
672         break_both_connections(bebob);
673         err = -ETIMEDOUT;
674     }
675 }

I think it better to apply your solution too in the above to keep code 
consistency.

> @@ -682,6 +675,12 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
>   	}
>   end:
>   	return err;
> +
> +stop_rx_stream:
> +	amdtp_stream_stop(&bebob->rx_stream);
> +break_connections:
> +	break_both_connections(bebob);
> +	return err;
>   }
>   
>   void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)

For the other patches, I can find no merit to apply except for reduction 
of the number of characters included in the file.


Thanks

Takashi Sakamoto
