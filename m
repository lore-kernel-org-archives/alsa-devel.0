From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/2] ASoC: dmaengine-pcm: Add support for
 querying DMA capabilities
Date: Tue, 16 Jul 2013 11:03:57 +0100
Message-ID: <20130716100357.GE22506@sirena.org.uk>
References: <1373906531-6938-1-git-send-email-lars@metafoo.de>
 <20130715172643.GZ11538@sirena.org.uk>
 <20130715165721.GV16653@intel.com>
 <20130715175726.GA11538@sirena.org.uk>
 <51E43D6C.1050000@metafoo.de>
 <20130715195145.GB11538@sirena.org.uk>
 <51E50D3B.2050207@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4413555869134613781=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2757126165C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 12:04:16 +0200 (CEST)
In-Reply-To: <51E50D3B.2050207@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4413555869134613781==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 11:07:07AM +0200, Lars-Peter Clausen wrote:

> I would assume that most of them don't express hardware limitations but
> rather are sensible lower limits which allow operation without
> over-/underruns. But that's something that doesn't necessarily depend on the

Yes, indeed.  Or just cut'n'pasted from some other driver without much
thought.

> DMA controller, but rather on the system as a whole, e.g. on a slower
> machine you'd typically set the limit higher so the CPU has a better chance
> to keep up. So this isn't something you'd want to set in the DMA controller
> driver. But I'm not sure if there is a good way to calculate a sensible
> minimum buffer size based on the whole system's constraints.

Not really.  It's going to depend on userspace as well, and things like
SMIs on systems with those.

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5RqKAAoJELSic+t+oim9l8AP/31XO0Q7swuEew4ypKwBl3Kb
rJBZU13oPXRHPcQcic8gUCp3A+mDcz9onzcAWWcIlsfVmXI75mZOUmaGfU4QPVe9
GRDKNwVA+1/Rc+NA8ZqcaRTFQ1mRAAVjvmmun9mewRi2tRPze59ChQKnrYkEpafA
JH2faLcdGSryLcNt4aPNnXYgemoZouSMpMmOFMqNWMViVakeIB3m1E5WXzYK8xJE
nkBp5zWgesUFUKnlPiHeCcdi4gGG42kETJHWdz5ZAKVJnXa/HSLVYJUdny3csZME
lqAgidLzI3h7Eh/FUCu4Xxt0jSOsfg47KoF8UBzLKokreI+kf2gf1uCD4DcLPKbN
Vuvd1n8zumA7OkTAQ6ls0RgvDq+MlnP5nn/qO6bWA1WAQ/wzEDSM87b3qdrbiHL0
2b/p18VZ5hTqe8vwxh3CzrmcLWK0an/geB5WUKSfMu9V0rpXheXZJFIj84QyXMcO
CdwXo2sD/gtwORKSEklcs5asfag/AfpM6C5NmI8giy+lFq+ZTmycpfvFSZzVqAny
QN64ckmJxi8ZDqlOjkJSyg24knABQ2dw7sqa1m9WRlhQEajVfo6IygwX0LEDL2+g
sKJ3fM7eDy93PNyafGQ5juxhCKclVm4jplT0bt+qac92T5QK4WFDMPImqgk6bcMB
DwuaerzRF2iaiqfIC9EY
=NmsS
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--

--===============4413555869134613781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4413555869134613781==--
