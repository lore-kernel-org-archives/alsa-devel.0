From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt1308: Add RT1308 amplifier driver
Date: Mon, 13 May 2019 15:56:08 +0100
Message-ID: <20190513145608.GA5168@sirena.org.uk>
References: <20190416022246.10121-1-derek.fang@realtek.com>
 <20190416153510.GE4834@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B8280116192E@RTITMBSVM07.realtek.com.tw>
 <20190417150518.GB5703@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B828011660AC@RTITEXDAG02.realtek.com.tw>
 <20190508064537.GN14916@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B1144E@RTITMBSVM07.realtek.com.tw>
 <20190512080621.GH21483@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B13EE2@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1556604960536457668=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA2BDF8961A
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 16:56:23 +0200 (CEST)
In-Reply-To: <BC6F7617C38F3E4E8CA887E07B35B82805B13EE2@RTITMBSVM07.realtek.com.tw>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, "bard.liao@intel.com" <bard.liao@intel.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1556604960536457668==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 01:54:08PM +0000, Derek [=E6=96=B9=E5=BE=B7=E7=BE=
=A9] wrote:

> > I'm confused about what this limit is - is it just some arbatrary limit
> > imposed in case some board has problems or is it an actual limit that
> > comes from the chip?  If it's a "just in case" limit then the board
> > should be the one doing the limiting, yes people can break things but
> > it's difficult to get decision like that done sensibly in the CODEC
> > driver in a way that works for everything and the general expectation is
> > that this is all for use by system integrators rather than end users.

> It is an actual limit that comes from the chip.

If there is an actual limit in the chip the driver just shouldn't expose
anything beyond what that limit is - the original thing I was calling
out was that you're just hard coding a value for this setting into the
driver, that just means that the expectation is that the values should
be user settable within whatever the chip can support.  If there's
settings that can't be supported at all the driver doesn't need to
pretend to offer them.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzZhYcACgkQJNaLcl1U
h9DC9wf4lBweOx0EW6GQZHiGYKNx79ISwdSyjLdm6oZHze5tzPid71jqutTu8oF6
Ok6eXx0Vx31lxHnrJ/6Zsoh74XP0w8Zw56qzBSBknCzTcK4mTng2y/K4JAOEW6Zd
0EVX/99GZB4RHOJghi+QgzBEQzVwu/Ab3c9exj+zG96G3E6ETtjiqCG/tteHi241
2UWOE2VIHsVbI3zxO/A8yTg7Ot4/qrhoGP6CuktQwyxtLfFfHywe8lzxHKIiGYuw
EWpOmHyVN2J97jA54c1kt4jXcKmPA6LqXpYEPUIkHgFwxc5qpQxCg0rM0XnQmYuf
UN2vjCb44JgprxdMuAokjQUVwTLz
=ZITg
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

--===============1556604960536457668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1556604960536457668==--
