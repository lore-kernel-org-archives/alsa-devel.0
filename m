From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 18/23] ASoC: tegra: tegra20_i2s.c: use
 devm_snd_soc_register_component()
Date: Tue, 2 Jul 2019 13:45:57 +0100
Message-ID: <20190702124557.GL2793@sirena.org.uk>
References: <87blyitky2.wl-kuninori.morimoto.gx@renesas.com>
 <87lfxms66q.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9160777682229144449=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A427F800C7
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 14:45:58 +0200 (CEST)
In-Reply-To: <87lfxms66q.wl-kuninori.morimoto.gx@renesas.com>
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


--===============9160777682229144449==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RD6GsZsdEJvsf78O"
Content-Disposition: inline


--RD6GsZsdEJvsf78O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 01:10:40PM +0900, Kuninori Morimoto wrote:

>  	if (!pm_runtime_status_suspended(&pdev->dev))
>  		tegra20_i2s_runtime_suspend(&pdev->dev);
> =20
> -	snd_soc_unregister_component(&pdev->dev);
> -
>  	clk_put(i2s->clk_i2s);

Same thing with clk_get() here and for some of the others.

--RD6GsZsdEJvsf78O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bUgUACgkQJNaLcl1U
h9B7lQf+I/eIcGxEDztFWUuOMBiZWGEc9NsHtgHoqoy9D163ZxGeVHXnTeyuA0xp
/hS74HOO2zJTVTsjtI/C3bJc2mVA4/8kmBtBNzmAdhZk8/VhC1Q5+7fmkrQ+wPuI
zpVVuIEIxlaZWX3mlI67I+F0GA4x2QICGUlSnhlAADxr8k+pfL3MI+xOlKoAfTNc
QipoindEdY6+pbfEh+Kljj2EDXMPyXtjt1wbQdquk++lmpMgWPLd7GtnQJYJ24YU
WKMznh983x9jvswdTG0hRL0LHdD/mpqe0B0ccL6Aej4xj+lINWKElaUGwtzCFWc1
3NIzMgjFdNDFCitmz9gAZyURFNCmKA==
=DHHF
-----END PGP SIGNATURE-----

--RD6GsZsdEJvsf78O--

--===============9160777682229144449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9160777682229144449==--
