From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 13:39:39 +0000
Message-ID: <20120222133939.GK7340@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120222132107.GD7340@opensource.wolfsonmicro.com>
	<20120222133207.GD22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3114949875882236317=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46FDA103F46
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:39:43 +0100 (CET)
In-Reply-To: <20120222133207.GD22562@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3114949875882236317==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ppIqr1kl39GnwQx"
Content-Disposition: inline


--1ppIqr1kl39GnwQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 01:32:07PM +0000, Russell King - ARM Linux wrote:

> I think you're making the assumption that other people need cyclic
> transfers.  I've seen little evidence that anyone other than sound
> needs such things, so I don't think there's justification to push
> this code into every DMA engine driver.

The idea was to have the library code to do this in the dmaengine core
rather in drivers.  Doing it in the drivers would be silly, it should be
in library code somewhere.  If we are going to librify it then pushing
the code as far up the stack as we can seems like a smart move.

> Remember, there's no common code to a DMA engine driver at all,
> everyone implements their own way with their own bugs.  I would agree
> with you if there was some decent DMA engine infrastructure to abstract
> out such things, but there isn't.

> So what you're asking is for N different ways of doing this, instead of
> having one centralized way.

Well, Vinod seemed to also think that dmaengine ought to be able to cope
with emulating this and I really don't see why it shouldn't be.  It does
know the capabilities of the underlying driver and it gets to look at
all the calls going into the driver before the driver does.  If ASoC can
interpose itself I don't see why dmaengine can't.

--1ppIqr1kl39GnwQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRPAVAAoJEBus8iNuMP3dXwMQAIPVbzqQpojOVd5DMQPFo8w9
bUDQ4FaHWbi0JjhM++Qi16JYHho6t++1gBKGtAG13WQ+xMrD2UUd4NGUZTL+vOgt
pcT6+vyYh0Ww0qp5Ft/h/uc0WUgBItqRUSDUkmicCj3zWmgMIJZes86hljkTmqvh
tD/REKTEsEppwOuXPNmWaIG9WxZa7ntKrUGFQxhJ+2NuIjUx0Y7AkVBKfH0v+udb
kQp+NtXVZLyxo/di0rFAKAHhMgk22VqEtWtlfjvOBuUre9IAxrlwoktI3tS6B4Qk
GxD4YAUP9UydNGsErPQnnsgxYNYmBth183ctNY0G5Vt/SaxmkYSm2sft/VS4yN+K
0HuuUBqEDWy4Z3sw69IuK07MlAJEhltYxUbaA63sIwSbGewEn3Kf8kd/5yx+7ipW
6kYxViIWW/i/Ikk0Vmxjo7dzwY7IIU6xitcv+w+QRNgb6zb7pQCXjPIYiKdxVJtG
0MjoOp0HaVydQYwuaTG2llt6ziCRTAaLxDe8Mu2qRp2J0TlHi+zfSnmEXiVQ13Qt
iyeV9kYDTq3yf0uuvmhdFr8akvUToZ1GbRcdKKlDPH4/N0XHhNCB+aXNyq+aPzn3
xsMWoGLgL0X8CBdc98h1sNFWiZ3p3c7cdUYmkVpwiZWas518NEyHi6yi1Q7cmN0i
x7eoTVV0HePcne6WQT86
=5EMd
-----END PGP SIGNATURE-----

--1ppIqr1kl39GnwQx--

--===============3114949875882236317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3114949875882236317==--
