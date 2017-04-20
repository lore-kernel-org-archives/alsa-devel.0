From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dwc: disallow building
 designware_pcm as a module
Date: Thu, 20 Apr 2017 21:25:52 +0100
Message-ID: <20170420202552.hhyzo55oo6jvkbhx@sirena.org.uk>
References: <20170418105954.23368-1-lkundrak@v3.sk>
 <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
 <1492532010.28092.12.camel@v3.sk>
 <20170418171519.csiftftd434psyn5@sirena.org.uk>
 <2e39b000-bf25-6447-b53b-047401041f4e@synopsys.com>
 <1492618461.28092.18.camel@v3.sk>
 <03a3fbbb-7221-f4ee-5b1b-8fff518ea82c@synopsys.com>
 <20170420194646.qcpu7w3acjyfmeu5@sirena.org.uk>
 <s5h37d2su8h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4674375316431232662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F50C26686A
 for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2017 22:26:07 +0200 (CEST)
In-Reply-To: <s5h37d2su8h.wl-tiwai@suse.de>
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
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Lubomir Rintel <lkundrak@v3.sk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--===============4674375316431232662==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ubfwtg4zsojybitg"
Content-Disposition: inline


--ubfwtg4zsojybitg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2017 at 10:24:14PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > I think forcing this to be built in to the kernel (which is what the
> > commit message says the change is going to do) is an obviously bad
> > idea.  Anything we add to the base kernel image needs to have a good
> > reason to be there and it is hard to think what that reason might be for
> > any audio driver, we need to be able to put this code into a module.

> Well, I guess the original patch description caused a big confusion.
> As far as I see, the intention of the patch is not about the module or
> built-in kernel.  Instead it's rather to fold designware_pcm stuff
> into the single designware_i2s driver.

Ah, right.  That'd be fine.

--ubfwtg4zsojybitg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj5GU8ACgkQJNaLcl1U
h9D02gf/WwU1Mez4kpYmzoRvV3+K0NyvKU5oObTspHbMKUQ5GU4DbXnT5sFoxkmr
WxsIwWVS0NuuhOmZOkTbehKGWi7yqWMqFfHXhIJmTdU0zxt54hKMklVQcNJWAveg
Io5AEYDW/bV4/PvIDqAwX0TCShpbqQ8fpQF51nWRuH2KggApyuzwG2el8Xfubsok
kXrzaEfKBfWNx6CFWfRoYKC4aD/iCRhrLVU9YJBA4LD00NxMPuJp2XMvvtSoqkxr
/qEZhu023HVOUl/GZk2h8ISFeshSxgp1govV0dcOe/kuFbPl7f6BRZVPfuC8awIW
SG0QFG5vJNUO7gPLzxSmN4p6o8ZPLg==
=L6zZ
-----END PGP SIGNATURE-----

--ubfwtg4zsojybitg--

--===============4674375316431232662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4674375316431232662==--
