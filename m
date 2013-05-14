From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: wm_adsp: memory leak in
 wm_adsp_create_control()
Date: Tue, 14 May 2013 16:40:40 +0400
Message-ID: <20130514124040.GA20930@sirena.org.uk>
References: <20130514120244.GA27826@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8780923689696423188=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 342AF26506D
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 14:40:45 +0200 (CEST)
In-Reply-To: <20130514120244.GA27826@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8780923689696423188==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 03:02:44PM +0300, Dan Carpenter wrote:
> There are two return paths which don't kfree(name).

Applied, thanks.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkjDAAAoJELSic+t+oim9lA0P/3b9Z7PwOqG7UNwzTrL4pltO
0eV72djxyDgOeUyf3VcR+NgpD3DYmqKEYhn+XDG7mC2GcZ2gdvPCZKGHR/4iFVQ1
7tmnbmAtTEpvWcsbqSUuY36Vpnyxiq4JtVZqTLbCTEFZwOfKcp72FULn78L/zZrg
pMsifOAjnuDP65JoaXqbOwwPFIbiwJdh7R37q2CuWThDTl+Th8fW6OvugjyAk7WS
u0tZkJa0h2RRCStSnI3tfwJZKtFra3pIUkJuVQD9ks/EUMp7lGqm+nedtWdtjxN8
CyUncEVrozShCqyB5J/GfD0TnETlpqpdAjbKTjAaZV6uwMN5UpeGr2LZ3+UIHpNA
TA1YvRn7kxkI61Ab5xffa6uSjDxE6gHgkFDEZNoXIOrmVYHrvek8mm0pxjqzuDZ0
gT/8AqVMsoaSnIFcpgIgHZB99XUi1moeno3x9FfVuR/EqP4p6h4R02QLLk62nYG6
NpRWINSWKg9WLu67n00Pa8Rbh9tsJ0ouN1ZhZeKAh03iTQRKKTrkJ2U58cfXk+mL
CXgY4po4XB9zTGC6830pAH3SbT5R11sg0Gs2GSAf0evo/Thti6mWjuRpMe2woYsp
f3cHZ/dxw6u54w8jASn1/YDBjCroQJzPtjgtsBFsOZc3zWIYwFdb/sOYyqMCqjgz
5+11XjUZLUxOLlb8tHXl
=Y6l6
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

--===============8780923689696423188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8780923689696423188==--
