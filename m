From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 07/19] ALSA: Oxygen: Add new CS4245 SPI
 functions
Date: Fri, 24 Jan 2014 13:43:51 +0000
Message-ID: <20140124134351.GC11727@sirena.org.uk>
References: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
 <1390565900-3337-7-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1236256508089508265=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1390565900-3337-7-git-send-email-v1ron@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Volkov <v1ron@mail.ru>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1236256508089508265==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a9msq94+WlNd0NRk"
Content-Disposition: inline


--a9msq94+WlNd0NRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2014 at 04:18:08PM +0400, Roman Volkov wrote:
> Add the new SPI write and read functions. The SPI read function
> is used for creating initial registers dump and may be used for
> debugging purposes. SPI operations are cached, so there is a new
> function to manage the cache (shadow). I have to remove
> the shift from the CS4245_SPI_* constants, since when
> we are performing the reading, we need to shift by 8 instead
> of 16.

I can't help but think that this driver ought to be making more use of
frameworks - it sounds like an ASoC system really (split CODEC and CPU)
and all this register I/O stuff sounds like it could make use of regmap.

--a9msq94+WlNd0NRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4m4UAAoJELSic+t+oim9vwoP/jnYeIxNnabVqCQ29PQV3PzG
iV1yOkR6INOTDb0bU+Lmv0MQNqFqq641BmaKj7vxuMr2BvTFEXDrn1znOk5lWk/q
IhyShf6cP/MbY9FJDt42MrrjHLmku90O3Sop3BcL4V2xKnjgHo+4+WpsWTpJQRjR
7NjcchuRW7bSvmr25ZZIWzDoYY2BASZyfW4DjuJejyFnfT7uB6rEWYRyir9GGcj4
wUZ1wx4f2wH2+JzRAyizKPAmEJhu+CQqZSifqQ0oP89qXlS6NjADtMzfED0+JDvT
IDUnHutfHmodYT+N6svUun7z9YPF8eqaCYYyfG1VXi8XjNgY6pdRmEpZlJx31R5c
zL2Ii3AjQB+Mbs/ZDhr/td2Sck/5L198Y4YmwMOTwYY9DwUnOlQlqr1O5D2JtDqs
AivR05Vm6w7WANUnzJcdXVa9WOUQTah3fGg7Ou6XkomRsoRme+zuNWFHHWUlfFkZ
ENbyVB6mDKr2i6rkAfFvwKE8mAD2Ucer+afsqd80Mz+m6R6n8d4OikDcvvg0HeSx
Pzyer0G8ojesvHpaUv3hqHA5PE6/V0+QPlGlZVFKLTOcE5/dq+RYCyL5+XZiiImx
FUyx103+OP4WUE5RkRM46QFY5ULk9yKjjViVgU7aAwOKSLRDUV5/3a2d5mXGz4Oh
C/ecQZ8lQJBCyBG0TYHA
=1/Tu
-----END PGP SIGNATURE-----

--a9msq94+WlNd0NRk--

--===============1236256508089508265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1236256508089508265==--
