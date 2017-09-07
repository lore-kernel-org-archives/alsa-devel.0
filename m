From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk
 when it is equal to system freq
Date: Thu, 7 Sep 2017 14:44:11 +0100
Message-ID: <20170907134411.uzwh54lstzmvp6dd@sirena.co.uk>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <20170905050602.GA2774@Asurada-CZ80>
 <bbcb123b-8700-501f-e6d9-cab9e212de40@denx.de>
 <20170905075247.GA6112@Asurada>
 <deb40031-9db0-d667-7314-352cf548c295@denx.de>
 <20170905151550.5mhb535p22lsohlh@sirena.org.uk>
 <20170905174528.GA23906@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3579945189696855673=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 36AC12669F3
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 15:44:23 +0200 (CEST)
In-Reply-To: <20170905174528.GA23906@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============3579945189696855673==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rgvmcye5ctp4qbis"
Content-Disposition: inline


--rgvmcye5ctp4qbis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2017 at 10:45:29AM -0700, Nicolin Chen wrote:

> The ipg clock is merely used to access registers, and has nothing
> (directly) to do with external clock outputs. The driver shall not
> change the ipg clock as the system ipg clock (its parent clock)
> might be messed and even system time would get weird -- happened
> once when the fsl_spdif driver used to call clk_set_rate() on its
> ipg clock. Although the clock controller should have some kind of
> protection in my opinion, we just avoid IP clock rate change in all
> audio drivers as well.

Yes, the clock API needs constraints code.

> On the other hand, the sys clock (baudclk in the driver) should be
> configured whenever it's related to external clock outputs. When I
> implemented this set_sysclk() for fsl_ssi.c, I used it to set this
> sys clock (baudclk) by a machine driver, in order to set bit clock.
> Then someone patched the driver by moving all the code to set_bclk()
> to make machine drivers simpler. Now the set_sysclk() is remained
> to give machine drivers a chance to override clock configurations
> in the hw_params(). This could be used in TDM or some other special
> cases (It could also have a purpose for backwards compatibility).

> So here, we should set baudclk (BCLK generator).

No, that's just going to cause confusion - if all the other drivers are
using set_sysclk() to set an input clock rate to the IP rather than an
output clock but your driver does something else then sooner or later
someone will run into trouble with that. =20

--rgvmcye5ctp4qbis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmxTSoACgkQJNaLcl1U
h9D6BggAhvgy6CFp6gK7LdASMfJ/yXPXLKrd5loBZcc6V768OgfLWhV27lMkZVR2
Y4x6glGIG0CdkZEgpFdb8IFXnYuMXk6dHLSDPVHs2Um/1J2w0QzvEO2IttSfJhuc
G1HCx+TRKn6XmTX2nmC+gkj3Tr8D6ANVbnFOg22/CnUgdiPF+eDeQwCUEuFuytR3
Zy24+99zVI2C7N/wZl4CwX0bQjYoyql21OxHWwF6BNo2fa7XGMDcqqnX7EorLW8E
CslI/0j7agznM0wQhdY7Jy2DgVJOmACSbtsuiPlslPzzt+32axY0oWXIEGoSnGRc
2SplsrX9DOPbqVN9jamSMZ/AjJHwOA==
=pAg9
-----END PGP SIGNATURE-----

--rgvmcye5ctp4qbis--

--===============3579945189696855673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3579945189696855673==--
