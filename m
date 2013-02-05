From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: How to use implicit feedback with full duplex?
Date: Tue, 5 Feb 2013 23:50:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1302052326150.1207@xoschi>
References: <51116F36.9040106@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 54136261737
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 23:50:28 +0100 (CET)
Received: by mail-bk0-f41.google.com with SMTP id q16so362264bkw.0
 for <alsa-devel@alsa-project.org>; Tue, 05 Feb 2013 14:50:26 -0800 (PST)
In-Reply-To: <51116F36.9040106@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hi Clemens,

On Tue, 5 Feb 2013, Clemens Ladisch wrote:
> Hi,
> 
> I thought I'd try to use implicit feedback with my simple audio device:
> 
>     Interface Descriptor:
>       bInterfaceNumber        1
>       bAlternateSetting       0
>     Interface Descriptor:
>       bInterfaceNumber        1
>       bAlternateSetting       1
>       AudioStreaming Interface Descriptor:
>         ...
>       Endpoint Descriptor:
>         bEndpointAddress     0x01  EP 1 OUT
>     Interface Descriptor:
>       bInterfaceNumber        2
>       bAlternateSetting       0
>     Interface Descriptor:
>       bInterfaceNumber        2
>       bAlternateSetting       1
>       AudioStreaming Interface Descriptor:
>         ...
>       Endpoint Descriptor:
>         bEndpointAddress     0x82  EP 2 IN
>
> So I wrote a patch to configure it like those M-Audio devices:
> 
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -391,6 +391,17 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
>  	attr = fmt->ep_attr & USB_ENDPOINT_SYNCTYPE;
> 
>  	switch (subs->stream->chip->usb_id) {
> +	case USB_ID(0x0582, 0x0018):
> +		if (is_playback) {
> +			implicit_fb = 1;
> +			ep = 0x82;
> +			iface = usb_ifnum_to_if(dev, 2);
> +			if (!iface || iface->num_altsetting < 2)
> +				return -EINVAL;
> +			alts = &iface->altsetting[1];
> +			goto add_sync_ep;
> +		}
> +		break;

Looks good to me. 

>  	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
>  		if (is_playback) {
>  			implicit_fb = 1;
> 
> This works fine when playing something:
...
> But when I then try to record at the same time, the driver refuses to
> configure the input endpoint (to the only format, which is already set):
> 
>   kernel: setting usb interface 2:1
>   kernel: Re-using EP 82 in iface 2,1 @ffff8801fd2ac000
>   kernel: Unable to change format on ep #82: already in use
> 
> And despite that "alreay in use" check, the input endpoint is affected
> so much that playback breaks.
> 
> Is full duplex supposed to work?  Does it work with other devices?

This is probably a "yes, but" :)
I use my device mostly full duplex, but with jack opening both 
playback and capture at the same time.

I assume you are opening two different streams, one for playback and
one for capture. In that case, the capture EP is of course already
in use, as a source for timing.
If I try opening 2 different streams I get the same here - but playback 
doesn't break for me. I wonder why that happens.

Can you try using jackd -d alsa -d hw:x with the device and see if that 
works for you?

Cheers,
Eldad
