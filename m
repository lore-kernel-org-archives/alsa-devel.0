From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 13:30:37 +0000
Message-ID: <20120222133037.GJ7340@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120222132107.GD7340@opensource.wolfsonmicro.com>
	<1329917409.24656.115.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1407370487431163008=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D49F103F8E
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:30:39 +0100 (CET)
In-Reply-To: <1329917409.24656.115.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1407370487431163008==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mPTHnM80CEnHQ2WJ"
Content-Disposition: inline


--mPTHnM80CEnHQ2WJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 07:00:09PM +0530, Vinod Koul wrote:
> On Wed, 2012-02-22 at 13:21 +0000, Mark Brown wrote:

> > For the non-cyclic DMAs the idea of emulating at the dmaengine layer
> > does seem very sensible but if that's hard then having the code at the
> > ASoC level and pushing it down later seems fine.  We do have several
> > platforms with non-cyclic DMA so it's a general need.

> I think this should be pushed to dmaengine rather than in ASoC. That way
> ASoC can always request circular and we emulate the behavior in
> dmaengine for dmacs who don't support this

That's what I just said.  I'm just saying that if for some reason it's
going to be difficult to implement I don't mind carrying code at the
ASoC layer while that work is done.

--mPTHnM80CEnHQ2WJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRO3zAAoJEBus8iNuMP3dDkwQAIfXld6ONYGhbQ4wtoNleAzd
jrTfCm9ZP57FAgEUEaMIzhGKf94ubCHRebloowFskGh9pJhiW1447d6foHwG6RmM
zoMWdgAmAg5aCVm56+rmF4Hq7vAG1IlVIIpNbmBYpsS53/e2QmwZvgt8zfmM+VCe
qc1sju4WFxVOEiqXjZclaoeicf9SiWzCRk91krDMvHtFij6O29YZ5tJnAXyWK/B2
3ZplNijXDqTPl0fcBfIA6zxDcHOy/jpfmNn5Pm5f+CZ7rC0TU61WTGFOaGQDiz6T
tmmqntpVPNfw69z5kwpi0O1IpaLfYibiQXB/+pFKYH1+juvo03VsrAhGpGR5WqMm
t2935iF1cSkJQ59zrogzNgVeIZEaKK/ue5hwYMYLaUeJ2RcPA0LoFacAxWKdPDMe
D1i/YQ6oRrsnlJPt9i0p16g89yChGH6ihksPkzF/Bc1I9QPprhOx/xzLvXlh4I9t
L9MCZjCcSSt/qhVRTmDbQApbNUX+qesdbn/MnX+DsqLPqjNYO33OiwHC6yuLEVY1
UkvueyXbRvFYIguuvt9dfkOvFlf9EkBRW4/Aby79J+hvhJlAr2lF2s/IsJVQdMSc
m8pC8VSpy5hyb+34XJogQM8PN+xISgS9UUaBdFNi4OgbDINvTutzzWhSWNF6q6Fs
I+JwudBOB1XslVtuX9SH
=MjTB
-----END PGP SIGNATURE-----

--mPTHnM80CEnHQ2WJ--

--===============1407370487431163008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1407370487431163008==--
