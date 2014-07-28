From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 17:36:45 +0100
Message-ID: <20140728163645.GA17528@sirena.org.uk>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
 <53D5ECA7.5090106@metafoo.de>
 <20140728112055.GM17528@sirena.org.uk>
 <CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>
 <CAKON4Owhhw6WvJBvZC6KYpS+rtvbPymAqEb1+4iZ=e6OokGeng@mail.gmail.com>
 <20140728162715.GZ17528@sirena.org.uk>
 <CAKON4OzrDeEbjzAgpB7f3NYcXGegUnF2+Hb1QZeZYKwztctkvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7476607882874893034=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F2D9265132
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 18:36:52 +0200 (CEST)
In-Reply-To: <CAKON4OzrDeEbjzAgpB7f3NYcXGegUnF2+Hb1QZeZYKwztctkvg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7476607882874893034==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtbYPoC95O61holF"
Content-Disposition: inline


--vtbYPoC95O61holF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 28, 2014 at 12:33:57PM -0400, jonsmirl@gmail.com wrote:

> So what do you want the device tree to look like?
> Example with no external amp.
> Example with external amp.

To repeat what I said in a previous mail:

| Just the same as any other card - allow a phandle to be provided to the
| amplifier.

| Assuming "jack populations" are DAPM links just do it the same way as
| anything else and use snd_soc_of_parse_audio_routing().

--vtbYPoC95O61holF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1nwaAAoJELSic+t+oim9FIkP/RLcr+k6B2Ax4roOogUVgw+K
uPQP6VxuTdhmu6RsaIsexF5iFa2iU52lH8FqClyTYS5oYi48wgG8c/pBCaQ3CjRo
NWB4YRp015MHtTy0uQQS3ErTZtmu3yXqkrEkn6UuntBVKxKfftGaZZP1oq1gkZ1u
MZT8G2LD6CDozdrP8MU4Kq6GyEi32soS0RfAdywDFV7qeefbUqwUucuDD93Z+DUn
EQmOfUfclHcfP1HZuEatf8rcbKRFlcgzy+SeCyeO8uPpNd6stG4EJqiAQ+UVKRgj
ogZowHGY5YHlm1ywhE/J7+b+g0SDU094X1rheC+VAUDmeyRU0kgGW1fGB6i3W5XC
lJKDySirwRDzCwhdbzCdQpjho1ZssQkDdq/RacRVE6eoUFyOyDI9Uq8RkJXsSmHx
0CaX0lpu/sJw2UD77vZHpcJiDTUXZLnY2+qNtRFqHqL90g3eX0ogxmpbbFc5Y6fi
z+BhMX9MF1qlmdpSs4h/8khWl7yYZ1J9etsLB05LamAv8xPfQmngJttmQT8C6vCT
f014n5072paZO20DDVO1OsLi9KWFxSXJx690BOvkUJcoNmwJBhbNTFIPXwV8ic3z
lpq4A2XgKPqKn3bOpceq2/bX5Z1WZTwv9ugq2AMUuDWxKG5nQlP1oRSm7fMnE0oX
Ma7aqKZ5p0duPz5X2DE/
=qdzb
-----END PGP SIGNATURE-----

--vtbYPoC95O61holF--

--===============7476607882874893034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7476607882874893034==--
