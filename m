From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] sound: soc: wm8903: Cut gpio_base data
Date: Tue, 18 Sep 2018 17:09:50 -0700
Message-ID: <20180919000950.GA2471@sirena.org.uk>
References: <20180918191233.17178-1-linus.walleij@linaro.org>
 <20180918195220.GX2471@sirena.org.uk>
 <CACRpkdazTEdc2u1u_Z0f_uVUiufzdkz1jYpSziVTPXKhCXxovg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7591347779228958514=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DB0626761D
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2018 02:09:55 +0200 (CEST)
In-Reply-To: <CACRpkdazTEdc2u1u_Z0f_uVUiufzdkz1jYpSziVTPXKhCXxovg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: patches@opensource.cirrus.com, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7591347779228958514==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+9kyDs7IugQ0lHaC"
Content-Disposition: inline


--+9kyDs7IugQ0lHaC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 18, 2018 at 04:51:23PM -0700, Linus Walleij wrote:

> Since there are no boards defining platform data (hence patch 1)
> I assume all users are using device tree and thus dynamic
> GPIO number assignment, so this can go.

> Even if new board files are added they should use machine
> descriptor tables for referencing the individual GPIO chip and
> offset. In this case by the label "wm8903" and local offset.

I tend to worry about breaking out of tree users unless there's an
active reason to do it, is there something coming along - this looked
more like just a cleanup?

--+9kyDs7IugQ0lHaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluhk80ACgkQJNaLcl1U
h9Cb3wf8DbIu8wW2jdmTXQyB1/h8+tQmSqb9aTtVbQFgNXwqhLalyQIO52FdUNvb
sW8nORCel1iE9m2s3Dcaisr2lxPSoM04EftbyfUvjdpBRMH5TAIlru+DR3tp3AFI
fhZuv/8Q0PCqpIeirCQv+yhqmnvM/h8lPoY6miBoAR6lJtqbx4d7N8TfiTA6tmTA
ijfln8F7maFP0HlYQUJrAQvVrj4dzI+4yD+mLcwe4nosmvjzlcY8RF7d8sjh7c0F
rRuBuAWh0aPQCD3M3OhaK2m3dTocTA3dAJ2JyE1sEiNsZQ7OMpgUPwQvYIYAVrXV
0vmmFaLP5D2X0bEUJdTr8oKf4nEcsA==
=eAl3
-----END PGP SIGNATURE-----

--+9kyDs7IugQ0lHaC--

--===============7591347779228958514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7591347779228958514==--
