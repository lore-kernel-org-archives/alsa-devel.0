From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/5] ASoC: Intel: ACPI support and
 machines
Date: Tue, 4 Nov 2014 11:15:13 +0000
Message-ID: <20141104111513.GE3815@sirena.org.uk>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
 <545889C4.5000509@linux.intel.com>
 <20141104082510.GC1870@intel.com>
 <545896DE.4030305@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5702591569323463626=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 112282606A4
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 12:16:40 +0100 (CET)
In-Reply-To: <545896DE.4030305@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>, lgirdwood@gmail.com, tiwai@suse.de, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5702591569323463626==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s8uQA167RD2xhjBe"
Content-Disposition: inline


--s8uQA167RD2xhjBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 11:05:34AM +0200, Jarkko Nikula wrote:
> On 11/04/2014 10:25 AM, Vinod Koul wrote:
> >On Tue, Nov 04, 2014 at 10:09:40AM +0200, Jarkko Nikula wrote:

> >>One difference at the moment is that byt-rt5640 machines out there
> >>have differences in audio routings but those are not too difficult
> >>to handle in the same machine driver.

> >>Bigger question how to handle platform part? I.e. can these use the
> >>same drivers and ADSP firmware? If they can, is the firmware
> >>available for distributions to take?

> >The two firmware are *not* compatible and that is the big reason why we
> >can't reuse the parts available

> Ok, so firmware appears to works on other than CR Baytrails too. Is it
> available in linux-firmware since if it's not when changing the platform
> drivers there will be obvious regressions to users?

Can we take a step back here: what are the firmwares and hardware
platforms we're talking about here?

> >Yes, I have tested this one on T100 and doesn't seem to break anything.
> >Please do test and revert if you find issues on any other available board (I
> >don't have any other board)

> Well, those audio routing differences require to have DMI quirks. E.g. T100
> has analogue internal mic, Dell Venue 8 Pro 5830 has digital mic connected
> to DMIC2 of the RT564x and some have it connected to DMIC1.

Are any of these things on sale at the minute?  Looks like T100 and the
Dell both are but I'm not sure if they're current or previous models.

--s8uQA167RD2xhjBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWLVAAAoJECTWi3JdVIfQ6OkH+gNoLQjBOilMV+sF5kgCkHT+
7R7e3BwrSf1izJ6pXEHh7IjsDk+WOYCQQIEQ6Ho6yhdKIoDOxb+AwIKbuKjNCaaT
vH7J4JNdokpt53Eng7k+wMiYTK1H1XPVic3XSuSVVe+bo7WNbsLI0tsJspJaNhMz
mTZeirruwcQmobHXOwnGP3MvE+TFEms+5DpF9TEEpYn8SCe9Ea8z5gxj4/z5uHLr
D2HM/jKkPvGecjap7Tni+MEpwSWKMBOAgWYwzQv0z/O73ZTU2zUl5PMW7rWt4L9x
4nSpbSRKeP2OoBhdrQMrRDCUJfkQkHH5STC2R5j9H+spRWVOo8wYq4nMbbnhLTk=
=Koyv
-----END PGP SIGNATURE-----

--s8uQA167RD2xhjBe--

--===============5702591569323463626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5702591569323463626==--
