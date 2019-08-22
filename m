From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ALSA: pcm: add support for 352.8KHz and 384KHz sample
 rate
Date: Thu, 22 Aug 2019 10:18:58 +0100
Message-ID: <cd375dcc-f2b8-4953-8099-485f72f426da@linaro.org>
References: <20190821102705.18382-1-srinivas.kandagatla@linaro.org>
 <s5h4l2a76qz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h4l2a76qz.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Vidyakumar Athota <vathota@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Thanks for taking time to review,

On 21/08/2019 18:44, Takashi Iwai wrote:
> On Wed, 21 Aug 2019 12:27:05 +0200,
> Srinivas Kandagatla wrote:
>>
>> From: Vidyakumar Athota <vathota@codeaurora.org>
>>
>> Most of the modern codecs supports 352.8KHz and 384KHz sample rates.
>> Currently HW params fails to set 352.8Kz and 384KHz sample rate
>> as these are not in known rates list.
>> Add these new rates to known list to allow them.
>>
>> This patch also adds defines in pcm.h so that drivers can use it.
>>
>> Signed-off-by: Vidyakumar Athota <vathota@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> As I repeatedly write for this kind of request, please submit always
> with the user of the API, not only the API change itself.
> 
I totally agree with you.

I will respin the patchset with wcd9335 and QDSP6 patches.


thanks,
srini


> 
> thanks,
> 
> Takashi
> 
