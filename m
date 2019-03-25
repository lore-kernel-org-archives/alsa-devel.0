From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
Date: Mon, 25 Mar 2019 15:05:33 +0000
Message-ID: <20190325150533.GI7284@sirena.org.uk>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
 <20190325121232.GF7284@sirena.org.uk>
 <50fafc60-0ee4-ab33-8d24-dfc149215bee@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50fafc60-0ee4-ab33-8d24-dfc149215bee@roeck-us.net>
Sender: stable-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org


--TKDEsImF70pdVIl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2019 at 07:21:00AM -0700, Guenter Roeck wrote:

> It is actually a bit more complicated than that. The stored pointer (drv->soc_card)
> isn't released. The problem is that dev_get_drvdata(drv->soc_card->dev) is NULL,
> which causes the crash. I don't think there is a UAF involved - I built the
> test image with KASAN enabled and it did not barf at me.

What is a "UAF"?

> Overall the implementation does seem a bit suspicious to me. I don't really
> understand why the platform driver handles suspend/resume for the cards.
> But that may just be my lack of understanding. However, either case, I think the
> Haswell driver (sst-haswell-pcm.c) has a similar problem. I am also not sure if

It's certainly a bit unusual, usually the platform driver would just
deal with suspending itself and the card driver would handle overall
card suspension together with the core.

--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyY7jwACgkQJNaLcl1U
h9BAeQf+PQ+l1znpCsPbzSflIPAJyV3HJ4A9fSRVIOnh2V/z+pJQAWq/aTP+9xmp
Ggb5K1xJVuu+oU5FsvAUmZe8vk2ek9LgJDSBFET5mZPljmGIWPLSNM3UgEQixAih
dEQmqfwKjICSHlMkS+Lk82X6GIhsVHCJSqtKS7AQWojcb+Rm2wqGaavgSGZzPBTs
whHJO6905jQyx9e9lE2FZV7/fq4icSPqtYey9yA+59qmT8R5fjxzRhvKs802ZWyR
UKyJZkzC/YRS4og/kThp4rgGpZwWDRi3AKHq4h/1E3b3kskb4QkeZpw4qrAoGtsv
Gn+E1wbeN2yCs1ok6dVkUQQwEEatQg==
=zn5k
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--
