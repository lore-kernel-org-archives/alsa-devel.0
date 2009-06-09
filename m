From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Tue, 9 Jun 2009 11:54:28 +0200
Message-ID: <20090609095427.GG26688@buzzloop.caiaq.de>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<1244276805.15998.102.camel@brutus>
	<1719ee7f0906090239m578d1ab3j80a7ebc15f9cc51e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 878EA1037F2
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 11:54:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1719ee7f0906090239m578d1ab3j80a7ebc15f9cc51e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Shen <boshen9@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 09, 2009 at 05:39:53PM +0800, Paul Shen wrote:
> Would you please give some informations about your platform ?
> Thus I can test the patches with your method.

Sure, here we go.

We're using the following setup:

 - PXA in master mode to BITCLK and LRCLK but external SSP clock
 - 64fs frame format
 - CS4270 codec

Here's the code sniplet I use to configure the port using your latest
patch set:


	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
		SND_SOC_DAIFMT_CBS_CFS | PXA_SSP_FRM_64FS;

	/* setup the CODEC DAI */
        ret = snd_soc_dai_set_fmt(codec_dai, fmt);
        if (ret < 0)
		return ret;

	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk, 0);
	if (ret < 0)
		return ret;

	/* setup the CPU DAI */
	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk);
	if (ret < 0)
		return ret;

        ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
        if (ret < 0)
                return ret;

	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_DIV_SCR, 4);
        if (ret < 0)
                return ret;

	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, 0, 1);
        if (ret < 0)
                return ret;

	snd_soc_dai_set_tdm_slot(cpu_dai, 3, 2);

That gives me the following register values:

	SSCR0 0xa10003ff
	SSCR1 0x00e01d80
	SSPSP 0x31a00084

... which works fine for me. But the PXA is not really in a typical
slave configuration, mostly because we had lots of strange issues when
we tried that.

Any more things I can provide?

Thanks,
Daniel
