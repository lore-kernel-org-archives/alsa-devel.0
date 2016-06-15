From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 1/2] ASoC: msm8916: Add codec Device Tree bindings.
Date: Wed, 15 Jun 2016 10:16:12 +0100
Message-ID: <57611CDC.3040508@linaro.org>
References: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1465582725-30183-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160614152318.GR2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160614152318.GR2282@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for review comments,

On 14/06/16 16:23, Mark Brown wrote:
> On Fri, Jun 10, 2016 at 07:18:44PM +0100, Srinivas Kandagatla wrote:
>
>> +Codec IP is divided into two parts, first analog which is integrated in pmic pm8916
>> +and secondly digital part which is integrated into application processor. Codec register
>> +controls are also split across pmic an lpass. Analog part is controlled via spmi bus to pmic.
>
> Please keep things wrapped at less than 80 columns.
Yep, will fix it in next version.
>
>> + - interrupt-parent : The parent interrupt controller.
>> + - interrupts: List of interrupts in given SPMI peripheral.
>> + - interrupt-names: Names specified to above list of interrupts in same
>> +		    order. List of supported interrupt names are:
>> +  "spk_cnp_int" - Speaker click and pop interrupt
>
> Please format this more clearly so these don't look like properties,
> more indentation would be good.
Ok, will do it in next version.
>
>> + - vddio-supply: phandle to VDD_CDC_IO regulator device tree node.
>> + - vdd-tx-rx-supply: phandle to VDD_CDC_TX/RX/CX regulator device tree node.
>
> You should name the supplies with the same name as the datasheet uses.
>
Yep, I will rename them to match the hw specs.

thanks,
srini
