From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about pinctrl_pm_select_xxx()
Date: Thu, 20 Jun 2019 12:54:27 +0100
Message-ID: <20190620115427.GC5316@sirena.org.uk>
References: <874l4mt525.wl-kuninori.morimoto.gx@renesas.com>
 <20190619114332.GR5316@sirena.org.uk>
 <87v9x1rt8o.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4845403699590494932=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE94EF8070D
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2019 13:54:29 +0200 (CEST)
In-Reply-To: <87v9x1rt8o.wl-kuninori.morimoto.gx@renesas.com>
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


--===============4845403699590494932==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/NDiA4DbghPWII0p"
Content-Disposition: inline


--/NDiA4DbghPWII0p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2019 at 09:35:06AM +0900, Kuninori Morimoto wrote:

> Thus, calling it from DAI only is very enough, I think.

I'd expect that only the DAI should have pins so probably yes, but we
can't guarantee that this won't break anything in practice.

--/NDiA4DbghPWII0p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Lc/IACgkQJNaLcl1U
h9D5Pwf/WdET1vLbTr07YNnnxHuqOASP7skpwuVh1A3eNFmEeGTvF8uTuK/Trp6t
8jlccsykvbb1ZhOOqDk9Qp23PLAFN4nGK14H2AK1+rHcovR7IR1mnyOur1WkgqXw
ypHrFXF3flTiZCSa2UaOmxG5jmBmVjzdjHE6Pw68rJAfma/Z4lm1QnJg6IOSosnF
FhXETpxZQZoDt1exUpVHpFjEW7MF/zUA1BTlAuhSZV+1mllA28O7EjUI+R3eRr0k
fiFRJJCD42OA3wIzRBcqfna8E9LuGuQwC0Dd6HlQGqesmNjJojxmZCRk7tZbNucs
+TkT3uA40+JC78L/gjeHlW5F54PoYg==
=eaP4
-----END PGP SIGNATURE-----

--/NDiA4DbghPWII0p--

--===============4845403699590494932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4845403699590494932==--
