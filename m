From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Tue, 16 Jun 2015 17:06:07 +0100
Message-ID: <20150616160607.GT18309@sirena.org.uk>
References: <1434338445-31992-1-git-send-email-yang.jie@intel.com>
 <s5hmw01gq9c.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA25@SHSMSX101.ccr.corp.intel.com>
 <s5h4mm9gi8h.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA81@SHSMSX101.ccr.corp.intel.com>
 <20150615150556.GQ18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554ACF5@SHSMSX101.ccr.corp.intel.com>
 <20150616105429.GI18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554B0BF@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5672653186064954327=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B22E5265842
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 18:06:19 +0200 (CEST)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A90554B0BF@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Zhang, Vivian" <vivian.zhang@intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5672653186064954327==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aiJlF+TB2UsRxGRQ"
Content-Disposition: inline


--aiJlF+TB2UsRxGRQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2015 at 12:36:16PM +0000, Jie, Yang wrote:

> > OK, that should have been in the commit message.

> OK, so let me add it to the commit message and resend?

Well, there's still the stubs to consider.  Should we really be
returning an error or should we silently ignore the error and hide the
DAI if the user deconfigured compressed audio?  Or rearrange things so
we don't need stubs?  Given that the machine driver has to select
compressed support it's not something that should ever really hit the
stubs, it's not truly a runtime thing...

--aiJlF+TB2UsRxGRQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVgElqAAoJECTWi3JdVIfQQbcH/RdMdwGfmg78XHCVj3l2totd
vTISOc0GglaO5syw3Kfs7otEuyV85VGoSwZVqZgMR7dXMtilNSrqikk/c2POOLXO
EQjt6P7LG3cBi1fstNJ+EOkilpR2kgVN56YSHnaMR0gkWOpLPQ89DFaQl+261JKL
i/yge+eDET/AasidHI9OjYsNcS8ERV/Pb1UkUmAzOSsqy0qVPo9SIiyfwM95V0zN
2vsRWLdRzse/UcugeIiK1u6kW0LVHvI5kXk2fGoraV4kexPuCSyKFzhTJtpRSIyI
hlyT/4foh7TxQpUBWfySWL4DrPcf1LBP7QEyA/4XRgmFb+u+HSHnNo0TcHDA/rM=
=adNf
-----END PGP SIGNATURE-----

--aiJlF+TB2UsRxGRQ--

--===============5672653186064954327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5672653186064954327==--
