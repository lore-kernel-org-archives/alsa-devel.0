From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] sound: usb-audio: support for
 Digidesign Mbox 2
Date: Mon, 24 Aug 2009 18:01:34 +0200
Message-ID: <4A92B95E.9090905@ladisch.de>
References: <4A8EBB35.2010604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 76A622439A
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 18:01:22 +0200 (CEST)
In-Reply-To: <4A8EBB35.2010604@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Damien Zammit wrote:
> S/PDIF mode works by setting the required flag
> in usbaudio.c. I think the device can't do both simultaneously,
> since different altsettings are required to set it.

Does the Windows driver allow it?

>              Remaining issues:
>                  1) Double check endianess of 24 bit capture.

This should be apparent even in low-amplitude noise.
Do you have a hex dump of recorded data?

> @@ -2441,6 +2441,12 @@ static int parse_audio_format_i_type(struct snd_usb_audio *chip, struct audiofor
>   				   fp->altsetting, sample_width, sample_bytes);
>   			break;
>   		}
> +
> +                /* Digidesign Mbox 2 workaround:
> +                 * supports S24_3BE BIG ENDIAN  */
> +                if (chip->usb_id == USB_ID(0x0dba, 0x3000))
> +                        pcm_format = SNDRV_PCM_FORMAT_S24_3BE;

Please put this into is_big_endian_format().

> +                /* Digidesign Mbox 2: skip altsets incompatible with device_setup
> +                 */

But there isn't actually a device_setup parameter?

> +mbox2_reboot:
> +                snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
> +                        0x85, 0xc0, 0x0001, 0x0000, &bootresponse, 0x0012, 1000);
> +
> +                if (bootresponse == MBOX2_BOOT_LOADING) {
> +                        snd_printdd("device not ready, resending boot sequence...\n");
> +                        goto mbox2_reboot;
> +                }

This could be made a loop.  And it could run infinitely long; maybe you
should add a timeout.  (How long does it usually need?)

> +                        err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
> +                                &dev->descriptor, sizeof(dev->descriptor));
> +                        config = dev->actconfig;
> +                        if (err < 0) snd_printdd("error usb_get_descriptor: %d\n", err);
> +                        err = usb_reset_configuration(dev);

Does this device change its descriptors without a reset?

> +                         * 80 bb 00 = 24bit mode - S24_3BE
> +                         * 44 ac 00 = 16bit mode?

0xbb80 = 48000
0xac44 = 44100

Do the descriptors change if you change the sample rate?  Or does using
44.1 kHz result in another altsetting?

> +                snd_printdd("unknown bootresponse, ignoring device: %d\n",bootresponse);
> +                return -ENODEV;
> +        }
> +        snd_printdd("Invalid firmware size: %d\n",fwsize);
> +        return -ENODEV;

snd_printdd is for debugging output, but a failure due to a new firmware
revision should be indicated in any case.

> +#ifdef MBOX2_SPDIF_IO

This should be done at runtime.  This would need logic to prevent using
analog/digital at the same time(?), and it might be necessary to
hardcode interfaces and if numbers in find_format().

> +                 * We have to make sure that the USB core looks
> +                 * again at interface 6

Why?


Best regards,
Clemens
