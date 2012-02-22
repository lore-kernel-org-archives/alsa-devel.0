From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 00/10] ASoC: Introduce dmaengine pcm helper
	functions
Date: Wed, 22 Feb 2012 10:50:04 +0000
Message-ID: <20120222105003.GB7205@opensource.wolfsonmicro.com>
References: <1329842884-9757-1-git-send-email-lars@metafoo.de>
	<20120222081908.GB21820@S2101-09.ap.freescale.net>
	<20120222090307.GQ22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4952341845796993600=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8BBEF245A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 11:50:07 +0100 (CET)
In-Reply-To: <20120222090307.GQ22562@n2100.arm.linux.org.uk>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4952341845796993600==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 09:03:07AM +0000, Russell King - ARM Linux wrote:

> I have developed a standard DMA engine ASoC driver tested on SA11x0 for
> playback only (that's because SA11x0 requires playback DMA to be active
> for capture to work, and ASoC doesn't support that.)

Eew, that does sound like a rather spectacular hardware fail.  What's
the root of the restriction?  Since I've never heard of any other
hardware with a similar requirement and would be surprised to see any
I'd be comfortable with a driver specific bodge to keep playback
running whenever there's a capture.

> I've not yet posted it, mainly because it's there by accident, along with
> the rest of the SA11x0 Assabet stuff (it's part of my testing for the
> SA11x0 DMA engine code.)

Can you guys take a look at each other's code and see what the overlap
is please?  Looking through it seems like the final result probably
wants to be a merge of both.

It'd also be nice to get as much as we can of the sa11x0 support merged,
glancing at the code there's quite a few updates I'd like to see like
more use of devm_ and moving over to using snd_soc_register_card() (you
shouldn't be registering any devices at all in your machine driver,
though I've no idea what's going on with L3, perhaps you need to
register something for that).

For the suspend/resume stuff you can make any assumptions you like about
the hardware setup in the machine driver suspend and resume callbacks
since all the code is specific to a particular system.  You can also
assume that the hardware is not in use over suspend and resume, the core
should quiesce the hardware before it suspends it.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRMhVAAoJEBus8iNuMP3dE5QP/Rc2i1k4rCu+e3QJhST+7hCH
/0GiFnGr0nod/kxpZqQKvdEmjGEhwl5gJ2E9d3+G5d4AaOp/vWgRf46di42Ou+0k
NIb7TfBtoWouPllqyyts66ZuMq5RitwB4MUtgfiibvxCwqd3+ZijFZENYmLgsn7o
Mli+grfpt0b3steSBdRv7ZGfcRfFq5n4WiIB/qqjsGgpSjkj0Gt4bwsypFke+fby
Qgv0uTphSQVYgBhGaBXaHFQI8v2sgc7FmvOHpcCNOGbiDfxuxayfjCHdsHbn+9lX
+dkl1xNil+w+s9BztqGLUoFmRR3pEg5IMfVE7esaPBoBzHSBjjExREPdsU1JwcZe
f8FJsha81qMP45hARp65k+9Gw/YtJEAWkucUZQJd8khGpwJUegckxbClHYi/HrBJ
apNYt3eexuueN40J2y/Q3X0riGsRZ5SjAq340XW4kPRE3T2Vb/H6dwk1+wX4WfkB
9IAf3UfNDVyP7d9hUE72hQc67uDrGqPB/PQt0/mgwOHhdomVhQQa4FhOqKgMd+rQ
wGxZhC3lc2XW6Cw8qSfl/PG0A3xo6QRzI+Dfs2rsBP8z+v7Q2ZpzHUUSAqy9Vqhe
lG0vMxnBEyw7ciMLV2VtekrnJvrRp/rwGRgp8gXmupI4m/x2ucde3QK3NU3J1cwa
wPhRWiIDSL1tCQAlkRY/
=Exwl
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

--===============4952341845796993600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4952341845796993600==--
