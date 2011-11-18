From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 5/5] ALSA: snd-usb: add support for
	implicit feedback
Date: Fri, 18 Nov 2011 21:22:17 +0100
Message-ID: <4EC6BE79.5060007@gmail.com>
References: <1321646744-13656-1-git-send-email-zonque@gmail.com>
	<1321646744-13656-6-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id D36F52439C
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 21:22:24 +0100 (CET)
Received: by bkat8 with SMTP id t8so3846870bka.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 12:22:23 -0800 (PST)
In-Reply-To: <1321646744-13656-6-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

On 11/18/2011 09:05 PM, Daniel Mack wrote:
> ---
>  sound/usb/pcm.c |   37 ++++++++++++++++++++++++++-----------
>  1 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index 34adb17..3cf23e3 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -298,7 +298,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
>  	struct usb_interface *iface;
>  	unsigned int ep, attr;
>  	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
> -	int err;
> +	int err, implicit_fb = 0;
>  
>  	iface = usb_ifnum_to_if(dev, fmt->iface);
>  	if (WARN_ON(!iface))
> @@ -323,25 +323,34 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
>  	 * assume it as adaptive-out or sync-in.
>  	 */
>  	attr = fmt->ep_attr & USB_ENDPOINT_SYNCTYPE;
> -	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
> -	     (! is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
> -	    altsd->bNumEndpoints >= 2) {
> -		switch (subs->stream->chip->usb_id) {
> -		case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
> -		case USB_ID(0x0763, 0x2081):
> +
> +	switch (subs->stream->chip->usb_id) {
> +	case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
> +	case USB_ID(0x0763, 0x2081):
> +		if (is_playback) {
> +			implicit_fb = 1;
>  			ep = 0x81;
>  			iface = usb_ifnum_to_if(dev, 2);
> +
> +			if (!iface || iface->num_altsetting == 0)
> +				return -EINVAL;
> +
>  			alts = &iface->altsetting[1];
>  			goto add_sync_ep;
>  		}

Eeks, something went wrong here in my patch rebasing/squashing. It
shouldn't matter for the review though - I'll fix that up next time.
