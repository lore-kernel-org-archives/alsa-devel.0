From: "Kenneth Westfield" <kwestfie@codeaurora.org>
Subject: Re: [PATCH 3/9] ASoC: ipq806x: add native LPAIF driver
Date: Mon, 8 Dec 2014 14:06:47 -0800
Message-ID: <618bab4577b2f74052f94c4c49ad6f52.squirrel@www.codeaurora.org>
Reply-To: kwestfie@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Tue, November 25, 2014 1:44 pm, Mark Brown wrote:
> On Wed, Nov 19, 2014 at 10:52:43AM -0800, Kenneth Westfield wrote:
>> +static int lpaif_pcm_int_enable(uint8_t dma_ch)
>> +{
>> +	uint32_t intr_val;
>> +	uint32_t status_val;
>> +	unsigned long flags;
>> +
>> +	if (dma_ch >= LPAIF_MAX_CHANNELS) {
>> +		pr_err("%s: invalid DMA channel given: %hhu\n",
>> +				__func__, dma_ch);
> dev_err().

Now using it in most cases, except for two or three functions that would need to have a handle
passed to it solely for the purpose of using dev_*.

>> +	while (intrsrc) {
>> +		dma_ch = lpaif_dai_find_dma_channel(intrsrc);
>> +		if (dma_ch != -1) {
>> +			if (lpaif_dai[dma_ch]->callback) {
>> +
>> +				ret = lpaif_dai[dma_ch]->callback(intrsrc,
>> +					lpaif_dai[dma_ch]->private_data);
>> +			}
>> +			intrsrc &= ~LPAIF_PER_CH(dma_ch);
>> +		} else {
>> +			pr_err("%s: error getting channel\n", __func__);
>> +			break;
>> +		}
>> +	}
>> +	return ret;
>> +}
> This all looks like a very simple demux of a single register - don't we have a generic irqchip
that can handle it?  It looks like that's what you're trying to implement here, each DMA channel
could be requesting the three interrupts it has separately rather than open coding an interrupt
controller here.
> I'm not actually immediately seeing one right now but it'd be simple to add (or regmap-irq could
do it if we used a regmap, though it assumes threading and isn't a great fit).

I will look into this.  If one fits perfectly, great. If not, then I will add one.


-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,  a Linux Foundation
Collaborative Project
