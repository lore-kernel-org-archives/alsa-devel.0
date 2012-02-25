From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Sat, 25 Feb 2012 11:39:03 +0000
Message-ID: <20120225113902.GA3167@opensource.wolfsonmicro.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<20120224141207.GI5450@opensource.wolfsonmicro.com>
	<4F47BB0D.9080905@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5247445444502754688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6553324442
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 12:39:07 +0100 (CET)
In-Reply-To: <4F47BB0D.9080905@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5247445444502754688==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 10:30:05AM -0600, Timur Tabi wrote:
> Mark Brown wrote:
> > The ARM machines really shouldn't be using the bindings that PowerPC is
> > using for the machine as they conflate the machine driver with the SSI
> > binding.  The idiom for new systems is that machine drivers should be
> > first class devices in the device tree referencing the SSI and CODEC.

> Where is this documented?

> I don't remember participating in the discussion for this new binding.

It's not a specific binding but rather a general idea of how these
bindings should be done - I don't know how one would go about
documenting general ideas like that, I have asked people to do that but
I don't think there's a mechanism.  There's a couple of such bindings in
mainline at present (the nVidia ones).

I do recall you being involved in some of the discussions, though it's
possible I have these confused with other device tree threads.

> > The current bindings should be preserved for existing systems of course.

> There's no reason we can't update the PowerPC device trees.

We could, yes, but it would make people's existing device trees buggy
which would be sad.  It'd be nicer to keep the old binding around and
support it for people who are already using it.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPSMhPAAoJEBus8iNuMP3due8P/3CQPR3rAOCmzv6yvL9AOnNQ
AaXUfRerhHfIEI3PM9emJCWI/R09eIUBv2Zr71GNn91vCEE623/+IsTfc25uXHhJ
na2uPCRftf7rpKs+b8NsLeOOqdrTAxzVgUGoaEeHxCoatQKx6eQr/rvqPh0fYeyj
P0KW9jPvl96irgKs0CZQrIh7AKXSONFKNTecxUG2BA24/xObbJBM95jvizbpxOX8
MY9UX0+7ZwPDuF/BhkBVW6f/zWXpwmOLB7MzvCXSwRnXcO3/IlHjQ64O40deXBVM
Re/Xhu/EHX8vcHNV+zcGBbzQ7t36hirwvF+sawRhA9WNSLnqrJxFxsq+lfDCVrWL
94stWodjPO022rGssHvHWr4IH1BQhS/ZrrapXJ/AjnPWThwm9Fz3LUzxjPZZAgLl
hWDa+Mi1/d3JA4O4EQmhv+UTfuq9W6o21/Q9N81HoZbSQj0NPWtZezn7bEuQHx6a
R65ncUjDbnay9Qw63znasWuy1L/jRKea8Wkn+zK7KmL1cdH5a83F9Jr/097j1agm
+SVp0SdJ6DaKuTfHDv8+JX2drbyuFfQjd3Qcx8fWscTXZyPy54zTqvCwNuHV6gj0
jSAePbtiASsOnRTboOHxfyDbLiGu3m+U17MSnHqEMbPj2PUjUMEGhm0h8wdjuhTS
zQ+2+n6G4cvxf3FVpkso
=ra5w
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

--===============5247445444502754688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5247445444502754688==--
