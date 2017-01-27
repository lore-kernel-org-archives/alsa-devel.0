From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: davinci - Fix possible NULL derefrence.
Date: Fri, 27 Jan 2017 11:58:23 +0000
Message-ID: <20170127115823.h44w7at2mrclkn5n@sirena.org.uk>
References: <CGME20170127111104epcas1p2810feef80b04b21983efd16c00b1b651@epcas1p2.samsung.com>
 <1485515457-3055-1-git-send-email-shailendra.v@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7cmbtuos44xnxu6c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485515457-3055-1-git-send-email-shailendra.v@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shailendra Verma <shailendra.v@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: alsa-devel@alsa-project.org


--7cmbtuos44xnxu6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2017 at 04:40:57PM +0530, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.

Oh, and:

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--7cmbtuos44xnxu6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliLNd4ACgkQJNaLcl1U
h9DPVQf+LYdCki93xelb0P2KUyNUzS8l5XQgbGZkEo3qCm+nHKEVl4gbRnZakHP+
UzhPBDmAek+ZQXLiC6pShNZXtEpBgbW7pjV/LWZUijjXqvuMptfx1sVVpSOro0v5
1CMj3dXokSSHBUGOk/sdZaqhVqQvRfKp1nJAchisJI51hzf9w9cWwSdbtt10SXyR
1+gdC8DjlECQQWZKESiMBnb1Unq7gI7T497aWF6B+XMnO5s+6Aiq4XtkEBMlChwe
I6R2YSmfeuEGz72gEbz1zh2Pg1ufBJu+WOtAXGhFsqgyFD79HvPnHr6L0Bf71jHH
55wNYNk/G3GRDGrv1JlnjMR33kQjvw==
=plB3
-----END PGP SIGNATURE-----

--7cmbtuos44xnxu6c--
