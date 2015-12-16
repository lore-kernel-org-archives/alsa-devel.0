From: Petr Kulhavy <petr@barix.com>
Subject: Re: DT soundcard driver with special clock routing
Date: Wed, 16 Dec 2015 07:54:19 +0000
Message-ID: <567118AB.5060302@barix.com>
References: <5669A8DE.7060702@barix.com> <5669B2BD.6010100@samsung.com>
 <566EA8B1.2020908@barix.com> <566EB5FD.2000803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 22CD426517F
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 08:54:24 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id n186so197946969wmn.1
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 23:54:24 -0800 (PST)
In-Reply-To: <566EB5FD.2000803@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Sylwester,

Currently I'm struggling with the clocks on the DaVinci platform as the 
clock tree is defined in the platform driver and not in DT.
Is there a way to reference the clocks by names from DT, or does the 
DaVinci clock driver need to be rewritten for DT support?

There is one more thing I came across using the simple soundcard driver. 
The codec needs to be set to generate the clock via PLL.
Unfortunately the simple soundcard always passes clock ID 0 to 
snd_soc_dai_set_sysclk() - I need a different value for the internal PLL.

What is the preferred approach here? On one hand the simple soundcard 
driver could be extended with a DT parameter "clock ID".
Or does a dedicated soundcard driver need to be written?

Thanks
Petr

On 14.12.2015 13:28, Sylwester Nawrocki wrote:
> Yes, you need the clock provider somewhere. In my case it was the I2S 
> driver that registered a clock provider. Probably you can add your 
> output clock provider to your SoC's main clock controller driver, and 
> perhaps use pinctrl API for the pin function mux setup. You can place 
> assigned-clock* DT properties in the clock provider node and the PLL's 
> will be configured by the kernel's clk subsystem. Grep for 
> of_clk_set_defaults or see last chapter of 
> Documentation/devicetree/bindings/clock/clock-bindings.txt. 
