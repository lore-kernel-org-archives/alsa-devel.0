From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/10] Kirkwood ASoC drivers fixes and
	improvements
Date: Fri, 23 Nov 2012 10:36:26 +0900
Message-ID: <20121123013625.GA4385@opensource.wolfsonmicro.com>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
 <20121120122051.GA12063@n2100.arm.linux.org.uk>
 <20121122140614.GA26930@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2487120150153676015=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2D4226030F
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 02:36:35 +0100 (CET)
In-Reply-To: <20121122140614.GA26930@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Rabeeh Khoury <rabeeh@solid-run.com>, linux-arm-kernel@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org


--===============2487120150153676015==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2012 at 02:06:14PM +0000, Russell King - ARM Linux wrote:

> Instead, a DT description will just declare there to be one I2S device
> with its relevant resources.

Yes, this is exactly the sort of thing all the existing platforms
using DT are doing in their ASoC drivers - there's normally some
grouping or sharing at the hardware level that doesn't map exactly onto
Linux models.  We're already at the point you're trying to get to here.

> Such a description is _inherently_ incompatible with ASoC as long as
> ASoC insists that there is this artificial distinction.

> What Mark is telling me is that he requires yet more board files to
> spring up under sound/soc/ which create these artificial platform
> devices.  Not only does that go against the direction which we're heading

What I said was that you should just register everything from the DT
nodes that describe the hardware and not create dummy devices in the DT
for the Linux internals.  The drivers instantiated from DT should take
care of mapping the hardware into Linux, instantiating everything they
need to from code.  The approach the existing drivers in mainline are
taking is to register multiple ASoC functions from a single device model
device which seems like the logical approach to doing the mapping to me.

Some of the remarks you've made on IRC and code you've pointed me at
suggest that you have formed the impression that there needs to be a 1:1
mapping between device model devices and ASoC function drivers.  This is
not the case.  A driver for a device model device can register as many
different ASoC functions of whatever type it sees fit from a single
device model device.

> on ARM (at Linus' insistance) to get rid of board files, but it perpetuates
> this silly idea that every audio interface should be split up whether
> there's a distinction there or not.

I'm not entirely convinced that modelling different areas of
functionality with different ops structures (which is essentially what
is happening here) is a massive design flaw.

> We need to have solutions which do not require artificial breakup of
> drivers; we need solutions where hardware can be described by DT and
> that DT description be used by the kernel with the minimum of code.
> What we don't need are yet more board files appearing in some other
> random part of the kernel tree.

This is the current situation, none of the existing DT using platforms
have had any need to do that.  Nothing about Kirkwood audio seems to be
at all unusual here.

We *do* have board files for the linkage between the various components
since (as discussed previously ad nauseum) a lot of embedded audio
hardware is interesting enough to warrant having a driver itself.  There
has been some work on generic drivers for simpler systems which should
be useful and can be built on, though we do need the problems with the
clock framework availability to be addressed (both getting it available
on all platforms and ensuring that the platforms with custom frameworks
move to the genric one).  These drivers are separate to the issue you
are discussing.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrtMRAAoJELSic+t+oim95vkP/0x+86NjccR5wc8ojVD93tf1
N7u55ElGFgQCZPoUobluqS1XZMffjO0MRZEbZRcHg3AWhTNB5TfVnddCBHTGhFdt
ypgIt12evUg/My0FYlyjJrNKc2avUmbBqPmfPuhKw6vLEyaLBmrBz/3Q8IAjh22i
uh+AByKMZ5ovIpVOBqpErwDLaI7Rd2YUhJTzLBItorJkRI1CAP9H7BGELI4pK/xQ
PNpasYSF5MRXZy4mpa3jnj9O7vDqU70WHcDbVyhHTWaYKfhbydhK8M5hSZsReAl1
GipcRuHQWfDsCvSSwb7mvrCzdd7wSyaebVROeVTYTCWcKIWqvy5q2TdElglT6ZJb
0pyXn9sPbdgXXkzRB2WKuVIZfMGqhUdAtr3clWk2bJaebZH4nQxauHCcpr325+Li
sGn0EWUjpQQo8ZjF6YKP5plPjK8ZxpYzXxsMAcQ62QdkaIzgUjv24J8QbQHChglv
dJRvSVx/v2WUbGSzn2oRSQOwnbSkWQwWur1/NOUf03XBinaZWe7hcpE6YgcAV5co
oG9+ZteLMnpsBYgT0scrKMmsO41YGwSdwIHgpxLS3yOBYP8hKaOAi2kNshNaOrdg
s3Sa2CvLoZfSZKIz9Zg8Pf9pBXW3GokFgr4w2QT10BCHe++EpPPTg2IBNh7/aHt9
2tqZGiYAygbnAUq/DDXS
=+Rw9
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

--===============2487120150153676015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2487120150153676015==--
