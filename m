From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: stop all working stream when
 .remove
Date: Tue, 5 Sep 2017 11:12:19 +0100
Message-ID: <20170905101219.coobo6txrud3f4dq@sirena.org.uk>
References: <s5htw0mx4ek.wl-tiwai@suse.de>
 <87d17akgqr.wl%kuninori.morimoto.gx@renesas.com>
 <s5h1snqvnnc.wl-tiwai@suse.de>
 <PS1PR0601MB1881FD07A3E16E039943DA7FD4910@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5h1snmuwxk.wl-tiwai@suse.de> <s5hziaati7p.wl-tiwai@suse.de>
 <PS1PR0601MB18818E81D00F3056E7F7D54CD4960@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5hk21dtvm6.wl-tiwai@suse.de>
 <PS1PR0601MB188127AD25441AE8543A0EE1D4960@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5hy3pto5ft.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1897055987063424590=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E5241266C6D
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 12:12:24 +0200 (CEST)
In-Reply-To: <s5hy3pto5ft.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1897055987063424590==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ldcjmlh3pi76wrd"
Content-Disposition: inline


--4ldcjmlh3pi76wrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 05, 2017 at 11:33:42AM +0200, Takashi Iwai wrote:
> Kuninori Morimoto wrote:

> > If my understanding was correct, your idea is that we want to call remove function for all connected drivers somehow.
> > And then, Card want to wait all drivers are removed. Correct ?

> Right.  Unless we really want to support the hog-plug/unplug of each
> component, it'd be more straightforward to do the full hot-unplug upon
> every component unbind action.

As far as the individual ASoC drivers are concerned this should just be
something that happens at component deregistration time like the DAPM
power down and so on.

--4ldcjmlh3pi76wrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmueIIACgkQJNaLcl1U
h9ApTgf+I6gylOVllprKKeeWnuW1DJGIA9TdDbR6hPHnk+qJTO1BZ/4iJ58Kw2QC
KaBaN1JQqgDjvAeVpzfsB02us+6OnF4mUScoLuDYNHTbmuYiV1aw80rnlRu+ZPfA
xycxRyMtAx3FhzOmaffOsU7zUgTS/2Jk5WA+4gLr8+v049XxiXt1QklMu58vDbYk
7cjs+LhZHmN05xd/gZIs+r6SXGqhuzffDMzNyXsKQSG+tGrBV6FH/iEo5o2JiAGI
rl7868WTSFDQVIZnSj8tP4387bn7zTZTD2A/5Qx2n0XWqUL2KgPO+3KX3bl+RmzN
exafhESJK5uDiy6MUb6W0aemUvGR4g==
=Sm/A
-----END PGP SIGNATURE-----

--4ldcjmlh3pi76wrd--

--===============1897055987063424590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1897055987063424590==--
