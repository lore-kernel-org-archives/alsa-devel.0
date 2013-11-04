From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: fsl_spdif: No need to check the
 return value of platform_get_resource()
Date: Mon, 4 Nov 2013 08:59:49 -0800
Message-ID: <20131104165949.GM2493@sirena.org.uk>
References: <1383565880-19692-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6320105090927771845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (unknown [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 81D17262629
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 18:00:35 +0100 (CET)
In-Reply-To: <1383565880-19692-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6320105090927771845==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ura8jf0QYTXVPAoa"
Content-Disposition: inline


--ura8jf0QYTXVPAoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2013 at 09:51:20AM -0200, Fabio Estevam wrote:
> When using devm_ioremap_resource(), we do not need to check the return value of
> platform_get_resource(), so just remove it.

Applied, thanks.

--ura8jf0QYTXVPAoa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSd9KBAAoJELSic+t+oim9k5UP/RmQ8BBzBX1xtgMSKwlSRK7V
gzmjIogPuiq0JDK3lDIh7ryjVDAiB9jIAvKtwCJ1BD/b0cz2KZYjJ3hb6fugLOsa
yhX2jNggmPnuhNsy89kXa+PC4xsm93ZHyzA+oeDdvu5WjeB01/5J6OE9Wbvi3tz8
XVCBDF754vbjrQypEKqmFs1FhqdXtidGl/TtdBoaZqnRhXDVCNcyINJjlWoAYlGl
NZrbSL0xcXJ6qarmX+kcVebX/cqAdCZ+9k034OLCXzId6mrZ0k5dVCdHDL5aCNyW
jXPbB3h6j9caqBTJ0wlQBJo0HRCSWrZxhdITlz5svQWofS1NLcy8YowVbRHAPmGC
evqGiZTg0FPLoUkx8o4l/V8/1/k3wk9nvAWIkjCfrhki5BGgLmiBCwPy55Egngw3
VkZeXgjdFl+Ps01OLXZtPFtcYgz1boDPMoa7MNFGWe91/0JPuuDSutmBceKwCJbN
HqCaBQxJpeLjqLdPFfeUc/gBJCGbAU7YSQ0ybdqysbOP6hvfYYCCgpniER3ecQC2
UR8Wa5D7oCC1X/VeJYXsCQhcDygKsgVYrE5hMaHFpIoWmG+t+mtM5MvBr43DT/zA
06RUbPOdSe+q5d5Y2Z+g+ZCN67j/7U3EuMEqjAi2X24+xwiHqiVrH+JwYEeFZdI/
NLRW4MV/cUa3WanXDVcY
=48kC
-----END PGP SIGNATURE-----

--ura8jf0QYTXVPAoa--

--===============6320105090927771845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6320105090927771845==--
