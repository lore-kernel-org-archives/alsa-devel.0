From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/10] ASoC: ux500_pcm: Differentiate between pdata and
 DT initialisation
Date: Tue, 19 Nov 2013 18:48:29 +0000
Message-ID: <20131119184829.GF2674@sirena.org.uk>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-9-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="656hIAUFSU7Oh46B"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384859269-19801-9-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--656hIAUFSU7Oh46B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2013 at 11:07:47AM +0000, Lee Jones wrote:

> require slightly different flags to inform the core that we 'are'
> booting with DT.

Is there some situation when we would want to say we're booting from DT
when we aren't?  Just wondering about the quotes.

> +static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
> +	.pcm_hardware = &ux500_pcm_hw,
> +	.prealloc_buffer_size = 128 * 1024,

You shouldn't need to set this explicitly, the generic code should be
able to pick a number for you - if you do need this number please
explain why the number was chosen in the comments (or fix the core to
guess better).  At the minute the core just makes up a number too but at
least then it's a consistent random number between platforms.

Can you also get away without the pcm_hardware - the core should also
have support for discovering this by querying the DMA controller?

--656hIAUFSU7Oh46B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi7J5AAoJELSic+t+oim9oP0QAITbM+n5akoBBjWbLa1gjR46
xu7Rl9FhOj30GqipWFLjuVwvYj2ks3aXdExcM/psJN2FL9ms7ILzhNS6CI5MpfLf
n6AAA0dqErREY4ijObjqiu76ZE7vkbd4AmafHLz/kXpRJ4W8O/Qmb3S7g1RIUd/D
D5XdQvhh54TlJtTyoT1iSsHyAVR3l4gWHjDdQpM0pVQe79/beznrt5+TbnrKv4ib
HNtbGnbQK7G8EIqhaQU6BrX1OjyLoAAL05Ixa29EMwszDTcmSy7j7uN4jbCwWLB1
Ubu3TKMkM3LUK/8X5oIB29N1mdV4xSRWbvdX1Q1DH8uXd8QV5EWWSfZw5GsKqRX1
juzarylyqOMtEtwRNmuU7DYmPTZt1izX6ToyZPEfJofyAkHafQTr5qGedxyeHLnj
CkrvUrWgx/wFJIBAOTZIKL1xtBnmh4eNIC47IXwLA1yM5dr5xgl4X/IwEfzLKsF5
Hh6aMoWTz542Uhi2trCGkLSFqOExsUX8Y6jWOkLUW3QgG9cs02aCM8JUo2gqXfdZ
/woTe/5MV3vGDFOOjvXMEe2N5O+5dMbnxlVu3jfFUzwZDD08l5Y6SuOhiHDMQuip
tnNbrDzbtzl5WXJpf43KyOo1bxKm67jIzavVyKbRNSMAuuff1egW4Rbh83ZrIMFn
ujgwIrSELPY/W7qEVNBD
=lnLP
-----END PGP SIGNATURE-----

--656hIAUFSU7Oh46B--
