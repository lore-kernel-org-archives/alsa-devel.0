From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5677: Switch to use unified
 device property API
Date: Mon, 22 Jun 2015 23:50:31 +0100
Message-ID: <20150622225031.GW14071@sirena.org.uk>
References: <1434996780-34535-1-git-send-email-benzh@chromium.org>
 <1434996780-34535-2-git-send-email-benzh@chromium.org>
 <558889CE.7010104@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1628055056075109523=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C43D2604E2
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 00:50:39 +0200 (CEST)
In-Reply-To: <558889CE.7010104@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Darren Hart <dvhart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Grant Likely <grant.likely@linaro.org>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============1628055056075109523==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bX/F0jVw41zVoqcS"
Content-Disposition: inline


--bX/F0jVw41zVoqcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2015 at 12:18:54AM +0200, Pierre-Louis Bossart wrote:
> On 6/22/15 8:13 PM, Ben Zhang wrote:

> >+	rt5677->pdata.in1_diff = device_property_read_bool(dev,
> >+			"realtek,in1-differential");

> Shouldn't it be device_property_present() ?

At least on the DT side they should be equivalent - I don't know if ACPI
works differently?

> thanks for starting this transition, this will be very useful for ACPI-based
> solutions.

Have the Intel audio people been speaking to the UEFI forum about using
the new registration process for these properties?  More from interest
than anything else.

--bX/F0jVw41zVoqcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJViJE2AAoJECTWi3JdVIfQorAH/iSAuvdPanYNhFN7WX15JnuG
fGYkBzFIGjxvRf1oS4lEfauO5PG7grqDm0O4qAy+3pyhxNdAW1pikY4dS1h1LN3M
LDTFcWXnrp83rxFj/J2xm1Ov80/Rq2Yo887U4DeVutTePsQdWfNgSN4OKRkn2LTo
/fv7gDXRRs9gWTICos/BxLwpkK5U0Piiu+GHM4JrGX3++FjOrvBANbvwNPT8I58f
uK/CcQWrTlTBc/Z9C4NwNT/dL090YfQ0jMpipPKtmQY8y0gW1ezHyRzsJs+nJSvN
LJ6Im11AH1Sl0MaWKiDEnNjGhhP4eo7tpxGwBAeuI8FnFsb8FWK4IAOU3VFoq3o=
=yA91
-----END PGP SIGNATURE-----

--bX/F0jVw41zVoqcS--

--===============1628055056075109523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1628055056075109523==--
