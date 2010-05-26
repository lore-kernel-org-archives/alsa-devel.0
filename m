From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/4] ALSA: usb-audio: parse UAC2 endpoint
 descriptors correctly
Date: Wed, 26 May 2010 18:17:46 +0200
Message-ID: <20100526161746.GE2695@buzzloop.caiaq.de>
References: <1274890299-8972-1-git-send-email-daniel@caiaq.de>
	<1274890299-8972-3-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A2EB6103965
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 18:17:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274890299-8972-3-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Wed, May 26, 2010 at 06:11:38PM +0200, Daniel Mack wrote:
> UAC2 devices have their information about pitch control stored in a
> different field. Parse it, and emulate the bits for a v1 device.
> 
> A new struct uac2_iso_endpoint_descriptor is added.

> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> ---
>  include/linux/usb/audio-v2.h |   16 ++++++++++++

Greg, I copied you because of this patch, just to let you know we're
having fun in your area of responsibility again :)


Daniel

>  sound/usb/endpoint.c         |   55 ++++++++++++++++++++++++++++++++----------
>  2 files changed, 58 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
> index 2389f93..92f1d99 100644
> --- a/include/linux/usb/audio-v2.h
> +++ b/include/linux/usb/audio-v2.h
> @@ -105,6 +105,22 @@ struct uac_as_header_descriptor_v2 {
>  	__u8 iChannelNames;
>  } __attribute__((packed));
>  
> +/* 4.10.1.2 Class-Specific AS Isochronous Audio Data Endpoint Descriptor */
> +
> +struct uac2_iso_endpoint_descriptor {
> +	__u8  bLength;			/* in bytes: 8 */
> +	__u8  bDescriptorType;		/* USB_DT_CS_ENDPOINT */
> +	__u8  bDescriptorSubtype;	/* EP_GENERAL */
> +	__u8  bmAttributes;
> +	__u8  bmControls;
> +	__u8  bLockDelayUnits;
> +	__le16 wLockDelay;
> +} __attribute__((packed));
> +
> +#define UAC2_CONTROL_PITCH		(3 << 0)
> +#define UAC2_CONTROL_DATA_OVERRUN	(3 << 2)
> +#define UAC2_CONTROL_DATA_UNDERRUN	(3 << 4)
> +
>  /* 6.1 Interrupt Data Message */
>  
>  #define UAC2_INTERRUPT_DATA_MSG_VENDOR	(1 << 0)
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index 4887342..28ee1ce 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -149,6 +149,47 @@ int snd_usb_add_audio_endpoint(struct snd_usb_audio *chip, int stream, struct au
>  	return 0;
>  }
>  
> +static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
> +					 struct usb_host_interface *alts,
> +					 int protocol, int iface_no)
> +{
> +	/* parsed with a v1 header here. that's ok as we only look at the
> +	 * header first which is the same for both versions */
> +	struct uac_iso_endpoint_descriptor *csep;
> +	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
> +	int attributes = 0;
> +
> +	csep = snd_usb_find_desc(alts->endpoint[0].extra, alts->endpoint[0].extralen, NULL, USB_DT_CS_ENDPOINT);
> +
> +	/* Creamware Noah has this descriptor after the 2nd endpoint */
> +	if (!csep && altsd->bNumEndpoints >= 2)
> +		csep = snd_usb_find_desc(alts->endpoint[1].extra, alts->endpoint[1].extralen, NULL, USB_DT_CS_ENDPOINT);
> +
> +	if (!csep || csep->bLength < 7 ||
> +	    csep->bDescriptorSubtype != UAC_EP_GENERAL) {
> +		snd_printk(KERN_WARNING "%d:%u:%d : no or invalid"
> +			   " class specific endpoint descriptor\n",
> +			   chip->dev->devnum, iface_no,
> +			   altsd->bAlternateSetting);
> +		return 0;
> +	}
> +
> +	if (protocol == UAC_VERSION_1) {
> +		attributes = csep->bmAttributes;
> +	} else {
> +		struct uac2_iso_endpoint_descriptor *csep2 =
> +			(struct uac2_iso_endpoint_descriptor *) csep;
> +
> +		attributes = csep->bmAttributes & UAC_EP_CS_ATTR_FILL_MAX;
> +
> +		/* emulate the endpoint attributes of a v1 device */
> +		if (csep2->bmControls & UAC2_CONTROL_PITCH)
> +			attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
> +	}
> +
> +	return attributes;
> +}
> +
>  int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
>  {
>  	struct usb_device *dev;
> @@ -158,7 +199,6 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
>  	int i, altno, err, stream;
>  	int format = 0, num_channels = 0;
>  	struct audioformat *fp = NULL;
> -	unsigned char *csep;
>  	int num, protocol;
>  	struct uac_format_type_i_continuous_descriptor *fmt;
>  
> @@ -279,17 +319,6 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
>  							fp->maxpacksize * 2)
>  			continue;
>  
> -		csep = snd_usb_find_desc(alts->endpoint[0].extra, alts->endpoint[0].extralen, NULL, USB_DT_CS_ENDPOINT);
> -		/* Creamware Noah has this descriptor after the 2nd endpoint */
> -		if (!csep && altsd->bNumEndpoints >= 2)
> -			csep = snd_usb_find_desc(alts->endpoint[1].extra, alts->endpoint[1].extralen, NULL, USB_DT_CS_ENDPOINT);
> -		if (!csep || csep[0] < 7 || csep[2] != UAC_EP_GENERAL) {
> -			snd_printk(KERN_WARNING "%d:%u:%d : no or invalid"
> -				   " class specific endpoint descriptor\n",
> -				   dev->devnum, iface_no, altno);
> -			csep = NULL;
> -		}
> -
>  		fp = kzalloc(sizeof(*fp), GFP_KERNEL);
>  		if (! fp) {
>  			snd_printk(KERN_ERR "cannot malloc\n");
> @@ -308,7 +337,7 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
>  		if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
>  			fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
>  					* (fp->maxpacksize & 0x7ff);
> -		fp->attributes = csep ? csep[3] : 0;
> +		fp->attributes = parse_uac_endpoint_attributes(chip, alts, protocol, iface_no);
>  
>  		/* some quirks for attributes here */
>  
> -- 
> 1.7.1
> 
