From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 000/127] ASoC: codec cleanup - codec
 probe/remove
Date: Tue, 9 Aug 2016 12:26:39 +0100
Message-ID: <20160809112639.GJ10383@sirena.org.uk>
References: <87popieek9.wl%kuninori.morimoto.gx@renesas.com>
 <54ffe6bb-9a97-db02-e96b-588630b08468@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5625587932731736925=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BF0D26781B
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 13:26:52 +0200 (CEST)
In-Reply-To: <54ffe6bb-9a97-db02-e96b-588630b08468@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============5625587932731736925==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v6ieFHm5OYqyo94Y"
Content-Disposition: inline


--v6ieFHm5OYqyo94Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2016 at 09:52:48AM +0200, Lars-Peter Clausen wrote:
> On 08/09/2016 06:52 AM, Kuninori Morimoto wrote:

> > Current "codec" has its .probe/.remove, and "component" has it too.
> > codec side is just relayed it to component side.
> > This is the time to cleanup.

> While for the widgets, routes and controls it did not really matter, I do
> not think this is the right approach for probe and remove.

> This is kind of sub-classing a normal design pattern found all throughout
> the kernel. You have a generic callback function and a specialized callba=
ck
> function that takes the type of the object that is being worked on rather
> than the generic object type.

I tend to agree here - look at struct device_driver for example, it has
a bunch of callbacks that are in practice rarely used because each
subsystem defines subsystem specific versions that are going to be much
more appropriate for most drivers.  This sort of refactoring tends to
make more sense when it's done with pure data (as for your previous
series).

>=20
> Especially done as a blind mechanical conversion like you did this is not=
 a
> cleanup. Most probe functions do not actually need to know that they work=
 on
> a CODEC.
>=20
> E.g. you now have very often this kind of code:
>=20
>     struct snd_soc_codec *codec =3D snd_soc_component_to_codec(component);
>     struct tas5086_private *priv =3D snd_soc_codec_get_drvdata(codec);
>=20
> This could easily be replaced with
>=20
>     struct tas5086_private *priv =3D snd_soc_component_get_drvdata(compon=
ent);
>=20
> But again, this indirection is not the problem we currently have with ASoC
> and it's layering. This kind of cleanup should be done as a very final st=
ep
> when all other CODEC specific elements have been removed from the driver.

--v6ieFHm5OYqyo94Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqb3uAAoJECTWi3JdVIfQ5t4H/RWfBeAYumnRknkZzDKjiglf
afVZqW9Jkk6LXwWvPeCNIJRSfvsevjGBA4Nd0R0QuEZ8ofy+ODV+8pUOptjDX81s
NERiI1O85/dXD2iSDIBga77A5/iRHAW3c3TKfIMo1IEcKhVitccylqk+eKXH6TbO
FLC3JjsVfzibTGzm8BNmMeK1pTTz6MxaqoVNXUHCaJ7tTsXaS+KT26qtBU5GYq42
a22AOMFmEqQtsqlIMNm85eG4M4XsawWIkKyAcxJpQEoQM0Le6iOQYjNWGq8hlorG
YH49OfSYHKOiV3byBVShkX1g8PVj2uuDq49/c3/woQ4r5jI1WNmCUgTSfZgC1Kk=
=PhBf
-----END PGP SIGNATURE-----

--v6ieFHm5OYqyo94Y--

--===============5625587932731736925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5625587932731736925==--
