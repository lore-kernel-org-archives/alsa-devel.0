From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: codecs: msm8916: fix invalid cast to bool type
Date: Sun, 14 May 2017 18:59:45 +0900
Message-ID: <20170514095945.7oefv6767yiz5nzz@sirena.org.uk>
References: <20170502133303.19622-1-o-takashi@sakamocchi.jp>
 <20170502133303.19622-3-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2em25zaefu6bhjoo"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170502133303.19622-3-o-takashi@sakamocchi.jp>
Sender: stable-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, "# 4 . 10+" <stable@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org


--2em25zaefu6bhjoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 02, 2017 at 10:33:01PM +0900, Takashi Sakamoto wrote:

> This commit fixes this bug by using unsigned int type, instead of bool.
> This bug is detected by sparse:

> smsm8916-wcd-analog.c:809:43: warning: odd constant _Bool cast (40 becomes 1)
> smsm8916-wcd-analog.c:814:43: warning: odd constant _Bool cast (40 becomes 1)

This looks like a bug in sparse - the use of integers in a boolean
context is totally valid and especially the fact that it is claiming
there is a cast when clearly there is no cast is an obvious red flag, at
the very least the message it reports is bogus.

--2em25zaefu6bhjoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkYKpAACgkQJNaLcl1U
h9AA6Qf/VG3NCbOY+arCaF6N+sRPXahxmRKnVMbq52i/F59qb0en7BP6wfUVfHbz
SIZId6dPAlT0ECD4E8L5nK3JK71O3siNDwfxXn71FW8ViscvR2v7MtWiPZ6B8dP3
8SF1BHs0ogksGG2aCL7P7ZHzAQYsMMoYbGah7DBQ1NzQFL+nJ6q4lWJjvDt5l22P
0pfkLqrf/x6dlQ2gTXZMuByT86aYQsJ/Mnk3UThZBcxljcf7vYCQpGQUVc/KkkyS
6t/cUlo4Uitw9Ny2ka0yaOYzdC+X6nOGdFnQXst8rT6GC1VQAgUhtjTQ/BDhlYci
b/Kgg0gxI4oRChGWlVGM74Y1hE+PFg==
=WeRf
-----END PGP SIGNATURE-----

--2em25zaefu6bhjoo--
