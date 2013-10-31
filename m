From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v3 3/4] ASoC: fsl_ssi: Add dual fifo mode support
Date: Thu, 31 Oct 2013 07:04:29 -0500
Message-ID: <5272474D.5000207@tabi.org>
References: <cover.1383207153.git.b42378@freescale.com> <da997ce67d9817364248ca1eba716bb6c7814a24.1383207153.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <da997ce67d9817364248ca1eba716bb6c7814a24.1383207153.git.b42378@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolin Chen <b42378@freescale.com>, s.hauer@pengutronix.de, shawn.guo@linaro.org, broonie@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, philippe.retornaz@gmail.com
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> +	if (ssi_private->use_dual_fifo) {
> +		write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
> +		write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
> +		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
> +	} else {
> +		write_ssi_mask(&ssi->srcr, CCSR_SSI_SRCR_RFEN1, 0);
> +		write_ssi_mask(&ssi->stcr, CCSR_SSI_STCR_TFEN1, 0);
> +		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TCH_EN, 0);
> +	}

Why do you need the "else" part?  Why can't you just do this:

if (ssi_private->use_dual_fifo) {
	write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
	write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
	write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
}
