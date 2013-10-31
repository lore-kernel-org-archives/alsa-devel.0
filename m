From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH v3 3/4] ASoC: fsl_ssi: Add dual fifo mode support
Date: Thu, 31 Oct 2013 12:28:49 +0000
Message-ID: <oxq6yw1a1g6ccnd85o4ral9y.1383222536476@email.android.com>
References: <cover.1383207153.git.b42378@freescale.com>
 <da997ce67d9817364248ca1eba716bb6c7814a24.1383207153.git.b42378@freescale.com>,<5272474D.5000207@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5272474D.5000207@tabi.org>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora>
List-Id: alsa-devel@alsa-project.org

Thank you for the comments.
I'll refine this part.

Sent by Android device.

Timur Tabi <timur@tabi.org> wrote:


Nicolin Chen wrote:
> +     if (ssi_private->use_dual_fifo) {
> +             write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
> +             write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
> +             write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
> +     } else {
> +             write_ssi_mask(&ssi->srcr, CCSR_SSI_SRCR_RFEN1, 0);
> +             write_ssi_mask(&ssi->stcr, CCSR_SSI_STCR_TFEN1, 0);
> +             write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TCH_EN, 0);
> +     }

Why do you need the "else" part?  Why can't you just do this:

if (ssi_private->use_dual_fifo) {
        write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
        write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
        write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
}


