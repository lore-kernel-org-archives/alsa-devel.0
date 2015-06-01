From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 1/4] ASoC: arizona: Export functions to
 control subsystem DVFS
Date: Mon, 1 Jun 2015 17:36:04 +0100
Message-ID: <20150601163604.GE14071@sirena.org.uk>
References: <1433163891-10084-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150601161047.GC14071@sirena.org.uk>
 <20150601162241.GA13681@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7550097739373392484=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B6F64260654
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 18:36:11 +0200 (CEST)
In-Reply-To: <20150601162241.GA13681@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7550097739373392484==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Content-Disposition: inline


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 05:22:51PM +0100, Richard Fitzgerald wrote:
> On Mon, Jun 01, 2015 at 05:10:47PM +0100, Mark Brown wrote:

> > > +		if (priv->dvfs_reqs)
> > > +			ret = arizona_dvfs_disable(codec);

> > Are you sure that the function shouldn't check for requests?  It seems
> > like every caller is repeating the same check.

> Sorry, I don't understand your comment here. When SYSCLK is disabled
> we need to disable DVFS so that the codec can't go into suspend in the
> illegal state of DVFS enabled but insifficient DCVDD. However, if
> dvfs_reqs==0 DVFS is already disabled so we can save some time.

Sure, but you repeat the same tests for dvfs_reqs at every call site
which suggests it should be factored into the functions.

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbInzAAoJECTWi3JdVIfQTzEH/RIMCaBqF/UnCjbcMHf6CCG7
/rELoJLzm+lGaIJDoH1te60vl9h50FeNNFNwPPsGBmxURQ9UQhDypojJ4cRrxGDQ
MDn+6b2sH0vSQOf1Nqhq1SOAmmfv5z3zZIQ5WU0FWRwHo7bXLgfqHEUWIKnduk9s
Zncn9aRcJ5bFitTzclrfbxFcXS8owySa/r85XRyHFuObovPNSt7j2rFs3jBgd0dR
0h+HDOz67Di0KhaNmuNEftQTs2Qqx0GI+WHC8BvXN+UxEiWI9AZSY/8FpQPee2eS
HNYNI0/mVfdKfwtR13oX0jfd9SJT41xXyKzTXXQFpArqGn+piDnFXdF2q141IrU=
=DW0C
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--

--===============7550097739373392484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7550097739373392484==--
