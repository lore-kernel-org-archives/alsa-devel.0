From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 12:02:04 +0200
Message-ID: <1314093725.3688.12.camel@mattotaupa>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name>
	<CACTFLANnEEV8waJvs7Yw4Y_KdD5CmK565+YBWLqZ8tu8qfGO3w@mail.gmail.com>
	<4E53585D.9050004@amlie.name>
	<CACTFLAP0gMjSShp59Gn1q+aXzPMNGMH05ze_p5S0sEsYwum9JA@mail.gmail.com>
	<1314090212.3688.6.camel@mattotaupa>
	<CACTFLAORzpmfp6=0ywokDP4j8E=zK6nZ1RsHS=JJ3FNL67qJPg@mail.gmail.com>
	<4E537600.2090006@amlie.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1134268299777785985=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 5141524627
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 12:02:08 +0200 (CEST)
In-Reply-To: <4E537600.2090006@amlie.name>
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


--===============1134268299777785985==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ysCaJlXLpiudPNMIb88+"


--=-ysCaJlXLpiudPNMIb88+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 23.08.2011, 11:42 +0200 schrieb Kristian Amlie:
> On 08/23/11 11:22, Daniel Mack wrote:
> > On Tue, Aug 23, 2011 at 11:03 AM, Paul Menzel wrote:

[=E2=80=A6]

> >> =E2=80=A6 and ask the manufacturer about GNU/Linux support.
> >>
> >> Something like, you bought the hardware and expect it to work
> >> everywhere. Additionally they make money by selling the hardware and n=
ot
> >> developing a driver, so they should publish the documentation and even
> >> pay someone =E2=80=93 like Daniel or Clemens ? =E2=80=93 to write the =
support for their
> >> hardware. (Only when they say they do not have any money or something
> >> like that, you can also tell them to donate/provide free hardware for
> >> the developer and a contact address to their M$ Windows developer for
> >> questions.)
> >=20
> > While I agree in general to your points, I think its not worth the
> > effort in this particular case. It's probably very easy to add support
> > for this by just sending one magic usb_control_msg up-front, and it's
> > not complicated to sniff that value. From a customer standpoint,
> > again, I'm sure the manufacturer will just state that they didn't
> > promise any Linux support, and so you can't claim it.
>=20
> Their homepage states "We are currently in the final phase of
> development in making all of our instruments class compliant.", which I
> take to mean that they want their future products to use a standard MIDI
> interface. Right now, Windows 7 and Vista 64 users are also left in the
> dark, so I think they are as eager to fix this as we are, they just
> decided to do it on the hardware side instead of the software side.

Still sending a message to them, would be good in my opinion.

1. It shows them, that people are using their devices on GNU/Linux and
that their decision to make it class compliant is a good move.
2. If they want to change that, maybe they are even releasing the
necessary documentation so you can save your time installing Windows.


Thanks,

Paul

--=-ysCaJlXLpiudPNMIb88+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5TepwACgkQPX1aK2wOHVjCCQCfVAvjD7W01VeHyYXwZa3iR8et
xc8An3LDQ1XW+Zd1aRqFMi0Qbu2eRFkL
=6NNj
-----END PGP SIGNATURE-----

--=-ysCaJlXLpiudPNMIb88+--


--===============1134268299777785985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1134268299777785985==--
