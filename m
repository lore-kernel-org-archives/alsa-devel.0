From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] ASoC: alc5632: Use params_width()
 rather than memory format
Date: Thu, 9 Jan 2014 10:33:16 +0000
Message-ID: <20140109103316.GD31886@sirena.org.uk>
References: <1389210723-16535-1-git-send-email-broonie@kernel.org>
 <1389210723-16535-2-git-send-email-broonie@kernel.org>
 <CALq1K=Kss-NUYB-mmhOjCbxSjhaRO62GpnY95rFMzruo35i=fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4476707263368730823=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C64F826515C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 11:33:23 +0100 (CET)
In-Reply-To: <CALq1K=Kss-NUYB-mmhOjCbxSjhaRO62GpnY95rFMzruo35i=fw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4476707263368730823==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0u1Vgq3WS4iAcgZo"
Content-Disposition: inline


--0u1Vgq3WS4iAcgZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 06:55:17AM +0200, Leon Romanovsky wrote:
> On Wed, Jan 8, 2014 at 9:51 PM, Mark Brown <broonie@kernel.org> wrote:

> > +       switch (params_width(params)) {
> > +       case 16:

> May be the better way will be to use define here and not hard coded value?

No, it really is actually a number of bits.

--0u1Vgq3WS4iAcgZo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSznrpAAoJELSic+t+oim99RsP/RPpbcJQvRgHiudgwQDGAHyy
ep3JPKhTDEBkJpH6W3LG4U8DNoYVbj2zLbZHzXBFfcjv0Q/YLiRv170hPnUT+J9P
1gED3B6J9pUlPG9Mc1OIj9d/f8XoYcE8dKI5lA/GeCl4dgqnJrKyb6rcIzk1n2tX
VxITnX3LHVzjuyqrNszHDcjrQfxnhCHchyEY05g8zMrC9G6O1cWGBurSWp6Yz4ym
PX/i+l1lQSaG61Zj4C3+ST4nw6+zIEDpXTWK1erBMT0nfjnS0GPFXdGOa94mchRL
Jx/crv+BKCjIRpYzaUKrBKqKCLtxk5iEe7kf7GESNH6eR8goiyn5aT7zKVaG//JL
ypIdQS6ZU4cmfmXvu4rpYJZ7RF1//jm55oixFHStulw6fbIc24Shl+9akbBfmgeu
0+VIa6BVvBbMZtVwtbxbc8ZCTiOVGj688Pcp+f4P3DayVhCSOWn3b50t3tfskkAg
z4mls7Iw0W1Jz+1edgRxhKmya9c+v8bVvl1eFzJA4UArY5+cFVwRboIchrRZLal9
1TeZRZzHWOwZ/JaZZHOlHBIscrSQmJOfBRKuD9DOb5VQdiJIEVu040Up4Cg0+TOL
5RcCc1jACzpgiUjBq+I50q/xbf1C41Ig6gt3N4OsVu9OSk6sak795jaHUTpIswkH
RjMsMKMAHP6hGjUkw+9J
=dqVd
-----END PGP SIGNATURE-----

--0u1Vgq3WS4iAcgZo--

--===============4476707263368730823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4476707263368730823==--
