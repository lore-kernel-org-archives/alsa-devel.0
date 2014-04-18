From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: use PTR_ERR instead of PTR_RET
Date: Fri, 18 Apr 2014 17:20:06 +0100
Message-ID: <20140418162006.GF12304@sirena.org.uk>
References: <1397594341-7817-1-git-send-email-christophjaeger@linux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Awac5e4PJmEUK1pq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397594341-7817-1-git-send-email-christophjaeger@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Jaeger <christophjaeger@linux.com>
Cc: perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Awac5e4PJmEUK1pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 10:39:01PM +0200, Christoph Jaeger wrote:
> PTR_RET is deprecated. PTR_ERR_OR_ZERO should be used instead. However,
> we already know that IS_ERR is true, and thus PTR_ERR_OR_ZERO would
> never yield zero, so we can use PTR_ERR here.

Applied, thanks.

--Awac5e4PJmEUK1pq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUVCzAAoJELSic+t+oim9b5EP/RdY3ij18M9S32sY0sPcybNi
zp0WnNXPvUyOEgGPMykm1rt2uy+Es0HEd9fXe38lKfzTxW7gEO/E7WI1E7MoP7za
HTak8YTUq2lAVxKg3MgGngqTtIhk6YONes3zsEERkNRlJEUxD8jDsXfqDtudfuNB
pdr4JyK26q6aZQvuyNGJqMwRDgp0VUQd9i9hF5u3OoNQaNviUeOtCxL1hp62I+Py
9XTGL4V5RI/lUPM+dlRNaGECcdrW5pYbryIeua+EixPck3frXMwCQTXWdJd4rGQI
RXUuiAiXREZGWUflmuUrRusLduQMOonOwhiHSQqOioveEBfr4FLf4n3BhGTVS0cW
vZm4sPGXrqfr7LGLAJdXXYs2zHRoo8Iz3vmS/fhHAQLJtRMgnhJCiHOWgMDnKUUp
ThwKrsi7e4DpZWpsf0EIXAyF+td/6IAT7j0AfguRzICPmnhXkq6QTqk9eWm18D5n
cgZEHAMpQGEEaLyBcYV1ozDjM2zSVm9Z+n2WPUMN/9SUcDviFRkg3XxBhxMh5TAf
sW5yBNzIlzjSGvyCHeX4Y6bKuIM2u7KPd92J8+eVvJPa0JRmbmfzO0fBh1kWans6
jYsY7xLiXpyjgLTBVv6UVMUsYrVpaX/yuO7jMyS87zpnRItu0tR8ooVlnXRSpS0F
Y/WnXPY/1FMUe2sNtq2p
=6Vjk
-----END PGP SIGNATURE-----

--Awac5e4PJmEUK1pq--
