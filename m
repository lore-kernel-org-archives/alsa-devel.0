From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: da7218: Use common error
 handling code in da7218_of_to_pdata()
Date: Fri, 24 Nov 2017 12:55:58 +0000
Message-ID: <20171124125558.uvfognezm75dtlbc@sirena.org.uk>
References: <07c631e4-e2df-7ae2-ea31-9430c89dc8e3@users.sourceforge.net>
 <32a4c9e8-2030-c4e8-eb54-9ce6712ef0cd@users.sourceforge.net>
 <2E89032DDAA8B9408CB92943514A0337014C1B11E5@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8756031602963865213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F3A2B267962
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 13:56:01 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1B11E5@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============8756031602963865213==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iknjngorugptk2nb"
Content-Disposition: inline


--iknjngorugptk2nb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2017 at 12:03:32PM +0000, Adam Thomson wrote:
> On 23 November 2017 20:06, SF Markus Elfring wrote:

> > Add a jump target so that a bit of exception handling can be better reused
> > in an if branch of this function.

> Hmm. Doesn't really gain an awful lot this. Would understand if there were
> multiple return paths, but in that case I'd have implemented something like
> this anyway. Also your patch description isn't really correct. You're re-using
> code from the sunny day scenario to handle an exception.

Other people have given him similar feedback on his other patches with
this pattern.  I'm not intending to apply any of them.

--iknjngorugptk2nb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloYFt4ACgkQJNaLcl1U
h9AH+Qf/ZNLVfptwWMgGXUEo2FNyi+pp1AW+I/dxOjNK9lN0pOwFEQh7/NlZSzz6
jSqnLjG80HEWhJEAsXHrE/DiNBP+8xNRRVZJogfyuoIHlLiu0mrug4nENANtG0fE
Z18UwDmTpoj0bL//sjVE07ugNVxH173wYJ3rhEM4rXCl8pavW3GQ4WSB/tRCEXDl
c6SEU2BZDJ9u2xxTeXRfSinfaluqdxpz/Y2Gc7idO+M9Pf83JKPDj23pps2rxgoM
lwPOvZX/FyRiXo+Q1r1fM2ruGtKvK+Br2cYvDDR0zHjg48yUdiPdPmQVhPTT46Rc
PjQLG94Etgqj7H5UT9GOgNooi+jekw==
=1NLI
-----END PGP SIGNATURE-----

--iknjngorugptk2nb--

--===============8756031602963865213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8756031602963865213==--
