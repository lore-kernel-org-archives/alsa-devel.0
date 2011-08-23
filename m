From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 11:03:24 +0200
Message-ID: <1314090212.3688.6.camel@mattotaupa>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name>
	<CACTFLANnEEV8waJvs7Yw4Y_KdD5CmK565+YBWLqZ8tu8qfGO3w@mail.gmail.com>
	<4E53585D.9050004@amlie.name>
	<CACTFLAP0gMjSShp59Gn1q+aXzPMNGMH05ze_p5S0sEsYwum9JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0783020249365596691=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 015FD103903
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 11:03:36 +0200 (CEST)
In-Reply-To: <CACTFLAP0gMjSShp59Gn1q+aXzPMNGMH05ze_p5S0sEsYwum9JA@mail.gmail.com>
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
Cc: Greg KH <greg@kroah.com>
List-Id: alsa-devel@alsa-project.org


--===============0783020249365596691==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-SnulDVB2jpNelgr/eUst"


--=-SnulDVB2jpNelgr/eUst
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 23.08.2011, 10:43 +0200 schrieb Daniel Mack:
> On Tue, Aug 23, 2011 at 9:35 AM, Kristian Amlie <kristian@amlie.name> wro=
te:
> > On 08/22/11 13:49, Daniel Mack wrote:
> >> It doesn't seem to be using a standard MIDI interface, but there's a
> >> chance that it accepts raw MIDI byte streams. Can you check the patch
> >> below?
> >
> > With that patch, the device shows up, but aseqdump does not report any
> > MIDI events after connecting to it.
> >
> > The Windows drivers are called "USB Serial Converter" and "USB Serial
> > Port", so maybe it's all wrapped in a different protocol. Does that nam=
e
> > ring a bell?
>=20
> That's possible, and it should be easy to support these type of
> devices in ALSA. However, some logic is neccessary to configure the
> hardware to its correct baud rate and hardware protocol. The easiest
> way to determine the setup sequence is certainly to sniff the Windows
> driver communication with some tool like usbsnoop. Can you give that a
> try?

=E2=80=A6 and ask the manufacturer about GNU/Linux support.

Something like, you bought the hardware and expect it to work
everywhere. Additionally they make money by selling the hardware and not
developing a driver, so they should publish the documentation and even
pay someone =E2=80=93 like Daniel or Clemens ? =E2=80=93 to write the suppo=
rt for their
hardware. (Only when they say they do not have any money or something
like that, you can also tell them to donate/provide free hardware for
the developer and a contact address to their M$ Windows developer for
questions.)

I am putting Greg into CC for possible sample texts or insights/best
practices on how to approach manufacturers.


Thanks,

Paul

--=-SnulDVB2jpNelgr/eUst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5TbNwACgkQPX1aK2wOHVjzDQCfW3qrNMhMdlJx5g+KWYzitbef
4wYAnid2/5ykLHjCWxL/jWj7ogYI0Jmf
=naLi
-----END PGP SIGNATURE-----

--=-SnulDVB2jpNelgr/eUst--


--===============0783020249365596691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0783020249365596691==--
