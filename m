From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: fsl_sai: Add imx7d platform
	support
Date: Tue, 11 Aug 2015 10:38:49 +0100
Message-ID: <20150811093849.GL10748@sirena.org.uk>
References: <35057b1d49085839cdd1c6514a6ed7b690c713e9.1438928571.git.zidan.wang@freescale.com>
 <f269bace628dd8ebac7c1833b743d4d5e5d528db.1438928571.git.zidan.wang@freescale.com>
 <20150807193436.GA6840@Asurada>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5634007526643890923=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 39C592604DD
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 11:39:04 +0200 (CEST)
In-Reply-To: <20150807193436.GA6840@Asurada>
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
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============5634007526643890923==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fDERRRNgB4on1jOB"
Content-Disposition: inline


--fDERRRNgB4on1jOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2015 at 12:34:37PM -0700, Nicolin Chen wrote:
> On Fri, Aug 07, 2015 at 02:23:52PM +0800, Zidan Wang wrote:

> > +	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx7d-sai"))
> > +		sai->sai_on_imx = true;

> What's the difference between imx6sx-sai and imx7d-sai?

> I think you may put its compatible model in the DT instead of adding
> a copy in the driver unless the SAI on the imx7d really has something
> different.

> For example:
> 	compatible = "fsl,imx6q-ssi", "fsl,imx51-ssi";
> 	/* The driver only has imx51-ssi */

It's generally good to have compatibles in the DT even if we believe the
hardware is identical since it can happen that differences are found
later (either due to new features being added or bugs found) and having
the explicit compatibles in DT already means that we only need to update
the driver.

--fDERRRNgB4on1jOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVycKoAAoJECTWi3JdVIfQCAsH/0RdQiQunzVHQPmcj0EdpSz9
hbZc0bQWlKzJ0oerKlah/80TVuCVPARrKi4P8/FF2WsYphF8xAQk3l0dk4QhanFd
B01qYeJJejoxi1gMr+mUK7mP6sKOuTvUosAy9u0kizzz1Yw56IZrDPsVzJlj4QXp
nySGOIZKdvjEVfEA/JcKEf0eddPy+ju7BmjTvX2qnsPJpUBpCATwC3Dy/ui8MvZG
S7kRAVJcdSHEp+bNBl0SsjWpi61aAwHutCoKQFUUHpcAOI7kPkqp1JTswpij5IWD
tcBhQ2YQ+kG7RIhH0Wssf0IQBLoR2ivF6TaMujE1oB2SOsgtCirKCk190e06TEM=
=skb3
-----END PGP SIGNATURE-----

--fDERRRNgB4on1jOB--

--===============5634007526643890923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5634007526643890923==--
