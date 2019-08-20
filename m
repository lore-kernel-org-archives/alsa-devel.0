From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/25] ASoC: soc-core: tidyup for
 snd_soc_dapm_add_routes()
Date: Tue, 20 Aug 2019 18:40:11 +0100
Message-ID: <20190820174011.GG4738@sirena.co.uk>
References: <87pnlhahr6.wl-kuninori.morimoto.gx@renesas.com>
 <87d0hhahon.wl-kuninori.morimoto.gx@renesas.com>
 <928df91b-997f-c1eb-5ab5-bda1fc374c1a@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2992866387077445355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com
 [209.85.128.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3976AF800BF
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2019 19:40:12 +0200 (CEST)
Received: by mail-wm1-f99.google.com with SMTP id d16so3396057wme.2
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2019 10:40:12 -0700 (PDT)
In-Reply-To: <928df91b-997f-c1eb-5ab5-bda1fc374c1a@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2992866387077445355==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Content-Disposition: inline


--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2019 at 01:18:01PM +0200, Cezary Rojewski wrote:

> Previously, ret from snd_soc_dapm_add_routes has been ignored thus it was
> permissive for addition of several routes to fail. As long as some routes
> succeeded, card was working just fine. Now it's no longer the case -
> behavior of the card initialization has changed: it is required for ALL
> routes to succeed before card can be fully instantiated.

I really wouldn't expect routes failing to add to be a normal part of
instantiation (we should have been complaining about that in the logs
shouldn't we?).  Whatever enumeration is causing the missing widgets
to not instantiate also ought to control the addition of the routes
connecting them.

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1cMHoACgkQJNaLcl1U
h9A8Swf+O0Lr9XMYyD8dIJBFRWD7RIUK+ivVn5mtnJ+dAa14saiptogl3rTCwDZF
2RZIQEz3XxEXoOhl3iTFCTujugV8pNj+mtiBO8kupEsfG8WFBjiCE/IyGdzxVdug
WU3ucbiTSgFvViV9jXHH7xjmbBrMtfHbRf+yhRlLvkgwG/WjMCczTaQv4IJ1a7Ql
O/A7NbOeGN5xPiclAb7ldjv5r/YksHy4tHraq2e3xmEYNIHtsWyXiqVe1PW1JwlL
fAH5TRP1hAPJQYu/R0KxA/VXigu9x9+4Qz5lKRFjCIVg1+UP3VS971bSyJlPvwvF
WD1Osj9BPJ4PvzLupkIH/SJdPpolkA==
=d++c
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--

--===============2992866387077445355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2992866387077445355==--
