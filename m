From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: rt5645: change gpio to gpiod
 APIs
Date: Tue, 2 Jun 2015 18:16:55 +0100
Message-ID: <20150602171655.GX14071@sirena.org.uk>
References: <1432894607-28489-1-git-send-email-bardliao@realtek.com>
 <5568944C.2060509@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4430223586586047245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB47226053B
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 19:17:05 +0200 (CEST)
In-Reply-To: <5568944C.2060509@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, Leilk.Liu@mediatek.com, koro.chen@mediatek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4430223586586047245==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gpOboRovIPmaBszt"
Content-Disposition: inline


--gpOboRovIPmaBszt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 06:31:08PM +0200, Lars-Peter Clausen wrote:

> Three things, don't use the _index API if there is only a single gpio for
> the property, either don't use a name at all or use a descriptive name
> something like "hp-detect" and use the new version of the API which has the
> flags parameter.

> So this should be: devm_gpiod_get(&i2c->dev, NULL, GPIOD_IN);

> and then drop the gpiod_direction_input()...

It seems better if people use names where possible if there's any chance
that we could add support for other GPIOs in the future, that avoids
confusion further down the line with extension.

--gpOboRovIPmaBszt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbeUGAAoJECTWi3JdVIfQW6EH/A8HRuIQQJ+/NnO8vDY/HJLh
HG2I+9zDfsWttu9T2XWWKwOo9akgFI3g/W7BkXDee0+/9icR5gdmo/NW/6eLQwv6
u8c8XO7m5e94nMg4b3x6MYjOtA3yKl7HjQ8M+ZYtpMA9z+K6U2/Zv0cFXb6PmbpF
amsWW8XKe5NWVM7LIFZCeStx51ktuVUbqk889iCiIC3Y+CWKebsTaeO9a5PxWxL4
28yUlpRvVB0A7LbYrXvy82XQDCF0/sFLGqiR8vAb/yo7CTEW3DZY3yZyi4Urvjod
Ez3fE3miSpN6DAxLTkLayPDzzXfAFXiZpPaY3d5mZg19n2z60T/uz+Zma6XJjmk=
=ktSy
-----END PGP SIGNATURE-----

--gpOboRovIPmaBszt--

--===============4430223586586047245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4430223586586047245==--
