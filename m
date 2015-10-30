From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Fri, 30 Oct 2015 08:49:47 -0700
Message-ID: <20151030154946.GA3505@Asurada-CZ80>
References: <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
 <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
 <20151030012934.GA5456@Asurada-GSX> <56332A4E.3010704@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id A91E126051B
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 16:49:53 +0100 (CET)
Received: by pasz6 with SMTP id z6so77862470pas.2
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 08:49:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56332A4E.3010704@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Caleb Crome <caleb@crome.org>, Markus Pargmann <mpa@pengutronix.de>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 30, 2015 at 09:29:02AM +0100, arnaud.mouiche@invoxia.com wrote:

> At imx50 age, I remember one workaround was to fill the fifo
> manually, writing directly a number of samples (equal to the number
> of slots for one frame to keep the synchronization), and then,
> enable the TMDAE.
> This just allow to not have to wait an undefined period of time for
> the DMA to be ready.
> But, on the other hand, if the time to wait the DMA is short enough,
> it should not be an issue.

Nice input. This reminds me of the zero-filling step inside the
ESAI startup procedure:

	case SNDRV_PCM_TRIGGER_START:
	case SNDRV_PCM_TRIGGER_RESUME:
	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
		regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx),
				   ESAI_xFCR_xFEN_MASK, ESAI_xFCR_xFEN);

		/* Write initial words reqiured by ESAI as normal procedure */
		for (i = 0; tx && i < channels; i++)
			regmap_write(esai_priv->regmap, REG_ESAI_ETDR, 0x0);

		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK,
				   tx ? ESAI_xCR_TE(pins) : ESAI_xCR_RE(pins));
		break;

It's exactly the same thing to prevent underrun. This might be
a reasonable alternative option due to no polling overhead and
timeout handling.

Thanks
Nicolin
