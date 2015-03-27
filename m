From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add support for NAU8824 codec to ASoC
Date: Thu, 26 Mar 2015 17:28:01 -0700
Message-ID: <20150327002801.GA3572@sirena.org.uk>
References: <1423986570-6355-1-git-send-email-Vincent.wan@amd.com>
 <20150224141314.GI6236@finisterre.sirena.org.uk>
 <54F6FC28.4030403@nuvoton.com>
 <20150304125527.GM21293@sirena.org.uk>
 <54F95721.7040103@nuvoton.com>
 <20150306210722.GK21293@sirena.org.uk>
 <5514811D.1060901@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3gIr+u2NK768I+f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5514811D.1060901@nuvoton.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chih-Chiang Chang <ccchang12@nuvoton.com>
Cc: "mcuos.com@gmail.com" <mcuos.com@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, AP MS30 Linux Kernel community <linux-kernel@vger.kernel.org>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--u3gIr+u2NK768I+f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 26, 2015 at 02:58:53PM -0700, Chih-Chiang Chang wrote:
> On 3/6/2015 1:07 PM, Mark Brown wrote:
> > On Fri, Mar 06, 2015 at 03:28:33PM +0800, Chih-Chiang Chang wrote:

> > Please fix your mailer to word wrap within paragraphs, it makes things a
> > lot easier to read.

> This seems to violate the kernel's rule. I am using the Thunderbird to
> do upstream. And in kernel's documentation, it shows we should set
> "mailnews.wraplength" from "72" to "0". Any way, for your convenience, I
> already modify the "mailnews.wraplength" back to "72".

You should never word wrap code since that corrupts the patches but
always word wrap text.

> > I'd really like to have a better understanding of what this is doing -
> > it can be valid to do this but there are some warning signs here such as
> > the volume of writes being large in comparison with the set of controls
> > the driver exposes which mean I'd like to be sure the use matches
> > expectations.  Normally this sort of thing is a small number of fixes
> > for undocumented registers or updates to register defaults changed in
> > later revisions of the chip.

> We have tried to reduce the sequence recently, but it got some issues in
> the tests. We think these large number of register settings are
> necessary to our NAU8824 codec. We will provide the comments of all
> values in source to have a better understanding, is it acceptable to you?

It sounds reasonable but obviously I've not seen the results yet.

--u3gIr+u2NK768I+f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFKQJAAoJECTWi3JdVIfQp1kH/ik9Fu9AQaxyMYEhfuJs+dcj
ke0Uj80Y/FCtYD+zgRocOPpM5hXfVCSMTct63G5m087BSYBWeW1MzZ/6YWtkQ8cy
zazYrCVEepzfcAinq9bRsrHLxr0zun/CH2rzSpADxQ5dx5drcSONfN9V2CbcMdK/
ZEf84HpUhYDSwYxHdRmcMYrD37AdEDTh0CiTaLAudH+BxxaydbEKug/TVuTGRIQP
ZE2ql+RrTQYrncyBGfPYGsHSgVP952CL+WUR5Ri5ILGJD7bVbnwei+3/WOc1LsG2
Rbfd1O2ImVQxNv2ScBvOeZOB2Wr1kh+X5QcFoVEYrci8vPBfO3Ouq++V1IAZNgI=
=MigT
-----END PGP SIGNATURE-----

--u3gIr+u2NK768I+f--
