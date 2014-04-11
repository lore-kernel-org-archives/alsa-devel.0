From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: fix clock prepare/unprepare
Date: Fri, 11 Apr 2014 11:14:04 +0100
Message-ID: <20140411101404.GP6518@sirena.org.uk>
References: <87ob08oebr.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0240840827958765637=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CDAC7265650
 for <alsa-devel@alsa-project.org>; Fri, 11 Apr 2014 12:14:15 +0200 (CEST)
In-Reply-To: <87ob08oebr.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============0240840827958765637==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VZekXYd/M+CUZV2i"
Content-Disposition: inline


--VZekXYd/M+CUZV2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2014 at 06:16:33PM -0700, Kuninori Morimoto wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
>=20
> As with the previous commit, before a clock can be used it must be prepar=
ed
> for use. Change from clk_enable() and clk_disable() to the versions of the
> calls which also prepare and un-prepare the clocks.
>=20
> Will fix warnings from the clock code when this is used.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This is written by you and sent by you but also signed off by
Morimoto-san - what's going on there?

--VZekXYd/M+CUZV2i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTR8BpAAoJELSic+t+oim9eloP/i477gXLpWJ3tnZAaUZJ66EP
8or78jT0SKYwQBFXjcLqIbWX8kadg5f0c+xs3MuLDkTU3UmfervHYUrk+5qB3Yoe
Q6cq6HX/AXf1OQ2joN3eoWfZ6LZDwe0UxGuvQkI9djyQtfx0ZrAukuXjDxsuwf/N
xAOp5meuWOtOvtEztNkHcm+ksNdrSibVw9SbJ6EBkdLWcfwUYO1ARZle24Oim2iM
XEUFwkbQ5MxPfv9iCW3Hs/hcTIVl2pO4YFmNxxOGTiwMtgqs7rYuhqyylxLF5Iku
bmnVubE8S/bC3chkpqJuHmkHQQnj8zOvHhoHyVuYiC/bFxvEQQQhWHxSl0eltqzi
o1QtEP+AHdFKhiipXz56j7Sl65jlNVpdIOsbeEeaGtWjoyj65NWR2+As8CyHOKlZ
nq+iSDyTTkdTVk0Zf2l+HaOZlkDZrcGkmQf8utBs9NZybtzZqxZoXNaiy5FCxl1j
/RAuiJ6tCk4jSRVlRkj5WBe0tTRazNZG1csTat19lgPXNeIwFNv5wsf2xV2ESJ84
TgykpgUWmA97DvTKihCpHz3/kpteYSa8t9NsMl/T49ubk0uSKewTTsrHWzHKVTYX
JV1PbNwLsMC5+On3yNd5fXkVQ92V3ICqitNlHJ6xgIftQ5Gio9Hv9nNM+Up0i9jg
234lrOIUizKXxRBlZmMi
=VK5r
-----END PGP SIGNATURE-----

--VZekXYd/M+CUZV2i--

--===============0240840827958765637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0240840827958765637==--
