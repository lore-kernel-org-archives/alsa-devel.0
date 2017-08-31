From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/9] ASoC: max98927: Added controls for Envelope tracking
Date: Thu, 31 Aug 2017 12:43:57 +0100
Message-ID: <20170831114357.dekzz4wa7j6vqi4t@sirena.org.uk>
References: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
 <1503963061-14763-2-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wi4vy2ai5lkxtx25"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503963061-14763-2-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org


--wi4vy2ai5lkxtx25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 28, 2017 at 04:30:54PM -0700, Ryan Lee wrote:

>  	/* Envelope Tracking configuration */
>  	regmap_write(max98927->regmap,
>  		MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM,
> -		0x08);
> +		0x0A);
>  	regmap_write(max98927->regmap,
>  		MAX98927_R0086_ENV_TRACK_CTRL,
>  		0x01);
> -	regmap_write(max98927->regmap,
> -		MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ,
> -		0x10);

Why are we changing the defaults here?  It was understandable to have a
fixed default that differed from the chip value when there was no
control but now there is a control and we're changing the default again
for some undocumented reason.  It'd be better to leave the values here
to avoid breaking compatibility with existing users and let users who
need different values change things using the newly added controls.

--wi4vy2ai5lkxtx25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmn9nwACgkQJNaLcl1U
h9Ab3wf/c2tkqhjM4cdFvgxwmCMgMwGEYJFsvILlo2dd53JbkVlNkUCPYlJfzW4m
G5988yE+BmRRYRddCkpxpDNNsxsSVCA3omAsdf1g4cKpi3H7BusEWK9Gz76ef0Mx
wzt8BvBpADGJ0tcV3NSNAc9epGTm1C4D0POqOpqaHpPt1g6ehBb3SPv4ZqLiLXPK
EtBKn0EAbj/Hw2irTgNvlKDvGTrgheSy96AojdI/QCU+a4ccE0QMhv49ahTPmbkC
cF42Pj/Y3oVL8TRAcilfsm2nnb+rOvpLFjPbTcZrDmtqSzlN+rnFdcJBFwr2kCmj
gkeMRKN1vTSs29B/UNU/IOki6uEgCQ==
=K1Lo
-----END PGP SIGNATURE-----

--wi4vy2ai5lkxtx25--
