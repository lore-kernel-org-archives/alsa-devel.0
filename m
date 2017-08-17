From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/9] ASoC: rockchip: Remove obsolete dmic-delay
Date: Thu, 17 Aug 2017 18:11:52 +0100
Message-ID: <20170817171152.abf3ngr6nr22jfif@sirena.org.uk>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
 <20170817044417.22069-3-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bqjgvkvdwut4v32t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170817044417.22069-3-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de, briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--bqjgvkvdwut4v32t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 17, 2017 at 12:44:10PM +0800, Jeffy Chen wrote:

> This property is no longer used.

> -Optional properties:
> -- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
> -  If this option is specified, which means it's required dmic need
> -  delay for DMIC to ready so that rt5514 can avoid recording before
> -  DMIC send valid data

Why would nobody ever want to use this in future?

--bqjgvkvdwut4v32t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmVzlcACgkQJNaLcl1U
h9CMBQf8DLSsu24hEigv9P56llv+ChN6gu0QcEJ2pXLWg/tqaNMAureIDeEmca7A
POtNQNkIGXDQdoa+eoOsoHCIK6CSqeJ5Mw4Cm0jXU5NEtYBZl68p1pMBsknBbK3+
K0zcoF9qSNXroBuVUlkO7bq8Rkcc7jMhcufY9tKYwJep19eRBA96+kEFJQucISBm
4yYopi0nYUsL3zZ77OWVBBYHsUF9Ov3V5v1ZNiYRWRtkHoRHkIsX7+0T4+0GKerk
FvQhQxYev2kwyvjFETVWzMvnTHHY5CSKpcK1d0GulWAYGdsF6Thi+oHxne1Ukg1U
oKuB1WTWn7EXCcC1iG9a4daR3i5ndw==
=MaRz
-----END PGP SIGNATURE-----

--bqjgvkvdwut4v32t--
