From: Mylene Josserand <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH 08/14] dt-bindings: sound: Add sun8i analog codec
 documentation
Date: Wed, 5 Oct 2016 14:08:54 +0200
Message-ID: <b94e3b11-8edb-a632-f7f1-217a594f310c@free-electrons.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <06ea14939405c3eb0fb9be655d26ee564a04a53d.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004162430.GQ5228@lukather>
 <CAGb2v67gT9j6-NYj04+et2PNHRGFUzhgCnVgX+eoPGybArL60A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAGb2v67gT9j6-NYj04+et2PNHRGFUzhgCnVgX+eoPGybArL60A@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-el>
List-Id: alsa-devel@alsa-project.org

Hello,


On 05/10/2016 04:59, Chen-Yu Tsai wrote:
> On Wed, Oct 5, 2016 at 12:24 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Hi,
>>
>> On Tue, Oct 04, 2016 at 11:46:21AM +0200, Mylène Josserand wrote:
>>> Add the documentation for dt-binding of the analog audiocodec
>>> driver for SUN8I SoC.
>>>
>>> Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
>>> ---
>>>  .../devicetree/bindings/sound/sun8i-codec-analog.txt | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
>>> new file mode 100644
>>> index 0000000..a03ec20
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
>>> @@ -0,0 +1,20 @@
>>> +* Allwinner A23/A33 Analog Codec
>>> +
>>> +This codec must be handled as a PRCM subnode.
>>
>> Like Mark was saying, you should probably reference the sun6i-prcm.txt
>> binding here


Okay, I will explain more how it works.


>>
>>> +Required properties:
>>> +- compatible: must be either "allwinner,sun8i-codec-analog"
>>
>> Our compatible prefix is <family>-<soc>, and using the older SoC that
>> introduced that block.
>>
>> In this case, that would be sun6i-a31, I think?
>
> sun6i-a31s actually, but a31s has extra line out controls,
> so the right one would be sun8i-a23. Both are listed in my
> original driver.


It is noted.

Thanks!


-- 
Mylène Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
