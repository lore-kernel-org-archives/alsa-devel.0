From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix pointer dereference in
 is_connected_output_ep()
Date: Fri, 15 Mar 2013 01:29:41 +0000
Message-ID: <20130315012941.GE4931@opensource.wolfsonmicro.com>
References: <1363292784-20537-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6841582922028997256=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FBF8261643
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 02:29:44 +0100 (CET)
In-Reply-To: <1363292784-20537-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6841582922028997256==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2013 at 09:26:24PM +0100, Peter Ujfalusi wrote:
> *path is not yet initialized when we check if the widget is connected.
>=20
> The compiler also warns about this:
> sound/soc/soc-dapm.c: In function 'is_connected_output_ep':
> sound/soc/soc-dapm.c:824:18: warning: 'path' may be used uninitialized in=
 this function

Applied, thanks.

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQnk8AAoJELSic+t+oim9xggQAJnC+bU6qUckW91D/H2vxDCL
ncAyfbsGngZfE2Tdmd4uX7lSBQE6jrn9t9Qp2eTCtwnZ14XK59ELFPPrG6t9a4AK
wAobVDPzi+a+ARRCOsdTbk9/9GbqmJXzGtEsIg2GbqLtlZwL18vKqI/DQtvn5VZy
/ZLJjK9g0xolLXkR1ppmxUfEyXJn2MX0jWGnr+VTi3FwT6C/voTmTPx3KDH6F8ol
QvuXPONaVu3bc1M021wsSrhv4ryBAX06OIvN9VtG0Ks2YEZhKq2bGiQLGkC1Zv+3
OoNygqcWP2GcXpFtOc+KjPQaHcxKVNdwojdxNTNNgWZ85WVT+mIIN4BTxf41cytz
NFVPdVxoVqPGzKYIbFYGxMMQ++kpPxOD5zeu0qMhSnmO+FvNkFgTg0g02ZUVbQZk
BoD1eEQfMkU+qQSh3JrpTl6tfdYTfjohF168Tj1SW/EGIsZbPsGrkZ3U5ALSF+wo
ENz1wUm07qzBL6v9p4+JPcewKuGSmcJNYWJrN2KUOxu5tZctMhQVICN1H1o0hCfc
nrKUT7ZnBS5Uj1+yw+IyOsyfJjAEn2dnIpnqEpRCwgasITB/9j/cuSj4FyC53uhx
tXeGCqg7hZ4CyxGn/og8IU27QtwlP3b2mBdcXHFqHG2rgmoLHRqtwkx28kyYGJRf
YSnz9H4RvwperGoLcRa9
=mxP0
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--

--===============6841582922028997256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6841582922028997256==--
