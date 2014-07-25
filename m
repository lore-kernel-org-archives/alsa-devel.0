From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: fixup dai remove callback
	operation
Date: Fri, 25 Jul 2014 18:50:47 +0100
Message-ID: <20140725175047.GC17528@sirena.org.uk>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87d2cwvmxa.wl%kuninori.morimoto.gx@gmail.com>
 <1815783.Bld4nzvI29@avalon>
 <87zjfzaata.wl%kuninori.morimoto.gx@gmail.com>
 <87lhrj9m26.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6154161115165345207=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DA012608E8
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 19:50:59 +0200 (CEST)
In-Reply-To: <87lhrj9m26.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org


--===============6154161115165345207==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ClpMRN7ztK9mBQjN"
Content-Disposition: inline


--ClpMRN7ztK9mBQjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2014 at 01:51:31AM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> rsnd driver is using SSI/SRC/DVC which are
> using "mod" base operation.
> These "mod" are supporting "probe" and "remove" callbacks.

Applied, thanks.

--ClpMRN7ztK9mBQjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0pjzAAoJELSic+t+oim9BRkP/RqUW9xk9cffrVJkPYd42h0x
K6/rE+d017gaaRChR/iUjLogxUrJH9XraFSq8Yaa8OflpFn3WVdVmQCeoRtU0Dva
QxHnadE4IMory2Et0E0VN3hfyCgei2sJAYkyKObiwjYdL+nW8LwRJQYPZfwzEq4G
1os37PG9i8aOxFPRkCj1UOMNlu6j194P4mjtHXll5KzOeN5UvVWbEhE90iKG7dUA
K/sTMw0fu1MLaHAKXleVGU6D1O6paMYlbkkCi2wWwMWRnbQckIGcy9pfOzPxDJrk
6A5xP64OjHVSA6jkV6ipCwxOITluF9XyEYQekD+SsMHhYn/+v0L4obwxQ+J6I/ZE
DIyvfdDFD/DLMukyOduNgbJn+T26p2sdAqmUuJlSwJD70J+HG4WTLt9nML09/n+5
XycbV9UL0Jm9xNFYS5lPEqivJY+e5zEaKyTq5mkWkVxU0h2LHzDYGt9B1p08UcX5
JagTlZ2mNySJcHlS9zsnhC0RmzI1TFecE4n1DXR/JWXFwaH/8/NQeD+vDy9l7/hu
HB/dBPtjpaAr+4+IaO4DRgPcadbug6R0kLxiL8TJoWZhZHy0IXar+tudohPRMuwJ
JH9i229YMtuyZCtCjoLIWJst22Rm434G2K3VJIgkmEaE0Tl7dorzf2E714EIML/Z
3hgy/50xwYe9shnDokW4
=SUFE
-----END PGP SIGNATURE-----

--ClpMRN7ztK9mBQjN--

--===============6154161115165345207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6154161115165345207==--
