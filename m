From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V3 2/2] ASoC: fsl_esai: recover the channel
 swap after xrun
Date: Wed, 10 Jul 2019 16:36:06 -0700
Message-ID: <20190710233605.GA9886@Asurada-Nvidia.nvidia.com>
References: <cover.1562566531.git.shengjiu.wang@nxp.com>
 <a055d9d590124aad2de70e97266e50d2bae752c8.1562566531.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EB3FF801A4
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2019 01:35:37 +0200 (CEST)
Received: by mail-pg1-x52d.google.com with SMTP id i8so1949405pgm.13
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2019 16:35:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a055d9d590124aad2de70e97266e50d2bae752c8.1562566531.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: shengjiu.wang@nxp.com
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Shengjiu,

Mostly looks good to me, just some small comments.

On Mon, Jul 08, 2019 at 02:38:52PM +0800, shengjiu.wang@nxp.com wrote:
  
> +static void fsl_esai_hw_reset(unsigned long arg)
> +{
> +	struct fsl_esai *esai_priv = (struct fsl_esai *)arg;
> +	u32 saisr, tfcr, rfcr;
> +	bool tx = true, rx = false, enabled[2];

Could we swap the lines of u32 and bool? It'd look better.

> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +			   ESAI_xCR_xPR_MASK, ESAI_xCR_xPR);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +			   ESAI_xCR_xPR_MASK, ESAI_xCR_xPR);

Let's add a line of comments for these two:
	/* Enforce ESAI personal resets for both TX and RX */

> +	/*
> +	 * Restore registers by regcache_sync, and ignore
> +	 * return value
> +	 */

Could fit into single-line?

> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +			   ESAI_xCR_xPR_MASK, 0);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +			   ESAI_xCR_xPR_MASK, 0);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
> +			   ESAI_PRRC_PDC_MASK, ESAI_PRRC_PDC(ESAI_GPIO));
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
> +			   ESAI_PCRC_PC_MASK, ESAI_PCRC_PC(ESAI_GPIO));

Could remove the blank line and add a line of comments:
	/* Remove ESAI personal resets by configuring PCRC and PRRC also */

Btw, I still feel this personal reset can be stuffed into one
of the wrapper functions. But let's keep this simple for now.

> +	regmap_read(esai_priv->regmap, REG_ESAI_SAISR, &saisr);

Why do we read saisr here? All its bits would get cleared by
the hardware reset. If it's a must to clear again, we should
add a line of comments to emphasize it.

Thank you
