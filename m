From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
 machine kcontrols.
Date: Mon, 6 Feb 2012 18:19:38 +0000
Message-ID: <20120206181938.GA5751@opensource.wolfsonmicro.com>
References: <20120203204640.GD23505@opensource.wolfsonmicro.com>
	<1328524623.6799.9.camel@odin>
	<20120206110939.GC3070@opensource.wolfsonmicro.com>
	<1328531118.6799.13.camel@odin>
	<20120206132746.GH3070@opensource.wolfsonmicro.com>
	<1328537786.6799.16.camel@odin>
	<20120206142559.GJ3070@opensource.wolfsonmicro.com>
	<1328541116.26182.99.camel@vkoul-udesk3>
	<20120206151737.GK3070@opensource.wolfsonmicro.com>
	<1328551752.26182.141.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4536504839490017378=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17215103BBD
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 19:19:40 +0100 (CET)
In-Reply-To: <1328551752.26182.141.camel@vkoul-udesk3>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4536504839490017378==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 11:39:12PM +0530, Vinod Koul wrote:
> On Mon, 2012-02-06 at 15:17 +0000, Mark Brown wrote:

> > Yes, or rather if the machine driver is peering into the CODEC internals
> > at all something went wrong.

> Yes it was wrongly done due to "historical" reasons. We should ideally
> move this to codec driver... Let me see how I can fix this up :)

Looking at the code I'm pretty sure it's the fanout mux thing (I think I
remember discussing it with you) - DAPM supports muxes selecting one of
n inputs for an output but it doesn't support muxes mapping one input to
one of many outputs.  Could be something else though.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMBmhAAoJEBus8iNuMP3duasQAJH4XefxaOVqYZyP8jZ9ziZu
px1Lu9yyaol1YdM6GT0+rNjwvNqTxF0heAu3ZHvE1Pg/FMLfnA2lgnPIno2r8mK8
tEarGG65TN7wox0UexJFug06vtw68peCQKzWPvFOxZPCayOEA/KA3zj4z0/FkgdB
bQEgnMiNwV0M/NIwuhPEv220eovuSXQ/hTD0bdexrKzWiaqDo7LUIIjsnsPE01Io
DcTSeA3J/xWx3GvR4z6xtSZ2fbRHtfEA4DDneyoC+IAPEjabcD42qxlnOmaI/6yz
tk9dKTYn6HcvKUZrKk6STADJwe+e7GQga17RbP3D8OkSlJvTI5QuaYb8qfvBiYJ3
nacbRPkuGOop5AVeT005gP6hipJZIu5MSqiKtTjbhsNGRpbA7sux6fKSEoIupyvF
AuFE1qNcVvv6S/t5oiV2nWsaRdd5wbpX5Lvzsyg0xrCulpY7uRm5fh1Le2DlQGL2
vqIAkhe/Oij0OuRTGnMrrppcXH/IGsq94SNnIDxUdOwuyvM5B0PNSO0/elH0xwWE
iwiwq7/7IU2fat6o48j0D9hwIwO/MSNO1C0G50SjCVzg8eizf16ZF4NXsuSiMHjy
zL6kx77CnWfLqFVBlecEPz6GP9kl0iIxTe3SosyreTMNnnBpTtAGPX4v4Riw0mPl
zvUOmS1BQhpfs06nMcWC
=3RcH
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

--===============4536504839490017378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4536504839490017378==--
