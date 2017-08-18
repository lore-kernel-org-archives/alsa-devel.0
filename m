From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/14] ASoC: blackfin: constify snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 13:17:07 +0100
Message-ID: <20170818121707.upn23wl6lhavqrge@sirena.org.uk>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1503057971-16033-2-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xvyun4iqf45azjeg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503057971-16033-2-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--xvyun4iqf45azjeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 05:35:58PM +0530, Arvind Yadav wrote:
> snd_soc_dai_ops are not supposed to change at runtime. All functions
> working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
> const snd_soc_dai_ops. So mark the non-const structs as const.

A version of this patch has already been applied.

--xvyun4iqf45azjeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmW2sIACgkQJNaLcl1U
h9DdZQf/WlYow2+n1fdDJVWVDRbCgJpkBq9/vsiN2ttrR6aFcYcZ/ZjWhNEpL3Ys
YKWC0lNmc8glQaxdzykKVGiLcNP0qLYNHWnJzH+wUcy51aqQ+2Xwz4nSCcfiOHon
LVi3FU5oQzv4SrED0FJ9Qf/3KWekQZ6M9vIusCfp8IRJd7IJWU4a26Z3vgY0Ctas
W91NDu89Ks++xuK5d4MvGS7A7kvqQDEcJipYP1Rx8pF2mPMiIudDE6O6O/VPn0d1
d0afe/Tt0GWbhYR0bXiy5P4yGvvb88cSeiM8M659MkSd3sNCHZwNXT+yaiXXEzjh
mKcc2UYEjsJzHAk5dmzEhQu0nyqm1w==
=5lyB
-----END PGP SIGNATURE-----

--xvyun4iqf45azjeg--
