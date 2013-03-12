From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/10] imx-ssi: Fix occasional AC97 reset
	failure
Date: Tue, 12 Mar 2013 18:53:47 +0000
Message-ID: <20130312185347.GT19942@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9026108845521368095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 88003265EBB
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 19:53:49 +0100 (CET)
In-Reply-To: <1362940391-8338-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============9026108845521368095==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RlgFhasKO3bfRJ5j"
Content-Disposition: inline


--RlgFhasKO3bfRJ5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2013 at 07:33:03PM +0100, Markus Pargmann wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Applied but *always* use subject lines appropriate to the subsystem and
bugfixes like this should be pulled to the front of the series as they
should be sent to mainline earlier.

--RlgFhasKO3bfRJ5j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3mqAAoJELSic+t+oim9nEsP/3YouLswoxGy165PiNgcN7nO
RIrzI6IO7CRfj8i/IeEOQt5qn2k7Ho+vxCfWDugkA6RIH6FctPg9j0xGXsu1k7Xl
gY3EAxCaA3eTJ0j4hWWukynJtHOJTSf+igyvvl1ceJHE4IP9WnMkG+2FkIRiSPzE
Do/qHNHiTxUI/e9epCwtKvYytMaMdNVhjihvCar2l1e3CzHmKbaXF9qSw9aLelpN
sm/Z/uJlPAPf/7fWX78LlVq1hN5QqwK/Podxn7crsP9F6R++fWF8wxc7Ned/nVqj
5CzWs/3MP7uyrF6SX8V59ORJMdldQ9O5ZB48Y/+2qUFJntiHP76IVAXBD2eom5Kt
HTzXK03LSh2dcE+ExztZjRhuRTWcdqrJLkFbaDElUnGm6ZGUIskbVD2CkgpPYCls
xzzWVu9DNC6XEbsxQ04lQ38ZHO07LoNBm9SprGNKMN3wkpmGY1SGw5u1dic80s1N
BA6AdLk+Fr+YRu7/UU60Ce3Gl+vgFeiaML4nLwrCrsgRVvlHEpOIPhjIcHlYtn7C
cGp7eA1XjW+5bmyNvDCsBrmFfE0tuMm68JIE1iXp6ujf5b4zH9YegO4a9AhGRMlj
mHzvPP+SijIBIc9xT2fGlDnnttZXg/3YMKZHwBu/jwHrCgNTu3DmmIcVvg3uUmDs
QYAMXeyqUe3z+wcvDRfH
=weVX
-----END PGP SIGNATURE-----

--RlgFhasKO3bfRJ5j--

--===============9026108845521368095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9026108845521368095==--
