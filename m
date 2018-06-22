From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH v2 2/2] ASoC: qcom: add sdm845 sound card
 support
Date: Fri, 22 Jun 2018 13:32:06 +0100
Message-ID: <ba90c267-2bca-469e-f41f-df46ed4421b5@linaro.org>
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-3-git-send-email-rohitkr@codeaurora.org>
 <20180621123503.GD27187@vkoul-mobl>
 <46f1a6af-a180-2568-d203-87323379c2fd@linaro.org>
 <58db39ee-d2a7-1cdf-c7e2-eea020c8a2c6@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58db39ee-d2a7-1cdf-c7e2-eea020c8a2c6@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit Kumar <rohitkr@codeaurora.org>, Vinod <vkoul@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 22/06/18 11:36, Rohit Kumar wrote:
>>
> Sure, I will add a new file, qcom_snd_common.c, which will have these 
> common functions and will update apq8096 and sdm845 machine driver to use
> APIs exposed by qcom_snd_common.c
Just name it as "common.c" no need to prefix this as is going to live in 
sound/soc/qcom anyway.

--srini
