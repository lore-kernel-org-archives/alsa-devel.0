From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: tlv320aic31xx: Fix master mode
 clock I2S bus clocks
Date: Wed, 14 Feb 2018 11:57:03 +0000
Message-ID: <20180214115703.GB12658@sirena.org.uk>
References: <20180214081348.4322-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7809349596247042035=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4446F26773D
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 12:57:05 +0100 (CET)
In-Reply-To: <20180214081348.4322-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, afd@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7809349596247042035==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2018 at 10:13:48AM +0200, Peter Ujfalusi wrote:
> In the reset state of the codec we do not have complete playback or capture
> routes.

Unfortuanetly this conflicts with the CODEC to component transition
patches that went in just after the merge window - could you rebase on
my current tree please?

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqEJA8ACgkQJNaLcl1U
h9DF8wf+IAt588yb3C3/uAEvf9bL/OLP/32+fmfYQyUW4l1zILanHTfsMbeVWvfj
7zX/QXWLlhww8NW74TpEwUk1HSAg9/l4VajchCKy+a4HfsPfYQY3cJprXocWhAfe
/FPPybQ42JduY94HFa5WBK5yVjVQXpBD/19npEEtbx776BeMvmlHO9bwbNaVgsEv
hrStoUNNCRDyeHahXp45btU/Am85R+Qi0oiRQJLX52XkRZ8RMVyja0ZecRjMcNWt
YXmGZvPSxKua/xFHh7wOHnPBHB4ygDOmoAv3HDx9I4+7j5KFCJw60IQi2Kj7hcuE
072C6Nr0SXbQ70D3uXOx/mpNVLs3hQ==
=Ktys
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--

--===============7809349596247042035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7809349596247042035==--
