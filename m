From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card
 support
Date: Mon, 9 Jul 2018 16:16:45 +0530
Message-ID: <c1766ce9-060f-32d8-46fa-b0a6ac42538b@codeaurora.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709074835.GB22377@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709074835.GB22377@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks Vinod for reviewing.


On 7/9/2018 1:18 PM, Vinod wrote:
> On 06-07-18, 15:13, Rohit kumar wrote:
>
>> +static void sdm845_init_supplies(struct device *dev)
>> +{
>> +	struct snd_soc_card *card = dev_get_drvdata(dev);
>> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
>> +
>> +	data->vdd_supply = regulator_get(dev, "cdc-vdd");
>> +	if (IS_ERR(data->vdd_supply)) {
>> +		dev_err(dev, "Unable to get regulator supplies\n");
>> +		data->vdd_supply = NULL;
>> +		return;
>> +	}
>> +
>> +	if (regulator_enable(data->vdd_supply))
>> +		dev_err(dev, "Unable to enable vdd supply\n");
>> +}
>> +
>> +static void sdm845_deinit_supplies(struct device *dev)
>> +{
>> +	struct snd_soc_card *card = dev_get_drvdata(dev);
>> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
>> +
>> +	if (!data->vdd_supply)
>> +		return;
>> +
>> +	regulator_disable(data->vdd_supply);
>> +	regulator_put(data->vdd_supply);
>> +}
> these two can be made generic, cant we make these common when we have
> supplies present?

Actually we  need to move it to codec driver as suggested by Rob in v2 
patchset.
I will remove this in next spin.

>> +static int sdm845_bind(struct device *dev)
>> +{
>> +	struct snd_soc_card *card;
>> +	struct sdm845_snd_data *data;
>> +	int ret;
>> +
>> +	card = kzalloc(sizeof(*card), GFP_KERNEL);
>> +	if (!card)
>> +		return -ENOMEM;
>> +
>> +	/* Allocate the private data */
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	ret = component_bind_all(dev, card);
>> +	if (ret) {
>> +		dev_err(dev, "Audio components bind failed: %d\n", ret);
>> +		goto bind_fail;
>> +	}
>> +
>> +	dev_set_drvdata(dev, card);
>> +	card->dev = dev;
>> +	ret = qcom_snd_parse_of(card);
>> +	if (ret) {
>> +		dev_err(dev, "Error parsing OF data\n");
>> +		goto parse_dt_fail;
>> +	}
>> +
>> +	data->card = card;
>> +	snd_soc_card_set_drvdata(card, data);
>> +
>> +	sdm845_add_be_ops(card);
>> +
>> +	sdm845_init_supplies(dev);
>> +
>> +	ret = snd_soc_register_card(card);
>> +	if (ret) {
>> +		dev_err(dev, "Sound card registration failed\n");
>> +		goto register_card_fail;
>> +	}
>> +	return ret;
>> +
>> +register_card_fail:
>> +	sdm845_deinit_supplies(dev);
>> +	kfree(card->dai_link);
>> +parse_dt_fail:
>> +	component_unbind_all(dev, card);
>> +bind_fail:
>> +	kfree(data);
>> +	kfree(card);
>> +	return ret;
>> +}
> I would make a case for this to be moved into common too :)

There are few platform specific APIs and structs here like struct 
sdm845_snd_data,
sdm845_add_be_ops() which needs to be initialized and assigned before 
soundcard
registration. Moving this complete API to common will restrict it. 
Please suggest.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
