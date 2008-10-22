From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: OMAP: Fix DSP DAI format in McBSP
 DAI driver
Date: Wed, 22 Oct 2008 13:12:25 +0300
Message-ID: <20081022131225.b162289e.jarkko.nikula@nokia.com>
References: <1224505799-16686-1-git-send-email-jarkko.nikula@nokia.com>
	<dfeb90390810220256t41015140l57cb3fb584e24da0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 999B2244F7
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 12:13:13 +0200 (CEST)
In-Reply-To: <dfeb90390810220256t41015140l57cb3fb584e24da0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Arun KS <getarunks@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Oct 2008 15:26:36 +0530
"ext Arun KS" <getarunks@gmail.com> wrote:

> >        /* Generic McBSP register settings */
> >        regs->spcr2     |= XINTM(3) | FREE;
> > @@ -293,6 +307,8 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
> >                /* 0-bit data delay */
> >                regs->rcr2      |= RDATDLY(0);
> >                regs->xcr2      |= XDATDLY(0);
> > +               /* Invert bit clock and FS polarity configuration for DSP_A */
> > +               temp_fmt ^= SND_SOC_DAIFMT_IB_IF;
> 
> Can you tell me why this is done here?
> This is modifying what machine driver has chosen. AM I missing something?
> 
Since as a McBSP sense, the normal polarities in DSP format (or
according to AIC33 DSP mode...) were different than in I2S. Idea is to
keep codec and cpu configuration in sync in the machine driver, i.e.
same bit clock and frame sync polarity configuration

	/* Set codec DAI configuration */
	err = snd_soc_dai_set_fmt(codec_dai,
					 SND_SOC_DAIFMT_I2S |
					 SND_SOC_DAIFMT_NB_NF |
					 SND_SOC_DAIFMT_CBM_CFM);

	/* Set cpu DAI configuration */
	err = snd_soc_dai_set_fmt(cpu_dai,
				       SND_SOC_DAIFMT_I2S |
				       SND_SOC_DAIFMT_NB_NF |
				       SND_SOC_DAIFMT_CBM_CFM);


Jarkko
