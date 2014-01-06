From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/5] ASoC: usp-pcm: add CPU DAI driver
 for PCM simulated from USP
Date: Mon, 6 Jan 2014 17:20:43 +0000
Message-ID: <20140106172043.GM31886@sirena.org.uk>
References: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
 <1388729104-28643-4-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7624864590830245034=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 711C42610CA
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 18:20:51 +0100 (CET)
In-Reply-To: <1388729104-28643-4-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============7624864590830245034==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MKQswQ7UUMqTthTa"
Content-Disposition: inline


--MKQswQ7UUMqTthTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 03, 2014 at 02:05:02PM +0800, RongJun Ying wrote:

> +static void sirf_usp_tx_fifo_op(struct sirf_usp *susp, int cmd)
> +{
> +	switch (cmd) {
> +	case FIFO_RESET:
> +		writel(USP_TX_FIFO_RESET, susp->base + USP_TX_FIFO_OP);
> +		writel(0, susp->base + USP_TX_FIFO_OP);
> +		break;
> +	case FIFO_START:
> +		writel(USP_TX_FIFO_START, susp->base + USP_TX_FIFO_OP);
> +		break;
> +	case FIFO_STOP:
> +		writel(0, susp->base + USP_TX_FIFO_OP);
> +		break;
> +	}
> +}

I'm not sure these functions and the switch statements in them are
adding anything - none of the statements share any code.  Either
refactor this so that the callers pass in USP_TX_FIFO_blah for the
argument or just inline the register operations.

> +static inline void sirf_usp_tx_enable(struct sirf_usp *susp)
> +{
> +	writel(readl(susp->base + USP_TX_RX_ENABLE) | USP_TX_ENA,
> +			susp->base + USP_TX_RX_ENABLE);
> +}

Similar thing here, just inline.

> +static int sirf_usp_pcm_dai_probe(struct snd_soc_dai *dai)
> +{
> +	dai->playback_dma_data = &dma_data[0];
> +	dai->capture_dma_data = &dma_data[1];

snd_soc_dai_init_dma_data().

--MKQswQ7UUMqTthTa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyuXoAAoJELSic+t+oim94aUQAIt7ZRmyn2D6pNURu/b2G1OK
CTDovFJOc0H90//fcZC0+gOTa9Nqy6hWNJu8XH9iaBLmFmaRkRNdCvXSq2af1SGC
JCD2RbsI6VHXPbFGXih4glSpLay//V27FxojxdMeLui4b3tH8TScAsaygkX7z8D8
niJ99wuM2Dj2YIz6jZEinexp10GQxNXjfWIWQYuYrra8d8fKAluSC40SZw4O1/P1
Zygg73SIumo2aPlEHf9zSuyPTOr4s8fBtbrxshZB4X1igiD7oNdL88YjVAHKvmuC
CO77sEXAhYtOv8cWY7uIRbXHj07XHSFrtoEJJQKZUGH1lQ+jkC0D+AKvx4qpCACY
e5R3SD3iSeekFz/eFpXNYTjS+7I9km7Y7lrLfd9zuG0NIYnENn/uWTQsyGK3zZaN
laVARB7aSZvIlxPqWq9MzKuNy8oap7vKctLdBGjSAX07guFtS8gvArGrtsZOhPtC
SMxS3egfVoZ1o1RIRryUL3e+/mxhC+zgbuMBo5FfITkgQqfkNiwi2We8GE6mDPcq
i/4KI6vnyWU8j1dYBo4zn3d/Gw8DGyqspCmmY27bQsr5v/D/ir2OyD58FVA4P/mo
gYlrXaO9bT0I8r9P+g06tV0H63JWLz9v+c1+aSJvRK/RDzi5/kwRjGPxIX/+i6xV
j5vLkj4dap7w204nnZlj
=9gZ5
-----END PGP SIGNATURE-----

--MKQswQ7UUMqTthTa--

--===============7624864590830245034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7624864590830245034==--
