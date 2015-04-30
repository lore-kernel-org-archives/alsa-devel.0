From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: ts3a227e: add platform data for
	ts3a227e driver
Date: Thu, 30 Apr 2015 22:25:49 +0100
Message-ID: <20150430212549.GR22845@sirena.org.uk>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-3-git-send-email-yang.a.fang@intel.com>
 <20150430200220.GH22845@sirena.org.uk>
 <0485FB02182A4744A8B06D69AB7BF8E718CC6E89@ORSMSX113.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4563623926463065609=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E8E0A26619D
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 23:25:54 +0200 (CEST)
In-Reply-To: <0485FB02182A4744A8B06D69AB7BF8E718CC6E89@ORSMSX113.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Fang, Yang A" <yang.a.fang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, "Diwakar, Praveen" <praveen.diwakar@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>, "dgreid@chromium.org" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============4563623926463065609==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l0czVjQLUIKEMoSP"
Content-Disposition: inline


--l0czVjQLUIKEMoSP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 08:45:40PM +0000, Fang, Yang A wrote:

> > ts3a227e_interrupt,
> > > -					IRQF_TRIGGER_LOW |
> > IRQF_ONESHOT,
> > > +					ts3a227e->pdata.irqflag,
> > >  					"TS3A227E", ts3a227e);
> > >  	if (ret) {
> > >  		dev_err(dev, "Cannot request irq %d (%d)\n", i2c->irq, ret);

> > This doesn't make much sense to me - no change is made to the
> > configuration of the device, the driver just passes the flag through to=
 the
> > interrupt controller code.  I can't see how that's going to work well,
> > somewhere along the line something must be misconfigured.

> My intention is to make irqflag configurable. I made them two patches.
> Patch 3/4 to make sure existing code no impact. 4/4 is set different=20
> Irq value via DMI for specific platform. Maybe I should squash them?

No, you're missing the point - if you're changing the flags for the
interrupt without also reconfiguring the hardware there's a bug.  This
seems like it's what Dylan identified with missing interrupts, it sounds
like the device is always level triggered.

--l0czVjQLUIKEMoSP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQp3dAAoJECTWi3JdVIfQimsH/jSEVNSw4zcWhhYDRjKRBLQ3
T6GNSTay1Kux2lskOzpukFewcP+eViaMY2PI1FXlB/zaikX7Ex7q3D7kGu6yBEdz
C8lgF/pL68AwkRVCqsg3BkifVBLSnq/AUVdZZopWpLZxVgvi/f2ctn8B5u2SzmZJ
vpq8Yw4VAX65zxVBMTa6UfQb6255ltg2Hotra3SshU76CBH4nmPsCnaRx3YfyyRi
b659Qo7Smf6Kkfc/gs/dxV3RRYWKmUl60ivb0C2AbCn7n7FNGEnFvmO0ocNGM3AL
CmvUAPyYH+O6Aw9wN38BDviaG7MqKi3Si9CXsRmQ140E9HMW3a/QHYB94yi81AQ=
=mMiK
-----END PGP SIGNATURE-----

--l0czVjQLUIKEMoSP--

--===============4563623926463065609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4563623926463065609==--
