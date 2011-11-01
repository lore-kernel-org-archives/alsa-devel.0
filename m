From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: switch over to new
 endpoint streaming logic
Date: Tue, 01 Nov 2011 21:57:30 +0100
Message-ID: <4EB05D3A.60405@ladisch.de>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 38BE610381A
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 21:57:35 +0100 (CET)
In-Reply-To: <1320063030-3502-3-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On 10/31/2011 01:10 PM, Daniel Mack wrote:
> @@ -276,6 +312,15 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
>  	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
>  	     (! is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
>  	    altsd->bNumEndpoints >= 2) {
> +		switch (subs->stream->chip->usb_id) {
> +		case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
> +		case USB_ID(0x0763, 0x2081):
> +			ep = 0x81;
> +			iface = usb_ifnum_to_if(dev, 2);
> +			alts = &iface->altsetting[1];

Better check that the device actually has these descriptors.

> +int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	case SNDRV_PCM_TRIGGER_START:
> +		err = start_endpoints(subs);

The trigger callback should execute very quickly; the initial URB
submission should be handled in the prepare callback.


Regards,
Clemens
