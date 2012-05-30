From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 30 May 2012 16:09:38 +0100
Message-ID: <20120530150938.GM9947@opensource.wolfsonmicro.com>
References: <1337865998-26150-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120530131421.GK9947@opensource.wolfsonmicro.com>
	<4FC6257F.4080905@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5143915363565757016=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6373104348
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 17:09:39 +0200 (CEST)
In-Reply-To: <4FC6257F.4080905@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============5143915363565757016==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2012 at 03:49:51PM +0200, Ola Lilja wrote:
> On 05/30/2012 03:14 PM, Mark Brown wrote:

> > What problems are you finding when you try to use the debug
> > infrastructure in both the regulator API and DAPM to discover the state
> > of the regulators?

> My vision here is that in a simple way, in one place, activate all
> debug-information we need in our driver, prefixed with our dev_xxx. This is very
> valuable for us when debugging, especially when a customer is told to activate
> debug-information that we can use to debug.
> I removed the menuconfig flag on your request, and then we lost the information
> for regulators and clocks when I implemented the clock/regulator-widgets. I'm
> just trying to keep some aspects of what we want to have but still conforming
> what you want to see on mainline.

All the existing diagnostics use dev_name() too...  just turning on the
standard logging ought to give you exactly the same stuff, indeed if
debugfs is on there should be no need to even manually enable equivalent
debugging.

> >> +int ab8500_audio_init_audioblock(struct snd_soc_codec *codec)

> > static.  Lots of other functions in the rest of the driver have the same
> > issue.

> This one should be static, yes. Cannot find any other non-static functions in
> the codec-driver that is missing static.

IIRC the function immediately below was one.

> >> +#define PRE_PMU_POST_PMD			(SND_SOC_DAPM_PRE_PMU | \
> >> +						SND_SOC_DAPM_POST_PMD)

> > You shouldn't define stuff like this in your driver!

> This was mainly to avoid impossible situations trying to comply with the
> 80-char-width.

Adding things like this if they're useful are fine but they shouldn't be
driver specific things.  There is a SND_SOC_DAPM_PRE_POST_PMD already
though.

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxjgdAAoJEBus8iNuMP3d5cUP/2cf+t97Zh53nVZaWZ1Ik+5b
/wKFd2SGkvInRP9QzBVYpii8DjPYj9c2wrB+6bgZEMr8gKHZz/uafPJpuuLGDrNa
egVBRZ1GSmMm1YCxIN6Nd6W8XGiiqaL/y75baO6NHI0iG5ZgRFRdzGBI4vNV1xNk
Tv4moBqbLqzrUU//gl5vgOhyE1PbiGTLPlJFNq9rXBE9TDQlQ19j2OBbFizbQIBE
0mZBjaaHjGaMsYWM1y3NcYuRg/oOElbkoEpOfDNtyTVoUGNFY707l25disLnLm4l
6AX7qxkFVBv6P05pqPgLCcDnJA0uLvCoiBfo3maOCXZvn8+GXLa0R4dEB1ESlJjF
s1fF00iEamDbEdq+xu1agAWYtxN4lV6HcEgq3avc2dBksDMPw9MD01zskwOjV0A4
dttWLDDEyOOSuiWVhyObJJi3peY9yDsnfRKnatqM9Ler7Y6T2VCT4jHXzTu6QtTc
SOF6Fm8sMxi3uqC8AkhooYQFs2J6b7z/wlZXEmGgyW004uEVJV8NdfnY56ycCxev
lBFn9rLgMVUU4QtWt222iJR8eLWBFoBAfCnYg+oZWET5+Jz37RFMoPmkQSV5er1E
ske//arD589v5Eftu92y/gJ0VnN/+kJV4ztZkBcWWI1H1KjjK852t0DMXdVo6viu
ecgZ1GCbteqPBC5EqrrE
=kQYH
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--

--===============5143915363565757016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5143915363565757016==--
