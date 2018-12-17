From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: xlnx: Add i2s driver
Date: Mon, 17 Dec 2018 12:24:41 +0000
Message-ID: <20181217122441.GC13868@sirena.org.uk>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <20181213153127.GN10669@sirena.org.uk>
 <19c273d9-c52d-48be-a1e1-88e2b1f14cce@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7631773382730171322=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D76C26789E
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 13:24:44 +0100 (CET)
In-Reply-To: <19c273d9-c52d-48be-a1e1-88e2b1f14cce@xilinx.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Vishal Sagar <vsagar@xilinx.com>
List-Id: alsa-devel@alsa-project.org


--===============7631773382730171322==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 14, 2018 at 07:50:43AM +0100, Michal Simek wrote:
> On 13. 12. 18 16:31, Mark Brown wrote:
> > On Sat, Dec 08, 2018 at 12:02:37AM +0530, Maruthi Srinivas Bayyavarapu wrote:

> >> @@ -0,0 +1,185 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Xilinx ASoC I2S audio support
> >> + *

> > This looks otherwise good so I've applied it but please send a followup
> > patch converting the entire comment block to C++ style so this looks
> > more consistent.

> Is it the rule for your subsystems? Or did it come from any generic
> agreement how this should be handled in .c files?

It's mainly me, it's certainly not a consistent policy.

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwXlYgACgkQJNaLcl1U
h9CieQf/d4qfEmhEQY7q0EE8eRo+Jy7falVp81WeY6WS40+3+HHpLtlu9i3ful/U
lP+grha3OB7ugQyuBBZQxlotb69r3pVHLPaUu/WDoumwB2OZ2Mkfgt5+dBPXcxCt
tKJ2IpRmCJcsYyQVed2i/XzmqRjc6EcONyO8FjA77w1YbkncAbjfko5CeTT+xUf1
TubG6H5dZdTsaYfdkoHoAqLhQkE7dEOYopnFLB0wm9n0NRhDtGy7TebU+/HSDkhE
kP5lSbtRP0/f1sdnvlBFddTn13EZtk5HLQAzp1dUOeYdl4Ml1jMvvCXz91hDhMRu
ZDlaox91zIow+PhuGCM0d8YDMzEGEA==
=ux+Q
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--

--===============7631773382730171322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7631773382730171322==--
