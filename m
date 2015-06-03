From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: rt5645: change gpio to gpiod
 APIs
Date: Wed, 3 Jun 2015 13:13:32 +0100
Message-ID: <20150603121332.GI14071@sirena.org.uk>
References: <1432894607-28489-1-git-send-email-bardliao@realtek.com>
 <5568944C.2060509@metafoo.de>
 <20150602171655.GX14071@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70107135C@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7856962574172661380=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4D0326500C
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 14:13:45 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70107135C@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "Leilk.Liu@mediatek.com" <Leilk.Liu@mediatek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7856962574172661380==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EzakZlbiokRMC/se"
Content-Disposition: inline


--EzakZlbiokRMC/se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 12:03:06PM +0000, Bard Liao wrote:

> > It seems better if people use names where possible if there's any chance
> > that we could add support for other GPIOs in the future, that avoids
> > confusion further down the line with extension.

> Do you mean use a well-described gpio name such as "hp-detect" so that
> we can use another name if we need to add other gpios in the future?

Yes.

--EzakZlbiokRMC/se
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbu9sAAoJECTWi3JdVIfQnKAH/2EBx9n+A6NMyXn7ezUhQBHt
GuoKwnZN2ukacvJtot7uYDVk1Hb9my/ImmSsjqwH5r6Z6TVLLOnn4PjGoJJXs65a
YBOQTKGibIUvaG92cAtgYx05UbPY9nq8sN7cvCoJPjqyMAFxI8Rau9SJ5rLw66JR
2qXvPii485XO3d4fXJN/Bkp6Z7fuwKAG9lTYPc5OXP0YZT7m/vQ+j4UXlPxupkye
8XRMfP7yNi/d+AYXMuE7HSq6wK5gJCQx0L6+l6ip7qwpcfgBCul0eSPGS6YB6GiP
1KuJs+194X/vWgeYKiw96boK4EH4rqHLhoZmmgem9OsxkPsxy4toaRclN019k7M=
=aZN6
-----END PGP SIGNATURE-----

--EzakZlbiokRMC/se--

--===============7856962574172661380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7856962574172661380==--
