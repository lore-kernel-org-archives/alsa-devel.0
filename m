From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Adds push button support
	for rt5650
Date: Wed, 22 Apr 2015 12:04:13 +0100
Message-ID: <20150422110413.GR22845@sirena.org.uk>
References: <1429497442-13021-1-git-send-email-bardliao@realtek.com>
 <20150420204114.GI14892@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D701062B62@RTITMBSV03.realtek.com.tw>
 <20150421104814.GF22845@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D701062EE9@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4048357580209525328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD142260538
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 13:04:22 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701062EE9@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4048357580209525328==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ep5m4srWGXPl6O+g"
Content-Disposition: inline


--Ep5m4srWGXPl6O+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 11:41:48AM +0000, Bard Liao wrote:

> > OK, you probaly want to move to separate default tables per device.
> > This is something that should have been called out in the commit log.

> Do you mean we need to write it down in the commit log and send
> another patch to use separate default tables for different device?

Yes, that's fine.

> Regarding the different default tables, do you mean something like:
> 	case RT5645_DEVICE_ID:
> 		rt5645->codec_type = CODEC_TYPE_RT5645;
> 		dev_info(&i2c->dev,	"Codec type is: RT5645\n");
> +		rt5645_regmap. reg_defaults = rt5645_reg;
> 		break;
> 	case RT5650_DEVICE_ID:
> 		rt5645->codec_type = CODEC_TYPE_RT5650;
> 		dev_info(&i2c->dev,	"Codec type is: RT5650\n");
> +		rt5645_regmap. reg_defaults = rt5650_reg;
> 		break;

It'd be better to have different regmap_config structures rather than
changing the register defaults in the one structure but basically yes.

> > OK, can we have a comment for that please?  We might want to extend
> > this in the future as the userspace ABI grows richer (and depending on
> > how things get reported we may need to synthesize at least a double press
> > for userspace).

> Do you mean comment in the source code?

Yes, please.

--Ep5m4srWGXPl6O+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN4AsAAoJECTWi3JdVIfQgNwH/3esK6bxlyS2NWp5U507DApy
NkAlEZskAWZaydyNIeilRp2Xk0banfBpwgCcfFfNbXsX/PqbcAKL+iDCtnsyC5u9
7nW+WSdK96qGANIQwCUn61ZcvGxXOUEgdvsW6zKcLqTDEcVG2TCejElpfcZgcy4Z
x2H9k4HYJquPi0ngiXuQQMT/cbBEdQU3zF5oSZ5RMojUyYvAeDddsswW9z+EAt9Q
U68Ze5EHlbWfBQASvoOsZRwZa5DI1GkMA92e3QPwREUYnP+iaRg301Wi9W9Haezb
EZyHI1mgffVptXPhQUL8N/abC1usTbg9PMTUo5piPCTQK77oQKao6i/HXhg60LI=
=EuM8
-----END PGP SIGNATURE-----

--Ep5m4srWGXPl6O+g--

--===============4048357580209525328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4048357580209525328==--
