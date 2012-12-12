From: isaac smith <hunternet93@gmail.com>
Subject: ALSA sound/usb/mixer.c:415 cannot get current value
 for control 2 ch 1: err = -22
Date: Wed, 12 Dec 2012 14:12:19 -0600
Message-ID: <CAFR7B-3jHmE3oVhw0Fvb54JuL6rMqs4bn3ySNAuDGpPVbJZmLw@mail.gmail.com>
References: <CAFR7B-09W6x_fDLpnYNXY8xe6frnHAK-82rd8uPz1U9zF4ZY9w@mail.gmail.com>
 <alpine.LNX.2.00.1212111956370.4365@xoschi>
 <CAFR7B-2p3jKZWhQNv0te0sPeT5uakY0f6VMv1=QEjqCYDkt7JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 58D27260321
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 21:12:20 +0100 (CET)
Received: by mail-we0-f179.google.com with SMTP id r6so510714wey.38
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 12:12:20 -0800 (PST)
In-Reply-To: <CAFR7B-2p3jKZWhQNv0te0sPeT5uakY0f6VMv1=QEjqCYDkt7JQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Success! I applied the patch against kernel 3.6.9 (AMD's Catalyst
driver doesn't support 3.7 yet) and I can now use the snd-usb-audio
driver without it hanging up on the wireless audio. I tested a USB
sound card, it worked perfectly. There's no sign of the HP Wireless
card in ALSA. Thanks a lot! Now I can finally use my slightly decent
speakers and my USB MIDI controller.

On Tue, Dec 11, 2012 at 12:59 PM, Eldad Zack <eldad@fogrefinery.com> wrote:
>
> On Mon, 10 Dec 2012, isaac smith wrote:
>
>> I have the same issue with my HP Envy 15. The sound card in question
>> is an HP Wireless Audio card that only works with HP-branded wireless
>> speakers, so playing to the card produces no output whatsoever, but
>> does hang whatever process tries to access it. I doubt that many
>> people ever use this feature, so unless someone invests the time to
>> get it working I'd like a way to just ignore it completely. I've
>> blacklisted the snd-usb-audio module for now, but I have a USB sound
>> card and a USB MIDI controller that I'd like to be able to use.
>
> Hi Isaac,
>
> Try this patch - applies against 3.7.
>
> Let me know if that works for you and you can successfully use other USB
> audio devices.
>
> Cheers,
> Eldad
>
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index 88d8ceb..be68c66 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -99,6 +99,42 @@
>  },
>
>  /*
> + * Standard Microsystems Corp.
> + * HP Wireless Audio
> + */
> +{
> +       USB_DEVICE(0x0424, 0xb832),
> +       .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> +               .vendor_name = "Standard Microsystems Corp.",
> +               .product_name = "HP Wireless Audio",
> +               .ifnum = QUIRK_ANY_INTERFACE,
> +               .type = QUIRK_COMPOSITE,
> +               .data = (const struct snd_usb_audio_quirk[]) {
> +                       /* Mixer */
> +                       {
> +                               .ifnum = 0,
> +                               .type = QUIRK_IGNORE_INTERFACE,
> +                       },
> +                       /* Playback */
> +                       {
> +                               .ifnum = 1,
> +                               .type = QUIRK_IGNORE_INTERFACE,
> +                       },
> +                       /* Capture */
> +                       {
> +                               .ifnum = 2,
> +                               .type = QUIRK_IGNORE_INTERFACE,
> +                       },
> +                       /* HID Device, maybe standard compliant? */
> +                       {
> +                               /* .ifnum = 3 */
> +                               .ifnum = -1,
> +                       }
> +               }
> +       }
> +},
> +
> +/*
>   * Logitech QuickCam: bDeviceClass is vendor-specific, so generic interface
>   * class matches do not take effect without an explicit ID match.
>   */
>
>
