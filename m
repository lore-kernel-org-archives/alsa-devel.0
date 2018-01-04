From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add db820c machine
 driver
Date: Thu, 4 Jan 2018 13:44:30 +0000
Message-ID: <418b531d-9d51-80c5-85aa-8ab8ef27bebb@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
 <20180104120244.GE10774@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20180104120244.GE10774@sirena.org.uk>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 04/01/18 12:02, Mark Brown wrote:
> On Wed, Jan 03, 2018 at 09:20:45AM -0800, Stephen Boyd wrote:
>> On 12/14/2017 09:34 AM, srinivas.kandagatla@linaro.org wrote:
> 
>>> uThis patch adds support to DB820c machine driver.
> 
>>> +	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
> 
>> Why do we need to do this? Can you add some sort of comment in the code
>> about why?
> 
> And why are we applying DMA restrictions in a machine driver?

Initially I had this in pcm driver, but looking at example usage of 
snd_dma_alloc_pages, most of them use card->dev and some of them use pcm 
device for allocating dma memory.

Also, as I moved most dsp static services and dais out of DT, except 
codec and sound card, sound card device was the only choice I had for 
binding with iommu and enforcing iova range restrictions.

This call will be replaced by dma-ranges property in DT either way.


--srini
> 
