From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: codecs: add support for TAS5720 digital
 amplifier
Date: Fri, 13 May 2016 12:55:40 +0100
Message-ID: <20160513115540.GI22038@sirena.org.uk>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
 <1461615456-19510-3-git-send-email-dannenberg@ti.com>
 <20160426154313.GA3217@sirena.org.uk>
 <20160426162240.GB2885@borg.dal.design.ti.com>
 <20160426172936.GE3217@sirena.org.uk>
 <20160426180105.GF2885@borg.dal.design.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426180105.GF2885@borg.dal.design.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 26, 2016 at 01:01:05PM -0500, Andreas Dannenberg wrote:
> On Tue, Apr 26, 2016 at 06:29:36PM +0100, Mark Brown wrote:

> > Is the device actually going to mess up if someone sends it something
> > else or is it just going to ignore the extra bits (given that it's doing
> > autodetection anyway).

> well in any of the left-justified modes (which are the only ones the
> driver supports) the device takes and processes as many bits as it can
> given the clock and divider settings. Any extra bits provided will get
> ignored, and the next sync happens on the frame sync signal and not by
> counting bits so there is no downside also as confirmed by some bench
> testing I did feeding in 32-bit long frames for one channel. This seems
> like a case of preferring tolerance over strictly enforcing
> datasheet-advertised bit-widths. Will take out the check code.

OK, accepting extra bits is fine.  You should set sig_bits in the DAI so
userspace can see what's going on if it cares.

> Along these lines, earlier as I was rummaging through the existing
> drivers looking for a solution I could model after I noticed that
> most(?) ASoC codec drivers don't have any type of HW fault checking, at
> at least whatever drivers I looked at. Not sure why this is but given
> this discussion this seems like a general opportunity to make
> improvements.

There are some with over temperature handling (eg, wm8962) but it's
relatively uncommon for observable protection features to be implemented
in silicon and even rarer for the interrupts to be hooked up (and hence
useful to support in software) unless there is also accessory detection
in the device.  On older devices the required digital logic was often
excessively expensive and realistically only relatively high power
speaker drivers have much risk of something going wrong - things like
headphone outputs or smaller speaker drivers end up with protection from
their supplies collapsing well before the device is in physical danger.

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNcC7AAoJECTWi3JdVIfQROEH/Ak5HBlr2KBghI0Gg/Rv6SVX
MzSwENSGZr4QUFZaJ9TRWQfZSL2KxKz4m7hvbRumxeGgc6IfgzTIVNkiYFp9vP4G
1LTQhTchq8WZ1simbfr668cCZN5LcwNOXlhlj4diewrcXWD7ZH0m8uqp/vcQNe6z
nWNGoSwE1DL7K1108JVMfh7XKEVarYQj1H4Dpc8iOjLdSuEGN2T06ipnAe4Uz/Xn
Ua6Ez1HmEUu3PUWAh8RJI2+sOohUHOOIXXK9dZEIEaFr4TaewnoBGpuuLC5ggBQD
HcMktMm8TNdVxa1CS3Q4uqQX6XMYUz2amVi3LLRcdJrJgfmpDWqPvocbrA+N+Jw=
=qmGA
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
