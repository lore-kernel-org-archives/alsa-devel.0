From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 20/24] ASoC: qdsp6: q6afe: Add q6afe dai driver
Date: Wed, 9 May 2018 10:43:32 +0100
Message-ID: <28faf045-a053-0918-70d3-1ef6fcdb13b8@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-21-srinivas.kandagatla@linaro.org>
 <22a39a17-36ef-3e94-e91b-11d303559ae4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22a39a17-36ef-3e94-e91b-11d303559ae4@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org



On 09/05/18 10:42, Banajit Goswami wrote:
>> +
>> +static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
>> +{
>> +    struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
>> +    struct snd_soc_dapm_context *dapm;
>> +    struct q6afe_port *port;
>> +
>> +    dapm = snd_soc_component_get_dapm(dai->component);
> dapm unused here?
> 
I already removed this in v8.

thanks,
srini

> LGTM otherwise.
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
> 
> -- 
