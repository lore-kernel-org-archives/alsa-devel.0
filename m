From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rcar: bugfix: it cares about the
	non-src case
Date: Mon, 24 Mar 2014 10:42:47 +0000
Message-ID: <20140324104247.GD2269@sirena.org.uk>
References: <87d2hci5rn.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4221709566262384854=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DC1D2616B4
 for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2014 11:42:52 +0100 (CET)
In-Reply-To: <87d2hci5rn.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4221709566262384854==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2014 at 09:23:42PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> src might not exist.
> kernel will be hung-up without this patch in such case.

Applied, thanks.

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMAwkAAoJELSic+t+oim9XqkP/0zl+GxCSdhOXpr3G7mx4ZHc
ritfCEmLKBzrRdzWXjrpSwRD02XH75W73zw77pe4DiZ39c0XDge8vDBSo8hNWX/G
ungKjfLpjxwjA4XuiWxqXeoA/YFnnLrt71Z+NbKhNp9q7bbYf1Rw4hGuD6y49AM5
4NkPDU+Xo9kwmNy/Zn9Xg71Damb9hZDrcWPqwMtWHJadsKAOpleXxXwzJZki6r+6
OTuaAw5DHbMgwcVCu1HDYBUaONpVWDeku9BG+h6iw1zRn9+scJkWAc40prSVDeHZ
+ljuobv2dDk91mdC8lZ+eE5YfE3d7RaFJn9p9+57HtdlkFVQODZC990GqKpqHwX+
GbrX5tY3lPY5CII2cP52i+nYtQqiN2k2hHY2JKCxZaYHkDUkAm+jt6mB4VDI3G2U
SE6R9tZ9WzcaX5eaC6e/MyCWAM52/HRF2Vm+YlE8cfCTh2pK7hT5uSYHdGM/2g6S
tIkNKNAaFKNQXef3D3wIJ4CA9Vmwu8ClxtYCk0U8LpsF0lUgkKVrg6n+pFGkrJ7M
/pMeSDhVIMFNlOYUS3uSNWbm/u9Q4F2jmHm/zI+QEysSJ/heEdXcmyjlaGkO7Vb1
n0tQKqpgCezl8q83z97lodoiV0R8+gdXXY1NqosrIbXYzOFA6msbbJQEz+19XLp/
QE6OLEkb6mgjag4vxZYu
=64GR
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--

--===============4221709566262384854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4221709566262384854==--
