From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/19] ASoC: fsl: Don't set unused struct
 snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 18:27:27 +0000
Message-ID: <20131220182727.GA31886@sirena.org.uk>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-6-git-send-email-lars@metafoo.de>
 <52B45371.8020808@tabi.org> <52B44E58.4080609@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4501637899605347224=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 25A0C2616FB
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 19:27:32 +0100 (CET)
In-Reply-To: <52B44E58.4080609@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4501637899605347224==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WnjMQ0y5QpAQNNgT"
Content-Disposition: inline


--WnjMQ0y5QpAQNNgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 03:04:08PM +0100, Lars-Peter Clausen wrote:
> On 12/20/2013 03:25 PM, Timur Tabi wrote:

> > Is this new?  There are formats that the codec and the SSI support that the
> > DMA controller does NOT support, like packed 24-bit samples.  How do we
> > ensure that we never get those?

> No, this is how it has always been. If there are restrictions imposed by the
> DMA controller we need to add support for expressing this inside the ASoC
> framework. But I think it will probably be more complex than just saying the
> DMA controller supports format A, B, C and the DAI controller supports
> format B, C, D and then just do the intersection of both. E.g. the DAI
> controller probably does not care whether the samples are packed or not if
> it only sees one sample at a time, while

The most common pattern I've seen is that the DAIs expect to see whole
samples at a time get written into their FIFOs since the FIFOs tend to
be stored in samples rather than bytes.  With that pattern it'd be a bit
cleaner to have them advertise sample sizes and transfer sizes and then
have the core work out that if you can for example do 24 bit samples
with four byte transfers and have a DMA controller that needs a 1:1
mapping between data read and written then we can't do packed format.

I think in general we want to be moving the DAIs to a sample size based
interface and then mapping that onto the DMA controller when we connect
the DMA and CPU DAIs.  This would help with clarity on the CODEC side as
well.

--WnjMQ0y5QpAQNNgT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStIwMAAoJELSic+t+oim9V+AP/i+N/5DYI0zUMb7lqhDff+EY
ppn0n3Im8y3PeH14bNiyjEN3F3Cyd7Og39pleVTrPIxgT86NFs4KPkdRH29xTu0M
xf2nm6wO/Ya+DZTBiF6tZRvQrzwpIiaYKySJFzJ0ru44YDqcObGm17IQzeIVcTXj
0hIUf8oVoUYZSk4eng4xVt0bqTiDuNp/sC2C/KTY8MFtjS9Ee/I7uXxV+/hbaICA
Bjl1qjN2NhWT0qUF7wy3uZDvEdNUPipfNzVEMXPqgCHeB4fc5L3UbqeIy5s0Tl8h
d721oafzTYjGaDhL5ZmZPojFnhdJFtMXTISRjd/5hvv6sRqMOj/q2fBpd7hhbvhy
17PFFio6J369XQvhY7mahyt4tWQ7Ebo2DClL4txd6Jx6Epg1MQQg4aGuceUzKZa2
2O1W9LCTyq6l5Fnks2wjihDbsOWGHm/YgEuH6ahXqCgGaJEblcIkUZzY3AsLEI2P
LV2iKSKjeludDO13BU22Ejf1ITJBuO/VJM7fHKIIKYonEQ2ygAZQpjzT6NxXrqks
Pd+GqfF3rddMRdasXwVhWHQrwdYYaJozqD0va/kiwn6HAAulRtBssimhtiGP4Ncr
jcLuy4F0QwrEfabSeevfJ9yODXT3IXFKpZxWQs+QJ8qQleFHhxr4F9rYsyTgeQLU
abEBiMZrPYnedke/z8+p
=sFbG
-----END PGP SIGNATURE-----

--WnjMQ0y5QpAQNNgT--

--===============4501637899605347224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4501637899605347224==--
