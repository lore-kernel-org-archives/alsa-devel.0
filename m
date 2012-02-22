From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 15:39:54 +0000
Message-ID: <20120222153953.GP7340@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120222132107.GD7340@opensource.wolfsonmicro.com>
	<20120222133207.GD22562@n2100.arm.linux.org.uk>
	<20120222133939.GK7340@opensource.wolfsonmicro.com>
	<20120222142236.GF22562@n2100.arm.linux.org.uk>
	<20120222150455.GO7340@opensource.wolfsonmicro.com>
	<20120222152355.GG22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5418589867933821783=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82ED51040C6
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 16:39:56 +0100 (CET)
In-Reply-To: <20120222152355.GG22562@n2100.arm.linux.org.uk>
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


--===============5418589867933821783==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PT0wT86ZVVq2zanE"
Content-Disposition: inline


--PT0wT86ZVVq2zanE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 03:23:55PM +0000, Russell King - ARM Linux wrote:

> Look, I spent a number of weeks working on the SA11x0 DMA engine code
> and ALSA side to get something which worked reliably, and a simple
> solution doesn't work.  I've been looking at the DMA engine code
> probably for longer than Vinod has been involved with it.  I've been
> working on cleaning up all the DMA engine drivers extracting some of the
> common bits from them.  I'm very familiar with level of crap in the DMA
> engine stuff.  I know what I'm talking about.

OK, fair enough - like I say the thing I'm not getting is why this is
resolvable in a dmaengine client but not in dmaengine itself.  If
nothing else I'd expect the core to be able to insert a proxy client.

> The point that I'm making is that there's more to this than just adding
> a layer.  If you think that's all that there is, then you haven't properly
> understood the SA11x0 audio support patch set that I have, and the
> interactions between the individual patches.  That's not surprising
> because I haven't posted the patches yet, and I haven't explained them
> either.

Indeed, I've not really looked at the code in any great detail at your
code as you didn't post it (I only looked at all because it showed up in
-next) and there were some issues at the subsystem level so I stopped
pretty quickly.

--PT0wT86ZVVq2zanE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRQxBAAoJEBus8iNuMP3d6gwP/2TZ62EKl3MP0c0qJPJBl0p9
GjBHJFeMNJCfRGtzyEIkfEyDBpEwqZeWEyub7QPCmyC0OSiAy5nleREnjEzDYde5
RLU7v0WVe1rSWHzuCeaGvfS6S3RANGeRICTeuxE1b4fHATe9M+0oNTaCztts1JHQ
x0BwF+pPw06hDTfM7sC88F5Skag1jId+XhiaimvST3FYrg10B9bvMwEmSpWoJpbd
LF3AYoHhymNQD67sfPJrQGHIKcg7CNkwjwfQusj06FFh1Tm47BcRJLtng0xKSjfx
SNHxUjvZkdM6W0+Vu+aSQyCdptgWBF7mQZzIlxki/c0EkUfxF1SRG/KW+BdyOMfy
I/vaQZEGMJ4kh+GcRioMQdTXd/ee87RtvslHhNyN9w0vmVS3OvOYMbtUmu801OVv
sgGfrBEE0tWBDkScH7b5aQ8rYkmoIhwpkY2GHlLegc1S7TuZq+f3A2sqF76h/wxo
uZAzw7jFAfWGrs6WaHss5+nYdTwUzyzz8t3Eky2SS9Vx88Zbcj4l+do20tGcJz+6
waPGtD7siDPX7023MwFiuDpIcbZ57fJ1LXX5r5TZHtpPtNwLpH6PI1y2KgYu0HBz
HLIetx1UFTaZAXWGOzNxlCdoihIbVl8q1lrDSMfW0SS+ypHK/RxzyQUHCZJptjCz
/LPOaa+hMoV0ssXkBxdG
=79qz
-----END PGP SIGNATURE-----

--PT0wT86ZVVq2zanE--

--===============5418589867933821783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5418589867933821783==--
