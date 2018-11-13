From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: cs35l36: Add device tree
 documentation for CS35L36
Date: Tue, 13 Nov 2018 11:30:19 -0800
Message-ID: <20181113193018.GJ2089@sirena.org.uk>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
 <1542134957-2395-2-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1532087169644537139=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 44E2026751A
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 20:30:33 +0100 (CET)
In-Reply-To: <1542134957-2395-2-git-send-email-james.schulman@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com, robh+dt@kernel.org, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============1532087169644537139==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kr14OxHsRwZHHqxS"
Content-Disposition: inline


--kr14OxHsRwZHHqxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 12:49:17PM -0600, James Schulman wrote:

> +  - cirrus,amp-gain-zc : Boolean to determine if to use Amplifier gain-c=
hange
> +  zero-cross

Why is this a DT setting and not either enabled unconditionally or set
=66rom userspace (many devices do the latter)?  It seems like more of a
use case dependent setting than a feature of the board.

> +  - cirrus,ldm-mode-select : Amplifier level-dependent muting enable mod=
e selection.
> +  Configures whether the amplifier level-dependent muting is enabled for=
 the various
> +  blocks when the selected audio source has been below the AMP_LDM_THLD =
for a period
> +  of time configured by AMP_LDM_DELAY. Any and all bits can be set.

Might the user not want to set these at runtime?

> +  - cirrus,pdm-ldm-exit : Boolean : Amplifier PDM mode digital volume ra=
mp enable.
> +  When AMP_PDM_MODE =3D 1 controls whether the digital volume soft ramp =
is enabled
> +  or disabled when exiting a level-dependent muted condition. The AMP_RA=
MP_PDM_DN
> +  control is used to control desired ramp rate.

This also seems like a use case dependent thing.

> +  - cirrus,imon-pol-inv : Boolean to determine Amplifier will invert the
> +  polarity of outbound IMON feedback data
> +
> +  - cirrus,vmon-pol-inv : Boolean to determine Amplifier will invert the
> +  polarity of outbound VMON feedback data

Why might anyone ever want to set these?

> +  - cirrus,pdm-channel-select : PDM Channel select.
> +  0x00 (Default) : Selects Channel A data when the PDM audio input is se=
lected.
> +  0x01 : Selects Channel B data when the PDM audio input is selected

This looks like routing control, shouldn't it be in DAPM?

--kr14OxHsRwZHHqxS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrJkoACgkQJNaLcl1U
h9CgFwf7BBDwUi430NzYkdX1pJPAqmop2r564GkHz8dI32n0OY8LxudGoa+AHGCt
NAaLKo8eXK05v0LJbYhRXeuBtjPCQxvudw9QbwUitjRdnHm/BlLLaJ/xmwCuUJgf
Pljqn/mCY/yvAUrj92VIrtWT3N98o42kldjZXHlZ5uZkmp7WuVegqqDYJ2nqC9DU
j0sO88I9aZJ+uC6nkOIngo0V+a3m81KiQG0JgB1Xhc44q5Bte/r7sLzM9sjMq7+a
eTItIKBdng1wz2e7xl2ulf2h3lSEYT7AUmfqI/rwRalSRrzS/cVyJI3pWkLBcVG2
OgBGQNGnI+ho2Oo55Vdbge8nRmNriQ==
=oPxq
-----END PGP SIGNATURE-----

--kr14OxHsRwZHHqxS--

--===============1532087169644537139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1532087169644537139==--
