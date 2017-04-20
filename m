From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dwc: disallow building
	designware_pcm as a module
Date: Thu, 20 Apr 2017 20:46:46 +0100
Message-ID: <20170420194646.qcpu7w3acjyfmeu5@sirena.org.uk>
References: <20170418105954.23368-1-lkundrak@v3.sk>
 <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
 <1492532010.28092.12.camel@v3.sk>
 <20170418171519.csiftftd434psyn5@sirena.org.uk>
 <2e39b000-bf25-6447-b53b-047401041f4e@synopsys.com>
 <1492618461.28092.18.camel@v3.sk>
 <03a3fbbb-7221-f4ee-5b1b-8fff518ea82c@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5047841271866981248=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 724CE26686A
 for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2017 21:46:58 +0200 (CEST)
In-Reply-To: <03a3fbbb-7221-f4ee-5b1b-8fff518ea82c@synopsys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--===============5047841271866981248==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iiywz4p2nvjmpyrd"
Content-Disposition: inline


--iiywz4p2nvjmpyrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 19, 2017 at 05:48:15PM +0100, Jose Abreu wrote:

> What do you think Mark? If you want to keep the PCM as a module
> then we will need to abstract this more, by reducing the
> dependencies.

I think forcing this to be built in to the kernel (which is what the
commit message says the change is going to do) is an obviously bad
idea.  Anything we add to the base kernel image needs to have a good
reason to be there and it is hard to think what that reason might be for
any audio driver, we need to be able to put this code into a module.

--iiywz4p2nvjmpyrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj5ECUACgkQJNaLcl1U
h9BDXQf+IKFKM4tDXYFWFyvf7OI1+DJz/SsXTkA/triJMUpaYdmGXCPFv1rvqqmB
O+wZB2rYF29bDvaDr4xodiLwmusNrUKLtneJpbJ/USwOZBJ0QB4NQ4ibhr8CFLnH
z74ZFFqHo9qjMmGMp3MVySKlsDpTIbT+kEehedj08ELWcaNqkSMbqIJv12UHsY86
CNlALRbEOQLN/Qug7Sra/4tFuku+6RPAqV+AYg0/rJE4xk0fkmfHkdNqgfcUBYcT
sbo6Vg39fmCGFAY7tak7zxU9XInLyhTPUXHdKtEfNpLWmM8kcWAE2/VhwvSSO53c
81Gw03pR1fJ7GYVD4tIk6bRrqehGJg==
=Iz/t
-----END PGP SIGNATURE-----

--iiywz4p2nvjmpyrd--

--===============5047841271866981248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5047841271866981248==--
