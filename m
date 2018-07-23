From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/11] ASoC: SOF: Add Sound Open Firmware
	KControl support
Date: Mon, 23 Jul 2018 19:58:40 +0100
Message-ID: <20180723185840.GJ13981@sirena.org.uk>
References: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
 <20180719185335.30912-2-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5723812271240971052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D87932675FC
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 20:58:40 +0200 (CEST)
In-Reply-To: <20180719185335.30912-2-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5723812271240971052==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Content-Disposition: inline


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 19, 2018 at 07:53:26PM +0100, Liam Girdwood wrote:

> +	pm_runtime_get_sync(sdev->dev);

There's no error checking on any of the runtime PM calls...

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltWJV8ACgkQJNaLcl1U
h9BBrwf8DN+s6+maisQsHjr56hyUfWY/RzNno3KQp9CBX/lQm6UqOsdwHxJkQ4Fb
R47JLMtxpVA5zHBAGzxdgZA9SIzOtbNZ3N7ZUC3zpvbIp5v7T73v+Kib4gykJJbx
tP751l2cgfeckr3g0zN8dSB4NfQaAfAv4KKWDB7LW4hzCVyJ6gukzbfFi6+BqpnV
P8EgL+Tz245LlfaTMODApjwhPiuBDcSRp0FkGNAn9Upzc+Z7/G5uZ6x2MpN4y09l
csWbsFNLMMcayftTNYuSaUgmOderfl/kr8d09iGNAJPyvxCK8rvyZ32l/kwkpARY
Cr1HY0ll52WduHS1moYCPxAXbcKeKQ==
=hEfh
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--

--===============5723812271240971052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5723812271240971052==--
