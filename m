From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake - Add Skylake RT286
 I2S machine driver
Date: Mon, 12 Oct 2015 22:04:29 +0530
Message-ID: <20151012163429.GI27370@localhost>
References: <201510101650.2oGqByd9%fengguang.wu@intel.com>
 <1444619526.3544.6.camel@intel.com>
 <20151012161736.GG4238@sirena.org.uk>
 <20151012163225.GH27370@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0582805741893702990=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DE9B3264F3F
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 18:33:54 +0200 (CEST)
In-Reply-To: <20151012163225.GH27370@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lkp <lkp@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Abdullah,
 Omair M" <omair.m.abdullah@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, "Kp, Jeeja" <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0582805741893702990==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2015 at 10:02:25PM +0530, Vinod Koul wrote:
> On Mon, Oct 12, 2015 at 05:17:36PM +0100, Mark Brown wrote:
> > On Mon, Oct 12, 2015 at 03:12:07AM +0000, Koul, Vinod wrote:
> > > On Sat, 2015-10-10 at 16:42 +0800, kbuild test robot wrote:
> >=20
> > > > [auto build test ERROR on next-20151009 -- if it's inappropriate ba=
se, please
> > > > ignore]
> >=20
> > > > config: arm-allmodconfig (attached as .config)
> > > > reproduce:
> >=20
> > > That's nice, thanks. We should add a depends on X86 for this to not c=
ompile on non
> > > X86 code
> >=20
> > > Will send updated patch
> >=20
> > It looks like the missing functions are just readl() and writel() which
> > means that they're probably only working on x86 through implicit
> > inclusion rather than intentionally - if that's the case adding (IIRC)
> > linux/io.h is a better fix.
> Yes relooking at this, I do agree that seems to be doable.
> Let me try that and see if we can get this to build :)
And will need depends on ACPI for acpi_ routines, so need to add that too

--=20
~Vinod

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWG+EVAAoJEHwUBw8lI4NH/z8QAIi8Rrogng+HWZaBjUbreuxg
QYjW0dhBo4EkzSKA+MfhNb9aDvrLiNNbArrxbXmmFT8SkCX8AQLmSUdG9IoDa+/G
Nantz6gaV3dWhwm0S3fQZWroV2CUVsrZH+b53lHIhAdT2CCklpOfIv4kKnA/0eEI
pN/MNoBiH+cVSW1KZ1x2fl4Lutx+1PpEo2Yx53A2oaOdYt/j4F9GX95t8IbXpIby
KB+9OwaQcqdMSGkjaXN+A7awJLoSeQf2dTfJrOzBEUXoLioELO4ACD4EAUa9bZcF
KlFE1OZqUDd3sbq1u4KoxkL4hvGrLSddYhdVbzc76ZCKwuFTxiH5AWNrA7MiY6VP
wkBvFaVS2+plI8/Bb50mx0pq5UOZTIAsgY/2KwCHJdAA1Mh9hbqo3Sg2mmIStE0/
DaenywiRsU7KLYmgbhiCt55SJntfVl+Y3/BJ7N5Tzb/FT5dWxQHxnNoYn8CW098J
fymPjTJRDZ4cZ2OuNEE1RBYcBosCcXl4q3juXmeUs8hMMluTt5tmHnGIeu7g0ADE
3Gx4BiAi4r0OYpE6utntZwK/Ob4TMuwgAeK2cNLd3r1zY4+EpC5glV+ZDVoqs7M5
FHqYy1RkWekY3QUkr10rStH+QFHc9689abJYwBM7JKmQgLmKs+l8p1ahPxfy9dFP
dkIWZGsmGjTQ436qAHHU
=Vf2k
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

--===============0582805741893702990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0582805741893702990==--
