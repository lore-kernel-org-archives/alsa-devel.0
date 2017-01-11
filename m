From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5651: use msleep for large delays
Date: Wed, 11 Jan 2017 14:59:26 +0000
Message-ID: <20170111145926.22jkebrb7ojemyhq@sirena.org.uk>
References: <1484135376-482-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="msayzpygxwoaqlad"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484135376-482-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--msayzpygxwoaqlad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2017 at 12:49:36PM +0100, Nicholas Mc Guire wrote:

>  		if (!rt5651->hp_mute)
> -			usleep_range(80000, 85000);
> +			msleep(85);

If you're doing conversions like this I'd expect us to be picking the
lower number rather than the higher number - people are saying "wait for
at least X and at most Y" and msleep() is "wait for at least X" so we
should be picking X.

--msayzpygxwoaqlad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh2SEoACgkQJNaLcl1U
h9CO5Af9F2fKHz/R6pYGCaZH3oMc/vb3BnCOtr9uSJwRSU+OGJGFnAGwQrW/ktA0
59aVi71HpLaHK0ztgQYbznbIuhHqQWMcD70qSDJtNaGldcTzmYkaRIUERu1DjBWO
+h/hsIL5kjO900mBJnAzJd0FMUyfjuMq6/+7GwNjiap9IZy8ta93tEnXKYD1o1Fd
5Dxx3ogLD84fDjY5jDGd/tE+l2lhGru+UDquWXkr7lH+XT0eaj2K2WfsqPNGOawy
63h1cjCRDzINFEnaci/atpINujErFcpzc/uyiNhqrNHTHy2DdhTjE77fEz8UPSYu
VbSiUkkPSG/j2nI4kjW5ly4SZzAfUQ==
=SSmV
-----END PGP SIGNATURE-----

--msayzpygxwoaqlad--
