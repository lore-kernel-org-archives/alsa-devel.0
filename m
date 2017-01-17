From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC] ASoC: rt5663: use msleep() for uncritical delay
Date: Tue, 17 Jan 2017 19:33:02 +0000
Message-ID: <20170117193302.q4spr53qwrgqdrbh@sirena.org.uk>
References: <1484147031-25525-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="efxlxtfm6cubc73y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484147031-25525-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--efxlxtfm6cubc73y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2017 at 04:03:51PM +0100, Nicholas Mc Guire wrote:
> The delay here does not seem to be critical with respect to longer
> delays than 10ms as this delay is to ensure that the write took
> effect before the next soc_update_bits/write call only, thus a=20
> high resolution timer makes little sense here - msleep() should do.

No, that's not what the code is doing at all.

> +++ b/sound/soc/codecs/rt5663.c
> @@ -2764,7 +2764,7 @@ static int rt5663_set_bias_level(struct snd_soc_cod=
ec *codec,
>  			RT5663_PWR_FV1_MASK | RT5663_PWR_FV2_MASK |
>  			RT5663_PWR_MB_MASK, RT5663_PWR_VREF1 |
>  			RT5663_PWR_VREF2 | RT5663_PWR_MB);
> -		usleep_range(10000, 10005);
> +		msleep(10);

The write before is turning on a bunch of analogue power bits, the
enabled supplies will then take time to ramp up to their operating
state before we can proceed.  That's not just "make sure the change took
effect", there's a bit more to it than that, and power up sequences are
generally very latency sensitive as they tend to happen in response to
user input.  People are generally picking the minimum value they can
reliably get away with and a lot of effort goes into optimising the
power up procedures.

That doesn't mean that the change is bad but the analysis in the
changelog is and could cause confusion.

--efxlxtfm6cubc73y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+cWoACgkQJNaLcl1U
h9D/zwf9HiZk3LtScSeIWEET6yrGKym9xwrYl3KVbw/QPYEuPPloxV1H0zyhozY9
TJP5OJBgqMWn2OY6NeQftmMED9yCnM63AiCRkbmZS6/Sez1NT8MMf99qlFDC6ClR
7EBzeq0TGnTMvaM/d50Kj9H/Fk77yGrA7+SGqoFglrOG1RLdmvBX2Q451ipytOuN
CWFT+1v4kq9+aT0f2HK4W+az7opXAjKl5MexBakcS2DFgrtkvxPdxEPW4INdmxOJ
kNGnZjbGTSSgKmaeVMDbDTDqtNeAzNE1tlVuw2JyI6bDqZfq6R4U0ozOT9D/x8ln
5ZEga1hcKtirsnOVQApGwtUt+JMOfA==
=F//1
-----END PGP SIGNATURE-----

--efxlxtfm6cubc73y--
