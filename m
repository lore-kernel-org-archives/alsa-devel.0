From: Eric Shattow <lucent@gmail.com>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Thu, 29 Sep 2005 08:04:03 -0500
Message-ID: <2c746f6205092906046546188c@mail.gmail.com>
References: <2c746f620509271752528aa59a@mail.gmail.com>
	 <Pine.HPX.4.33n.0509281356340.3203-100000@studcom.urz.uni-halle.de>
Reply-To: Eric Shattow <lucent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0509281356340.3203-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 9/28/05, Clemens Ladisch <clemens@ladisch.de> wrote:
> Eric Shattow wrote:
> > I have a Hercules PC DJ Console (Windows Edition) that I would like to
> > work with ALSA. The device outputs some sound at 48kHz after asoundrc
> > configuration,
>
> It should just work without an .asoundrc.  What did you put in there?
>
> > MIDI is not functional.
>
> Please try the patch below (against the current CVS).
> How many ports does it have? -- Eight is probably too much ... :-)
>
>
> HTH
> Clemens
>
>
> --- alsa-kernel/usb/usbquirks.h 26 Sep 2005 07:55:01 -0000      1.54
> +++ alsa-kernel/usb/usbquirks.h 28 Sep 2005 11:58:56 -0000
> @@ -1066,6 +1066,21 @@
>         /* TODO: add Edirol UM-3 support */
>         /* TODO: add Edirol MD-P1 support */
>
> +/* Guillemot devices */
> +{
> +       USB_DEVICE_VENDOR_SPEC(0x06f8, 0xb000),
> +       .driver_info =3D (unsigned long) & (const snd_usb_audio_quirk_t) =
{
> +               .vendor_name =3D "Hercules",
> +               .product_name =3D "DJ Console",
> +               .ifnum =3D 4,
> +               .type =3D QUIRK_MIDI_FIXED_ENDPOINT,
> +               .data =3D & (const snd_usb_midi_endpoint_info_t) {
> +                       .out_cables =3D 0x00ff,
> +                       .in_cables  =3D 0x00ff
> +               }
> +       }
> +},
> +
>  /* Midiman/M-Audio devices */
>  {
>         USB_DEVICE_VENDOR_SPEC(0x0763, 0x1002),
>
>

I tried the above patch, and applied it to debian alsa-source package
1.0.9b4, and now the DJ Console is recognized. I've changed some of
the hardware around since my last post.

baker:/usr/src# amidi -l
Device    Name
hw:0,0    M Audio Delta 1010 MIDI
hw:2,0,0  DJ Console MIDI 1
hw:2,0,1  DJ Console MIDI 2
hw:2,0,2  DJ Console MIDI 3
hw:2,0,3  DJ Console MIDI 4
hw:2,0,4  DJ Console MIDI 5
hw:2,0,5  DJ Console MIDI 6
hw:2,0,6  DJ Console MIDI 7
hw:2,0,7  DJ Console MIDI 8

However, using amidi -d -p hw:2,0,n  does not yield any output when
moving the controls. I also tried 'amidi -p virtual -d' and to connect
all the outputs that show up in the alsa sequencer from the DJ Console
to this virtual device, and no output.

Isn't that strange? Maybe this is due to me not using cvs code, I will
have to make some time soon and try it. Anyways, thanks for the patch.
It is giving me some hope this device will eventually work :)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
