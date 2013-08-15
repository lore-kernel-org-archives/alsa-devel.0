From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: core: allow SND_DMAENGINE_PCM use
	from modules
Date: Thu, 15 Aug 2013 18:30:18 +0100
Message-ID: <20130815173018.GE30073@sirena.org.uk>
References: <1376575432-30354-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1573084783802632803=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D9680261AAE
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 19:30:22 +0200 (CEST)
In-Reply-To: <1376575432-30354-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1573084783802632803==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2013 at 04:03:52PM +0200, Daniel Mack wrote:
> When users of SND_DMAENGINE_PCM are built as module, the config symbol
> SND_DMAENGINE_PCM must be tristate, otherwise the linker will fail.

Applied, thanks.

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSDRAmAAoJELSic+t+oim9VXgP/0Ithb8yHZ/8A6sDFNJY4QfF
OF6ONnc9pUb3oLfBRDtrp4FdudEiqOMiFHsRbP8tljzOFXkc3/CmHCqqmVQ2tN7c
hS6cXO1bcIrcLln/vRK1YFw4VxvFh+ywQNVJNizgvVHljsgrlmfXjWF0BhU+TCGK
oHzb1i8i5i1FTK+YLtZAgvsHOv7qqzJFWDQB++/GjJx9i4+PwkLaR/qOTU3q3ftp
VOIVH0U96m3G2Z6muWMYA6qWDgFPG0TG367jUdw2USJztOR0CreunID1ZcOz0KIm
aAbSSBDa28uglUF3SzkMc6A5HiX9GtaDG1DuRR85gmK7FogzE0rPGCdmOfPqJFKW
EGd7Ood+BIi/u7WbR0bEU8QJDrnXpaQbJAzZfm+Xrfpy2kpxIsjBaGienc5jFCLS
2l5yMkR6XQrEN4U6PDC77V8SKf67A0iCWzhrQNk6rIf0AYiOV3ZX/v0GGlJLnrhS
hfKNsIP5tjpMNNxAyOkrc8CVR2w85miA0JgNUrqceej8xqa3DsAbHEhmPlD/jq9s
tbZrTIyHAqW9ZOc5VZEqpuDnO8RzVhCk6tESol/vN82L/39rvm8w/aVauVxGRReM
9MA40Xj606FYmmgWJBdJcJ7mzl7kAOnFOu0GAHQVe/YAxXwt7TKmykEuEu0rmcXm
5WkQi8zwzqFnx1yoe/W2
=BWUM
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--

--===============1573084783802632803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1573084783802632803==--
