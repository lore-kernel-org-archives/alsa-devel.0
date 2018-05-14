From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v4 2/4] ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
Date: Tue, 15 May 2018 00:00:11 +0300
Message-ID: <CAB=otbSF+Nqo2G-fTGTXX_cOtGmo8KrbSgcHim7EKxUZq4APzw@mail.gmail.com>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk> <20180511152537.32267-3-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511152537.32267-3-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 11, 2018 at 6:25 PM, Jorge Sanjuan
<jorge.sanjuan@codethink.co.uk> wrote:
> bmAtributes offset doesn't exist in the UAC3 CS_EP descriptor.
> Hence, checking for pitch control as if it was UAC2 doesn't make
> any sense. Use the defined UAC3 offsets instead.

This one I already reviewed in v2 and there is no changes in v4,
so still:
Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

By the way, this patch is an independent change and can go
into v4.17-rcXX, if it's not too late for it.

Thanks,
Ruslan

>
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>  sound/usb/stream.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/sound/usb/stream.c b/sound/usb/stream.c
> index 764be07474a8..6b2924533d8d 100644
> --- a/sound/usb/stream.c
> +++ b/sound/usb/stream.c
> @@ -576,7 +576,7 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
>
>         if (protocol == UAC_VERSION_1) {
>                 attributes = csep->bmAttributes;
> -       } else {
> +       } else if (protocol == UAC_VERSION_2) {
>                 struct uac2_iso_endpoint_descriptor *csep2 =
>                         (struct uac2_iso_endpoint_descriptor *) csep;
>
> @@ -585,6 +585,13 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
>                 /* emulate the endpoint attributes of a v1 device */
>                 if (csep2->bmControls & UAC2_CONTROL_PITCH)
>                         attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
> +       } else { /* UAC_VERSION_3 */
> +               struct uac3_iso_endpoint_descriptor *csep3 =
> +                       (struct uac3_iso_endpoint_descriptor *) csep;
> +
> +               /* emulate the endpoint attributes of a v1 device */
> +               if (le32_to_cpu(csep3->bmControls) & UAC2_CONTROL_PITCH)
> +                       attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
>         }
>
>         return attributes;
> --
> 2.11.0
>
