From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sirf: Move the tx rx enable from
 port to codec, that will not need register sharing
Date: Fri, 21 Mar 2014 19:20:02 +0000
Message-ID: <20140321192002.GS552@sirena.org.uk>
References: <1395301579-2960-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6569581511991056803=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF919265148
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 20:20:15 +0100 (CET)
In-Reply-To: <1395301579-2960-1-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============6569581511991056803==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWOY2/vB4uO4FuME"
Content-Disposition: inline


--JWOY2/vB4uO4FuME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2014 at 03:46:19PM +0800, RongJun Ying wrote:
> From: Rongjun Ying <rongjun.ying@csr.com>
>=20
> The port driver only used to register component and dmaengine pcm.

Applied, thanks.

--JWOY2/vB4uO4FuME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLJDfAAoJELSic+t+oim93hsP/i4N9dOBXgYSR9HpYilZ3k1v
uEV8vIz17+M6cZFKeBpHvTyQurihjhtPWrET/4WttFDZ6TAhRL0y2nrH+0N9OKQX
QPze+MQOtLOex6nL29Lq15yaCiTW4k65gIk6fiF9KZqLtYtrtET+RaemyPAUU2eS
N2lX7rd8wFZ1EQVhgjZ/ipIg1voA/90bGYx8FGjhwfkpcHRadLWMaTbbSKSUA15U
1bA3k3n0MjR4MiOuFDyT07BhSsLzJm8qdgGbuJpbO9DWXbX/z08WbDQ3BgPFeZ3m
3MJrLlkyN3AdGAwb8vYvvmD/utJVufCcpDX/y1WBi+ZLby/DKBFxY9F8uRtda2Vw
XndXNebbRDLdz9acQHJGyWlCgaeHYI80UQXRJTqMqPqMDwIGDkVQJxaq0k0ayfAo
ojUSXgkImny4QPL6au2/BG8WTtXBxTcBP0RJPpa+at17ZZrIDF7TfNjhbk7kaS/o
PWdZy2f8o32+Rh/1CUqMjuLhy87XHSL5FVQQExKddTvlDdcZsOtUbzLLJEplrj7n
l/1+T0BgPbEvRDUvpxN6ohwmVSOJ35mql3bB0RYjjsovMwkpA37Mrt5sUOK98xrr
eFRzQqDoBDQ6dPvDo7CPjFMzKnYLB++MOnw2vh/7VG5iJLoZc3Mx88w4+dmKUrXt
gcLhPLxJplGq+ftwY1M1
=g3pJ
-----END PGP SIGNATURE-----

--JWOY2/vB4uO4FuME--

--===============6569581511991056803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6569581511991056803==--
