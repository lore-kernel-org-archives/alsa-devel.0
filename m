From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: fsl: imx-spdif: Delete unneeded
 test before of_node_put
Date: Tue, 7 Oct 2014 20:01:22 +0100
Message-ID: <20141007190122.GB4609@sirena.org.uk>
References: <1412706598-18796-1-git-send-email-fabio.estevam@freescale.com>
 <1412706598-18796-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4617921406429462967=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33463260427
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 21:01:35 +0200 (CEST)
In-Reply-To: <1412706598-18796-2-git-send-email-fabio.estevam@freescale.com>
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
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4617921406429462967==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ATpkSYPIqF1Y+gtT"
Content-Disposition: inline


--ATpkSYPIqF1Y+gtT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 03:29:56PM -0300, Fabio Estevam wrote:
> of_node_put() supports NULL as its argument, so the initial test is not
> necessary.

Applied, thanks.

--ATpkSYPIqF1Y+gtT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNDiCAAoJECTWi3JdVIfQ+xIIAIa1jnk3V3dkjUaKeANjw2mB
7ECV6iKUY1K2LE5D0NKHoqO1cE9D3LPkdAFZNcVMPml+paXVHGbUTxQAs53YqHdi
d+++PmsYX9u0G7VeoJgx7rBJS663rrlyYtDC9sf9ZSbdq8CwVCxJGwfciIp1Vne5
b2+GDRcQBsA5BfJgbADLDIS3m0wEjMpfVV/B+5ZO7CXwRGsVpa7iLsw8glfavlo+
5WKx3xyIOT1mjeyPhijj4oJEPOMISH4Ym5sX9eyfZHc1nCh7cw6D5qEZWO0+seSh
Xg8HidmBs1cqDt8uWeEAZSeHDvJSfzaUUtu6CT3TYhTO8NdCJwLZvDzU2AWl0bE=
=gHWZ
-----END PGP SIGNATURE-----

--ATpkSYPIqF1Y+gtT--

--===============4617921406429462967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4617921406429462967==--
