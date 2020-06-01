Return-Path: <SRS0=kaWB=7O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D110BC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:27:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8B92074B
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WWrLCE6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8B92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFD7115F2;
	Mon,  1 Jun 2020 23:26:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFD7115F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591046836;
	bh=PvTW8zNAr8kLGNIOaQpSHeZI03NsJrtPAnGoi4WQgnA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WWrLCE6U2jUjJ83s5pMJDlMyTGKuEYN9Gy2FyhgEmHpRJpY4deJdmhH9rHt8eLlz7
	 FGZNlwulimFrRYLYvqpDkiFRQR5/Rl3M+M5rXmr1BD1BiSoq7ZUsNyMPZZGFWaX3IO
	 f8ZzI09/jtlXG7XcBPHnzcY0vEOznh/350BY0FPQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71394F801EC;
	Mon,  1 Jun 2020 23:26:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73BEDF801ED; Mon,  1 Jun 2020 23:26:24 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C071F80159
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2020 23:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C071F80159
IronPort-SDR: ZxOnhuYlME9UTYleSonCiEkw8lsQ05BpeI6R/O3JMt7/u+2/+Dgfa/DQJCPPx76VLRp7lusryx
 4kehqI9+s2KA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2020 14:26:17 -0700
IronPort-SDR: js+y0Iijjcfon9Q/752GmlOcUaI8Vk+CSWlLU/9r1l/0Xa1UiHf3Ko2jdiPTrCi+MvxO3PTY/r
 rj60RIilJtlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; d="scan'208";a="470428876"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.29.12])
 ([10.213.29.12])
 by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2020 14:26:14 -0700
Subject: Re: [PATCH v3 1/3] ASoC: Intel: Add KeemBay platform driver
To: Sia Jee Heng <jee.heng.sia@intel.com>
References: <1591005201-31704-1-git-send-email-jee.heng.sia@intel.com>
 <1591005201-31704-2-git-send-email-jee.heng.sia@intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <c0474bde-ebb9-ab3c-3cb3-c8e2758cf891@intel.com>
Date: Mon, 1 Jun 2020 23:26:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1591005201-31704-2-git-send-email-jee.heng.sia@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 2020-06-01 11:53 AM, Sia Jee Heng wrote:

> +
> +#define PERIODS_MIN		2
> +#define PERIODS_MAX		48
> +#define PERIOD_BYTES_MIN	4096
> +#define BUFFER_BYTES_MAX	(PERIODS_MAX * PERIOD_BYTES_MIN)
> +#define TDM_OPERATION		1

Looks as this is unused.

> +#define I2S_OPERATION		0
> +#define DATA_WIDTH_CONFIG_BIT	6
> +#define TDM_CHANNEL_CONFIG_BIT	3
> +#define I2S_SAMPLE_RATES	(SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_48000)

This defines common rates yet .formats are left alone? As .formats, 
.rate_min/ max and others are left alone I'd stick with this style and 
specify .rates directly too.

> +
> +static const struct snd_pcm_hardware kmb_pcm_hardware = {
> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
> +		SNDRV_PCM_INFO_MMAP |
> +		SNDRV_PCM_INFO_MMAP_VALID |
> +		SNDRV_PCM_INFO_BATCH |
> +		SNDRV_PCM_INFO_BLOCK_TRANSFER,

Several flags have been or'ed here. Have these been verified working for 
Keembay?

> +	.rates = I2S_SAMPLE_RATES,
> +	.rate_min = 16000,
> +	.rate_max = 48000,
> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |
> +		   SNDRV_PCM_FMTBIT_S24_LE |
> +		   SNDRV_PCM_FMTBIT_S32_LE,
> +	.channels_min = 2,
> +	.channels_max = 2,
> +	.buffer_bytes_max = BUFFER_BYTES_MAX,
> +	.period_bytes_min = PERIOD_BYTES_MIN,
> +	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
> +	.periods_min = PERIODS_MIN,
> +	.periods_max = PERIODS_MAX,
> +	.fifo_size = 16,
> +};
> +
> +static unsigned int kmb_pcm_tx_fn(struct kmb_i2s_info *kmb_i2s,
> +				  struct snd_pcm_runtime *runtime,
> +				  unsigned int tx_ptr, bool *period_elapsed)
> +{
> +	unsigned int period_pos = tx_ptr % runtime->period_size;
> +	void __iomem *i2s_base = kmb_i2s->i2s_base;
> +	u16(*p16)[2];
> +	u32(*p32)[2];
> +	int i;
> +
> +	if (kmb_i2s->config.data_width == 16)
> +		p16 = (void *)runtime->dma_area;
> +	else
> +		p32 = (void *)runtime->dma_area;
> +	/* KMB i2s uses two separate L/R FIFO */
> +	for (i = 0; i < kmb_i2s->fifo_th; i++) {
> +		if (kmb_i2s->config.data_width == 16) {
> +			writel(p16[tx_ptr][0], i2s_base + LRBR_LTHR(0));
> +			writel(p16[tx_ptr][1], i2s_base + RRBR_RTHR(0));
> +		} else {
> +			writel(p32[tx_ptr][0], i2s_base + LRBR_LTHR(0));
> +			writel(p32[tx_ptr][1], i2s_base + RRBR_RTHR(0));
> +		}

Looks like a refactor candidate. Both, the preceding 'if' and the 'for' 
- which are the body of this func - are "data_width" dependent. You 
could redure if-ology by defining separate variants for 16 and non-16.

Idk about naming index-variable 'rx_ptr'. This isn't a pointer, that's 
for sure.

> +
> +		period_pos++;
> +
> +		if (++tx_ptr >= runtime->buffer_size)
> +			tx_ptr = 0;
> +	}
> +
> +	*period_elapsed = period_pos >= runtime->period_size;
> +
> +	return tx_ptr;
> +}
> +
> +static unsigned int kmb_pcm_rx_fn(struct kmb_i2s_info *kmb_i2s,
> +				  struct snd_pcm_runtime *runtime,
> +				  unsigned int rx_ptr, bool *period_elapsed)
> +{
> +	unsigned int period_pos = rx_ptr % runtime->period_size;
> +	void __iomem *i2s_base = kmb_i2s->i2s_base;
> +	u16(*p16)[2];
> +	u32(*p32)[2];
> +	int i;
> +
> +	if (kmb_i2s->config.data_width == 16)
> +		p16 = (void *)runtime->dma_area;
> +	else
> +		p32 = (void *)runtime->dma_area;
> +	/* KMB i2s uses two separate L/R FIFO */
> +	for (i = 0; i < kmb_i2s->fifo_th; i++) {
> +		if (kmb_i2s->config.data_width == 16) {
> +			p16[rx_ptr][0] = readl(i2s_base + LRBR_LTHR(0));
> +			p16[rx_ptr][1] = readl(i2s_base + RRBR_RTHR(0));
> +		} else {
> +			p32[rx_ptr][0] = readl(i2s_base + LRBR_LTHR(0));
> +			p32[rx_ptr][1] = readl(i2s_base + RRBR_RTHR(0));
> +		}

The exact same advice goes here.

> +
> +		period_pos++;
> +
> +		if (++rx_ptr >= runtime->buffer_size)
> +			rx_ptr = 0;
> +	}
> +
> +	*period_elapsed = period_pos >= runtime->period_size;
> +
> +	return rx_ptr;
> +}
> +

> +
> +static void kmb_pcm_operation(struct kmb_i2s_info *kmb_i2s, bool playback)
> +{
> +	struct snd_pcm_substream *substream;
> +	bool active, period_elapsed;
> +
> +	if (playback)
> +		substream = kmb_i2s->tx_substream;
> +	else
> +		substream = kmb_i2s->rx_substream;
> +
> +	active = substream && snd_pcm_running(substream);

'active' serves little to no purpose here, I'd opt for removing it.

> +
> +	if (active) {

When deciding between no middle func 'return' or recuded indentation, 
the later is more readable. Simple:

	if (!substream || snd_pcm_running(substream))
		return;

allows rest of the function to be shift-left'ed.

> +		unsigned int ptr;
> +		unsigned int new_ptr;

'ptr' and 'new_ptr' declared in local scope yet 'period_elapsed' found 
its way out of here. To make code look cohesive, either have all 
declared in function's var declaration block or make sure local scope 
contains all local variables declarations.

Of course this is obsolete if you decide to pursue shift-left suggestion.

> +
> +		if (playback) {
> +			ptr = kmb_i2s->tx_ptr;
> +			new_ptr = kmb_pcm_tx_fn(kmb_i2s, substream->runtime,
> +						ptr, &period_elapsed);
> +			cmpxchg(&kmb_i2s->tx_ptr, ptr, new_ptr);
> +		} else {
> +			ptr = kmb_i2s->rx_ptr;
> +			new_ptr = kmb_pcm_rx_fn(kmb_i2s, substream->runtime,
> +						ptr, &period_elapsed);
> +			cmpxchg(&kmb_i2s->rx_ptr, ptr, new_ptr);
> +		}
> +
> +		if (period_elapsed)
> +			snd_pcm_period_elapsed(substream);
> +	}
> +}
> +

> +
> +static int kmb_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
> +{
> +	struct kmb_i2s_info *kmb_i2s = snd_soc_dai_get_drvdata(cpu_dai);
> +	int ret;
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		kmb_i2s->master = false;
> +		ret = 0;
> +	break;

Identation is off here.

> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		writel(MASTER_MODE, kmb_i2s->pss_base + I2S_GEN_CFG_0);
> +
> +		ret = clk_prepare_enable(kmb_i2s->clk_i2s);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(kmb_i2s->dev, kmb_disable_clk,
> +					       kmb_i2s->clk_i2s);
> +		if (ret)
> +			return ret;
> +
> +		kmb_i2s->master = true;
> +	break;

Same here.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +

> +
> +/*
> + * struct i2s_clk_config_data - represent i2s clk configuration data
> + * @chan_nr: number of channel
> + * @data_width: number of bits per sample (8/16/24/32 bit)
> + * @sample_rate: sampling frequency (8Khz, 16Khz, 48Khz)
> + */
> +struct i2s_clk_config_data {
> +	int chan_nr;
> +	u32 data_width;
> +	u32 sample_rate;
> +};
> +
> +struct kmb_i2s_info {
> +	void __iomem *i2s_base;
> +	void __iomem *pss_base;
> +	struct clk *clk_i2s;
> +	struct clk *clk_apb;
> +	int active;
> +	unsigned int capability;
> +	unsigned int i2s_reg_comp1;
> +	unsigned int i2s_reg_comp2;
> +	struct device *dev;
> +	u32 ccr;
> +	u32 xfer_resolution;
> +	u32 fifo_th;
> +	bool master;
> +
> +	struct i2s_clk_config_data config;
> +	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
> +
> +	/* data related to PIO transfers */
> +	bool use_pio;
> +	struct snd_pcm_substream *tx_substream;
> +	struct snd_pcm_substream *rx_substream;
> +	unsigned int tx_ptr;
> +	unsigned int rx_ptr;

As you 'if' stream's direction in several pcm handlers, how about 
declaring simple arrays here. You could access members based on 
SNDRV_PCM_STREAM_PLAYBACK/ CAPTURE i.e. direction, reducing the if-ology.

	struct snd_pcm_substream *substream[2];
	unsigned int ptr[2];

If the number of direction-based 'ifs' cannot be reduced even with this 
change, drop the suggestion.

> +};
> +
> +#endif /* KMB_PLATFORM_H_ */
> 
