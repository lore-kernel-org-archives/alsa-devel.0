From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: change set_tdm_slot api to
	allow	slot_size override.
Date: Thu, 11 Jun 2009 13:07:39 +0100
Message-ID: <20090611120738.GD26509@sirena.org.uk>
References: <1244715420.21356.29.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E13F2464D
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 14:07:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244715420.21356.29.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 11, 2009 at 07:17:00AM -0300, Daniel Ribeiro wrote:
> Extend set_tdm_slot to allow the user to arbitrarily set the frame width
> and active TX/RX slots.

Looks good - I'll apply this unless someone else spots any issues.
Unfortunately I'm not able to test the PXA changes right now.

> Updates magician.c and wm9081.c for the new set_tdm_slot(). wm9081.c
> still doesn't handle the slot_width override, I will submit this as a
> separate patch after I figure how to handle the I2S case.

There's no need for you to spend time looking at this, I'll take care of
it.

> (this series is meant for Mark's for-2.6.32 branch + "remove duplicated
> code" patch I sent yesterday)
> 
> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
> 
> ---
>  include/sound/soc-dai.h   |    5 +++--
>  sound/soc/codecs/wm9081.c |    5 +++--
>  sound/soc/pxa/magician.c  |    2 +-
>  sound/soc/pxa/pxa-ssp.c   |   27 ++++++++++++++++++++-------
>  sound/soc/soc-core.c      |    9 ++++++---
>  5 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 352d7ee..6692410 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -106,7 +106,7 @@ int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
>  int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
>  
>  int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
> -	unsigned int mask, int slots);
> +	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width);
>  
>  int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
>  
> @@ -140,7 +140,8 @@ struct snd_soc_dai_ops {
>  	 */
>  	int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
>  	int (*set_tdm_slot)(struct snd_soc_dai *dai,
> -		unsigned int mask, int slots);
> +		unsigned int tx_mask, unsigned int rx_mask,
> +		int slots, int slot_width);
>  	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
>  
>  	/*
> diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
> index 86fc57e..c47d573 100644
> --- a/sound/soc/codecs/wm9081.c
> +++ b/sound/soc/codecs/wm9081.c
> @@ -1206,8 +1206,9 @@ static int wm9081_set_sysclk(struct snd_soc_dai *codec_dai,
>  	return 0;
>  }
>  
> +/* FIXME: Needs to handle slot_width */
>  static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
> -			       unsigned int mask, int slots)
> +	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
>  {
>  	struct snd_soc_codec *codec = dai->codec;
>  	unsigned int aif1 = wm9081_read(codec, WM9081_AUDIO_INTERFACE_1);
> @@ -1219,7 +1220,7 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
>  
>  	aif1 |= (slots - 1) << WM9081_AIFDAC_TDM_MODE_SHIFT;
>  
> -	switch (mask) {
> +	switch (rx_mask) {
>  	case 1:
>  		break;
>  	case 2:
> diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
> index c89a3cd..34437d8 100644
> --- a/sound/soc/pxa/magician.c
> +++ b/sound/soc/pxa/magician.c
> @@ -188,7 +188,7 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
> +	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 0, 1, width);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index e22c5ce..613cccb 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c
> @@ -375,21 +375,34 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai,
>   * Set the active slots in TDM/Network mode
>   */
>  static int pxa_ssp_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
> -	unsigned int mask, int slots)
> +	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
>  {
>  	struct ssp_priv *priv = cpu_dai->private_data;
>  	struct ssp_device *ssp = priv->dev.ssp;
>  	u32 sscr0;
>  
> -	sscr0 = ssp_read_reg(ssp, SSCR0) & ~SSCR0_SlotsPerFrm(7);
> +	sscr0 = ssp_read_reg(ssp, SSCR0);
> +	sscr0 &= ~(SSCR0_MOD | SSCR0_SlotsPerFrm(7) | SSCR0_EDSS | SSCR0_DSS);
> +
> +	/* set slot width */
> +	if (slot_width > 16)
> +		sscr0 |= SSCR0_EDSS | SSCR0_DataSize(slot_width - 16);
> +	else
> +		sscr0 |= SSCR0_DataSize(slot_width);
>  
> -	/* set number of active slots */
> -	sscr0 |= SSCR0_SlotsPerFrm(slots);
> +	if (slots > 1) {
> +		/* enable network mode */
> +		sscr0 |= SSCR0_MOD;
> +
> +		/* set number of active slots */
> +		sscr0 |= SSCR0_SlotsPerFrm(slots);
> +
> +		/* set active slot mask */
> +		ssp_write_reg(ssp, SSTSA, tx_mask);
> +		ssp_write_reg(ssp, SSRSA, rx_mask);
> +	}
>  	ssp_write_reg(ssp, SSCR0, sscr0);
>  
> -	/* set active slot mask */
> -	ssp_write_reg(ssp, SSTSA, mask);
> -	ssp_write_reg(ssp, SSRSA, mask);
>  	return 0;
>  }
>  
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index e1a920c..c72a8e8 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2133,17 +2133,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
>  /**
>   * snd_soc_dai_set_tdm_slot - configure DAI TDM.
>   * @dai: DAI
> - * @mask: DAI specific mask representing used slots.
> + * @tx_mask: bitmask representing active TX slots.
> + * @rx_mask: bitmask representing active RX slots.
>   * @slots: Number of slots in use.
> + * @slot_width: Width in bits for each slot.
>   *
>   * Configures a DAI for TDM operation. Both mask and slots are codec and DAI
>   * specific.
>   */
>  int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
> -	unsigned int mask, int slots)
> +	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
>  {
>  	if (dai->ops && dai->ops->set_tdm_slot)
> -		return dai->ops->set_tdm_slot(dai, mask, slots);
> +		return dai->ops->set_tdm_slot(dai, tx_mask, rx_mask,
> +				slots, slot_width);
>  	else
>  		return -EINVAL;
>  }
> -- 
> tg: (c787980..) asoc/set_tdm_slot (depends on: asoc/remove-code-duplication)
> 
> 
> -- 
> Daniel Ribeiro



-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
