From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Thu, 14 Dec 2017 15:31:39 +0000
Message-ID: <20171214153139.GG9788@sirena.org.uk>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
 <20171214115648.qidtgzihdoikxvhe@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4688939542879956499=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 24DCC26732A
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 16:31:50 +0100 (CET)
In-Reply-To: <20171214115648.qidtgzihdoikxvhe@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, "Chen.Liu" <chen.liu.opensource@gmail.com>, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org


--===============4688939542879956499==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2017 at 11:56:48AM +0000, Charles Keepax wrote:
> On Wed, Dec 13, 2017 at 08:37:30PM +0800, Chen.Liu wrote:

> > +	if (unsupported)
> > +		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x6,
> > +				WM8960_SYSCLK_DIV_2);
> > +

> Looking at this a bit more I do have some reservations. Firstly
> this divider can be set through wm8960_set_dai_clkdiv, and
> secondly it is also set at the bottom of

Removing set_clkdiv() would be a better thing if there were conflicts
here, in general we're trying to avoid uses of it.

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloymVoACgkQJNaLcl1U
h9Dfywf+JQ2Z2RttyQxXMvQMa1cmrAOBOPv2b2Uv0CH3XcjIjZCxjPaQOsZRQ/Wp
XVofEfvmCnMNXzD2Hlp7JWho1r3lIntMal13i2cOYV8Y51/nbeM3+Gu9YWJ10/N2
9gD0WTTNVBKoFHcZfecDibUB415+1L5lDNlk+AOGRUXEhv62HaylzR5XWZEV2oVU
ViFv76n0ML+yF3llwQ498YLSlCkA7dNinR3qV93aHRwMCnBqERay7IkUKExVJreM
LX9HpDZwp3ub9gNQ97RNOtks+ewzelxXesFfVECSVYRiykdUmd4llEf871laCbFD
1XWMCWZGYCx3h3jGbaWS3SXZr7cBXw==
=1mqp
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--

--===============4688939542879956499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4688939542879956499==--
