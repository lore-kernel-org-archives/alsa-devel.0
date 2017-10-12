From: Mark Brown <broonie@kernel.org>
Subject: Re: regression introduced by commit 70d435ba1cd6
 ("ASoC: imx-pcm-dma: simplify pcm_config")
Date: Thu, 12 Oct 2017 16:51:31 +0100
Message-ID: <20171012155131.zn6r47eaombcqdlk@sirena.co.uk>
References: <20171004103657.1c6a433d@karo-electronics.de>
 <1507646944.2398.1.camel@pengutronix.de>
 <20171010171846.509f399e@karo-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6849446087761397450=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E9F1A266D6B
 for <alsa-devel@alsa-project.org>; Thu, 12 Oct 2017 17:51:34 +0200 (CEST)
In-Reply-To: <20171010171846.509f399e@karo-electronics.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============6849446087761397450==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tj5wtjjcj56xxago"
Content-Disposition: inline


--tj5wtjjcj56xxago
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 05:18:46PM +0200, Lothar Wa=DFmann wrote:

> I circumvented the problem by changing my /etc/asound.conf to use the
> only supported sample format. So, if nobody else has a problem, there
> is no need to revert the patch or apply additional modifications to the
> driver.

I've not seen any other reports.

--tj5wtjjcj56xxago
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnfj4IACgkQJNaLcl1U
h9DRZwf9F8hughtggJm4y0nroRsBYvkxc1hgm0iYuYl1xHpmSvJVXzl+D/uFZmKk
AdwLc8REsqsvknwj1J5gjx5E3q4esKb0Gy66GXLMpSpL36jlmRhBBnK6LIByAnlY
qwL+Muov/BongT+iq91+6rBilkLrLHRXvJ+fFLxuws4F09t9M3UdEP7UDXr3mGrp
uu00s86CHlhQZYxDxcSS5Wkv5+rAfAU0NLUI6tiFI1p+zFs2xWWZj2EGXgFjke/D
NFrpzhs0IEVN5E7tLCfs5qeks0r5jcBBcbQa0+1jKeqEpJi/JPPyp2zWc71q7D16
RZPKrHpy/Ib7NWtp/nvlhptGWZ4dGw==
=yS1G
-----END PGP SIGNATURE-----

--tj5wtjjcj56xxago--

--===============6849446087761397450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6849446087761397450==--
