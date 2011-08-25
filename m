From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] Added support for Starr Labs USB MIDI
	devices.
Date: Thu, 25 Aug 2011 14:20:34 +0200
Message-ID: <CACTFLAMPXVVfODASqWB8RD0HuKqh5L8eJ9LmY=fgLkLwDKwW=w@mail.gmail.com>
References: <4E5631E1.7050400@amlie.name>
	<1314272107-15239-1-git-send-email-kristian@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3426D24512
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 14:20:41 +0200 (CEST)
Received: by gxk1 with SMTP id 1so1708344gxk.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2011 05:20:34 -0700 (PDT)
In-Reply-To: <1314272107-15239-1-git-send-email-kristian@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Very good :) Just one minor thing below, and you can add my acked-by.

Remember to re-send the patch with your Signed-off-by: line, and see
Documentation/SubmittingPatches for the details.


Daniel


On Thu, Aug 25, 2011 at 1:35 PM, Kristian Amlie <kristian@amlie.name> wrote:
> Based on a patch by Daniel Mack.
> ---
> =A0sound/usb/midi.c =A0 =A0 =A0 =A0 | =A0 29 +++++++++++++++++++++++++++++
> =A0sound/usb/quirks-table.h | =A0 11 +++++++++++
> =A0sound/usb/quirks.c =A0 =A0 =A0 | =A0 =A01 +
> =A0sound/usb/usbaudio.h =A0 =A0 | =A0 =A01 +
> =A04 files changed, 42 insertions(+), 0 deletions(-)
>
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index f928910..ec7a799 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -816,6 +816,18 @@ static struct usb_protocol_ops snd_usbmidi_raw_ops =
=3D {
> =A0 =A0 =A0 =A0.output =3D snd_usbmidi_raw_output,
> =A0};
>
> +static void snd_usbmidi_ftdi_input(struct snd_usb_midi_in_endpoint* ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint=
8_t* buffer, int buffer_length)
> +{
> + =A0 =A0 =A0 if (buffer_length > 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_usbmidi_input_data(ep, 0, buffer + 2, b=
uffer_length - 2);
> +}
> +
> +static struct usb_protocol_ops snd_usbmidi_ftdi_ops =3D {
> + =A0 =A0 =A0 .input =3D snd_usbmidi_ftdi_input,
> + =A0 =A0 =A0 .output =3D snd_usbmidi_raw_output,
> +};
> +
> =A0static void snd_usbmidi_us122l_input(struct snd_usb_midi_in_endpoint *=
ep,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u=
int8_t *buffer, int buffer_length)
> =A0{
> @@ -2073,6 +2085,13 @@ void snd_usbmidi_input_start(struct list_head* p)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_usbmidi_input_start_ep(umidi->endpoint=
s[i].in);
> =A0}
>
> +static int snd_usbmidi_ftdi_command(struct snd_usb_midi *umidi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 =
command, u16 value, u16 index)
> +{
> + =A0 =A0 =A0 return usb_control_msg(umidi->dev, usb_sndctrlpipe(umidi->d=
ev, 0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 command, 0x=
40, value, index, NULL, 0, 1000);
> +}

With only one use of this function, I'd say you can inline the code.

> +
> =A0/*
> =A0* Creates and registers everything needed for a MIDI streaming interfa=
ce.
> =A0*/
> @@ -2163,6 +2182,16 @@ int snd_usbmidi_create(struct snd_card *card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* endpoint 1 is input-only */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0endpoints[1].out_cables =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 case QUIRK_MIDI_FTDI:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 umidi->usb_protocol_ops =3D &snd_usbmidi_ft=
di_ops;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set baud rate */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D snd_usbmidi_ftdi_command(umidi, 3, =
0x60, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D snd_usbmidi_detect_per_port_endpoin=
ts(umidi, endpoints);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_printd(KERN_ERR "invalid quirk type %d=
\n", quirk->type);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -ENXIO;
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index 0b2ae8e..68ca427 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -39,6 +39,17 @@
> =A0 =A0 =A0 =A0.idProduct =3D prod, \
> =A0 =A0 =A0 =A0.bInterfaceClass =3D USB_CLASS_VENDOR_SPEC
>
> +/* Starr Labs MIDI USB device */
> +{
> + =A0 =A0 =A0 USB_DEVICE(0x0403, 0xb8d8),
> + =A0 =A0 =A0 .driver_info =3D (unsigned long) & (const struct snd_usb_au=
dio_quirk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* .vendor_name =3D "STARR LABS", */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* .product_name =3D "Starr Labs MIDI USB d=
evice", */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ifnum =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D QUIRK_MIDI_FTDI
> + =A0 =A0 =A0 }
> +},
> +
> =A0/* Creative/Toshiba Multimedia Center SB-0500 */
> =A0{
> =A0 =A0 =A0 =A0USB_DEVICE(0x041e, 0x3048),
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 090e193..65591df 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -306,6 +306,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[QUIRK_MIDI_EMAGIC] =3D create_any_midi_qu=
irk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[QUIRK_MIDI_CME] =3D create_any_midi_quirk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[QUIRK_MIDI_AKAI] =3D create_any_midi_quir=
k,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [QUIRK_MIDI_FTDI] =3D create_any_midi_quirk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[QUIRK_AUDIO_STANDARD_INTERFACE] =3D creat=
e_standard_audio_quirk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[QUIRK_AUDIO_FIXED_ENDPOINT] =3D create_fi=
xed_stream_quirk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[QUIRK_AUDIO_EDIROL_UAXX] =3D create_uaxx_=
quirk,
> diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
> index 1e79986..3e2b035 100644
> --- a/sound/usb/usbaudio.h
> +++ b/sound/usb/usbaudio.h
> @@ -80,6 +80,7 @@ enum quirk_type {
> =A0 =A0 =A0 =A0QUIRK_MIDI_CME,
> =A0 =A0 =A0 =A0QUIRK_MIDI_AKAI,
> =A0 =A0 =A0 =A0QUIRK_MIDI_US122L,
> + =A0 =A0 =A0 QUIRK_MIDI_FTDI,
> =A0 =A0 =A0 =A0QUIRK_AUDIO_STANDARD_INTERFACE,
> =A0 =A0 =A0 =A0QUIRK_AUDIO_FIXED_ENDPOINT,
> =A0 =A0 =A0 =A0QUIRK_AUDIO_EDIROL_UAXX,
> --
> 1.7.3.4
>
>
