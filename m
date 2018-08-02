From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
Date: Thu, 2 Aug 2018 08:34:55 +0100
Message-ID: <292fb788-fa5a-8106-efbb-e1fa825f5697@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
 <20180731204536.GA7241@rob-hp-laptop>
 <d31d8f54-18b0-118f-eb25-7b92d5bf9842@linaro.org>
 <CAL_JsqJqCvWBqCfiS7dQMSzJ_FZDtAMJ8OQZvdGSJhsX0eYr6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJqCvWBqCfiS7dQMSzJ_FZDtAMJ8OQZvdGSJhsX0eYr6w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Banajit Goswami <bgoswami@codeaurora.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vinod <vkoul@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks for review,

On 01/08/18 23:17, Rob Herring wrote:
> On Wed, Aug 1, 2018 at 2:57 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> Thanks for the review,
>>
>> On 31/07/18 21:45, Rob Herring wrote:
>>> On Fri, Jul 27, 2018 at 01:17:59PM +0100, Srinivas Kandagatla wrote:
>>>> WCD9335 supports two lines of irqs INTR1 and INTR2.
>>>> Multiple interrupts are muxed via these lines.
>>>> INTR1 consists of all possible interrupt sources like:
>>>> Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA
>>>> INTR2 is a subset of first interrupt sources like MAD, VBAT, and SVA
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>    drivers/mfd/Makefile                |   2 +-
>>>>    drivers/mfd/wcd9335-core.c          |   9 ++
>>>>    drivers/mfd/wcd9335-irq.c           | 172 ++++++++++++++++++++++++++++++++++++
>>>>    include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
>>>
>>> I'm confused why these are defined here. The binding for the wc9335 is
>>> not an interrupt-controller.
>>
>> I can move this defines to include/linux/mfd/wcd9335/wcd9335.h as there
>> are no active users for this, but I  was hoping that these can be used
>> in DT in future.
>>
>> WCD9335 is an interrupt controller too. It muxes multiple interrupts via
>> a gpio line interrupt.
>>
>> I did mention this in the bindings.
> 
> Then the header belongs in the binding patch.
> 
> I don't recall child nodes being defined though and you don't need to
> be a interrupt-controller (in DT) without them.

Sure, I will fix it in next version.

Thanks,
srini
> 
> Rob
> 
