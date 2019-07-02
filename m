From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/23] ASoC: cirrus: ep93xx-i2s.c: use
 devm_snd_soc_register_component()
Date: Tue, 2 Jul 2019 13:44:11 +0100
Message-ID: <20190702124411.GK2793@sirena.org.uk>
References: <87blyitky2.wl-kuninori.morimoto.gx@renesas.com>
 <87y31ms69i.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5732111350196391826=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7722AF800C5
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 14:44:12 +0200 (CEST)
In-Reply-To: <87y31ms69i.wl-kuninori.morimoto.gx@renesas.com>
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


--===============5732111350196391826==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FCF9ydJxlAJsfRTu"
Content-Disposition: inline


--FCF9ydJxlAJsfRTu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 01:09:00PM +0900, Kuninori Morimoto wrote:

>  	struct ep93xx_i2s_info *info =3D dev_get_drvdata(&pdev->dev);
> =20
> -	snd_soc_unregister_component(&pdev->dev);
>  	clk_put(info->lrclk);
>  	clk_put(info->sclk);
>  	clk_put(info->mclk);

I'll apply this one since it already has issues with the platform
registration and the fix is to convert to devm_clk_get().

--FCF9ydJxlAJsfRTu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bUZoACgkQJNaLcl1U
h9D+DggAgWrCFFBp3NxiHojErntwwBwloDDDPecWb4kVX1Kii3yAo3OPrUvagN5r
8WysZNlXYIawLm8W6x0LM8BPXafVIWlxp3EZ99DeazTAZGHAep/Xs9GIOxa+COs1
llsR4P2wBUADqJpIGR/zXGrtPXjAvlXisQkijxTWMfw+g+jLLfnAPO3HY4NkH2O/
anPgWMo0p4cSk+M7C+H0ZiGKHUTHP5h97GiMinHoLJrNYLlnqXfEWcBqJNOMMHrZ
/0YH25XzwDA0YxFb/WL7kHzsPVDYUni0azkQlhcdD7VwZA3WtRYoufvvHuhVqKRp
MCcic3N/2f3mZmcrFcz6RlkAAdKocg==
=Wlo3
-----END PGP SIGNATURE-----

--FCF9ydJxlAJsfRTu--

--===============5732111350196391826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5732111350196391826==--
