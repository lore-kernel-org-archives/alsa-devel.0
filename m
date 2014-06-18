From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/3] ASoC: fsl: add imx-es8328 machine
	driver
Date: Wed, 18 Jun 2014 11:31:11 +0100
Message-ID: <20140618103111.GH5099@sirena.org.uk>
References: <1403063242-20840-1-git-send-email-xobs@kosagi.com>
 <1403063242-20840-4-git-send-email-xobs@kosagi.com>
 <20140618100233.GE5099@sirena.org.uk> <53A1687C.9010705@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0569274379198145310=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 134D1261735
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 12:31:55 +0200 (CEST)
In-Reply-To: <53A1687C.9010705@kosagi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sean Cross <xobs@kosagi.com>
Cc: mark.rutland@arm.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, bunnie@kosagi.com, Philipp Zabel <p.zabel@pengutronix.de>, Grant Likely <grant.likely@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0569274379198145310==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MVwEilv/pzU3ooWF"
Content-Disposition: inline


--MVwEilv/pzU3ooWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 18, 2014 at 06:22:52PM +0800, Sean Cross wrote:
> On 06/18/14 18:02, Mark Brown wrote:

> > This should be handled by the clock bindings not open coded in the
> > driver - leaving this here most likely won't play nicely when the clock
> > API can configure the defaults for the tree.  There is supposed to be
> > support for setting default clock trees going in (or perhaps already in)
> > the clock bindings.

> Can you give me more information on it?  Currently, it looks like most
> boards use a 24 MHz clock, judging from this comment in
> mach-imx/clk-imx6q.c:

Look at the clock API, this stuff was introduced in the last merge
window if it's there yet at all.

> This codec requires the more unusual 22.5792 MHz clock.  What is the
> appropriate method of obtaining this particular frequency?

clk_set_rate() on the directly connected clock, the problem is fiddling
about with the parenting rather than setting the rate.

> > No, this is broken.  The CODEC should request its own supplies which
> > need to correspond to the supplies the physical device has and failing
> > to get the supplies should be a fatal error unless the device works
> > without power (in which case why bother enablin them at all?).

> Not all codecs have power supplies.  Most don't, in fact, it's just this

The manufactuers of those that don't are being awfully quiet about what
sounds like a rather impressive feature...

> Additionally, since the regulator is external to the codec (as it
> physically cuts 3.3V from the power supply), it doesn't make sense to
> put it in the codec driver.

I'm not sure you've quite understood what the regulator API is there
for.

--MVwEilv/pzU3ooWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToWpsAAoJELSic+t+oim9EpEP/Rf8o/5hNCF37Y8+ibsBUMtv
R1+9YAH8QKzfW/yAfQjMtXE4pdi8qHvPW3NVJ8HDdPU9VLzW/O9VM6WigaPEgNKy
Lu0c8IxMpldbjO0dGwoHTrAKQv+l2Z6kMpIbCzezLBQE46EYukYTEP2p5jPmauyl
7PU1XJWnUukx2FSV/a5qEGDyheMff0lunFCjCXEo7J3nutDG6W556n951ydD937/
wHmMSRRM3lEKksi6CfOKHuGkHaPSFZK7gKGHrlKc/0ceXfmmhM3kahhdTQHtb/nB
gzY+PSLICs8P3//Q6QQYAnV78QYZUHaHJV7clxWEhoA9SJ6/SPdNgrTUmWDQ+dCj
QldxPKvA4fOCPeHJaOt1ljpQvV0k59W5OyMg56B7+mLSjowRGX3i6k23VzK88pZJ
qFgVrrVjIgD5uHl4y2O8NZSceyfXbkx/lSkboStX1gxanbJIm6F6CZvQ1J/KF27A
GlaeaPhk2kIFtKvG92sRpVgMqCrUU26CRb8M9p5kryZmE/qtc5ynP3WTck8y6p1X
QrsLqb+K1i2QaVzWlaT3QZLp3ULxW4mz2T/lsWn8cP89fZVpQcHx9QGO9Qhz7jHV
ACCtf4NLBh9QUGh9MOCMEv1yeHoea2jt3f6X6a4jSRKTS2LDZqtRBvzqvH2bsnG8
dMvX9s+ds04Pz5E50ZkP
=TBhh
-----END PGP SIGNATURE-----

--MVwEilv/pzU3ooWF--

--===============0569274379198145310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0569274379198145310==--
