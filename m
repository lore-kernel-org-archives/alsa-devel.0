From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 9/9] ASoC: wm8996: Fix negative array index
	read
Date: Wed, 30 Oct 2013 09:51:03 -0700
Message-ID: <20131030165103.GJ2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-10-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8491137636744689928=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CA55226553A
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:10:00 +0100 (CET)
In-Reply-To: <1383118507-21503-10-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8491137636744689928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2013 at 08:35:07AM +0100, Takashi Iwai wrote:

>  	int block =3D wm8996_get_retune_mobile_block(kcontrol->id.name);
> =20
> +	if (block < 0)
> +		return block;
>  	ucontrol->value.enumerated.item[0] =3D wm8996->retune_mobile_cfg[block];

Applied, but this only fixes some of the problem - there's nothing
validating that block is in bounds for the array, this now adds code
which validates the lower but not upper bound for this.

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScTjzAAoJELSic+t+oim9hcwP/0x51sHeLmGLPvIuOzBvD2pG
BWbPzQplVHlnGf6PzsXa6Trqz4U5jYrQRC6M+zhHA4QWUmZJpeP+h9hbV24/UuuZ
xqE0cOBRx08De1xPY7F9GtXmVUhaGKPoVfUwF7ejfoyREKmajXpryEcScmDaXcWn
taMcc8jHYBJRVXXMmhHaA+G6BFGGqsjvIg+p7H9Ie4AglfCiR586R5OccOOGs8/V
Xm0NVcrpdFpSpaBrX5dF/KxeTtx+ORc7/B3Kn28gu6us+o/dx1ETsmULx26sMISZ
vUSqP66HsOS8cqJkrUOXYNe02zWA9FQr4P72qU/Yx7o5izHZMDP5S2t/lsYrtuMG
baUfUqPPknSqayHeA432qgViiHqvy3QzZSPjyv8MkOGYGRLtb3x+8bVNAq+IHgsl
d9YlS1KQ8Y1etqeXtz4lH7/EuzhUU51E4wsjPBLDmiY+FoD3v1aDv7MzrhcxOQ6l
5shPPaSndiH61Nkkxkpk0GtK7ATgYWCudh/p+cnHrA7YlKhyITr3hlpB2N2VA0ob
fxjzeLW7W/X6Mz3TGy4dahgVCGzzfVrXjLmscjbLFe+e4CcW/yFJeePcPWWcFW4m
sUiTRq4qkTt633uARzBBGDAAxYlA7AWmOy/9zNRtKkpTgpAZQR1ukg2irQlScLLt
1fVhcqeHhhUQ/6RXUoR6
=e6wF
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--

--===============8491137636744689928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8491137636744689928==--
