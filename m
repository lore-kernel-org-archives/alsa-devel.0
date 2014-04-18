From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: alc5623: Add device tree binding
Date: Fri, 18 Apr 2014 17:33:51 +0100
Message-ID: <20140418163351.GI12304@sirena.org.uk>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
 <1397749994-24983-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9140759709424352458=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F5502616C9
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 18:34:12 +0200 (CEST)
In-Reply-To: <1397749994-24983-2-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============9140759709424352458==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRKAdR3hOZdGUkn3"
Content-Disposition: inline


--TRKAdR3hOZdGUkn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 17, 2014 at 05:53:10PM +0200, Andrew Lunn wrote:

> + - compatible:	"realtek,alc5623"

You've not added an ID table to the driver for this.

> +  - add-ctrl:	Default register value for Reg-40h, Additional Control Register.
> +		If absent, the default is 0.

> +  - jack-det-ctrl:	Default register value for Reg-5Ah, Jack Detect
> +			Control Register. If absent, the default is 0.

I would expect the default for these to be to leave the hardware
defaults untouched - why is it different, what does setting to zero mean?

--TRKAdR3hOZdGUkn3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUVPsAAoJELSic+t+oim9ueMQAIr/ldfaKhLHIsCiU8T+dNZ4
AqwSJD1C9g2OaopSVC0uXiawkrfYJ/HEyjL9khScds6qYwhoRpETXTitf1uLWH2n
FXKUaBQsUZgMK81QX4HHa/E+2kUDyLmn71vpOCkU6R0xSVvATTiDkchTguJu7zUj
VSx93j1KYL83x09gRPvwqeGBfmNZG6vabQ+psknbDCFNnzXiknjhm8Izm7uOwc7U
kR0qKmsuPDWU208Ds4WFACEdxUub/hRvWZPvldrol+gqLCHdeswBtHiKdsRuaFLH
UyT+Rtpmik2CHGZOhL1gU8qeuZZY/7e2g69X/25FNLqvV+JUloxR/oNl49HHDgaS
H5/Tl7vqxh0mvK5PMsAm98//SVpMLOlJMgdjeknhzFqQT1Ozfy8QkfgVKbFRrJIn
eBz36DBxuklnwsN0u4r9Vt7gFyN/iowIv2qcoWAyiVKb1UraH6hDOgyfnECRFQ3O
QSZlQjt4DIHfh9AbcX9x86BJ2UbRsA910Riu80Gjm7/jwTAp8Y+LIptugAsR7mtB
UOs4f2jMvarDoFY3lRDfzF0QYWoHkDlD/mdlkt4nX+eX5+0g3FIcrhuNy+5gDifq
FT9Rfz1Psf2B3VrfmReDxMQ4zLQl3Jq+5EdnDqm3Gq/qGKpB0ja0FW72xaX8TzM/
RJW+Y5c9lR9mLVsEGXu4
=tdr9
-----END PGP SIGNATURE-----

--TRKAdR3hOZdGUkn3--

--===============9140759709424352458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9140759709424352458==--
