From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC][PATCH] ASoC: rsnd: add SSIU BUSIF support
Date: Wed, 14 Nov 2018 14:13:38 -0800
Message-ID: <20181114221338.GC2089@sirena.org.uk>
References: <87a7mvswr1.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4485314844007746228=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3496F2677E8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 23:13:47 +0100 (CET)
In-Reply-To: <87a7mvswr1.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jiada Wang <jiada_wang@mentor.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4485314844007746228==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SfqqZ2zU93BLT28p"
Content-Disposition: inline


--SfqqZ2zU93BLT28p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 07:54:30AM +0000, Kuninori Morimoto wrote:

> BUSIF is handled by SSIU instead of SSI anymore.
> Thus, its settings no longer needed on SSI node on DT.
> This patch removes its settings from Document, but driver is still
> keeping compatibility. Thus, old DT style is still working.
> But, to avoid confusing, it doesn't indicate old compatiblity things on
> Document. New SoC should have SSIU on DT from this patch.

It's better to move these to a deprecated section rather than deleting
them entirely, that way someone working on the driver or looking at a DT
for a board in future can see what the old binding did more easily.

> > Jiada
>=20
> This patch supports BUSIF, you can select it on DT.
> Is this style OK for you ?
> For example
>=20
> 	playback =3D <&src0 &dvc0 &ssiu02 &ssi0>;
> 	                        ~~~~~~~
>=20
> It is keeping compatiblity. no <&ssiu> is still OK

Any news here?

This looks basically fine to me.

--SfqqZ2zU93BLT28p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvsnhEACgkQJNaLcl1U
h9AkMwf+OPauITXmpUVib+x9MytcXc6LzYE8YxH0AZ2P256m3tIqUgf46FfDQQdS
5IqSLwHVWQhxGYtzrc5kw5Qdny8jLHGbxPQ2klYsxgwv9ZjDQA2CLQIQS4UHe/sF
lUGaHe70rOnIG6XRPbwRf/+lyTPrLMIA8rAxfeVP0zZKYr2kNuMaW91kNQzeb893
WTlGthKN6+cmE3FGTkNZHLf6/TjRZBnEBuiHN2fID+MljWsjDrwtOp9dNmuVo71J
70dOmk/+HuVsC83eHoXTiyPHT6BtY2JRd4WnCMIQti7Bt5S+1wik9QurNQk4w2pP
3f7UNZLQoUNsRUQlN4o71mu3v9Mfzg==
=K+tb
-----END PGP SIGNATURE-----

--SfqqZ2zU93BLT28p--

--===============4485314844007746228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4485314844007746228==--
