From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: DaVinci: Added two clocking
 possibilities to McBSP (I2S)
Date: Thu, 1 Jul 2010 15:35:40 +0100
Message-ID: <20100701143540.GC8742@rakim.wolfsonmicro.main>
References: <1277905678-4695-1-git-send-email-lamiaposta71@gmail.com>
	<1277905678-4695-2-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E47AF10384A
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 16:35:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1277905678-4695-2-git-send-email-lamiaposta71@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Davide Bonfanti <davide.bonfanti@bticino.it>, Raffaele Recalcati <raffaele.recalcati@bticino.it>, Troy Kisky <troy.kisky@boundarydevices.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 30, 2010 at 03:47:56PM +0200, Raffaele Recalcati wrote:

> +static int davinci_i2s_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
> +				int div_id, int div)
> +{
> +	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
> +	int srgr;
> +
> +	dev->clk_div = div;
> +	return 0;
> +}

As previously mentioned this should check the div_id argument.

> +	switch (master) {
> +	case SND_SOC_DAIFMT_CBS_CFS:

...

> +	case SND_SOC_DAIFMT_CBM_CFS:

...

> +	default:
> +		/* Clock and frame sync given from external sources */

The two remaining options (_CBM_CFM and _CBS_CFM) are different, your
description matches _CBM_CFM.

> +		if (master == SND_SOC_DAIFMT_CBS_CFS ||
> +				master == SND_SOC_DAIFMT_CBS_CFM) {

Switch statement again.

> +	if (master == SND_SOC_DAIFMT_CBS_CFS ||
> +			master == SND_SOC_DAIFMT_CBS_CFM) {
> +		rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(0);
> +		xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(0);
> +	} else {

...and another.  Please fix all these.
