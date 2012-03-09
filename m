From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Fri, 9 Mar 2012 11:55:44 +0000
Message-ID: <20120309115540.GE3273@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
	<4F591B8D.8090705@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2137836380242901034=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 74E3910B98E
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 12:55:57 +0100 (CET)
In-Reply-To: <4F591B8D.8090705@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2137836380242901034==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2012 at 02:50:21PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:

> > More importantly, the imx machine drivers to be added working with
> > fsl_ssi will not have this property, as they use new ASoC machine
> > driver binding mechanism.

> I want to see that binding documented in Documentation/devicetree/bindings
> first.

That binding will generally be per machine driver.

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWe+2AAoJEBus8iNuMP3d/L0P/jzbcl6EACr5lMFFfdOOg883
Ep2OdqUzTgZTXRH/nFvhakywZazmmcmq08FFApW2i7OCpILkYgJsst1u9FCQ+dvb
EHmxt4vjPz2WxAtjMcOLq6XLlXXXojpeYrYhQyLkD3sp2TavubniSe8ybc3kqbm8
GwkFi6sSdaVmTtKk//5mQR0gwjvE8grRv8Md6zTwhIewut7DC/3z6FrNN4/k7tHs
FtH1eOxYM+5yEPfRrva+nD8DeebXh5cEbQGxcQMNN6VJKJz+9aqwWf/wRi28b68a
XMBN8qip29bCD8Q6oP8k7OQxW6dHICqIeJNUxxsHVVognrLOeILWZm61UgBmyZ9+
QsiRqMftJ1MxmpmJ7nYzjiWweorjzXq4FNNQocx2YKUt4eqZdJ98ozU+KD/bd2uv
tNwIq4EHbxnfUxxeFXKmLMb5AU93bzQQDSl/422UBYBvAuRgjiNf4GJdjZb+Douo
B781cSX1WZ1tyZ5xyjB8I2IeUM0Cap+XCRJSpKs3WvuWgDWBuTq5GbAlWcVYDRfa
pMFh4fMJKN5zqZI2OlqvsOKtBYYm0kE8TUiEZZ5YVP2j8C9SoWqUs+qAD7Dy4Qw4
Fn/yYWtz7oQCk2+fHR3XiCiTwOl1889dJ5KZuE5/zZWy0mnj1kcebPVeePyYDWKy
F0VXcJQDVZdwCIEwOWWV
=o4N5
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--

--===============2137836380242901034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2137836380242901034==--
