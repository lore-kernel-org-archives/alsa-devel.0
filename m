From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoc: kirkwood: merge kirkwood-i2c and
	kirkwood-dma
Date: Fri, 26 Jul 2013 11:58:31 +0100
Message-ID: <20130726105831.GA9858@sirena.org.uk>
References: <20130725111428.419ee278@armhf>
 <20130725191604.GQ9858@sirena.org.uk>
 <20130725225816.GG24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8926420388056522225=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B37E92610A4
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 12:58:41 +0200 (CEST)
In-Reply-To: <20130725225816.GG24642@n2100.arm.linux.org.uk>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: alsa-devel@alsa-project.org


--===============8926420388056522225==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nGKiHl1eSywcUu0Z"
Content-Disposition: inline


--nGKiHl1eSywcUu0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 11:58:16PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 25, 2013 at 08:16:04PM +0100, Mark Brown wrote:

> > This seems mostly fine, though it may be best to keep kirkwood-dma as a
> > separate module for the benefit of the S/PDIF support when it gets added
> > - I had a look at the implementation Russell has and it looks like it
> > can be added as a separate interface.

> You wouldn't want I2S and SPDIF to be separate modules though - they're
> the same hardware but different output stream formatters attached to the
> DMA FIFO output.  Don't forget the requirements concerning the simultaneous
> use of I2S and SPDIF - these "output formatters" must both be enabled and
> disabled in unison when concurrent use is required - both bits must be
> set or cleared together with a single register write.

OK, I knew they both needed to know about each other and to share some
stuff but I figured it was reasonable to compile out the S/PDIF support
if only using I2S or similar - so long as they're coupled at runtime it
should be fine.

> > Should the name be done as dev_name() for the interface (I don't know if
> > there is ever more than one)?

> Getting away from "kirkwood-i2s" would be sensible, because it may not be
> just "i2s" in this hardware block.  The documentation calls this an "audio
> controller" but I guess "kirkwood-pcm" would be a reasonable compromise,
> even though it has a separate AC'97 block which could also be construed
> as being "pcm".

I was thinking just pick a name at runtime based on what was doing the
instantiation which would avoid hard coding anything in the DMA driver.

--nGKiHl1eSywcUu0Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8lZUAAoJELSic+t+oim9EkAP/iXAJ6qaN8lVBm4Jvq0uZqO6
dn8feNjZc472gdpbFDctl4dGu1TIqPzyOYBLhQof7yui71Z0QURMtIWXeYovDUfh
Z5nG+/N5YSZfm0W5HDbM1sDNk3Y8fIeF8jTUpZ+JVboplBMBk36O9L/KRb/zARYu
CVc+MWVd8s3g9XPM+EodQ8YbsC6Gdm9pm+ixpllPJ3zK3Ed83gonJ5unByWLHMwX
qkSmw+3/ceEtv+1kYLVSOeh4TDkYTH4MB0Hs5VxvA0JMIv12ztcEarR3A8zrW6MS
8tsg1XvJc/uQkeKYQCa3o8vkHMIyb9WRSCETylIzxfrq3X79HdbPxSvHGeGnl4Tf
/Xs160V0dT1QrQX56QGsOipQNULJPks5QlVuk4jeqsmtS7oxIbeUXvmn9WbOo+r8
h4jcqUtWBW0zrr+vlJ6d3IGumDaDpN+v2OFiXhDXuKCBvYe6AnjQjkiT2LKrk/Eq
b6OPGUflsYpBOLNshEWjhD8uvDZ5RB4IUu4q91lsgAE4E2UC8LRt7+kmW9cFnipF
66tShXKvSWVoIBAQ0Hagkp9kFpCJScco4LFekhg2/x73I7zD2AyE6jSc6tusvBq7
BrLZeSe/fMY3PhFvy1g8GDaGnm/FBOpzGbjyhrihE33nSyREZiWRqnkDri1w0T/y
wk8uFpFxhW6wiggxPxVy
=jYt7
-----END PGP SIGNATURE-----

--nGKiHl1eSywcUu0Z--

--===============8926420388056522225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8926420388056522225==--
