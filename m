From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Add name prefix for machines
 with different topologies
Date: Mon, 19 Mar 2018 15:13:49 +0800
Message-ID: <20180319071349.GF2186@sirena.org.uk>
References: <20180314202511.13614-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0008096592457249739=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A12326737B
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 08:13:54 +0100 (CET)
In-Reply-To: <20180314202511.13614-1-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0008096592457249739==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="scAc3P9VHJ9eL0X2"
Content-Disposition: inline


--scAc3P9VHJ9eL0X2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2018 at 08:25:11PM +0000, Liam Girdwood wrote:
> Provide a mechanism for drivers to modify there card name with a prefix
> so that userspace can load a different configuration file to default.
> This can be useful when topology has changed the PCMs and kcontrols
> for a machine.

This doesn't apply against current code, please check and resend.

--scAc3P9VHJ9eL0X2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqvYy0ACgkQJNaLcl1U
h9BSXwf6AgdPv6DIefuq2JVDd8P6ndCBlDZHMT0+LY4rKY8O87m6tYl9oDY3PhSD
cnl0J3cL6Ay87D5Wz37QC4v2ABvBs80nhlEVp/0RbVoPvZQ+Q1nv2Fr14agLzGRP
pv5pdX7JBk1+Cz1vTOq5D+nX69IsqUHyXSC18cC6qPi9UtypB/LKWFhu+/MHtK7a
L39NFOQ/GkzLvxN7ecSdtQE21uotA1ejX6q3sPtQGzHilCx28FcMSVwCz0B5T47m
DdqSmMntUpPk0nwlGIc6LvZngi9mE/csRfgAUezPLF4JCNWdlIesilYZqjUq8pTZ
GMdHE7vmfj8oyyYpPtyzj92OxcQaeA==
=5laQ
-----END PGP SIGNATURE-----

--scAc3P9VHJ9eL0X2--

--===============0008096592457249739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0008096592457249739==--
