From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc/mxs/mxs-saif.c: use devm_
	functions
Date: Fri, 10 Feb 2012 20:21:13 +0000
Message-ID: <20120210202112.GA12644@opensource.wolfsonmicro.com>
References: <1328861821-3380-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3131419207398907528=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E70E2443E
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 21:21:15 +0100 (CET)
In-Reply-To: <1328861821-3380-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3131419207398907528==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2012 at 09:17:01AM +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> The various devm_ functions allocate memory that is released when a driver
> detaches.  This patch uses these functions for data that is allocated in
> the probe function of a platform device and is only freed in the remove
> function.

Applied, thanks for your persistence!

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNXwtAAoJEBus8iNuMP3dLF0P/0rPStcBUNZBPaxXPKytGpeM
DnNu/g1j0gp2xsFk5BpK97CeXTBBRLXwvC7z2Rej9d3UKK/GthkkDwg/KmusAtkJ
qcgbSjziv7HF7beTHh+QaAHrriCgM8IZjA2K+GrFhngY8j6ep/pINqOvvvGadDy6
4VM5mgNqv71cBDSUuXhTgO1ufhvrqSs9XWWi6jLZsSw4lhU8JUbyxKGm7o+Y25XL
MkgkWGKeVHnl0X1OqeGMuW5IgNN7AI5PEc3Wfq2vZUsIndEnelLW64F82kcO0NeE
NgeeZnO/hPzEnuwr5o8RynlRjZ1xfakEB2I57p+zEmL8wmNVAnl16JHrOM+QqWg8
TjMb1nd62u1Z+xTCNDXUde1+/zRlxvT2ELTGLlxWwPClC9ZaRddDKkMgJPF6bxk4
GWt86bzRZHoo8pRFokC08GHlMz+RA7sXm4VFhBZt03/MCPvdS/MzK/rNzo4GNNrK
RuSJlSn/ofWZTc+/egx/urb4bgRAX7VAz/e3xdTVHU65TSs5om9LzAqtPRDVINt7
SLImbAMtgIhZj3x32Map7UxAnxYb1qi2UGPbMZcTAKDAfrlbUVNOeYC6okE7KW/O
fZjeFruuJBICMbqS8u/9XRJLWcj8nThEAfdYuwTxkvndBFLdqcV+wBxZtp0uqNDO
yZngN9EPFWc2g1ucSyY8
=waBX
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

--===============3131419207398907528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3131419207398907528==--
