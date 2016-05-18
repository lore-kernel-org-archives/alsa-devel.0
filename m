From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Wed, 18 May 2016 18:05:49 +0100
Message-ID: <20160518170549.GR8104@sirena.org.uk>
References: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
 <20160513104841.GA22038@sirena.org.uk> <573926C5.70704@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0678678359686742394=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C24426147A
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 19:05:58 +0200 (CEST)
In-Reply-To: <573926C5.70704@nuvoton.com>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0678678359686742394==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="19HmC3QOnaNVzKTI"
Content-Disposition: inline


--19HmC3QOnaNVzKTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 16, 2016 at 09:47:49AM +0800, John Hsu wrote:

> There is another patch is made by this patch.
> [PATCH 2/2] ASoC: nau8825: cross talk suppression measurement function

I'm confused about what's going on here...  if you're sending multiple
patches that need to be grouped together you should always send them all
together.  If you're not sending a group of patches then you shouldn't
use numbering in the subject line.

> Besides, please help to review the following patch for the DC offset
> issue. Thank you very much.
> [PATCH] ASoC: nau8825: apply BIQ to reduce recording signal DC offset

This is hard to review since it's quite complex and doing things that
look like they might be using general purpose parts of the chip for
specialist purposes.

--19HmC3QOnaNVzKTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPKDsAAoJECTWi3JdVIfQMM4H/0dlQDv/I8slKr8983idv4kb
aE2h08QBylIFExta0xMZc6wiNBW1OpLZ6ElRRVrH6O/Ht62RfllncGWrKL3j0K/u
5Kw8KzeWfI8HP5yorTUIuMnJiegUg6Q6lIatXudmMBA4nX0wAkoQBqoFuHyVYRFY
Ftg2Wexv1P68Og4BYbFp/WL49DWJLLzU7T/u/W6xpyrVsn5NpB/HKHNl002AhZWf
dF0Gwb9RLPKetIkwbsD73qY2j5XquM93SbxhEZc8hv35fvuNLT7NrHHQJOJ4MLrB
YOC9VEWQk85DvlSRd4x9VKZOMojplwo+1PrtdRTotUgDiUdaHMf1tDHfUDRR47Y=
=Khav
-----END PGP SIGNATURE-----

--19HmC3QOnaNVzKTI--

--===============0678678359686742394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0678678359686742394==--
