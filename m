From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/17] ASoC: rt5645: fix error handling for
	gpio detection
Date: Tue, 31 Jan 2017 20:00:49 +0000
Message-ID: <20170131200049.atw7euwvbgsqt7pl@sirena.org.uk>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1485461385-14544-15-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8906449012109183192=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97A49267395
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 21:00:58 +0100 (CET)
In-Reply-To: <1485461385-14544-15-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8906449012109183192==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n3zvfqaikqhb3waw"
Content-Disposition: inline


--n3zvfqaikqhb3waw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 02:09:42PM -0600, Pierre-Louis Bossart wrote:
> Optional gpio handling should not cause an error status
> and prevent probing.
> Remove error return and move error message to dev_info

> @@ -3660,8 +3660,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
>  						       GPIOD_IN);
> =20
>  	if (IS_ERR(rt5645->gpiod_hp_det)) {
> -		dev_err(&i2c->dev, "failed to initialize gpiod\n");
> -		return PTR_ERR(rt5645->gpiod_hp_det);
> +		dev_info(&i2c->dev, "failed to initialize gpiod\n");
>  	}

I'd expect this to depend on what the error is - the normal pattern is
to check for whatever the error code for "this doesn't exist" is and
ignore that while treating other things (especially -EPROBE_DEFER but
also other things) as errors.

--n3zvfqaikqhb3waw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliQ7PEACgkQJNaLcl1U
h9A+2Qf+PQveQDV351Tsnl0BhHTcTATeS6f2/7ljp3I76oqidEUqhGYOWSzIkPMo
r2c/d/xNijc9VUa6R3BLiO36s2BiZBR490eBfVkqY3XikqPTK7kVDzOySxWhZrEM
rxO/FFOGRiSrqu3IMPzFSgf44q9Zkmo1Yj7tTu9+prbpZ65EXOPIL4IDOQFRHhrQ
Fa6900M5NFqWxsiy/TPPh8/vKfQTOKxGR6JC/plnSfdEbnoG9zUN3yDGndd3ljOP
s02ALlfDx5k1h/SCOU5TBmNVIbkbiztW4RbR0GJYekshAE7R/SbXpr4ERVTxdP8T
HpRFttCFy72h2Z5j6dttMbwQeNUGsw==
=xDgk
-----END PGP SIGNATURE-----

--n3zvfqaikqhb3waw--

--===============8906449012109183192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8906449012109183192==--
