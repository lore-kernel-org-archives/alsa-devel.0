From: Mark Brown <broonie@kernel.org>
Subject: Re: multi-codec support for arizona-ldo1 was Re:
 System with multiple arizona (wm5102) codecs
Date: Sun, 15 Nov 2015 00:14:02 +0000
Message-ID: <20151115001402.GZ12392@sirena.org.uk>
References: <20151012154715.GF4238@sirena.org.uk> <20151012201137.GA7317@amd>
 <20151013115355.GC14956@sirena.org.uk> <20151113215812.GA19020@amd>
 <20151113225355.GU12392@sirena.org.uk> <20151114074400.GA7898@amd>
 <20151114123931.GW12392@sirena.org.uk> <20151114175915.GA20429@amd>
 <20151114184940.GY12392@sirena.org.uk> <20151114211633.GE20429@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7055918977224343994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A689B26062C
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 01:14:21 +0100 (CET)
In-Reply-To: <20151114211633.GE20429@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============7055918977224343994==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MzUyxqdXrKJm2YZW"
Content-Disposition: inline


--MzUyxqdXrKJm2YZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2015 at 10:16:33PM +0100, Pavel Machek wrote:
> HiOn Sat 2015-11-14 18:49:40, Mark Brown wrote:
> > On Sat, Nov 14, 2015 at 06:59:16PM +0100, Pavel Machek wrote:

> > > Well, mfd_core.c seems to call regulator_bulk_register_supply_alias()
> > > with device that does not have dev_name initialized.

> > OK, that'll be the problem then - we're not mapping the supply into the
> > individual child device but rather system wide, probably because that
> > mapping is being done too early, before we've actually created the
> > device.

> Take a look at mfd_add_device(). Yes, we do
> regulator_bulk_register_supply_alias() before doing
> platform_device_add().

Looking at this I suspect we need to re-add the code for matching
regulators on the actual struct device and do that since this is going
to be very error prone.

> I guess Charles Keepax should be listed there?

Possibly, up to them.

> > So if you look at this just templates out some boilerplate regulator API
> > client code which calls regulator_get() like any other client and then
> > hooks that regulator into the audio power management.

> Ok, so SND_SOC_DAPM_REGULATOR_SUPPLY() does not work, because I have
> two regulators, right? Is there similar macro I can use?

No?  What would make you say that?

> Do you have an example (filename, linenumber) of sound driver that
> gets this right?=20

I'm not aware of any drivers that get this wrong.

> > I'm not sure how I can be any clearer that supply names are namespaced
> > by client device and that as a result fiddling around with the supply
> > name is not going to help anything.

> Well, you are saying that pretty clearly, but sound driver I seen
> assumes names are global, and /sys interface assumed the names are
> global. Give me an example I can look at and I should be able to
> figure it out... You are clear, but the kernel code seems to disagree
> with you.

Every single sound driver gets this right, none of them assume the name
is global.  What makes you say that they assume names are global?

--MzUyxqdXrKJm2YZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWR85JAAoJECTWi3JdVIfQ3esH/jPVwF+ihcC5UsB7XQQ1/6Nq
TKvwWB84HppX04hCsX1v3Os/Z9shMro/nzK22CEuIy5U80H38v66CpEUVOp3uIlj
9a5d9Rb7pIeZnmQoAEexg9Y/G694BMW47mIK48WCx2jzAwpp82pGpvVpdT/lz1C/
RxdpItZSPtMU4dCFwFAOkRh+1s0oYOfAYqgMEzgEwCHhX7NVbqahu2CO9yBIv57E
zEnyDCleVwAs6zVLKcYPoiV1IqU44cfMAYb0ZKmaYeQGDTKa6gn20WZsdOkAffYz
SAIQ3VrN1Ty2Wgne6sekx90lbWUNFXvbH6Kps/qjLReZh6qSbrILc3Hf7DhY1Uw=
=c19l
-----END PGP SIGNATURE-----

--MzUyxqdXrKJm2YZW--

--===============7055918977224343994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7055918977224343994==--
