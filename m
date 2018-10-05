From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/5] ALSA: soc-compress: add support to
 snd_compr_set_runtime_buffer()
Date: Fri, 5 Oct 2018 09:16:26 +0100
Message-ID: <6ac9b82e-9f92-d06a-724e-b460d24433ae@linaro.org>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
 <20180926102349.23481-2-srinivas.kandagatla@linaro.org>
 <20181005003112.GG2372@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005003112.GG2372@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org, mark.rutland@arm.com
List-Id: alsa-devel@alsa-project.org

Thanks for review!

On 05/10/18 01:31, Vinod wrote:
> On 26-09-18, 11:23, Srinivas Kandagatla wrote:
>> This patch adds support to set runtime dma buffer on compressed stream.
> The change is fine as is, but I feel we need to document the motivation
> in the changelog. The core changes need a bit more explanation on why we
> should add this..

Sure, I will add more information into the change log in next version.

--srini

> 
>> Signed-off-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>> ---
>>   include/sound/compress_driver.h | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
>> index ea8c93bbb0e0..0cdc3999ecfa 100644
>> --- a/include/sound/compress_driver.h
>> +++ b/include/sound/compress_driver.h
>> @@ -23,6 +23,7 @@ struct snd_compr_ops;
>>    * struct snd_compr_runtime: runtime stream description
>>    * @state: stream state
>>    * @ops: pointer to DSP callbacks
