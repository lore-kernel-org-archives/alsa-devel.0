From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Date: Wed, 14 Aug 2019 09:09:04 -0500
Message-ID: <99d35a9d-cbd8-f0da-4701-92ef650afe5a@linux.intel.com>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
 <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814041142.GU12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, spapothi@codeaurora.org
List-Id: alsa-devel@alsa-project.org



On 8/13/19 11:11 PM, Vinod Koul wrote:
> On 13-08-19, 20:58, Mark Brown wrote:
>> On Tue, Aug 13, 2019 at 02:38:53PM -0500, Pierre-Louis Bossart wrote:
>>
>>> Indeed. I don't have a full understanding of that part to be honest, nor why
>>> we need something SoundWire-specific. We already abused the set_tdm_slot API
>>> to store an HDaudio stream, now we have a rather confusing stream
>>> information for SoundWire and I have about 3 other 'stream' contexts in
>>> SOF... I am still doing basic cleanups but this has been on my radar for a
>>> while.
>>
>> There is something to be said for not abusing the TDM slot API if it can
>> make things clearer by using bus-idiomatic mechanisms, but it does mean
>> everything needs to know about each individual bus :/ .
> 
> Here ASoC doesn't need to know about sdw bus. As Srini explained, this
> helps in the case for him to get the stream context and set the stream
> context from the machine driver.
> 
> Nothing else is expected to be done from this API. We already do a set
> using snd_soc_dai_set_sdw_stream(). Here we add the snd_soc_dai_get_sdw_stream() to query

I didn't see a call to snd_soc_dai_set_sdw_stream() in Srini's code?
