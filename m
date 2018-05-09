From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 23/24] ASoC: qcom: apq8096: Add db820c machine driver
Date: Wed, 9 May 2018 11:03:35 +0100
Message-ID: <0db86f6a-76cb-22a5-eed9-98b2134dcb8b@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-24-srinivas.kandagatla@linaro.org>
 <c52fc35d-95a6-6675-6c6e-32a0d5f486d4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c52fc35d-95a6-6675-6c6e-32a0d5f486d4@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

Thanks for the review Banajit.

On 09/05/18 10:15, Banajit Goswami wrote:
> 
> On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
>> This patch adds support to DB820c machine driver.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/Kconfig   |   9 ++
>>   sound/soc/qcom/Makefile  |   2 +
>>   sound/soc/qcom/apq8096.c | 238 
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 249 insertions(+)
>> +    link = card->dai_link;
>> +
>> +    for_each_child_of_node(node, np) {
>> +        cpu = of_get_child_by_name(np, "cpu");
>> +        platform = of_get_child_by_name(np, "platform");
>> +        codec = of_get_child_by_name(np, "codec");
>> +
>> +        if (!cpu) {
>> +            dev_err(dev, "Can't find cpu DT node\n");
> clean up missing to kfree(card->dai_link)?
Yep, I will fix error path in next version.
> 
>> +            return -EINVAL;
>> +        }
>> +
>> +                return ret;
>> +            }
>> +            link->no_pcm = 1;
>> +            link->ignore_suspend = 1;
> ignore_suspend will also need to be set for FE DAIs?
> 
Okay!
>> +            link->ignore_pmdown_time = 1;
>> +            link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
>> +        } else {
>> +            link->platform_of_node = link->cpu_of_node;
>> +            link->codec_dai_name = "snd-soc-dummy-dai";
>> +            link->codec_name = "snd-soc-dummy";
>> +            link->dynamic = 1;
>> +        }

>> +

>> +
>> +static void apq8096_unbind(struct device *dev)
>> +{
>> +    struct snd_soc_card *card = dev_get_drvdata(dev);
>> +
>> +    component_unbind_all(dev, card);
>> +    snd_soc_unregister_card(card);
> Should sound card not be unregistered first, before calling 
> component_unbind_all()?
Yep, I will give that a go.

thanks,
srini

> 
