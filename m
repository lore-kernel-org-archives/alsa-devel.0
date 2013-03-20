From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: soc: fix invalid free of devm_
	allocated data
Date: Wed, 20 Mar 2013 11:05:30 +0100
Message-ID: <20130320100529.GH28775@opensource.wolfsonmicro.com>
References: <1363434334-5461-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6473998745387212445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E1C502616E3
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 11:05:31 +0100 (CET)
In-Reply-To: <1363434334-5461-1-git-send-email-silviupopescu1990@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6473998745387212445==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Content-Disposition: inline


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 16, 2013 at 01:45:34PM +0200, Silviu-Mihai Popescu wrote:
> The objects allocated by devm_* APIs are managed by devres and are freed when
> the device is detached. Hence there is no need to use kfree() explicitly.

In this case since we're in error handling paths which might not be
fatal (though I suspect they probably should be normally) it looks like
the better fix is to use devm_kfree() to free immediately.  Otherwise
the unused memory will end up hanging around for as long as the device
is bound.

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSYniAAoJELSic+t+oim9DgMP/RhaQzY1ietaUuc+vH+VtI5N
ol5d6apuq7ycsuP6h9ocY7hZS/tYoztXtF4p6LfiKUCDnf342DIe/apBbcHIcbiW
udK7Bm9kIUcBV3T/1LBfjTB9iLD4JGwLZMazTjRF9L319zP8WaBiHQbKRSd75YnM
N2yh+arJbDZVIhWK92zpIrcSmekrxcAVWK93tUnvydYEmOlaF1dUd7nT4QeuMgdL
ynzDciIngVx1R7DHP+dCmG2ugU/VpBo3APMsGYsbLKuBKl9b3g8dMBar3OCGnV07
60eOEoG4d2LRnKbu2KSjcNPaJwNpyPXWpFk/jpEoW1DoP/tt4U1QNpcG68eEfd2E
reoCs1OsF0Is2nIlXXmHKQFdq+xP6EoumAEijLzpbhYnmBw8hBf8A3e/ZvzlibYC
5Cb8qX1EhGQdqbNGCcaQdAFjzcC+RFd92qEaDKEUDAE0Gv/QGl71WqYYLz8T5F/J
Pkw8jY/cEfdJJ5FHOjvVtHpUtCqnZ5pnzBbIcJg7bErk67+84oswUG7OKwGLr15M
Oy2Mgep6L/AletJWRiirKQIo9WcgiRJ2RkV1yj47/BOxh/C0zIk+wCxZmTsH6bby
mzCqMi/FMjPOIlHznYZYKCwiOKxgfgREUCxZFuQj7SS1I2qUxMS26h67ciIJtwkD
xBNEIwbd6a/AcQjZZgvU
=YJdM
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--

--===============6473998745387212445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6473998745387212445==--
