From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Fix master mode clock
	I2S bus clocks
Date: Tue, 13 Feb 2018 12:23:10 +0000
Message-ID: <20180213122310.GE5988@sirena.org.uk>
References: <20180212140646.3268-1-peter.ujfalusi@ti.com>
 <b582d1d1-a027-f7cf-1f2e-a09a411f1354@ti.com>
 <cdf06301-8166-3035-97db-0e87d3888192@ti.com>
 <fe5d4632-7b31-8001-f2b9-98a6ee3ed317@ti.com>
 <eca9d510-8d2f-bee7-4f80-2eabd35916c6@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7126030999360063000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DD0F9267716
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 13:23:12 +0100 (CET)
In-Reply-To: <eca9d510-8d2f-bee7-4f80-2eabd35916c6@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, "Andrew F. Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7126030999360063000==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 01:19:05PM +0200, Peter Ujfalusi wrote:
> On 2018-02-12 19:27, Andrew F. Davis wrote:

> > Is there no way to communicate the device is muted back to the I2S data
> > master to not try to push data?

> Not sure I follow you...
> If the codec is clock master on the I2S bus, it must provide the clocks
> during audio playback/capture. If the codec is muted, it still needs to
> provide the clocks as w/o the clocks the CPU will not shift out data,
> DMA will stall and the audio will be aborted with timeout.

Right, and if userspace finds that audio is paused instead of muted that
will really confuse it - A/V sync will be broken, sync with song
progress will be broken...

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqC2K0ACgkQJNaLcl1U
h9CdxQf+Ow1AiHs0pMCaFNydjJq3CLtcDdDesaX3fdBy0581tpQ1weTFTNIPbqTG
BGS/sGuB+653aw79ojaq0oOy9y62Jbzm6QnLR7jQR7Y+kZQ3Y1ffnnPXlEg/GMB7
qpVrF9N82gWcLJBmnd8QEmpJWvTEsRdM19klbXrsp+fmZ7OilgcGNyKfHqh3ELFa
zkUPil7rDzIKm2u1ZYHu7ulgai3kdMQ7srdRU9r5oBwccnqVa0DUmOGGPkItsrxF
qP/cXNf3Qha43CVj+oSSa4QUXJYXKwqLMt5Oa1WTQwDU0WadoMYYmTwIJNnvIvbH
nmi/CMuwZvJyLuB6cuU6A3xhHiirIw==
=/Wcb
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--

--===============7126030999360063000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7126030999360063000==--
