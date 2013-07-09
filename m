From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH 1/7] ALSA: usb-audio: store protocol
 version in struct audioformat
Date: Tue, 9 Jul 2013 20:34:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307092029080.1417@xoschi>
References: <51CC9D8B.7060601@ladisch.de> <51CC9DF9.4050208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id E186B26561E
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2013 20:34:17 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id jk13so2539811bkc.15
 for <alsa-devel@alsa-project.org>; Tue, 09 Jul 2013 11:34:17 -0700 (PDT)
In-Reply-To: <51CC9DF9.4050208@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Clemens,

On Thu, 27 Jun 2013, Clemens Ladisch wrote:

> Instead of reading bInterfaceProtocol from the descriptor whenever it's
> needed, store this value in the audioformat structure.  Besides
> simplifying some code, this will allow us to correctly handle vendor-
> specific devices where the descriptors are marked with other values.

This change introduced a regression for fixed stream quirks, since
fp->protocol is not set in the respective initializer.

It's a trivial fix, I'll send a patch shortly.

Cheers,
Eldad

> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> ---
>  sound/usb/card.h   |  1 +
>  sound/usb/clock.c  |  4 +---
>  sound/usb/format.c | 34 ++++++++++------------------------
>  sound/usb/format.h |  2 +-
>  sound/usb/pcm.c    |  4 +---
>  sound/usb/stream.c |  3 ++-
>  6 files changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index bf2889a..5ecacaa 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -21,6 +21,7 @@ struct audioformat {
>  	unsigned char endpoint;		/* endpoint */
>  	unsigned char ep_attr;		/* endpoint attributes */
>  	unsigned char datainterval;	/* log_2 of data packet interval */
> +	unsigned char protocol;		/* UAC_VERSION_1/2 */
>  	unsigned int maxpacksize;	/* max. packet size */
>  	unsigned int rates;		/* rate bitmasks */
>  	unsigned int rate_min, rate_max;	/* min/max rates */
> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
> index 3a2ce39..86f80c6 100644
> --- a/sound/usb/clock.c
> +++ b/sound/usb/clock.c
> @@ -407,9 +407,7 @@ int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
>  			     struct usb_host_interface *alts,
>  			     struct audioformat *fmt, int rate)
>  {
> -	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
> -
> -	switch (altsd->bInterfaceProtocol) {
> +	switch (fmt->protocol) {
>  	case UAC_VERSION_1:
>  	default:
>  		return set_sample_rate_v1(chip, iface, alts, fmt, rate);
> diff --git a/sound/usb/format.c b/sound/usb/format.c
> index 99299ff..3525231 100644
> --- a/sound/usb/format.c
> +++ b/sound/usb/format.c
> @@ -43,13 +43,12 @@
>   */
>  static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
>  				     struct audioformat *fp,
> -				     unsigned int format, void *_fmt,
> -				     int protocol)
> +				     unsigned int format, void *_fmt)
>  {
>  	int sample_width, sample_bytes;
>  	u64 pcm_formats = 0;
> 
> -	switch (protocol) {
> +	switch (fp->protocol) {
>  	case UAC_VERSION_1:
>  	default: {
>  		struct uac_format_type_i_discrete_descriptor *fmt = _fmt;
> @@ -360,11 +359,8 @@ err:
>   */
>  static int parse_audio_format_i(struct snd_usb_audio *chip,
>  				struct audioformat *fp, unsigned int format,
> -				struct uac_format_type_i_continuous_descriptor *fmt,
> -				struct usb_host_interface *iface)
> +				struct uac_format_type_i_continuous_descriptor *fmt)
>  {
> -	struct usb_interface_descriptor *altsd = get_iface_desc(iface);
> -	int protocol = altsd->bInterfaceProtocol;
>  	snd_pcm_format_t pcm_format;
>  	int ret;
> 
> @@ -387,8 +383,7 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
>  		}
>  		fp->formats = pcm_format_to_bits(pcm_format);
>  	} else {
> -		fp->formats = parse_audio_format_i_type(chip, fp, format,
> -							fmt, protocol);
> +		fp->formats = parse_audio_format_i_type(chip, fp, format, fmt);
>  		if (!fp->formats)
>  			return -EINVAL;
>  	}
> @@ -398,11 +393,8 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
>  	 * proprietary class specific descriptor.
>  	 * audio class v2 uses class specific EP0 range requests for that.
>  	 */
> -	switch (protocol) {
> +	switch (fp->protocol) {
>  	default:
> -		snd_printdd(KERN_WARNING "%d:%u:%d : invalid protocol version %d, assuming v1\n",
> -			   chip->dev->devnum, fp->iface, fp->altsetting, protocol);
> -		/* fall through */
>  	case UAC_VERSION_1:
>  		fp->channels = fmt->bNrChannels;
>  		ret = parse_audio_format_rates_v1(chip, fp, (unsigned char *) fmt, 7);
> @@ -427,12 +419,9 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
>   */
>  static int parse_audio_format_ii(struct snd_usb_audio *chip,
>  				 struct audioformat *fp,
> -				 int format, void *_fmt,
> -				 struct usb_host_interface *iface)
> +				 int format, void *_fmt)
>  {
>  	int brate, framesize, ret;
> -	struct usb_interface_descriptor *altsd = get_iface_desc(iface);
> -	int protocol = altsd->bInterfaceProtocol;
> 
>  	switch (format) {
>  	case UAC_FORMAT_TYPE_II_AC3:
> @@ -452,11 +441,8 @@ static int parse_audio_format_ii(struct snd_usb_audio *chip,
> 
>  	fp->channels = 1;
> 
> -	switch (protocol) {
> +	switch (fp->protocol) {
>  	default:
> -		snd_printdd(KERN_WARNING "%d:%u:%d : invalid protocol version %d, assuming v1\n",
> -			   chip->dev->devnum, fp->iface, fp->altsetting, protocol);
> -		/* fall through */
>  	case UAC_VERSION_1: {
>  		struct uac_format_type_ii_discrete_descriptor *fmt = _fmt;
>  		brate = le16_to_cpu(fmt->wMaxBitRate);
> @@ -483,17 +469,17 @@ static int parse_audio_format_ii(struct snd_usb_audio *chip,
>  int snd_usb_parse_audio_format(struct snd_usb_audio *chip,
>  			       struct audioformat *fp, unsigned int format,
>  			       struct uac_format_type_i_continuous_descriptor *fmt,
> -			       int stream, struct usb_host_interface *iface)
> +			       int stream)
>  {
>  	int err;
> 
>  	switch (fmt->bFormatType) {
>  	case UAC_FORMAT_TYPE_I:
>  	case UAC_FORMAT_TYPE_III:
> -		err = parse_audio_format_i(chip, fp, format, fmt, iface);
> +		err = parse_audio_format_i(chip, fp, format, fmt);
>  		break;
>  	case UAC_FORMAT_TYPE_II:
> -		err = parse_audio_format_ii(chip, fp, format, fmt, iface);
> +		err = parse_audio_format_ii(chip, fp, format, fmt);
>  		break;
>  	default:
>  		snd_printd(KERN_INFO "%d:%u:%d : format type %d is not supported yet\n",
> diff --git a/sound/usb/format.h b/sound/usb/format.h
> index 6f31522..4b8a011 100644
> --- a/sound/usb/format.h
> +++ b/sound/usb/format.h
> @@ -4,6 +4,6 @@
>  int snd_usb_parse_audio_format(struct snd_usb_audio *chip,
>  			       struct audioformat *fp, unsigned int format,
>  			       struct uac_format_type_i_continuous_descriptor *fmt,
> -			       int stream, struct usb_host_interface *iface);
> +			       int stream);
> 
>  #endif /*  __USBAUDIO_FORMAT_H */
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index 93b6e32..776c58c 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -202,13 +202,11 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
>  		       struct usb_host_interface *alts,
>  		       struct audioformat *fmt)
>  {
> -	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
> -
>  	/* if endpoint doesn't have pitch control, bail out */
>  	if (!(fmt->attributes & UAC_EP_CS_ATTR_PITCH_CONTROL))
>  		return 0;
> 
> -	switch (altsd->bInterfaceProtocol) {
> +	switch (fmt->protocol) {
>  	case UAC_VERSION_1:
>  	default:
>  		return init_pitch_v1(chip, iface, alts, fmt);
> diff --git a/sound/usb/stream.c b/sound/usb/stream.c
> index 60d0ff1..df43844 100644
> --- a/sound/usb/stream.c
> +++ b/sound/usb/stream.c
> @@ -635,6 +635,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
>  		fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
>  		fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
>  		fp->datainterval = snd_usb_parse_datainterval(chip, alts);
> +		fp->protocol = protocol;
>  		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
>  		fp->channels = num_channels;
>  		if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
> @@ -676,7 +677,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
>  		}
> 
>  		/* ok, let's parse further... */
> -		if (snd_usb_parse_audio_format(chip, fp, format, fmt, stream, alts) < 0) {
> +		if (snd_usb_parse_audio_format(chip, fp, format, fmt, stream) < 0) {
>  			kfree(fp->rate_table);
>  			kfree(fp->chmap);
>  			kfree(fp);
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
