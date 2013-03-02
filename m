From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: usb: Work around CM6631 sample rate
 change bug
Date: Sat, 02 Mar 2013 14:12:33 +0100
Message-ID: <5131FAC1.30007@gmail.com>
References: <20130302130403.GD4452@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f52.google.com (mail-ee0-f52.google.com [74.125.83.52])
 by alsa0.perex.cz (Postfix) with ESMTP id DF873261636
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2013 14:12:36 +0100 (CET)
Received: by mail-ee0-f52.google.com with SMTP id b15so2915723eek.11
 for <alsa-devel@alsa-project.org>; Sat, 02 Mar 2013 05:12:36 -0800 (PST)
In-Reply-To: <20130302130403.GD4452@pvv.ntnu.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torstein Hegge <hegge@resisty.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02.03.2013 14:04, Torstein Hegge wrote:
> The C-Media CM6631 USB-to-S/PDIF receiver doesn't respond to changes in
> sampling frequency while the interface is active.
> 
> Reset the interface after setting the sampling frequency, to ensure that the
> sample rate set by snd_usb_init_sample_rate() is used. Otherwise, the device
> will try to use the sample rate of the previous file, causing distorted sound
> on sample rate changes.
> 
> Signed-off-by: Torstein Hegge <hegge@resisty.net>

Acked-by: Daniel Mack <zonque@gmail.com>


Thanks!

Daniel


> ---
>  sound/usb/pcm.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index d82e378..01978a6 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -710,6 +710,16 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
>  		subs->need_setup_ep = false;
>  	}
>  
> +	/* Some devices doesn't respond to sample rate changes while the
> +	 * interface is active. */
> +	switch (subs->stream->chip->usb_id) {
> +	case USB_ID(0x0d8c, 0x0304): /* C-Media - Schiit USB Interface */
> +	case USB_ID(0x0d8c, 0x0309): /* C-Media CM6631 */
> +		usb_set_interface(subs->dev, subs->cur_audiofmt->iface,
> +					subs->cur_audiofmt->altset_idx);
> +		break;
> +	}
> +
>  	/* some unit conversions in runtime */
>  	subs->data_endpoint->maxframesize =
>  		bytes_to_frames(runtime, subs->data_endpoint->maxpacksize);
> 
