From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic23: add support for SPI control mode
Date: Thu, 6 Mar 2014 16:07:20 +0800
Message-ID: <20140306080720.GI13126@sirena.org.uk>
References: <1394091862-13603-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IcjzwMCQyeqbz4V/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394091862-13603-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--IcjzwMCQyeqbz4V/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 06, 2014 at 11:44:22AM +0400, Max Filippov wrote:

> -	select SND_SOC_TLV320AIC23 if I2C
> +	select SND_SOC_TLV320AIC23 if SND_SOC_I2C_AND_SPI

We're moving towards having drivers have separate bus drivers rather
than in one file - take a look at how drivers like ad193x handle this.

--IcjzwMCQyeqbz4V/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGCywAAoJELSic+t+oim9+BAP/3WU574i1RxBs+3Wb8xnE1Qu
acHRW2c7klNJu/QbnmDFqQAfcWlADt70XID32Udy5srnhaPt0nepGMOd3u+iKSrC
lsiMQ8pJPLGNMv+K+PL+HCFUfAu39i8euf22URqhzuzWMPBpmg5ThbSXNdaZHhaM
4Sfz79208ff3kreHW+DhunRd9RczrDw7frXcRMhfeK5rxYHdBb+EdQ9gy/kc/p8N
G3VhgU8axM1T74U2mcqh7HC03jaKhpmQ0Vw2IHCo5dS5yIx6A49+FSP0cc1F2fwW
zwsxBenXY7fE4KRzv5ARqoLVvR+RcpPmnZ5zE56bGjYxCesQwlFYfPdc/suhtDtD
C3gh8eW4HbCLQ7KV/eH6jYoGpPGjlCrAXjS0E6yyNzdMlGv/HFhssjLtrHq5Qwwp
HMU60w2T2s6An15zjBo05QvV51e8pEyWQyJn86RHiUqqz1Ztatn+jXO2FqnPt7LY
7FNMw1Rlz4JZI07hFA2VrNt/sehyZ2cPDxDWBbeQPQ4BraHnkz+B4hqP/QCJk4Iq
MJw7zjijis2xdAuT+JMyOMXapEP5dqOgvrUvipmwAKSb2CWyI23GjbSWhMVC/5+4
xXimH8LtU4ShkxsTRITengTdzUHzhK1OJJhv7ty9NkCoQMU3fK29QdeyRALPLc+4
HqG/oCp9cXOZPzi2c/VB
=XWzH
-----END PGP SIGNATURE-----

--IcjzwMCQyeqbz4V/--
