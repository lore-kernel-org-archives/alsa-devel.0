From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
Date: Thu, 15 Aug 2013 11:33:58 +0100
Message-ID: <20130815103358.GY2401@sirena.org.uk>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7852648203913884482=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 258CE2615D1
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 12:34:01 +0200 (CEST)
In-Reply-To: <1376296961-20564-3-git-send-email-zonque@gmail.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, eric.y.miao@gmail.com, arnd@arndb.de, s.neumann@raumfeld.com, haojian.zhuang@linaro.org, rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7852648203913884482==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGDvG9BNY5+B3nxW"
Content-Disposition: inline


--ZGDvG9BNY5+B3nxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2013 at 10:42:38AM +0200, Daniel Mack wrote:
> The pxa ssp DAI acts as a user of a pxa ssp port, and needs an
> appropriate 'port' phandle in DT to reference the upstream.

I've applied this and the rest of the series though I'm not really that
happy about having a binding for the DAI in the DT since there's at best
tenouous hardware there.

--ZGDvG9BNY5+B3nxW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSDK6TAAoJELSic+t+oim9thYP/jTfq+XfVyT2VN8Q2RyB6mMU
gFMn4cBoChwCpxmdsIYbScfJbgKKOC0GtO3tfL4E6Octm3M72wMjL1eOqjD0fDv2
jF1/YmFtmH204CPnzkcL7S9WVg1+swjrlGA+MARLXbfchSUPYGjQ2k+XcV3OS2+0
OwFRKjYnGIyhpmoNylUx6MMHCIvClZLJHZplWIOBQtRHGb5tHrgDrLIEPHBfwD8B
7ZteSvSEfG4i/f7BP4Con7ztrD/f6GR2tIQSly+qCRI+oDV7eqdv1F7kd0GfnQOO
XysVHC1MRCuJ8F5uL4eJwMyJB4kIO6EZF9dJIoHhGghLF2ARhaIrZd0qgnqBU6+J
EI2PGZoiRFvb3e7/IdW6Dr3a1+b88YmcL/Dt8IKsrShXtJTpvr8YJE8wlPBae64Q
68yT1kmeDNsVR+yBcOWPWQgjMCOU2956xJE5qSRfULNaEIkDKijXkdDBdaSnwtMh
CmZxyzt0Xe9OiJaLV0onvFByQobZSYVXg+wUopjp9XfHglBgqTdnZObODkHks5mm
ntDbTcopd8VMdtdjmLte6pGKa/nFOnW/kiXpRkQecXZa5iw2oeeMz2kqPTFh5SmW
Yn/euUU8G57KyKFxMbiZePVu+Bdp2xOQPVzYQ5j067DPJt6Qca7POl7a2vUNTG/v
SwrVKWTo4/Men4SngxMy
=Cysg
-----END PGP SIGNATURE-----

--ZGDvG9BNY5+B3nxW--

--===============7852648203913884482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7852648203913884482==--
