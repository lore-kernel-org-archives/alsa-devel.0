From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] fsl_ssi: set fifo watermark to more reliable value
Date: Wed, 4 Jan 2017 18:27:12 +0000
Message-ID: <20170104182712.d3vv47g4v5ylis5e@sirena.org.uk>
References: <1483467777-8651-1-git-send-email-caleb@signalessence.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qmg5drw7rxypz7xk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483467777-8651-1-git-send-email-caleb@signalessence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Crome <ccrome@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org


--qmg5drw7rxypz7xk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2017 at 10:22:57AM -0800, Caleb Crome wrote:
> From: Caleb Crome <caleb@crome.org>
>=20
> The fsl_ssi fifo watermark is by default set to 2 free spaces (i.e.
> activate DMA on FIFO when only 2 spaces are left.)  This means the

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--qmg5drw7rxypz7xk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhtPoAACgkQJNaLcl1U
h9D8NQf8DSqdNWpOibOzR2x7529SOZk1AOONahxt2J/jm3a4b7mopt7pl2UPrezu
8WuluhCG1cwqt98+y3xMEvV/7Ljo3dcKAC9E9STrE3xJDNtoShrSDCfFJtIlU4HP
Dn+3aY2VthNpzzvlSd2xdoqWEZJdDaJ6CQEUn5JTwZRMf1FNd8xkrH0dYpCaLrR3
1KVJxay19mccelg/mnJdi1Kwfno/zVYtKX37xgu5DRcw0ijGwIga+GXq+gdOWpz0
ZaGAgpvQCpGb2oX7ExOL/2NnEjF+DI0yxz0QWK4326Oj6eLrnU+DmZnIxTpXNxSl
cPvhUb7VE+cWvcXB24xGR5aKfNyt/A==
=byx+
-----END PGP SIGNATURE-----

--qmg5drw7rxypz7xk--
