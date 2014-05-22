From: Mark Brown <broonie@kernel.org>
Subject: Re: The resume of sgtl5000 causes kernel Oops
Date: Thu, 22 May 2014 18:48:18 +0100
Message-ID: <20140522174818.GN12304@sirena.org.uk>
References: <20140522145650.GD32184@dragon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5204135127745734508=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 86A69261A01
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 19:48:33 +0200 (CEST)
In-Reply-To: <20140522145650.GD32184@dragon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5204135127745734508==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A++jtAeVRMZJdZL/"
Content-Disposition: inline


--A++jtAeVRMZJdZL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 22, 2014 at 10:56:51PM +0800, Shawn Guo wrote:
> The suspend/resume test on imx51-babbage board discovers a kernel Oops
> caused by sgtl5000_resume().  I believe it happens due to commit
> e5d80e82e32e (ASoC: sgtl5000: Convert to use regmap directly).  After
> the commit, it seems that the codec->reg_cache in function
> sgtl5000_restore_regs() becomes invalid.  It looks that the register
> restoring in the function requires some strict sequence, I'm not sure
> what the correct fix is.

Yes, reg_cache isn't there if we're not using ASoC level caching.  The
fix should just be to replace the direct cache references with
snd_soc_read()s which will end up in a cache lookup if the register is
cached.

--A++jtAeVRMZJdZL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfjhfAAoJELSic+t+oim9i20P/3dhFEBHdLEsZiKo7K8MmmsJ
v55WyV0v396yE/6/HbSJVM6SI0X9XUCqhQgeN8gwg3CPeq4VWo0K7WvWaXVLHtUx
v0yyj3ZM36oshLt4J7gBsaWNsdiTabKQdPh/AwqUqW36cwJ7hx+OuVCTkn/iK1WI
VXZkB81Tcg+EeBwL0fDEAngK5rN9+ZL8qaZTLJTcCx+faIsDUYy09EeyKkyqNwYY
KX8xJ4q8ONUl9goyDcvzV7dPQS63hyZJoCe65l5uyev0RpzoEX1yOJduLzVqf5Mx
5/HYkIj5tFVfJVaLrp91it5WWPdlBsj06Jc24vOhcUThQf147WH++xKPLKcjChrn
vObbdm6dHr9fGiTrFgZr6eO7x2iMxkOiFULgWeTOyiMl8pls6l4FJH1+1agj0Fl1
A0NWHv+ycW62srcQFRdo80qWAiL2QljHYahEzjpC6EwP6fiwvzbYZke+Ynb23k/C
syRC0IC1PjvN+H/pTE3qBpl8H8MNRJbxQORoAmZ+zAw2a9pugXMVPIxhgO4YFhLJ
C5vb4diYPW8qIuzQ09PkaU6rXRpBQEHSYGPQ8XZG792codDVsHTphZHbgHB1U/B2
2hTMPWhQPVy5WfNhATcVi9GkL0k7T0nFT8XTv+IsURYY1nytUL3NB+e2heId4o5+
LDbIAyAuc8FOw7ytQ1XY
=/QRe
-----END PGP SIGNATURE-----

--A++jtAeVRMZJdZL/--

--===============5204135127745734508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5204135127745734508==--
