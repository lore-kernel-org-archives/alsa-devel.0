From: Mark Brown <broonie@kernel.org>
Subject: Re: sgtl5000 fails after suspend/resume
Date: Thu, 15 Feb 2018 18:16:32 +0000
Message-ID: <20180215181632.GJ8374@sirena.org.uk>
References: <CAOMZO5B3rb_UKatssvP0eZdm4JD_oa3A0A1pAr4keq4w0EYBNA@mail.gmail.com>
 <CAOMZO5CyE5T-H=K2Q9A=tYoY9zt0CO4YdFWK5PMS=NR2XbqPzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6184789931518336285=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F6E2267CD7
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 19:16:34 +0100 (CET)
In-Reply-To: <CAOMZO5CyE5T-H=K2Q9A=tYoY9zt0CO4YdFWK5PMS=NR2XbqPzQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Eric Nelson <eric@nelint.com>, Stefan Agner <stefan@agner.ch>, Gary Bisson <gary.bisson@boundarydevices.com>, Max Krummenacher <max.krummenacher@toradex.com>, Richard Leitner <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org


--===============6184789931518336285==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iRjOs3ViPWHdlw/I"
Content-Disposition: inline


--iRjOs3ViPWHdlw/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2018 at 02:36:00PM -0200, Fabio Estevam wrote:

> Reverting the commit below on top of 4.16-rc1 makes sgtl5000
> suspend/resume to work again:

> @@ -880,8 +880,6 @@ static int sgtl5000_set_bias_level(struct
> snd_soc_component *component,
>                                     SGTL5000_REFTOP_POWERUP);
>                 break;
>         case SND_SOC_BIAS_OFF:
> -               snd_soc_component_update_bits(component,
> SGTL5000_CHIP_ANA_POWER,
> -                                   SGTL5000_REFTOP_POWERUP, 0);
>                 break;
>         }

> Any suggestions for a proper fix? Eric?

Does it need a register map resync when powering on again?

--iRjOs3ViPWHdlw/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqFzn8ACgkQJNaLcl1U
h9APRAf/eGcDRsaPk0R9yIP9Z2iyYr+2J8UtD2s3YPSknhoobgxem2AWurINdJV2
kpwfJDnJ2pzzNetvMvU/wDKTEKY3f9cNKYnH+Bn6bQb218ho0nCTcQT/u/dD+ET5
PqRpgHKgPGxICKq1RE+M9Vr5JcDrz3PPL/dRaAMG2yBd4zMxxjG3QVXHBFMnT/WH
YH8EhzP4w917dopoiubSV6gUpchKZx/AXuXVmdCuWtCHv9mpvbJV911e6jTXIkZu
Ym2AhTunixhBJjg0OEkgBfqossW8HG+Ifno7eKSwaTmZbJTXItdzQssUJudVwKo/
645xVVNGvh9Sc3Yqpurb401mHptW5A==
=BFuk
-----END PGP SIGNATURE-----

--iRjOs3ViPWHdlw/I--

--===============6184789931518336285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6184789931518336285==--
