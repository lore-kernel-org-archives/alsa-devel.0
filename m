From: =?iso-8859-1?Q?Alain_Cr=E9tet?= <cretet@digigram.com>
Subject: =?iso-8859-1?Q?RE=A0=3A_=5BAlsa-devel=5D_Sampling_rate_problems_on_a_VXPo?=
 =?iso-8859-1?Q?cket_v2?=
Date: Fri, 12 Dec 2003 09:10:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <08F1D234AF91E540BC1F43889E2A6AA701364315@digiexch.digigram.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Geoffrey Martin <GGM@bang-olufsen.dk>
Cc: pshirkey@boosthardware.com
List-Id: alsa-devel@alsa-project.org


Hi Geoffrey,

You could set all the SPDIF bytes with the iecset command.

Try this, to set the SPDIF Byte 3 at 0000 :
	iecset professional false rate 44100

Best regards

Alain

> ----------
> De : 	Geoffrey Martin
> Envoy=E9 : 	Friday, December 12, 2003 8:43 AM
> =C0 : 	alsa-devel@lists.sourceforge.net
> Objet : 	[Alsa-devel] Sampling rate problems on a VXPocket v2
>=20
>=20
>=20
>=20
>=20
> Hi,
>=20
> I'm using the following:
>       IBM T40 laptop
>       Digigram VXPocket v2
>       RedHat 9
>       Kernel 2.4.22-ac4
>       ALSA drivers 0.9.8
>       vxloader 0.9.7-i686
>=20
> Measurement gear
>       Audio Precision System Two Cascade
>       PrismSound DSA-1
>=20
>=20
> Some of my other gear is having difficulties locking to the S/PDIF =
output
> of the card at 44.1 kHz and I have a suspicion as to why this is
> happening...
>=20
> I have control over the sampling rate of the S/PDIF output of the card =
as I
> would expect, however...
>=20
> In the S/PDIF Channel Status Block information there is a portion of =
Byte 3
> that is used to send the intended sampling rate (selectable between =
three
> values, 32 kHz, 44.1 kHz and 48 kHz, depending on the arrangement of =
bits
> 0-3 in Byte 3. For specific information on this, please see =
Application
> Note AN22REV2 from www.crystal.com). It is also possible, using bit 0 =
of
> Byte 0, to indicate whether the signal is Professional or Consumer =
format.
>=20
> Using my present configuration, I do not appear to have control over =
either
> of these two variables. For example, even when I am sending a 44.1 kHz
> signal at a rate of 44.1 kHz (or close enough... it's actually =
44.0993, -17
> ppm) Byte 3 of the Channel Status Block is saying that the signal is a =
48
> kHz transmission.
>=20
> Are the VXPocket drivers in ALSA capable of changing these values in =
the
> card? The official drivers for Mac OSX allow me to change the =
Pro/Consumer
> flag using an application, and the sampling rate indicator changes
> automatically with the actual sampling rate of the card's output.
>=20
> Cheers
> -geoff
>=20
>=20
>=20
>=20
> ____________________________________________________
> Geoff Martin Ph.D.
> Tonmeister, Bang & Olufsen a/s
> email: ggm@bang-olufsen.dk
> web: www.bang-olufsen.com
> web: www.tonmeister.ca
> phone: +45 96 84 49 54
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20
>=20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
