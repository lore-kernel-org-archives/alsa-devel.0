From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2][RFC] ASoC: soc-core: allow no Platform
 on dai_link
Date: Tue, 12 Feb 2019 14:12:31 +0000
Message-ID: <20190212141231.GC20635@sirena.org.uk>
References: <8736paoqr5.wl-kuninori.morimoto.gx@renesas.com>
 <87zhrinc2y.wl-kuninori.morimoto.gx@renesas.com>
 <e984c300-5732-17ca-212b-3954cbdf3765@linux.intel.com>
 <87o97xlicc.wl-kuninori.morimoto.gx@renesas.com>
 <477d13e1-7dfa-b384-259e-2e0e5b98684a@linux.intel.com>
 <87imy4nxq7.wl-kuninori.morimoto.gx@renesas.com>
 <20190208182524.GI6695@sirena.org.uk>
 <87zhr1q15g.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7027067878901067814=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 77E922673F8
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 15:12:34 +0100 (CET)
In-Reply-To: <87zhr1q15g.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7027067878901067814==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 10:03:32AM +0900, Kuninori Morimoto wrote:

> Yes, agree.
> I think we can do like this

> 	v5.x     : multi CPU support
> 	v5.x + 1 : transit to modern for CPU/Codec/Platform on all drivers
> 	v5.x + 2 : add "no Platform / no implicit dummy" support

> If there is no objection about "no Platform / no implicit dummy"...

That sounds like a reasonable plan; I don't think we actually need to
wait for a new kernel version between each of these if things happen to
go faster but equally if we do that's also fine.

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxi1E8ACgkQJNaLcl1U
h9ClZAf+OQyIIGpuv8WWZfYrqjqhKJrv2DzqmqkedVk1Ob3A7tU4h+EJHiZFnr25
XKnRyeVtcRplRRsAnJGJFLsv4FzuQN+JxXaZUix3kcbG+LKZxWGyJVfF0X24ojDs
mMASO8ICu9w7zv3f239XyUrQnJ4+36xvZyR0jkqndV9mUR/UtsDv/YL4MkiOQfb7
QXVmOAVCRM/mQUcvZmGNDvLryrq7HyMnmD5EKjrC6Cn7GSFq3RMSAkDn2eDXXCQp
J8NYhaREKEjFL8i+d0NB6xEKenTbcAJYvJmMmYwb3GZDJOJ4JnW/ZrlK1bNlf0cx
LmsYdIgnTwrWQ2E3/tuj4R0CJKfCfA==
=vDY7
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--

--===============7027067878901067814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7027067878901067814==--
