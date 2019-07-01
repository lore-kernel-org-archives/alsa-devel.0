From: nick83ola <nick83ola@gmail.com>
Subject: Re: [BUG] Line6 Helix / X Stomp:
 parse_audio_format_rates_v2v3(): unable to retrieve number of sample rates
 (clock 16)
Date: Mon, 1 Jul 2019 12:55:34 +0100
Message-ID: <CABPh3UN-P4kZY3nYqDvi2-3eMGm3_BCGUPzhHq2iWRpkk196kg@mail.gmail.com>
References: <CABPh3UNCZhssHLmZF2paU4EKOK1WKScbC7Vw=uGfJn7WUeXO3Q@mail.gmail.com>
 <8fd64743-fc0e-a536-2099-a0e0adbe83d4@jensverwiebe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76490F80CC4
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2019 13:55:46 +0200 (CEST)
Received: by mail-lj1-x242.google.com with SMTP id v24so12843664ljg.13
 for <alsa-devel@alsa-project.org>; Mon, 01 Jul 2019 04:55:46 -0700 (PDT)
In-Reply-To: <8fd64743-fc0e-a536-2099-a0e0adbe83d4@jensverwiebe.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jens Verwiebe <info@jensverwiebe.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Jun 2019 at 17:22, Jens Verwiebe <info@jensverwiebe.de> wrote:
>
> Hi Nick
>
> This looks like the same hurdle i once had with Helix.
>
> Imho you should first try my patch to format.c and extend the
> vendor/model clause to your device:
>
> diff --git a/sound/usb/format.c b/sound/usb/format.c
> index 2c44386..1c0107d 100644
> --- a/sound/usb/format.c
> +++ b/sound/usb/format.c
> @@ -298,6 +298,20 @@ static int parse_audio_format_rates_v2(struct
> snd_usb_audio *chip,
>           goto err;
>       }
>
> +    /*
> +    * Line6 HELIX does not respond to sample rate
> +    * query requests. The only valid rate is 48000.
> +    */
> +    if (chip->usb_id == USB_ID(0x0e41, 0x4244)) {
> +        fp->nr_rates = 1;
> +            fp->rate_min = 48000;
> +            fp->rate_max = 48000;
> +            fp->rates = SNDRV_PCM_RATE_48000;
> +            fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
> +            fp->rate_table[0] = 48000;
> +            return 0;
> +        }
> +
>       /* get the number of sample rates first by only fetching 2 bytes */
>       ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
>                     USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
>

I can confirm that your patch get the device recognized in kernel 5.2
(I modfied it a bit).
I'll work on this a bit and try to submit a patch to alsa to at least
having the device available.
Regarding the second part ( get_usb_high_speed_rate(rate + 5);)
I think I have to debug it better because I don't think it can be
accepted upstream.
(maybe someone from the mailing list can help?)

> I personally encountered still slight pops from time to time which i
> "healed" with an ugly second patch:
>
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index c90607e..026095a 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -878,6 +878,8 @@ int snd_usb_endpoint_set_params(struct
> snd_usb_endpoint *ep,
>
>       if (snd_usb_get_speed(ep->chip->dev) == USB_SPEED_FULL)
>           ep->freqn = get_usb_full_speed_rate(rate);
> +    else if (USB_ID(0x0e41, 0x4244))
> +        ep->freqn = get_usb_high_speed_rate(rate + 5); // ugly helix hack
>       else
>           ep->freqn = get_usb_high_speed_rate(rate);
>
>
> I still never could get the Line6 device to really follow the
> syncadaption in 16.16 format.
>
> I tried all kinda voodoo like endpoint redirection ( like axe fx needs )
> to no avail. Perhaps you have better ideas.
>
> I would be very interested in getting Line6 devices usb-compliant mode
> working 100 % reliable.
>
> The dream would be to have all samplerates. Btw:: i have sniffed data
> from Helix connected to a windows machine,
>
> ioreg data from helix connected to an OSX(macOS)  machine and even a bit
> experimented with retdec on the windows drivers ;).
>
> This for now, 'am just on the jump to the Hamburg Linux Group :)
>
> Lets stay in contact about this stuff.
>
> Cheers ... Jens
>
>
> Am 27.06.19 um 09:45 schrieb nick83ola:
> > Hi all,
> > I just purchased an HX stomp and when I connect to linux I get the
> > following error message:
> >
> >      [  322.404503] usb 1-6: new high-speed USB device number 13 using xhci_hcd
> >      [  322.531804] usb 1-6: New USB device found, idVendor=0e41,
> > idProduct=4246, bcdDevice= 2.00
> >      [  322.531806] usb 1-6: New USB device strings: Mfr=1, Product=3,
> > SerialNumber=2
> >      [  322.531806] usb 1-6: Product: HX Stomp
> >      [  322.531807] usb 1-6: Manufacturer: LINE 6
> >      [  322.531808] usb 1-6: SerialNumber:    3021888
> >      [  322.535789] usb 1-6: parse_audio_format_rates_v2v3(): unable to
> > retrieve number of sample rates (clock 16)
> >      [  322.535907] usb 1-6: parse_audio_format_rates_v2v3(): unable to
> > retrieve number of sample rates (clock 16)
> >
> > I have some kernel development experience but not a lot with usb so
> > can someone point me where to start looking?
> >
> > there was a previous discussion on the mailing list related to this by
> > Jens Verwiebe (and other request for help).
> > Here are the relevant patches/discussion
> >
> >      https://www.spinics.net/lists/alsa-devel/msg71459.html
> >      https://patchwork.kernel.org/patch/10113121/
> >
> > If someone can help me I have an HX stomp here and time to do some debugging.
> >
> > Also if someone from Line6 is listening would be helpful to have some hints.
> >
> > Cheers
> > Nicola Lunghi
> >
> --
>
> Jens Verwiebe
