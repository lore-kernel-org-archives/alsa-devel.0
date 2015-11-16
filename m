From: Mark Brown <broonie@kernel.org>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Mon, 16 Nov 2015 10:50:35 +0000
Message-ID: <20151116105035.GA31303@sirena.org.uk>
References: <20151013115355.GC14956@sirena.org.uk>
 <20151113215812.GA19020@amd>
 <20151113225355.GU12392@sirena.org.uk>
 <20151114074400.GA7898@amd>
 <20151114123931.GW12392@sirena.org.uk>
 <20151114175915.GA20429@amd>
 <20151114184940.GY12392@sirena.org.uk>
 <20151114211633.GE20429@amd>
 <20151115001402.GZ12392@sirena.org.uk>
 <20151116074534.GA5606@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151116074534.GA5606@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2015 at 08:45:34AM +0100, Pavel Machek wrote:

> > > Ok, so SND_SOC_DAPM_REGULATOR_SUPPLY() does not work, because I have
> > > two regulators, right? Is there similar macro I can use?

> > No?  What would make you say that?

> Plus, I'd expect to see some kind of "struct device" argument to
> SND_SOC_DAPM_REGULATOR_SUPPLY(). I'm selecting supply name, but I'm
> not selecting on which device...

I've already pointed you at the implementation at least once and
hopefully the regulator API interfaces are quite clear here too that
it's not possible to request a regulator without providing a device.

> > Every single sound driver gets this right, none of them assume the name
> > is global.  What makes you say that they assume names are global?

> Ok, so you are saying that if I fix mfd initialization, sound will
> automagically switch from global regulators to device-specific
> regulators and things will start working?

Yes.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWSbT7AAoJECTWi3JdVIfQPmsH/j6nHB8LcaSZDBVBi2oPy/Pu
UBoPMsgvWEKv6lK60crtu0OhrAimW4KMAmYH1+BhxBoVvqLBp5kJURIFM1Jf/JJA
Bl8c1HOUe1eehJE9pIps46dkODt6VBRlX4IZszyCLGeBw4La6dNF51P3LPAu1SQj
x+a7O8RFUaxacjGIrW0w0lBLLsXw8YmOXKEq8LdL/OwE3GaPQmYJwmj3al8LswFo
wkyoY9iNOAK80zDDa8u7nS/Dgtyo+W6MgS3fdUVYBvCWxR9Nz3n9K50WdObg9r7Z
WNwsprawPKRA+UMHaGgCwdPXLA08cXXSpsW6MlqKeOmgGurTJsQL95ooFkY0Dis=
=X+OH
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
