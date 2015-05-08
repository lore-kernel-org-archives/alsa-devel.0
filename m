From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Fri, 8 May 2015 11:25:52 +0100
Message-ID: <20150508102552.GZ22845@sirena.org.uk>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>
 <1430837158.8043.61.camel@loki>
 <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
 <1430997961.17543.38.camel@loki> <554B9BCF.8040201@intel.com>
 <20150508081339.GP1541@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5740601044803134986=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 652BF265AD0
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 12:26:03 +0200 (CEST)
In-Reply-To: <20150508081339.GP1541@lahna.fi.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5740601044803134986==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PPsOEKaEsfKdE9T/"
Content-Disposition: inline


--PPsOEKaEsfKdE9T/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2015 at 11:13:39AM +0300, Mika Westerberg wrote:

> Looks like some of the context is lost but if I decode the above
> right, you want to know if there is anything that corresponds to
> of_get_named_gpio() in the generic property API?

> You can use fwnode_get_named_gpiod() if you need to extract a GPIO
> directly from firmware node. Otherwise you should be using
> devm_gpiod_get() and friends.

Right, almost certainly devm_gpiod_get() in this case as I've said
several times now :(

--PPsOEKaEsfKdE9T/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTI8vAAoJECTWi3JdVIfQclwH/3K0edvgVWyeHfB8x/LiS8uY
mwGB9BrQq01JBQ+eJXXWW+KNHfckSZ5TbiBrlQfi+xSX4nVrqXM9mPDWQ2jd9W7u
pnsPzRb+H4KSu+HaWTCxX96TS0wNwT4CT3onxbgOg6/Dv/9w1FzRrpVD8GsvRYOn
zxsWDzsIli0WPGnixH+1EF1/f3+0hS3/zPBt8VU00/5YKcXBtkJbBFEHn3fxZVQN
/pR3JCnNFbUM5EVGFk20U+8lLYwfGNR7RVdrVo1XRq/TwfRAx71tMLQS+ANkpwpr
SjT1Txp+r6bewK3VG3dXu3p0TvFMo6xNt3mc1mQszJoIobvX+RNGFrSjg1KdSsw=
=hBuk
-----END PGP SIGNATURE-----

--PPsOEKaEsfKdE9T/--

--===============5740601044803134986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5740601044803134986==--
