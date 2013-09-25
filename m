From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum
 workaround into SPI I/O function
Date: Wed, 25 Sep 2013 13:55:38 +0100
Message-ID: <20130925125538.GP3226@sirena.org.uk>
References: <1379960073-23245-1-git-send-email-broonie@kernel.org>
 <1379960073-23245-2-git-send-email-broonie@kernel.org>
 <20130925111954.GG5132@lee--X1>
 <20130925113103.GN3226@sirena.org.uk>
 <20130925114643.GH5132@lee--X1> <20130925115502.GI5132@lee--X1>
 <20130925123536.GO3226@sirena.org.uk>
 <20130925125139.GJ5132@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7709953782978119088=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 60BEB261B2E
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 14:55:46 +0200 (CEST)
In-Reply-To: <20130925125139.GJ5132@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7709953782978119088==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9g2r9e2kvGs7M7R"
Content-Disposition: inline


--v9g2r9e2kvGs7M7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2013 at 01:51:39PM +0100, Lee Jones wrote:
> On Wed, 25 Sep 2013, Mark Brown wrote:
> > On Wed, Sep 25, 2013 at 12:55:02PM +0100, Lee Jones wrote:

> > > https://git.linaro.org/gitweb?p=3Dpeople/ljones/mfd.git mfd-asoc

> > Thanks, could you include the first patch as well please (there's a
> > dependency for bisection due to the BUG_ONs)?=20

> Okay, done. Same branch.

Pulled, thanks.  That URI isn't directly pullable BTW.

--v9g2r9e2kvGs7M7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQt1HAAoJELSic+t+oim9jdgP/jv41dbYWWtFgmmrUSw84Xth
MekE1Dm+57Vh8EXATIW60nbOO3lcg72msJrg+fdDzQasOWCbzb6AbMmwNYqp5kQt
pZ1iRoHX348+De5rNeLxz5+V8gthqw0IET4dk2Dj8DKlCKABn7+kjvkgm228OMm9
0+UoM3u4RvaxZNFNTJPpSn2C8EV5kmzJcQIDdMtxcKc56NztnU45YDWTBjRUs1tn
xYZ76nK00/m9oLGmD+C4sN8W4H5+3UkuQqfqbUGnxIsmkvQ65qB//XnDy3bAJ6ZJ
StgzG89pgqIY4mdyEGRdU3ItWscNfOq9b0VEG7QBkXHRCvjlms1w5L0H6BK0e5cJ
4PH9nblKs/RbVJt2wKK/8fRKJGOT2R+a3Pivu6sRm/tEpBC4h7Ua3VPnhdRjNMv0
v27jmAhslp7DuS3x19pckaKuuvo6Op0Ef05cLuZLnn9vYeTUxtSYywdC4v/Vc+E7
6z9mtkQN2qPDY/zffQGdVGuHvhwJl7e6mj7q+ysb3sxdmp+krY2YBQHt4+TuT4Zd
LX8DzW8L0C0rnTVwcUXzpZ/bEfKa0jmdVIYUmzh4NwZmLLS0O08EoIYI96ZwAnnh
iEy283XMreWR9VLwlE4APcwrHlgQYa1kXVSZBSguVOn858yawLtDvjytgCz5NAoe
4y0qKFrt1D1xVIDYk7Xg
=4r01
-----END PGP SIGNATURE-----

--v9g2r9e2kvGs7M7R--

--===============7709953782978119088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7709953782978119088==--
