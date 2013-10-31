From: =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@gmail.com>
Subject: Re: [PATCH v2 3/4] ASoC: fsl_ssi: Add dual fifo mode support
Date: Thu, 31 Oct 2013 08:54:12 +0100
Message-ID: <52720CA4.3090003@gmail.com>
References: <cover.1383197521.git.b42378@freescale.com> <0e947536358af7bd6e179559006a3526801a1abe.1383197521.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <0e947536358af7bd6e179559006a3526801a1abe.1383197521.git.b42378@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolin Chen <b42378@freescale.com>
Cc: s.hauer@pengutronix.de, timur@tabi.org, shawn.guo@linaro.org, broonie@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, galak@codeaurora.org, dmaengine@vger.kernel.org, ijc+devicetree@hellion.org.uk, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi

>
> +			/* When using dual fifo mode, we need to keep watermark
> +			 * as even numbers due to dma script limitation.
> +			 */
> +			ssi_private->dma_params_tx.maxburst /= 2;
> +			ssi_private->dma_params_tx.maxburst *= 2;
> +			ssi_private->dma_params_rx.maxburst /= 2;
> +			ssi_private->dma_params_rx.maxburst *= 2;
>

Why not using a mask here ?
ssi_private->dma_params_tx.maxburst &= ~0x1;
ssi_private->dma_params_rx.maxburst &= ~0x1;

Regards,

Philippe

