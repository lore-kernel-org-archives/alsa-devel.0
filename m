From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Use the common interrupt
 line if supported by the SoC
Date: Mon, 19 Mar 2012 15:44:38 +0000
Message-ID: <20120319154438.GB5132@opensource.wolfsonmicro.com>
References: <1332170183-25474-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6709843640522262479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F3BC104149
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 16:44:40 +0100 (CET)
In-Reply-To: <1332170183-25474-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============6709843640522262479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2012 at 05:16:23PM +0200, Peter Ujfalusi wrote:
> With the common irq the driver only needs to use one interrupt line, and
> it provides better debugging possibilites compared to the legacy TX/RX
> interrupt lines.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZ1ReAAoJEBus8iNuMP3dvbYP/jNEpusL76laZuD/ATz2wWE2
NJhxaaL1Uy54qgsueZmwOHv9KSv296Sq5rtNoL9lEuVAOA5t3BYveaEQLWnuDuCK
57rEwn7bE3s8chQSHNEuWoN0F6jdQ76JPZJssGVl1o1RftGfz7bt+m8+GdctyRAh
bIl4ukZstrRNC5wq7bJeFdfhc4nuBZSG56xJU5VhBR9hAnmtO4bFwKwbM4dg21Sc
7HWDloTH02ZtrygaEsO8DlaGwWD0UCPESMCOs+LB9qnHmpcV1qYx80uFJaBgSXle
9w/ouihxTqZzxKD6U85zarDXCZUbplFd2VrdRowHTtntuXz6rXTOQd4Q0pjaIy4t
sTCL4fQ4UdZPvKbWwieDqIACaqHwMNH/YrXPhqMe7hHEw5S7BOGiqD0RbhtpwE7u
Dy2Ylw+jOhQbOZMozLbvR0FkPTvO6s2EMcbqU7qvpL7Pz6LaG8RxSyG9vlvLYu1N
eogvx6O1/K2dWWMf2A44fLSQcMjrxA5V54Qdr+kz6h7VFTUGviqSEhPVtGrFgw2g
tZaaicWxo8x95gSOMjgMKk5k4fJNB/HXK1w2O2NWIgMFLFgMY6lV3KUrhfNmJxCS
45ycS4sLLD0CjT1RFlhNLQJyDeDD+i98jJHuUtAkwlFR9PcQSvUYxON88QBga2A1
bA2LP86yVvc8fmcEAjGC
=I4yT
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--

--===============6709843640522262479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6709843640522262479==--
