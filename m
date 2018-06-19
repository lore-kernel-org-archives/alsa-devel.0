From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: qcom: add sdm845 sound card support
Date: Tue, 19 Jun 2018 19:20:55 +0530
Message-ID: <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <20180619050527.GR25852@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619050527.GR25852@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks Vinod for reviewing.


On 6/19/2018 10:35 AM, Vinod wrote:
> On 18-06-18, 16:46, Rohit kumar wrote:
>
>> +struct sdm845_snd_data {
>> +	struct snd_soc_card *card;
>> +	struct regulator *vdd_supply;
>> +	struct snd_soc_dai_link dai_link[];
>> +};
>> +
>> +static struct mutex pri_mi2s_res_lock;
>> +static struct mutex quat_tdm_res_lock;
> any reason why the locks can't be part of sdm845_snd_data?
> Also why do we need two locks ?
No specific reason, I will move it to sdm845_snd_data.
These locks are used to protect enable/disable of bit clocks. We have 
Primary MI2S RX/TX
and Quaternary TDM RX/TX interfaces. For primary mi2s rx/tx, we have 
single clock which is
synchronized with pri_mi2s_res_lock. For Quat TDM RX/TX, we are using 
quat_tdm_res_lock.
We need two locks as we are protecting two different resources.
>
>> +static atomic_t pri_mi2s_clk_count;
>> +static atomic_t quat_tdm_clk_count;
> Any specific reason for using atomic variables?
Nothing as such. As we are using mutex to synchronize, we can make it 
non- atomic.
Will do it in next-spin.
>
>> +static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
>> +
>> +static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
>> +					struct snd_pcm_hw_params *params)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +	int ret = 0;
>> +	int channels, slot_width;
>> +
>> +	channels = params_channels(params);
>> +	if (channels < 1 || channels > 8) {
> I though ch = 0 would be caught by framework and IIRC ASoC doesn't
> support more than 8 channels

OK. Will check and remove.
>> +		pr_err("%s: invalid param channels %d\n",
>> +				__func__, channels);
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (params_format(params)) {
>> +	case SNDRV_PCM_FORMAT_S32_LE:
>> +	case SNDRV_PCM_FORMAT_S24_LE:
>> +	case SNDRV_PCM_FORMAT_S16_LE:
>> +		slot_width = 32;
>> +		break;
>> +	default:
>> +		pr_err("%s: invalid param format 0x%x\n",
>> +				__func__, params_format(params));
> why not use dev_err, bonus you get device name printer with the logs :)

Sure. Will change it.
>> +static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>> +{
>> +	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +
>> +	pr_debug("%s: dai_id: 0x%x\n", __func__, cpu_dai->id);
> It is good for debug but not very useful here, so removing it would be
> good

OK
>> +	switch (cpu_dai->id) {
>> +	case PRIMARY_MI2S_RX:
>> +	case PRIMARY_MI2S_TX:
>> +		mutex_lock(&pri_mi2s_res_lock);
>> +		if (atomic_inc_return(&pri_mi2s_clk_count) == 1) {
>> +			snd_soc_dai_set_sysclk(cpu_dai,
>> +				Q6AFE_LPASS_CLK_ID_MCLK_1,
>> +				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
>> +			snd_soc_dai_set_sysclk(cpu_dai,
>> +				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
>> +				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
>> +		}
>> +		mutex_unlock(&pri_mi2s_res_lock);
> why do we need locking here? Can you please explain that.
So, we can have two usecases: one with primary mi2s rx and other with 
primary mi2s tx.
Lock is required to increment  pri_mi2s_clk_count and enable clock so 
that disable of one
usecase does not disable the clock.
>
>> +		snd_soc_dai_set_fmt(cpu_dai, fmt);
>> +		break;
> empty line after break helps in readability

Sure. Will add that change.
>> +static int sdm845_sbc_parse_of(struct snd_soc_card *card)
>> +{
>> +	struct device *dev = card->dev;
>> +	struct snd_soc_dai_link *link;
>> +	struct device_node *np, *codec, *platform, *cpu, *node;
>> +	int ret, num_links;
>> +	struct sdm845_snd_data *data;
>> +
>> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
>> +	if (ret) {
>> +		dev_err(dev, "Error parsing card name: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	node = dev->of_node;
>> +
>> +	/* DAPM routes */
>> +	if (of_property_read_bool(node, "qcom,audio-routing")) {
>> +		ret = snd_soc_of_parse_audio_routing(card,
>> +					"qcom,audio-routing");
>> +		if (ret)
>> +			return ret;
>> +	}
> so if we dont find audio-routing, then? we seems to continue..
Right. Its not mandatory to have qcom,audio-routing in device tree.

Regards,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
