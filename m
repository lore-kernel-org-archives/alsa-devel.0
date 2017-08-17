From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/9] ASoC: rt5514: Switch to snd_soc_register_codec
Date: Thu, 17 Aug 2017 18:11:20 +0100
Message-ID: <20170817171120.xvvsmx2fleeqj2s5@sirena.org.uk>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
 <20170817044417.22069-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bt2krtj4o6aa3c5m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170817044417.22069-2-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de, briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--bt2krtj4o6aa3c5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 17, 2017 at 12:44:09PM +0800, Jeffy Chen wrote:
> Currently we are using devm_snd_soc_register_component, which would
> use legacy dai name.

> Switch to snd_soc_register_codec to use dai driver name.

This is the wrong direction to be going in, we are trying to move all
drivers to use component.  Whatever you want to do make components use
it.

--bt2krtj4o6aa3c5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmVzjgACgkQJNaLcl1U
h9CEWgf/Wez1qnIb4+lnvG+1eL095p1DMFeQuKAozpb1iIMabI8Lw4G4lttkg4oM
e6HTf9XIrT99vwGkVyG+kFGmx4JkzI80BeCCTnRwtkCu+ETQ8s4CUsbOdLRYA8Np
qpi7A+CCgiKKdZRq6k/fXQbjagl4LLOB3w3TMD8U5nyWUqbwHUpYt0o1W6JHtsnx
1p4Bf0/jnSTCwCLyCPAKtoU5dsDEeRJGSZwHAGqHQM5ziA3p4BneQa7VMuLQMGrf
jCmISBfCCMMbciP/ibqm40EL8QwE3bOfEn13KCnkTQKr5AfkXgG/G7VNyIJSNMxp
bYxsgqI3x5MxKw3kHB+ITc5B9xccgw==
=wESh
-----END PGP SIGNATURE-----

--bt2krtj4o6aa3c5m--
