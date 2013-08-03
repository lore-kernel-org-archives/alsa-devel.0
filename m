From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v2 7/9] ALSA: usb-audio: remove is_playback
 from implicit feedback quirks
Date: Sat, 3 Aug 2013 11:05:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308031104360.25957@xoschi>
References: <1375519875-25774-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 425AA2617AA
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 11:05:26 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id ji2so455852bkc.24
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 02:05:26 -0700 (PDT)
In-Reply-To: <1375519875-25774-1-git-send-email-eldad@fogrefinery.com>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


I had some error while sending, and this was sent twice.

On Sat, 3 Aug 2013, Eldad Zack wrote:

> An implicit feedback endpoint can only be a capture source. The
> consumer (sink) of the implicit feedback endpoint is therefore limited
> to playback EPs.
> Check if the target endpoint is a playback first and remove redundant
> checks.
> 
> Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
> ---
>  sound/usb/pcm.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index bb2e0f5..af30e08 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -334,41 +334,39 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
>  {
>  	struct usb_host_interface *alts;
>  	struct usb_interface *iface;
> -	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
>  	int implicit_fb = 0;
>  	unsigned int ep;
>  
> +	/* Implicit feedback sync EPs consumers are always playback EPs */
> +	if (subs->direction != SNDRV_PCM_STREAM_PLAYBACK)
> +		return 0;
> +
>  	switch (subs->stream->chip->usb_id) {
>  	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
>  	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C600 */
> -		if (is_playback) {
> -			implicit_fb = 1;
> -			ep = 0x81;
> -			iface = usb_ifnum_to_if(dev, 3);
> +		implicit_fb = 1;
> +		ep = 0x81;
> +		iface = usb_ifnum_to_if(dev, 3);
>  
> -			if (!iface || iface->num_altsetting == 0)
> -				return -EINVAL;
> +		if (!iface || iface->num_altsetting == 0)
> +			return -EINVAL;
>  
> -			alts = &iface->altsetting[1];
> -			goto add_sync_ep;
> -		}
> +		alts = &iface->altsetting[1];
> +		goto add_sync_ep;
>  		break;
>  	case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
>  	case USB_ID(0x0763, 0x2081):
> -		if (is_playback) {
> -			implicit_fb = 1;
> -			ep = 0x81;
> -			iface = usb_ifnum_to_if(dev, 2);
> +		implicit_fb = 1;
> +		ep = 0x81;
> +		iface = usb_ifnum_to_if(dev, 2);
>  
> -			if (!iface || iface->num_altsetting == 0)
> -				return -EINVAL;
> +		if (!iface || iface->num_altsetting == 0)
> +			return -EINVAL;
>  
> -			alts = &iface->altsetting[1];
> -			goto add_sync_ep;
> -		}
> +		alts = &iface->altsetting[1];
> +		goto add_sync_ep;
>  	}
> -	if (is_playback &&
> -	    attr == USB_ENDPOINT_SYNC_ASYNC &&
> +	if (attr == USB_ENDPOINT_SYNC_ASYNC &&
>  	    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
>  	    altsd->bInterfaceProtocol == 2 &&
>  	    altsd->bNumEndpoints == 1 &&
> -- 
> 1.8.1.5
> 
