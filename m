From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: fsl: remove use of imx-pcm-audio
	from fsl_ssi
Date: Wed, 15 May 2013 09:27:43 +0400
Message-ID: <20130515052743.GM24524@sirena.org.uk>
References: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
 <1366859930-1232-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8072479285230886661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EE3F2610AF
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 07:27:47 +0200 (CEST)
In-Reply-To: <1366859930-1232-2-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============8072479285230886661==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zHDeOHGDnzKksZSU"
Content-Disposition: inline


--zHDeOHGDnzKksZSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2013 at 11:18:46AM +0800, Shawn Guo wrote:
> Rather than instantiating imx-pcm-audio to call imx_pcm_dma_init(),
> fsl_ssi can just directly call it to save the use of imx-pcm-audio.
> With this change, fsl_ssi becomes not only a cpu DAI but also a platform
> device, so updates platform device setup in imx-sgtl5000 accordingly.

Applied all, thanks.

--zHDeOHGDnzKksZSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxzMAAoJELSic+t+oim960oP/iSy96GtmNoIcqSifzF47zNK
tZVimNUI2pvshYnIOScS7utqgneXbq4N7yOStQ4Wo7vf+Vx8C1m3+fFgBYSswdHt
rVcKwFuLfZGYb9No0Ul2GEF6ZpwRZlUQikoF3EPhHkcVUnHNGX/yWHsDRoI50rkV
VtWQaxlSOYYpeH6fOQXmNkdfd3OfJWXboZ0pjtbcxEi7NDwR7T8pZNl79cwJ2r2W
epbNlv2tvCdX9XLOi9KpuC3zEhxm36SrwlqNNQuUgPG/Uy1HdJcvaykDD0+foCG2
THlbKRB3YYnrGv4iCyLafBfmt3GXA7/3NYVLt8NsB70uV40n4ZR3X8M7A/+7Lvxz
wemfWlZmkJNliSM4I9IdnGsmXyYnwGrXciqZzfRO71VuumxsCkEruIP6Fis9OPuB
Y2q6ovn2DA8HeykEvITByjOWTLTM0Hvt+aQhlvsq7QCIFsYXBQPYTvXWI1JxOrYt
F1/aXoM1/up5zvHAFk3Kav53xFthdFCeYkiIWVnzmdIpP51c4erDs2eg0tK9uFYd
H1zuD+41Jevb0ipUFygaQMC+bSWJ6eJBVU9XTEwfoM782jXCaNk2wH39xYPuwaZQ
1Zi3bBRnkzPz3Hy8udkrAPJy/C7BpNJtc94TDostDuBb1NspjKg4NNsuWcNGpOch
uPL5OQ4ZqvNDRXBUJx4f
=2GBC
-----END PGP SIGNATURE-----

--zHDeOHGDnzKksZSU--

--===============8072479285230886661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8072479285230886661==--
