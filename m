From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4] ASoC: sgtl5000: Fix the cache handling
Date: Mon, 26 May 2014 09:26:33 +0200
Message-ID: <5382ECA9.1090808@metafoo.de>
References: <1400958960-18775-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-112.synserver.de (smtp-out-227.synserver.de
 [212.40.185.227])
 by alsa0.perex.cz (Postfix) with ESMTP id C6AED264F1E
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 09:26:37 +0200 (CEST)
In-Reply-To: <1400958960-18775-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

On 05/24/2014 09:16 PM, Fabio Estevam wrote:
[...]
>   /*
> + * restore all sgtl5000 registers,
> + * since a big hole between dap and regular registers,
> + * we will restore them respectively.
> + */
> +static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
> +{
> +	u16 reg;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +
> +	/* restore regular registers */
> +	for (reg = 0; reg <= SGTL5000_CHIP_SHORT_CTRL; reg += 2) {
> +
> +		/* These regs should restore in particular order */
> +		if (reg == SGTL5000_CHIP_ANA_POWER ||
> +			reg == SGTL5000_CHIP_CLK_CTRL ||
> +			reg == SGTL5000_CHIP_LINREG_CTRL ||
> +			reg == SGTL5000_CHIP_LINE_OUT_CTRL ||
> +			reg == SGTL5000_CHIP_REF_CTRL)
> +			continue;
> +
> +		regmap_update_bits(sgtl5000->regmap, reg, reg, 0);

This makes even less sense than before. The third parameter of 
regmap_update_bits() is the mask for the update operation and the last 
parameter is the value. regmap_update_bits() basically does this reg = (reg 
& ~mask) | value;

I think the issue with this chip is that it wants a special sequence in 
which the registers are written when syncing the cache to the hardware. The 
first thing to check is probably if that is actually necessary. If not just 
drop the whole restore_regs thing. If it is necessary its probably worth 
investigating whether it makes sense to support custom sync sequences in 
regmap. We already have regcache_sync_region() so maybe add a 
regcache_sync_regions() which takes a array of struct regmap_range. And 
syncs the registers in the order of the ranges.

- Lars
