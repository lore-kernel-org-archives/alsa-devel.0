From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about pinctrl_pm_select_xxx()
Date: Wed, 19 Jun 2019 12:43:32 +0100
Message-ID: <20190619114332.GR5316@sirena.org.uk>
References: <874l4mt525.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8581529270060174900=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7396CF808AF
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 13:43:33 +0200 (CEST)
In-Reply-To: <874l4mt525.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8581529270060174900==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YzytRCpZNWCht94M"
Content-Disposition: inline


--YzytRCpZNWCht94M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2019 at 04:22:11PM +0900, Kuninori Morimoto wrote:

> But, I can't find its paired pinctrl_pm_select_default_state().
> It looks strange for me. Is this really needed ??

It's in snd_soc_resume() for active DAIs, or otherwise when we open the
PCM.

--YzytRCpZNWCht94M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0KH+MACgkQJNaLcl1U
h9D7xQf+J95/dL5j3qJ5ylzIeHLWVUu/SZ5qfyDs5QXW3br7N8YztMFEYsusOPaW
DZ4DhuAZj64+5gxh/NnVXjAXvt34rXqHe7xYDbaQ6xIyjT8mvpuk1yvl3oD+94Yd
he9IMUso2q34RdRec6h1mqUxai+TdVHZPr5o2y0oGkyS2ojNKHV6ASg+2w78fcqO
gKJr5QNYEBqlnb/riaA4AbVzj08Qa2LTn+iCsG8bvbZhqJD3Rnqa7riDVdICmDfz
u9kU/cGIOwiH73ZzCbeg/7Cdu0IcXPRZpgkqy5J47bhKqaXeJFnYx/YvhMxOp3/B
pYG7C3ajtoleOQ8/K28rBVkfICqz7Q==
=H6sC
-----END PGP SIGNATURE-----

--YzytRCpZNWCht94M--

--===============8581529270060174900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8581529270060174900==--
