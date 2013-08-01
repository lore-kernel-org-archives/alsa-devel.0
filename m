From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: init delayed_work for
	codec-codec links
Date: Thu, 1 Aug 2013 16:23:56 +0100
Message-ID: <20130801152356.GW9858@sirena.org.uk>
References: <20130731131627.GA32631@opensource.wolfsonmicro.com>
 <20130731132522.GP9858@sirena.org.uk>
 <20130801151336.GA1112@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5910625712454011248=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B98E7260818
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 17:24:02 +0200 (CEST)
In-Reply-To: <20130801151336.GA1112@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5910625712454011248==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l+pUxxqDKySPXtXF"
Content-Disposition: inline


--l+pUxxqDKySPXtXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2013 at 04:13:52PM +0100, Richard Fitzgerald wrote:
> On Wed, Jul 31, 2013 at 02:25:22PM +0100, Mark Brown wrote:

> > Why is this better than pointing at the normal work that you'd expect to
> > be used there?

> By 'normal work' do you mean the close_delayed_work() used for
> standard PCM DAIs?

Yes - making up this empty work doesn't seem like a robust approach.

--l+pUxxqDKySPXtXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+n2JAAoJELSic+t+oim9b+8P/14vvuE2H3/wOa8+XFu5TNx8
zY4ryRH5SXvL1CDOmOth16EwDjI+bqeDB7wI0MzafaE1MHOCHW84KLR0Bhso1c2E
KDTecSl5geJkimJPiqlEJfbLK0VnP+rFQlz6aEBpl310+vs7krLxOJLxZKDgQJDG
81WL5MD6gMfr/AoFyg8LIxDUE7oYe9NwWHoDwZaugO81AckOBuVHB4b1q6MppTbQ
xkCwx3fAnW5/suUj/aaA2IaWFIeHh5gDko+JXmJH/m0ddI/Kle3Y82Z7Fcde5BIQ
TqSWsW+JI7jbwPzpyOG47oBUc2ydPJ/+pPcQemU8Vi3pPuAibG2id5OYLHfVkeLS
/hJkPxFEXrorZUbfUSwV4KnICQTy1lP9007Lu94N29PEAFXoiLf99oSgDSePHIo/
mEinb8TkpNlq5sH/WI4sg4mD/xQkuVIDsbfhtamG492lbwwOi7k4Zc1699BNv/GJ
p50+WDv8Ck4BIIaQ86z0pKj6pP8pR0eV7Vv2pqx6co9EqALYBfYFTTaUd+7G6V2Q
oAcDBBp9CKUBYTAlP+uSHoEg6Z1DY4lncfIOmy8AXTUnWKBX6zu9U4qBMEw+PM9z
5uyildvUtKiv7ulODxtsuN1UWTgc9cpjwKb4hT3xdIW2PWB7qvqxEOmIvBMTvdXk
3RX5u2zoMCrsboq+AEqY
=4ws9
-----END PGP SIGNATURE-----

--l+pUxxqDKySPXtXF--

--===============5910625712454011248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5910625712454011248==--
