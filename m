From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: DAPM over two regmaps (and a mailbox)
Date: Tue, 20 Sep 2016 08:41:59 +0200
Message-ID: <20160920064159.GZ8719@lukather>
References: <20160919105419.GK8719@lukather>
 <20160919111247.GL10189@sirena.org.uk>
 <20160919113415.GM8719@lukather>
 <CAGb2v67FSOKKREr49xkD6J6APs=sc=iVvmBJxQ4n9d2L9_oGjg@mail.gmail.com>
 <20160919191543.GU8719@lukather>
 <CAGb2v65qARPr1cEL5oU6bsiwK61rFQx4Gma=Z0r8DK5WTBOnmA@mail.gmail.com>
 <CAGb2v67dm6UYJhy0ZLkLhp2J3HOotHWUKroEpv31GMvFnL9PVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0190578977288694152=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AFFF266D40
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 17:46:06 +0200 (CEST)
In-Reply-To: <CAGb2v67dm6UYJhy0ZLkLhp2J3HOotHWUKroEpv31GMvFnL9PVQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0190578977288694152==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GhOjTe89cQfBPqWP"
Content-Disposition: inline


--GhOjTe89cQfBPqWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2016 at 08:41:02AM +0800, Chen-Yu Tsai wrote:
> Turns out I hadn't even added the file to git, so it's still there!
>=20
>     http://wens.tw/sun6i-a31s-codec-analog.c
>=20
> Looks like I finished the register definitions, but only copied the
> widgets/controls from my A31 driver, and haven't fixed them up yet.
>=20
> Also, my use of SOC_DAPM_DOUBLE requires some work to the DAPM code
> to support updates to two registers, rather than two fields in one
> register, which I already implemented. This is, and the driver, are
> on my TODO list.
>=20
> Let me know how you would like to proceed, so we don't end up doing
> double the work.

We'll probably have something ready by next week. Maybe we can just
send the patches and start from there?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--GhOjTe89cQfBPqWP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4No2AAoJEBx+YmzsjxAgPa4P/2TJxe3U+yLdh2Z/nWf3fRK6
ZeqYK0B5d3vWK3DMMCUMSAmA217xHLQg+fmnMEKcVFNH2E/gbN3l1IrEUuzhD/Xx
3SLwwaETGRutiym6l7uOEVKRcXbsd2fraGFOWxJO9CJuWwfdTTSflAETrhiNdlrX
TlBtKIAFR3dVblnGPvtouA2DlWRgJDvqBVtM6qNmd3cHLIw5F6DkhwYJhUh+XFUu
B2L9L8MYGWeK0yoYIyE6iY00l/j5eTyyydq1RMyO2c3RitpmeUxspfS2nP0wHH3H
jgNmvGZAwdRN71ZCrljpDGZi8CDINMqAhMrm0swiodB7Nyh8V+BxKz9u+qYCAVzq
BlodZ5yyjzT39x2H996zWri3Ulh8EldX2gwH07XPp01571OGfYgYY5S6UahkuLuo
i34kt+RWzkEmsHFs2Kcot6Bup7TOJKHnR5nk/REtAB1WL3HoC0wd4rqqeQiFYyNk
VJeX5QS+QbD6JNUIBjkw7OOiNrgTKCB6oe/f668AXIA5jsXSfpOQQrFQN4ZH7m52
oNU5MZApfsBP7QB3/U+V9gVMlBH0RRrO6lTlog9C7u1SDSioJCKXOHEiRDFGTOIJ
RquzJXfzW9WSLRONlwpIwI81hzJCVV0WepdFZxefYh1KJEZ3l+FmoumMCb9wy7Kr
utiQWlg7vLAdGXV4tVA7
=KbwB
-----END PGP SIGNATURE-----

--GhOjTe89cQfBPqWP--

--===============0190578977288694152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0190578977288694152==--
