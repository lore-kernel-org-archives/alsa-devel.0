From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: automatic BCLK and LRC
 divde in master mode
Date: Fri, 10 Feb 2017 12:05:37 +0000
Message-ID: <20170210120537.gfx7ei4h7knb5ccs@sirena.org.uk>
References: <1486625411-475-1-git-send-email-KCHSU0@nuvoton.com>
 <20170209164547.fgwi6cc4wicag2c2@sirena.org.uk>
 <589D135C.3040904@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6413644312172456730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3918626683E
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 13:05:47 +0100 (CET)
In-Reply-To: <589D135C.3040904@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, AC30 WTLi <WTLI@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, "mac.chiang@intel.com" <mac.chiang@intel.com>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6413644312172456730==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eqmmfp3sutaqkrdy"
Content-Disposition: inline


--eqmmfp3sutaqkrdy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 10, 2017 at 09:11:56AM +0800, John Hsu wrote:

> There are three branches about nau8825 driver as follows.
> origin/fix/nau8825
> origin/for-next
> origin/topic/nau8825
> Which branch do I make patch based on? Thank you.

Whatever it needs to be based on, or Linus' tree if nothing else.  The
topic/nau8825 branch is currently empty and I don't have a fix/nau8825
branch right now...  if there are things in my for-next that's usually
fine but it doesn't apply there either.

--eqmmfp3sutaqkrdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlidrJAACgkQJNaLcl1U
h9Ainwf/d3xBXp3pEb054FTfeVr1U9GvwiGMY95eTHjiEVPCmKSAGhXgBMmIX+4z
OP9vr3Xit1N6NXN0F4I/uxqK4gcYTpR7nfpKWSo2N6minuHh0Ws982nkPKssRbr1
JW1WA5kUMZtt23w4UqkYEQlP0QKDAIZdhjJEUAmtHnP0MR+0/oRzhIyOBTfjj4+j
aTH/BnPduCXnMdFGVO7HUDWqRZpLfbDmhCx6c+248rmWyU6sR6uBKT9ocBn6nTqm
ieLCjSrOJ2Oefy4vlfF31WMAfMpQQutJo/VqXhDMAeQPXlLXQo4iyfHxIzopxuEe
WBB6dRzbvUwkJGuj/WBWUcaAPkr1Aw==
=7Ois
-----END PGP SIGNATURE-----

--eqmmfp3sutaqkrdy--

--===============6413644312172456730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6413644312172456730==--
