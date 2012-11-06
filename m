From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC patch v3 3/4] ASoC: atmel-ssc-dai: register dai and pcm
 directly
Date: Tue, 6 Nov 2012 12:39:08 +0100
Message-ID: <20121106113908.GC10080@opensource.wolfsonmicro.com>
References: <1352181474-19597-1-git-send-email-voice.shen@atmel.com>
 <1352181474-19597-3-git-send-email-voice.shen@atmel.com>
 <20121106084814.GC5044@opensource.wolfsonmicro.com>
 <5098D930.8030403@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5098D930.8030403@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, plagnioj@jcrosoft.com
List-Id: alsa-devel@alsa-project.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2012 at 05:32:32PM +0800, Bo Shen wrote:
> On 11/6/2012 16:48, Mark Brown wrote:
> >On Tue, Nov 06, 2012 at 01:57:53PM +0800, Bo Shen wrote:

> >No, this isn't converting things to device tree which presumably is the
> >goal here and obviously just doing the rename doesn't accomplish an
> >enormous amount.  What I said was that you should instantiate the ASoC
> >adaption when the machine driver needs to use them.  You shouldn't even
> >need a separate device for this.

> Maybe this is not the best solution, but just abstract audio as a
> separate device. The other's still keep as a ssc library.

It's not abstracting things, that's the whole problem.  It's putting the
internals of how the Linux audio stack is organised into the device
tree.  The point is that the SSC should be a library to all users.

> >Please do look at other platforms with similar hardware and do something
> >similar to them.

> I take some reference (e.g: freescale, marvell, invidia soc, this
> RFC implement is similar with them), but don't find the similar
> hardware with us. Please help provide the information who's HW is
> similar with us. Thanks.

A *huge* range of SoCs have generic serial ports - off the top of my
head this includes at least OMAP, PXA and Freescale.  The same issue
also applies to DMA controllers which affects almost all SoCs.

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmPbBAAoJELSic+t+oim9nvkP/Aq7tuIm/tpRBbRhFXhUgYWk
qRwrVjHgoDHIryKYVmtVxApazcw68eCP97zNWPIhwNCE+VAMmSnS+GESONRir1/u
1XNZjczforjel74BA82QiPbhyO2rYeaWvTu4oTHUYpJiLnUtrgx3Sq2h6xEcozmG
AkYYI4nPMXxr9CliiCtKqwXzIuVJZHH6a6Yc4AXvneSivmRM0e4syjlMSxptv7+d
F3AzzxniDIQyFkxBMWz0JJYupfxRdhZQDVqOnH+8kfCXhU1RLE2XPjWMwp2FuHag
By5MaV3aUm1mJrXj3vxwycjt1EueDaR+2gs+XfvCJ9PvLpvYmHAJmUkbTDkQvDJp
CENQKU7MoWoX6/q1OhKwwEBv9yDrGnHTA7cPIBXWwM0rW9YZ03qyrF85MrnBjkts
1Np+67T1FYjfxo8LerbBQsoGJary8bIGVFkhbIfH4ifeNEE8W5+FyjgrH3O6xvre
B13qBU8zQs4T2Op5nz0fAp9SA/SqKTLNidbR/7naR2dGyuzMwEV92PaxYTOzXcSB
3OQ52d8gJ5rYCvfpidzjLss9aIy61plmc4aZYgzKMzxR2G9WzU5maq0uy7PyEmuD
O38cVQy+wuExWtB+7CUY286twuKE1l8dOn8nXHrTicabYWqtyO8M7hireQFWp7JG
dWUwF7IhZW+yBSspUCgx
=gtOn
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
