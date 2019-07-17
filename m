From: Mark Brown <broonie@kernel.org>
Subject: Re: Is there a way to support TX master mode and RX
 slave mode?
Date: Wed, 17 Jul 2019 19:02:04 +0100
Message-ID: <20190717180204.GF4459@sirena.org.uk>
References: <VE1PR04MB6479C4D2CD4B9D486209102FE3CE0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <548bda36-b81f-1811-7969-e80e698ecfa3@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6532329951749856262=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63F10F800C2
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 20:02:13 +0200 (CEST)
In-Reply-To: <548bda36-b81f-1811-7969-e80e698ecfa3@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6532329951749856262==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 11:02:05AM -0500, Pierre-Louis Bossart wrote:
> On 7/16/19 3:35 AM, S.j. Wang wrote:

> > Is there a way to support TX master mode but RX slave mode?  It seems c=
urrent .set_fmt only set same mode for TX and RX.

> good question if you are thinking of supporting the 6-pin versions of I2S
> interfaces with independent bit clock and frame sync on RX and TX
> Looking at the topology definition it could be that this mode needs to be
> handled with separate dailinks. Adding Mark in case he didn't see this
> question.

If the TX and RX sides are completly disconnected then they're just two
separate interfaces.

As documented in SubmittingPatches please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0vYpsACgkQJNaLcl1U
h9CgAgf8CszPBMJzgRhyN/HYeSk0VXQ907/XEEF6Y6t/FwJdSGDhEwRUHuIEPz2U
3ybKAe1S1qcaNQ83/h0ZbBDcsJYk2FMRdSIP/j5C7O2jgcFRSOg6PGE6QD78KwBm
fnu6d0L6pZ7E+gN5Y7ZU1DIZHh1Y7mrfy3c9Nd4X7ug1s6fh02R5ZSTCkUehMMxx
HLpkyf9aK+7fUFiIFwYhBlYsKGFagztf33dF44eXSZ8p+xvo/Swhm6C4x2AMubRV
2zFK7mYK67JyLMLhfF7RjViRPY5USR20zcFK/6Evijs2bq9Ha4fXmZ3+n5dfRwD5
wJdp3jwk8wt5a7p82sJbNdDn/MILJw==
=WqPe
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--

--===============6532329951749856262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6532329951749856262==--
