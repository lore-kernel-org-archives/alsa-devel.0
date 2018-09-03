From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2][RFC] ASoC: add for_each_xxx_codec macro
Date: Mon, 3 Sep 2018 14:49:09 +0100
Message-ID: <20180903134909.GL10302@sirena.org.uk>
References: <87lg8jfi94.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3647600251535359351=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CB44267891
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:49:10 +0200 (CEST)
In-Reply-To: <87lg8jfi94.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============3647600251535359351==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XRwESHC7KXlqFpSs"
Content-Disposition: inline


--XRwESHC7KXlqFpSs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 02:12:05AM +0000, Kuninori Morimoto wrote:
>=20
> Hi Mark
>=20
> These are not so important patches.
> But current code is using for loop for dai_link codecs
> and rtd codec_dai, but I think using for_each_xxx
> macro for these can be more readable.
> These patches do it.

These seem like sensible additions - any strong reason for the RFC tag?

--XRwESHC7KXlqFpSs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNO9UACgkQJNaLcl1U
h9DUEgf/fy9UdmkXmT0JEaKdyYyG5W/6dUxetz5L5bb4SlbMTFh2yhYYWIz2rCu2
bVcKaS1fsemN4VfoVVNlwz995gL9Np045Ijayt6ytkUrfKqe7t+gVZJ1FoPUEPZ6
IoOCOuBK2zf/Ip9ITxPZ+i+5+pwQyGGkF9VU3yNkmkyY6xmX0MKXMZYeLfnou8b0
Tt31a1C9XDRSKmWQwWbwKAShTJu10VqDktw7RMWLP+hGiuJTA/oyieom+Meqx3zv
sbYg+a6yJPkpmkT/AvC3pkZ7H2aC/QvDuHQGjxWrssCVWdc3ddk1n7mv9i6H2BlG
0BGqBbQpkfFwab7jWV3+vhfsuCzUog==
=hdYb
-----END PGP SIGNATURE-----

--XRwESHC7KXlqFpSs--

--===============3647600251535359351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3647600251535359351==--
