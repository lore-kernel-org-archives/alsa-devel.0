From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: USB-MIDI: Use common error handling
 code in __snd_usbmidi_create()
Date: Wed, 23 Aug 2017 12:49:16 +0200
Message-ID: <e78ed11b-3456-d093-957f-5e9ab702b18c@ladisch.de>
References: <328d3b62-2113-e51a-5d66-79d515de3179@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 19AF82664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 12:49:23 +0200 (CEST)
In-Reply-To: <328d3b62-2113-e51a-5d66-79d515de3179@users.sourceforge.net>
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
To: Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

SF Markus Elfring wrote:
> Add jump targets so that a bit of exception handling can be better reused
> at the end of this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  sound/usb/midi.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index a35f41467237..bd9d02268724 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -2435,10 +2435,8 @@ int __snd_usbmidi_create(struct snd_card *card,
>  		err = -ENXIO;
>  		break;
>  	}
> -	if (err < 0) {
> -		kfree(umidi);
> -		return err;
> -	}
> +	if (err < 0)
> +		goto free_midi;
>
>  	/* create rawmidi device */
>  	out_ports = 0;
> @@ -2448,23 +2446,25 @@ int __snd_usbmidi_create(struct snd_card *card,
>  		in_ports += hweight16(endpoints[i].in_cables);
>  	}
>  	err = snd_usbmidi_create_rawmidi(umidi, out_ports, in_ports);
> -	if (err < 0) {
> -		kfree(umidi);
> -		return err;
> -	}
> +	if (err < 0)
> +		goto free_midi;
>
>  	/* create endpoint/port structures */
>  	if (quirk && quirk->type == QUIRK_MIDI_MIDIMAN)
>  		err = snd_usbmidi_create_endpoints_midiman(umidi, &endpoints[0]);
>  	else
>  		err = snd_usbmidi_create_endpoints(umidi, endpoints);
> -	if (err < 0) {
> -		return err;
> -	}
> +	if (err < 0)
> +		goto exit;
>
>  	usb_autopm_get_interface_no_resume(umidi->iface);
>
>  	list_add_tail(&umidi->list, midi_list);
>  	return 0;
> +
> +free_midi:
> +	kfree(umidi);
> +exit:
> +	return err;
>  }
>  EXPORT_SYMBOL(__snd_usbmidi_create);
>
