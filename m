From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: DT soundcard driver with special clock routing
Date: Wed, 23 Dec 2015 13:43:01 +0100
Message-ID: <567A96D5.5080803@samsung.com>
References: <5669A8DE.7060702@barix.com> <5669B2BD.6010100@samsung.com>
 <566EA8B1.2020908@barix.com> <566EB5FD.2000803@samsung.com>
 <567118AB.5060302@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 36FD8265888
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 13:45:16 +0100 (CET)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NZT00K8GA38YP20@mailout2.w1.samsung.com> for
 alsa-devel@alsa-project.org; Wed, 23 Dec 2015 12:45:08 +0000 (GMT)
In-reply-to: <567118AB.5060302@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

(Adding ASoC maintainer at Cc).

On 16/12/15 08:54, Petr Kulhavy wrote:
> Currently I'm struggling with the clocks on the DaVinci platform as the 
> clock tree is defined in the platform driver and not in DT.
> Is there a way to reference the clocks by names from DT, or does the 
> DaVinci clock driver need to be rewritten for DT support?

I don't think so, you need a clock provider to reference clocks in DT.
You may want to ask such question on linux-arm-kernel@lists.infradead.org
mailing list and Cc relevant maintainer(s).

> There is one more thing I came across using the simple soundcard driver. 
> The codec needs to be set to generate the clock via PLL.
> Unfortunately the simple soundcard always passes clock ID 0 to 
> snd_soc_dai_set_sysclk() - I need a different value for the internal PLL.
>
> What is the preferred approach here? On one hand the simple soundcard 
> driver could be extended with a DT parameter "clock ID".
> Or does a dedicated soundcard driver need to be written?

I'm not sure what is the preference here, I guess a dedicated soundcard
driver could be a way to go in your case.

> On 14.12.2015 13:28, Sylwester Nawrocki wrote:
>> Yes, you need the clock provider somewhere. In my case it was the I2S 
>> driver that registered a clock provider. Probably you can add your 
>> output clock provider to your SoC's main clock controller driver, and 
>> perhaps use pinctrl API for the pin function mux setup. You can place 
>> assigned-clock* DT properties in the clock provider node and the PLL's 
>> will be configured by the kernel's clk subsystem. Grep for 
>> of_clk_set_defaults or see last chapter of 
>> Documentation/devicetree/bindings/clock/clock-bindings.txt. 

-- 
Regards,
Sylwester
