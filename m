From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2] ALSA: usb: Work around CM6631 sample
 rate change bug
Date: Tue, 5 Mar 2013 07:02:58 +0100
Message-ID: <CAOf5uwmf4L0bonZ=gJD+NkTpBY5=gL20JnVCfAP-AGskWo_Fkg@mail.gmail.com>
References: <20130304223937.GI4452@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f173.google.com (mail-ia0-f173.google.com
 [209.85.210.173])
 by alsa0.perex.cz (Postfix) with ESMTP id A1EED2651A0
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 07:02:59 +0100 (CET)
Received: by mail-ia0-f173.google.com with SMTP id h37so5715578iak.18
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2013 22:02:58 -0800 (PST)
In-Reply-To: <20130304223937.GI4452@pvv.ntnu.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torstein Hegge <hegge@resisty.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

Some comments:

On 4 Mar 2013 23:40, "Torstein Hegge" <hegge@resisty.net> wrote:
>
> The C-Media CM6631 USB-to-S/PDIF receiver doesn't respond to changes in
> sample rate while the interface is active.
>
> Reset the interface after setting the sampling frequency on sample rate
> changes, to ensure that the sample rate set by snd_usb_init_sample_rate()
is
> used. Otherwise, the device will try to use the sample rate of the
previous
> stream, causing distorted sound on sample rate changes.
>
> Signed-off-by: Torstein Hegge <hegge@resisty.net>
> ---
>  sound/usb/clock.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
> index 5e634a2..d12a9c4 100644
> --- a/sound/usb/clock.c
> +++ b/sound/usb/clock.c
> @@ -255,6 +255,7 @@ static int set_sample_rate_v2(struct snd_usb_audio
*chip, int iface,
>         unsigned char data[4];
>         int err, crate;
>         int clock = snd_usb_clock_find_source(chip, fmt->clock);
> +       unsigned int previous_rate;
>

crate and previous_rate are different types.
Why don't call it prate or change both name?

>         if (clock < 0)
>                 return clock;
> @@ -266,6 +267,18 @@ static int set_sample_rate_v2(struct snd_usb_audio
*chip, int iface,
>                 return -ENXIO;
>         }
>
> +       if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
UAC2_CS_CUR,

Is it more clear to assign it and then test?

> +                                  USB_TYPE_CLASS | USB_RECIP_INTERFACE |
USB_DIR_IN,
> +                                  UAC2_CS_CONTROL_SAM_FREQ << 8,
> +                                  snd_usb_ctrl_intf(chip) | (clock << 8),
> +                                  data, sizeof(data))) < 0) {
> +               snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq
(v2)\n",
> +                          dev->devnum, iface, fmt->altsetting);
> +               return err;
> +       }
> +
> +       previous_rate = data[0] | (data[1] << 8) | (data[2] << 16) |
(data[3] << 24);
> +
>         data[0] = rate;
>         data[1] = rate >> 8;
>         data[2] = rate >> 16;
> @@ -294,6 +307,18 @@ static int set_sample_rate_v2(struct snd_usb_audio
*chip, int iface,
>         if (crate != rate)
>                 snd_printd(KERN_WARNING "current rate %d is different
from the runtime rate %d\n", crate, rate);
>
> +       /* Some devices doesn't respond to sample rate changes while the
> +        * interface is active. */
> +       if (crate != previous_rate) {
> +               switch (chip->usb_id) {
> +               case USB_ID(0x0d8c, 0x0304): /* C-Media - Schiit USB */
> +               case USB_ID(0x0d8c, 0x0309): /* C-Media CM6631 */
> +                       usb_set_interface(dev, iface, 0);
> +                       usb_set_interface(dev, iface, fmt->altsetting);
> +                       break;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 1.7.10.4
>
>

Michael
_______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
