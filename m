From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: xlnx: add pcm formatter platform
	driver
Date: Thu, 20 Dec 2018 15:06:56 +0000
Message-ID: <20181220150656.GB9325@sirena.org.uk>
References: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1545239949-112845-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0425014690054138336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BA44226798A
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2018 16:07:00 +0100 (CET)
In-Reply-To: <1545239949-112845-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@xilinx.com>, Vishal Sagar <vsagar@xilinx.com>
List-Id: alsa-devel@alsa-project.org


--===============0425014690054138336==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 10:49:08PM +0530, Maruthi Srinivas Bayyavarapu wrote:

This looks mostly good, a few small things but all pretty trivial:

> +	switch (bits_per_sample) {
> +	case 8:
> +		val |= (BIT_DEPTH_8 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 16:
> +		val |= (BIT_DEPTH_16 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 20:
> +		val |= (BIT_DEPTH_20 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 24:
> +		val |= (BIT_DEPTH_24 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 32:
> +		val |= (BIT_DEPTH_32 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	}

It'd be better to have a default case returning an error for unsupported
sample sizes.

> +		ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
> +				       xlnx_mm2s_irq_handler, 0,
> +				       "xlnx_formatter_pcm_mm2s_irq", dev);
> +		if (ret) {
> +			dev_err(dev, "xlnx audio mm2s irq request failed\n");
> +			goto clk_err;
> +		}
> +		ret = xlnx_formatter_pcm_reset(aud_drv_data->mmio +
> +					       XLNX_MM2S_OFFSET);
> +		if (ret) {
> +			dev_err(dev, "audio formatter reset failed\n");
> +			goto clk_err;
> +		}
> +		xlnx_formatter_disable_irqs(aud_drv_data->mmio +
> +					    XLNX_MM2S_OFFSET,
> +					    SNDRV_PCM_STREAM_PLAYBACK);

This requests the interrupt before we've reset and quiesced the hardware
meaning the interrupt could fire immediately on request with the
hardware in an unknown state; it'd be better to reset the hardware first
then request the interrupt to minimize the risk that something goes
wrong with the handler.

> +	dev_info(dev, "pcm platform device registered\n");
> +	return 0;

This is just adding noise to the log.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwbsBAACgkQJNaLcl1U
h9Cpegf/WpTeT0YeDGH0yu/OmjEIpOjD5J8UooYjuzyLJCdKXLgfQy+I8gCQhe2M
Y+gOMrV1HtL2EayxfPee5P00+H/4RfTZ63nDEJY/SAQTRS7CA93lmYVqMAwPSm6/
mzeQmaawJJMPSK2dZFDwU9mafYaJzEiItW/eKFpUPbQSdqhCLHu41yaLGdxouvNv
ZaUOeOkI/y0w//PUWnJFlO2ddPjhC6PcdtkOstzxKzSTVu6tYrHZE0R4nBiAh4+S
SEdqbixMoAnuq9g2MfKzs1jopzMOpNjmcBpEE858EbZyOzG9b1gcHyxu21ldu2VQ
cPdurnYOp1tr986M/Y9yTc8PhxJoAg==
=sW2Y
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

--===============0425014690054138336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0425014690054138336==--
