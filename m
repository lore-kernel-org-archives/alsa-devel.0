From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
Date: Wed, 1 Aug 2018 09:57:27 +0100
Message-ID: <d31d8f54-18b0-118f-eb25-7b92d5bf9842@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
 <20180731204536.GA7241@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731204536.GA7241@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: lee.jones@linaro.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 31/07/18 21:45, Rob Herring wrote:
> On Fri, Jul 27, 2018 at 01:17:59PM +0100, Srinivas Kandagatla wrote:
>> WCD9335 supports two lines of irqs INTR1 and INTR2.
>> Multiple interrupts are muxed via these lines.
>> INTR1 consists of all possible interrupt sources like:
>> Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA
>> INTR2 is a subset of first interrupt sources like MAD, VBAT, and SVA
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/mfd/Makefile                |   2 +-
>>   drivers/mfd/wcd9335-core.c          |   9 ++
>>   drivers/mfd/wcd9335-irq.c           | 172 ++++++++++++++++++++++++++++++++++++
>>   include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
> 
> I'm confused why these are defined here. The binding for the wc9335 is
> not an interrupt-controller.

I can move this defines to include/linux/mfd/wcd9335/wcd9335.h as there 
are no active users for this, but I  was hoping that these can be used 
in DT in future.

WCD9335 is an interrupt controller too. It muxes multiple interrupts via 
a gpio line interrupt.

I did mention this in the bindings.

+- interrupt-controller:
+	Usage: required
+	Definition: Indicating that this is a interrupt controller
+
+- #interrupt-cells:
+	Usage: required
+	Value type: <int>
+	Definition: should be 1
+

> 
>>   include/linux/mfd/wcd9335/wcd9335.h |   3 +
>>   5 files changed, 228 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/mfd/wcd9335-irq.c
>>   create mode 100644 include/dt-bindings/mfd/wcd9335.h


Thanks,
srini
