From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Remove HS/HF gain ramp
	feature
Date: Mon, 7 May 2012 18:27:32 +0100
Message-ID: <20120507172732.GP17002@opensource.wolfsonmicro.com>
References: <1336133840-12330-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7910592622496332558=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29421103F94
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2012 19:27:35 +0200 (CEST)
In-Reply-To: <1336133840-12330-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7910592622496332558==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RtGa12sjXv8gVUZO"
Content-Disposition: inline


--RtGa12sjXv8gVUZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2012 at 03:17:20PM +0300, Peter Ujfalusi wrote:
> None of the machines uses the gain ramp possibility for HS/HF.
> This code path is mostly unused and it does not reduces the pop
> noise on the output (it alters it to sound a bit different).
> The preferred method to reduce pop noise is to use ABE.

...to implement gain changes?

Applied, thanks.

--RtGa12sjXv8gVUZO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqAX8AAoJEBus8iNuMP3d5GQP/3X/f0pSivWjM9iTDD+Me8v0
n2G0IB0nZjp9relvYDHtsLsCnLZgWsNUGTU2jstqvhdx/zxhv2mnpoFZZc24c+la
FmEelOpE/9xBZFi1wSYkfx0d/p0bVJUSiAMu+Y7HyWLkHVHxyDzhbLe4A/EWW73Q
UnvX5XGwsnXry35J+9wbtmgMhK7MZCRyt72ap4u2/vqTPP09KJPJXun0RbjOMtoK
PsFWW5T2UNaOn+B3A5f7HpF/KJqS5bVzgKKhKSjf9s//Adan2Cv9YIfbiryYE3s2
3TIstkhvtptqMZOVNpf9dDuXMOc+t+PBVsFsDD217DwErTAkDRwP7dqxdHBw75VD
wX0hLbnEawz1hHbUixtrSv+QKA957SxDLu4chiNjkficVALD4J9QpbZ8fIioO7+z
7JT14OzIvQh1pyblU5w0wF/y+u2nAPTSFiQbi9MoGWscvkkZALwfnmcvXYrWIIWb
xfsXyGU0iTRlEql7rbnQqUCOXdzc/b2JldbIu0XWRQ7DvwCahQm9/INpwVk8WMzX
VRLBhNSejlP/MlfwXjpFEIkAeYeUrRpQDM8FPTY+o37uIQi4vaQVeieTbZXoW+I6
AT2E8hpfmhrO22o788nYh/gCZb3RNmVyiGzWsu5pw46VAFVLfzfNWxlCZdFw8Qtm
BGNrK7bn0SQy9nQT8g2u
=481G
-----END PGP SIGNATURE-----

--RtGa12sjXv8gVUZO--

--===============7910592622496332558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7910592622496332558==--
