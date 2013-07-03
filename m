From: Bo Shen <bard.shen@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: atmel_ssc_dai: move set dma data
 to startup callback
Date: Wed, 03 Jul 2013 13:22:53 +0800
Message-ID: <51D3B52D.5020304@gmail.com>
References: <1372755849-19546-1-git-send-email-voice.shen@atmel.com> <1372755849-19546-2-git-send-email-voice.shen@atmel.com> <51D2F0FA.6040409@metafoo.de> <51D37C59.3090306@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <51D37C59.3090306@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, richard.genoud@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On 7/3/2013 09:20, Bo Shen wrote:
> Hi Lars-Peter,
>
> On 7/2/2013 23:25, Lars-Peter Clausen wrote:
>> On 07/02/2013 11:04 AM, Bo Shen wrote:
>> [...]
>>> +    dma_params->substream = substream;
>>
>> Unrelated to this patch, but having a substream field in the
>> dma_params seems
>> to be redundant, since you need to know the substream to get the
>> dma_params in
>> the first place. Looking at the code it also seems to be unused other
>> than this
>> assignment. Maybe you can send a follow up patch to remove it.
>>
>> [...]
>>
>
> Yes, this is redundant. I will remove it in next version patches.

Sorry for mistake, this substream parameter need by the interrupt for 
PDC transfer, so, I will keep it.

Best Regards,
Bo Shen

