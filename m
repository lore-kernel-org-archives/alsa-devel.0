From: Mandar Joshi <emailmandar@gmail.com>
Subject: Re: S51 usb support
Date: Sat, 23 Oct 2010 15:37:11 +0000
Message-ID: <AANLkTikQG1pyA-ccHs+GvQg9A4SLF6AkoAHeqEEHhH=d@mail.gmail.com>
References: <AANLkTin0_BibT7_+n-ipC8S8q14tfdfj7LTGqHpNweCP@mail.gmail.com>
	<AANLkTinLd+XqGBL6UP8_jZw+6qa6FdzfCqWq7_5m7Sc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 79284244C3
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Oct 2010 17:37:12 +0200 (CEST)
Received: by gyg8 with SMTP id 8so1573615gyg.38
	for <alsa-devel@alsa-project.org>; Sat, 23 Oct 2010 08:37:11 -0700 (PDT)
In-Reply-To: <AANLkTinLd+XqGBL6UP8_jZw+6qa6FdzfCqWq7_5m7Sc8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 22, 2010 at 5:14 AM, Mandar Joshi <emailmandar@gmail.com> wrote:

> Just had to add an entry specific to USB X-Fi to mixer_quirks.c
> I tested this with alsa-driver 1.0.23. Compiled it with debug. You can
> see the received code in /var/log/messages
> 0x0F for anticlockwise rotation. 0x0D for press and 0x10 for clockwise ro=
tation
>
> Of course since there is no hardware mixer, the volume won't change.
> This received code needs to be communicated to userspace. Any Suggestions?
>
> Here is the addition I've tested
>
> diff -rupN alsa-driver-1.0.23.orig/alsa-kernel/usb/mixer_quirks.c
> alsa-driver-1.0.23/alsa-kernel/usb/mixer_quirks.c
> --- alsa-driver-1.0.23.orig/alsa-kernel/usb/mixer_quirks.c =A0 =A0 =A0201=
0-04-16
> 11:10:10.000000000 +0000
> +++ alsa-driver-1.0.23/alsa-kernel/usb/mixer_quirks.c =A0 2010-10-22
> 10:45:22.000000000 +0000
> @@ -61,6 +61,7 @@ static const struct rc_config {
> =A0 =A0 =A0 =A0{ USB_ID(0x041e, 0x3020), 2, 1, 6, 6, =A018, 0x0013 }, /* =
Audigy 2 NX =A0*/
> =A0 =A0 =A0 =A0{ USB_ID(0x041e, 0x3040), 2, 2, 6, 6, =A02, =A00x6e91 }, /=
* Live! 24-bit */
> =A0 =A0 =A0 =A0{ USB_ID(0x041e, 0x3048), 2, 2, 6, 6, =A02, =A00x6e91 }, /=
* Toshiba SB0500 */
> + =A0 =A0 =A0 { USB_ID(0x041e, 0x3042), 0, 1, 1, 1, =A01, =A00x000d }, /*=
 Usb X-Fi */
> =A0};
>
> =A0static void snd_usb_soundblaster_remote_complete(struct urb *urb)
> @@ -75,7 +76,7 @@ static void snd_usb_soundblaster_remote_
> =A0 =A0 =A0 =A0code =3D mixer->rc_buffer[rc->offset];
> =A0 =A0 =A0 =A0if (rc->length =3D=3D 2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0code |=3D mixer->rc_buffer[rc->offset + 1]=
 << 8;
> -
> + =A0 =A0 =A0 snd_printd(KERN_DEBUG "remote code: %02X\n",code);
> =A0 =A0 =A0 =A0/* the Mute button actually changes the mixer control */
> =A0 =A0 =A0 =A0if (code =3D=3D rc->mute_code)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_usb_mixer_notify_id(mixer, rc->mute_mi=
xer_id);
>

This works fine with the alsa_usb driver in lirc.
The code is received is being handled by Creative USB IR receiver
devices config in /etc/lircd.conf
So just adding

{ USB_ID(0x041e, 0x3042), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi */

to mixer_quirks.c is enough to get the volume knob working with Lirc.

Should I submit a patch for that?

-Mandar Joshi
