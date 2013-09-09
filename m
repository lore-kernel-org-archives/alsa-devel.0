From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 3/8] ASoC: davinci-mcasp: Get DMA
 related properties from DT
Date: Mon, 9 Sep 2013 16:25:59 +0100
Message-ID: <20130909152559.GM29403@sirena.org.uk>
References: <cover.1378738436.git.jsarha@ti.com>
 <35b6dc24d8a803b97c683d4d2c51db7e3518f7ff.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4692586667539016188=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 37FD42650D7
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:26:06 +0200 (CEST)
In-Reply-To: <35b6dc24d8a803b97c683d4d2c51db7e3518f7ff.1378738436.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: oku@iki.fi
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4692586667539016188==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3v/vPZnlCeuYLnyQ"
Content-Disposition: inline


--3v/vPZnlCeuYLnyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 06:12:14PM +0300, oku@iki.fi wrote:
> From: Jyri Sarha <jsarha@ti.com>
>=20
> This patch adds new DMA related properties to mcasp DT bindings. The
> new properties may not be needed after davinci audio is updated to use
> dmaengine.

How hard is it going to be to convert to dmaengine or to open code
something that works with the standard bindings even if the
implementation is open coded?  I'm not enthusiastic about adding
temporary bindings, I'm not sure the DT maintainers would be either.

--3v/vPZnlCeuYLnyQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLeiDAAoJELSic+t+oim98hcQAJmVgopKjKBXCO+A97vQ8cg8
p98gGbBtOiYV68+9jehSvhbs5z/VdjTTN8xynHJGHNhynVYMXxaAPBpUJVGj+doU
0cD5tEmJRviF9bpMnkpiHbltwxI5z6U8cCpy11Tyk+Tha/TeOoligXONJmFiuZJS
RDZmhJmfuiatDLHAzv17a4Flfzb6XVxkxq2KsjifxXf93eqOCjpza/LvvkmryRi/
sS1imRM6QVTxNKX2SPiKr2yBVdhRbwjVSVuHiT15l6eZqyxHP84JpfdN9cn4YFOE
dG5xkoctIPKv2IakMbdpOaXaaSojdyKHof1F9B3NM81yBS92Hl9TXpSo9gdH73Un
NsxXnqgY2s1vew0SjzOPZ+kUDpXRGSjge4QhVscPF4MgJU4D9NWajEcBkVDHhZao
CWJzuZwd9hLYDQOsQE4tu1gy7KyjXcXz4oh3B/Z6J1uc49P2+qeMdvaR9z9L2nsS
ySHpZBS6JKUQyWD7W8Dr9GbTZ0ya5OESCGzikVg7ty//0JGMjlfBVh1GQ7q8N7vn
SXkeNPVDfSdwVusetaWrOY4NirE4GyRtzkEuTFjw9UievblQd8tHqKZWy53fUvxZ
gn0PekYbb/3nM9hW1oIuALK1AnqZfDffMGbqksnHKxTgABHHrBMq65EotCFZaoxT
FsqC3LNyDPAAEBH1CC7T
=ETiI
-----END PGP SIGNATURE-----

--3v/vPZnlCeuYLnyQ--

--===============4692586667539016188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4692586667539016188==--
