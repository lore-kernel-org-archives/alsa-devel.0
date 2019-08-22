From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] ASoC: qdsp6: q6afe-dai: Update max rate for slim
 and tdm dais
Date: Thu, 22 Aug 2019 11:53:22 +0100
Message-ID: <20190822105322.GA4630@sirena.co.uk>
References: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
 <20190822095653.7200-4-srinivas.kandagatla@linaro.org>
 <s5h7e75v7en.wl-tiwai@suse.de>
 <923f1d65-d908-c64c-3109-0da1938d3824@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <923f1d65-d908-c64c-3109-0da1938d3824@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, spapothi@codeaurora.org, bgoswami@codeaurora.org, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2019 at 11:45:48AM +0100, Srinivas Kandagatla wrote:
> On 22/08/2019 11:09, Takashi Iwai wrote:

> > This will support a lot more than advertised, e.g. it contains 64000Hz
> > or 22050Hz.  Is this supposed?  If yes, mention it clearly in the
> > changelog, too.

> Some of the rates inbetween are not in the DSP supported rate list for TDM.

> DSP should return error if we try to set any unsupported rate!

The goal with the capabilities is that we should never get as far as
trying to actually set an unsupported rate, we should figure out earlier
on that it won't work and never even try.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1edB0ACgkQJNaLcl1U
h9CyZQf+NkxJ3s3y4A36V4wjspMiCTbPJ1AjcV6Gd6tv7I1R+qKTpJkPTC9Z9rMb
7iMb065hO/nn885r+VvMF66Qihouou4XieX8RMUxUvjAA6v4+napihPwiZOGFIW6
c5rUCzCzZFK4jXD71dMOhOlIJENcKgXdgBQG+9fIfDAPNLHp/4RCWEc9PUDJ5f6w
UW6/aGyZlXypfQxEpsw9maZoYV3VZhCp+uJ1++P7Ps6gjqU6RrcPGRnGm7ZQ+iWk
YKkLmgj3q1FxfNYzxEmXCRNg7mwW9jvGmO85/DD0YtUpl2T0TMOBuzyzkaqqtYj4
IXCrbdaghj8kBw2QyXbzZ7I13DNbag==
=Dx3p
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
