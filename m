From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: dapm: add support to pinctrl dapm
Date: Wed, 7 Mar 2018 15:13:29 +0000
Message-ID: <20180307151329.GJ7290@sirena.org.uk>
References: <20180305123213.2045-1-srinivas.kandagatla@linaro.org>
 <20180305155208.GK8588@sirena.org.uk>
 <21635274-1d7b-5ed9-6832-2e12fd844f7a@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0003919243706365979=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EC22267255
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 16:13:34 +0100 (CET)
In-Reply-To: <21635274-1d7b-5ed9-6832-2e12fd844f7a@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============0003919243706365979==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ELVYuRnMxQ5nnKRy"
Content-Disposition: inline


--ELVYuRnMxQ5nnKRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2018 at 08:35:48PM +0000, Srinivas Kandagatla wrote:
> On 05/03/18 15:52, Mark Brown wrote:

> > This doesn't look right - we're trying to synchronize with the DAPM
> > async queue from something that should be run inside that very queue.
> > What is this supposed to be doing?

> I thought this is supposed to ensure that any pending asynchronous I/O is
> completed before touching pinctrl framework.

No, it completes all the pending DAPM operations.  async I/O is part of
that but it's not the only thing.

--ELVYuRnMxQ5nnKRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqgAZgACgkQJNaLcl1U
h9B8kQf/ZaByvWyPdq0w1KVI43QSJ2IDyyHNiDD+VktR8ZxPg/4jFOrjRQRZC139
CpODTu//1fn2QYjZrzAEhLSHBTdrrWKJTe1gJl4vWPAsXpQyeGQknsT8ig2BFy1+
eShwYsezPcTD7faHItEyCAKeX/IpmY0tHe73BUDkpNgrvxR4N50OCAPXgtFJ7aAi
YxLcSv2yVkP00tDPiszdA4iqZnZ0r2zgFNb7jzBkZCHVVfvWX/k/FgABdCAtVOrQ
7HqlahZvhNFirTCnfNZ/b1TzaRcaEZFiWv0jukH/sEYkT9TvuSRSKJ5B/alYPt+J
KHDBLOhlGWFJeBkJOtHF1oB6cjgwJg==
=xWwj
-----END PGP SIGNATURE-----

--ELVYuRnMxQ5nnKRy--

--===============0003919243706365979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0003919243706365979==--
