From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: ac97c: Fix an error handling path in
 'atmel_ac97c_probe()'
Date: Thu, 31 Aug 2017 11:37:16 +0100
Message-ID: <20170831103716.n5f7mpzr2gatulmw@sirena.org.uk>
References: <20170831044042.23306-1-christophe.jaillet@wanadoo.fr>
 <20170831081021.g4luo557ggtnyfyg@piout.net>
 <alpine.DEB.2.20.1708311020340.3243@hadrien>
 <20170831095615.lpon4a36vil6avma@piout.net>
 <s5h7exkjb9v.wl-tiwai@suse.de> <s5h4lsojast.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1347685928897100015=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1831B267217
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 12:37:21 +0200 (CEST)
In-Reply-To: <s5h4lsojast.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, garsilva@embeddedor.com, kernel-janitors@vger.kernel.org, nicolas.ferre@microchip.com, Julia Lawall <julia.lawall@lip6.fr>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, arvind.yadav.cs@gmail.com, andriy.shevchenko@linux.intel.com, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1347685928897100015==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6jvjthbtp5pcv6u7"
Content-Disposition: inline


--6jvjthbtp5pcv6u7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 31, 2017 at 12:23:14PM +0200, Takashi Iwai wrote:

> Ah, wait, now I see your point.  It was introduced by the very recent
> patch through Mark's asoc tree (since it was wrongly labeled as "ASoC"
> while it isn't).  That patch looks indeed fishy.  The change in
> atmel_ac97c_resume() is also bad.

The resume check looks fine?  The function appears to do nothing other
than the clk_prepare_enable().

> So, I'd prefer reverting the wrong commit instead, and leave some
> comment about the uselessness of clk_prepare_enable() return value
> check.

I'd rather keep the error checking there, it means that people don't
need to open the code and verify it when they go scanning for potential
problems.

--6jvjthbtp5pcv6u7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmn5tsACgkQJNaLcl1U
h9DODQf+LCnhqqpkJBL8EZZs0P36G78C7sMxRlYEq0xv5yikaZoqhBtW8k5qowan
KuTz5twab8hB+j2n+JoHENGIPe6I8l14QZY4yure/aWmt6Za7oaPoI5S+lB293pn
kqC2jpXQ939CCyJVMpuVHItYk+2ZxKrnFZlyGtLrIij/2dxRj0MvFJrfT9h3Hxr7
3jlkgQD1YEYUANH3xEpLl8c1kDkL7aUKgOIf9wNOzs9861//75M2k8gj/U9tP9qf
9TTH9adKpL0STjKbIbon6VFNjAepr2x13Zm0t/txuVhBOG86lM5gWdO1Ig4WheRa
0IbFAlGkisA40pC8peZC8anx03Tofg==
=U3e/
-----END PGP SIGNATURE-----

--6jvjthbtp5pcv6u7--

--===============1347685928897100015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1347685928897100015==--
