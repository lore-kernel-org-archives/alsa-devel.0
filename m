From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/16] ASoC: blackfin: Convert to
	copy_silence ops
Date: Mon, 22 May 2017 10:27:56 +0100
Message-ID: <20170522092756.yhlylhqhy4wm6fty@sirena.org.uk>
References: <20170521200950.4592-1-tiwai@suse.de>
 <20170521200950.4592-15-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3196983085193117439=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C6A3266F7C
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 11:28:06 +0200 (CEST)
In-Reply-To: <20170521200950.4592-15-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-media@vger.kernel.org, Bluecherry Maintainers <maintainers@bluecherrydvr.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org


--===============3196983085193117439==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3j2jiap3val242hs"
Content-Disposition: inline


--3j2jiap3val242hs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2017 at 10:09:48PM +0200, Takashi Iwai wrote:
> Replace the copy and the silence ops with the new merged ops.
> The silence is performed only when CONFIG_SND_BF5XX_MMAP_SUPPORT is
> set (since copy_silence ops is set only with this config), so in
> bf5xx-ac97.c we have a bit tricky macro for a slight optimization.
>=20
> Note that we don't need to take in_kernel into account on this
> architecture, so the conversion is easy otherwise.

Acked-by: Mark Brown <broonie@kernel.org>

--3j2jiap3val242hs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkirxsACgkQJNaLcl1U
h9DuUQf/V2n6Vlu71qRUNOzKCIhBaPDQ6SunlUEdzoMc5qYUvsOssUvRtxMbXHMM
MBG1lqxWV+a761HraN+z9meGDwgpagtlhBidw3ECOAsi+XK5o23i1owNMcRApMrX
bx3NA9IxHLkbvrGB7xPlSccH3SSNQ/BE8oWCnrdSq1MwLJR0L2Q6yFQLMests0Q2
q+r3TILyrVo3ev8P+/EsVl+Iap7XB/lXzYPtpM/dkeGYtKye/znk6WOdzEs6SKNS
GbF6tM0Am5eco4kwnjPxIZwJcke6411Y4WyTseCFeyQ3fjrgkhocojnTc9/pL5VZ
JIegAyWmIY62BzoiBEFF2Jy6LTLtsQ==
=y0uZ
-----END PGP SIGNATURE-----

--3j2jiap3val242hs--

--===============3196983085193117439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3196983085193117439==--
