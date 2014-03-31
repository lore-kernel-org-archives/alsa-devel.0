From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Mon, 31 Mar 2014 19:58:44 +0200
Message-ID: <5339ACD4.5010208@zonque.org>
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
 <52E5CC2E.1010000@gmail.com> <5314EDA1.5040101@zonque.org>
 <53365B9B.2050402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 173D7262618
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 19:58:47 +0200 (CEST)
In-Reply-To: <53365B9B.2050402@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi Damien,

On 03/29/2014 06:35 AM, Damien Zammit wrote:
> A few revisions of this patch have been made.  This patch provides support for usb cards
> which have their streams on multiple endpoints within the same interface.
> In particular, it provides duplex mode support for Digidesign Mbox 1.
> 
> I followed ALSA dev team's suggestion of making it work for N endpoints
> rather than hardcoding it to two, and improved error handling has been provided.
> An extra parameter has been added as requested to the usbaudio quirk struct 'epmulti'
> to give the number of endpoints within a multi interface.
> 

A few style nits below, which you can fix for the next version. Most
important, the error unwinder should be more in-line with other code in
the kernel.

> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 7c57f22..affbced 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -180,6 +180,84 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
>  	return 0;
>  }
>  
> +/*
> + * create N streams for an interface without proper descriptors but with multiple endpoints
> + */
> +static int create_fixed_multi_stream_quirk(struct snd_usb_audio *chip,
> +				     struct usb_interface *iface,
> +				     struct usb_driver *driver,
> +				     const struct snd_usb_audio_quirk *quirk)
> +{
> +	struct audioformat **fp;
> +	struct usb_host_interface *alts = NULL;
> +	int *stream;
> +	int err, i;
> +	unsigned *rate_table = NULL;
> +	int rates_found;
> +	rates_found = 0;
> +
> +	stream = (int*) kmalloc(sizeof(int) * quirk->epmulti, GFP_KERNEL);

No need to cast the result of k[mzc]alloc. Same for other locations below.

> +	if (!stream)
> +		goto err_mem;

err = -ENOMEM;
goto exit_err;

> +	fp = (struct audioformat**) kmalloc(sizeof((const struct audioformat*)quirk->data) * quirk->epmulti, GFP_KERNEL);
> +	if (!(fp))

Extra parenthesis not needed.

> +		goto err_mem;
> +
> +	for (i = 0; i < quirk->epmulti; ++i) {

i++ is prefered if the operation order doesn't matter. It's not
important but a little more common in the kernel.

> +		fp[i] = kmemdup((const struct audioformat*)(quirk->data + i*sizeof(const struct audioformat)), sizeof(*fp[i]), GFP_KERNEL);

You need to do something about these overlong lines, as they're also
quite unparsable for humans. One solution is to pre-calculate the size
into a temporary variable.

> +		if (!(fp[i])) {

Extra parenthesis not needed.

> +			usb_audio_err(chip, "cannot memdup %d\n", i);

err = -ENOMEM;
goto exit_err;

> +			goto err_mem;
> +		}
> +		if (fp[i]->nr_rates > MAX_NR_RATES) {
> +			err = -EINVAL;
> +			goto err_rates;
> +		}
> +		if (fp[i]->nr_rates > 0 && !rates_found) {
> +			rate_table = kmemdup(fp[i]->rate_table,
> +				     sizeof(int) * fp[i]->nr_rates, GFP_KERNEL);
> +			rates_found = 1;

Not sure if I overlook anything, but isn't the extra variable
rates_found redundant here, as can derive the same information by
checking for (rate_table != NULL)?

> +		}
> +		if (!rate_table) {
> +			err = -ENOMEM;
> +			goto err_rates;
> +		}

This check makes more sense directly underneath the kmemdup().

> +		fp[i]->rate_table = rate_table;
> +
> +		stream[i] = (fp[i]->endpoint & USB_DIR_IN)
> +			? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
> +
> +		err = snd_usb_add_audio_stream(chip, stream[i], fp[i]);
> +		if (err < 0)
> +			goto err_ratetable;
> +
> +		if (fp[i]->iface != get_iface_desc(&iface->altsetting[0])->bInterfaceNumber ||
> +		    fp[i]->altset_idx >= iface->num_altsetting) {
> +			err = -EINVAL;
> +			goto err_ratetable;
> +		}
> +		alts = &iface->altsetting[fp[0]->altset_idx];
> +		fp[i]->datainterval = snd_usb_parse_datainterval(chip, alts);
> +		fp[i]->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
> +	}
> +	usb_set_interface(chip->dev, fp[0]->iface, 0);
> +	snd_usb_init_pitch(chip, fp[0]->iface, alts, fp[0]);
> +	snd_usb_init_sample_rate(chip, fp[0]->iface, alts, fp[0], fp[0]->rate_max);
> +	return 0;
> +
> +err_mem:
> +	return -ENOMEM;

You can drop this ...

> +err_ratetable:
> +	kfree(rate_table);
> +err_rates:
> +	for (i = 0; i < quirk->epmulti; ++i)
> +		if(fp[i])
> +			kfree(fp[i]);
> +	kfree(fp);
> +	kfree(stream);

... and place another label here:

exit_err:
> +	return err;
> +}
> +


Thanks,
Daniel
