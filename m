From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: cs4349: Add support for Cirrus
	Logic CS4349
Date: Thu, 16 Jul 2015 13:23:33 +0100
Message-ID: <20150716122333.GD4039@sirena.org.uk>
References: <55a68b00.4e946b0a.7bbc.ffff9616@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8954829748485071222=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B8650260563
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 14:23:44 +0200 (CEST)
In-Reply-To: <55a68b00.4e946b0a.7bbc.ffff9616@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timothyc.howe@gmail.com
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============8954829748485071222==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2015 at 11:31:49AM -0500, timothyc.howe@gmail.com wrote:

> +static int cs4349_runtime_suspend(struct device *dev)
> +{
> +	struct cs4349_private *cs4349 = dev_get_drvdata(dev);
> +	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = snd_soc_update_bits(rtd->codec, CS4349_MISC, PWR_DWN, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	regcache_sync(cs4349->regmap);
> +	regcache_cache_only(cs4349->regmap, true);
> +
> +	/* Hold down reset */

So, you've inverted the sync and the cache only here which means we're
not going to try to do a sync while cached but we're still doing this
immediately before we put the device in reset.  Why are we syncing at
all?  Why would the device be out of sync with the cache and what is the
expected result of syncing at this point?  We're going to do a sync when
we put the device back into write mode...

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVp6JEAAoJECTWi3JdVIfQHWwH/RS73kMV21lrDRV/RDf9VJNt
jJ22u5kbr3VRDB18um6dY+bkAni/QKRgrGKL9RaoZikCRtKrpYSBqu7CqFfeeEs5
ITRpZy31fZVjuKggQa6jTM6nt1PxxABB/3hEfONKEUybnL12UKRo84k5hAvq16Cg
XCs00We6AFKByJ87OWze+SrD3tOF4kl7phZl/sriL5oOmCzZXO52CLVC3vRUjVLn
c6SIzh3xULvBYin6xsYIAXwKXk/IIdUb3EYYQU4EiVn5mQCvvxfp/dSs81IYVvuv
CJ3wNgnIqbYBVLXTMj92Gz9D8Rcqkg2uD/h8LJs/ykd3tIz28BLQVW95xvZrZyU=
=j8UW
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--

--===============8954829748485071222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8954829748485071222==--
