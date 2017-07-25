From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v3 3/9] clk: at91: add audio pll clock drivers
Date: Tue, 25 Jul 2017 13:30:29 +0200
Message-ID: <5f6fd25b-8f99-8dec-39b6-0e7677675c24@free-electrons.com>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
 <20170713074927.10882-4-quentin.schulz@free-electrons.com>
 <20170721222029.GO19878@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170721222029.GO19878@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: mark.rutland@arm.com, boris.brezillon@free-electrons.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, linux-clk@vger.kernel.org, lgirdwood@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, broonie@kernel.org, cyrille.pitchen@wedev4u.fr, linux@armlinux.org.uk, perex@perex.cz, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Stephen,

I forgot to answer one of your questions:

On 22/07/2017 00:20, Stephen Boyd wrote:
> On 07/13, Quentin Schulz wrote:
>> diff --git a/drivers/clk/at91/clk-audio-pll-pad.c b/drivers/clk/at91/clk-audio-pll-pad.c
>> new file mode 100644
>> index 000000000000..10dd6d625696
>> --- /dev/null
>> +++ b/drivers/clk/at91/clk-audio-pll-pad.c
[...]
>> +}
>> +
>> +CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pad_setup,
>> +	       "atmel,sama5d2-clk-audio-pll-pad",
>> +	       of_sama5d2_clk_audio_pll_pad_setup);
> 
> We can't have a device driver for this?
> 

I tried to work on that but the device does not get probed because the
parent node (pmc) does not register its children. We would need to
modify the DT to add such a support and break DT compat.

As we are speaking about getting rid of clk subnodes (c.f. Rob and
Alexandre answers on the first version of this patch series:
https://patchwork.kernel.org/patch/9805991/) in favor of a clock
controller node that would break the DT compat as well, IMHO it would be
best to break the DT compat as few times as possible and thus, rework
this driver once we switch to a clock controller node.

Thanks,
Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
