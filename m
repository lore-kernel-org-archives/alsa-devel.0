From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v3.19
Date: Mon, 8 Dec 2014 15:53:40 +0000
Message-ID: <20141208155340.GC11764@sirena.org.uk>
References: <20141208133826.GA11764@sirena.org.uk>
 <s5h388q9nkw.wl-tiwai@suse.de>
 <20141208154135.GB11764@sirena.org.uk>
 <s5hr3wa87vu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6854393127586576888=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 20B67260453
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 16:54:01 +0100 (CET)
In-Reply-To: <s5hr3wa87vu.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6854393127586576888==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6nSyB+bcl/pT7+kx"
Content-Disposition: inline


--6nSyB+bcl/pT7+kx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2014 at 04:43:17PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > > For fixing a build error with CONFIG_SND_JACK=3Dn
> > >   sound/soc/codecs/ts3a227e.c:223:2: error: implicit declaration of f=
unction =E2=80=98snd_jack_set_key=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]

> > The device probably should be ensuring that the jack detection is
> > enabled - the device doesn't do anything except jack detection.

> Yes.  But apart from that, still it's better to have the corresponding
> dummy function,=20

That's not always the case - there's some interfaces that should really
only be used by something that really has a strong dependency on the
feature, things will go wrong if the driver thinks the feature is doing
something and it isn't.  This one should be fine though.

--6nSyB+bcl/pT7+kx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhcmDAAoJECTWi3JdVIfQaBgH/3Bjr7cIwJgx9QUpmqGQ83a4
MV6/smdBKHRWkIOo3QtIPb1mPxH0X3rBiXeqzWIELPM4iKFRW9C8ggl2jkdvg4sk
3dVgZUZx0QTsCj8wiVnFxq3TCc5zBjndrf5YF8R7Bmz2arSmWEtAJzxldk+k0s+9
NS9neWtVJcQNULvghdmUHO0a2hlmmEUDrTxgWZCEkWg5Lf3/IKU/Q+wkZQUOD6WE
iTlT8tV47gxtvWnP+e/LvOqymTrTFQFWbkBi1TfGns5PZvKlqXcxFYYFXqQHnguI
rKIhc26xF4QiPnFtgM9xI69ihy6OOWJ8/QOloLp5T+8TnIshwpB0Vk1fcIZoekY=
=KNZ/
-----END PGP SIGNATURE-----

--6nSyB+bcl/pT7+kx--

--===============6854393127586576888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6854393127586576888==--
