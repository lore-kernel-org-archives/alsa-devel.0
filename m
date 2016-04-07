From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 6/6] ARM: DTS: da850: Add McBSP0 and McBSP1
Date: Thu, 7 Apr 2016 14:55:27 +0200
Message-ID: <570658BF.9010802@barix.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-7-git-send-email-petr@barix.com> <570645B4.6060606@ti.com>
 <57064F8B.3020501@barix.com> <5706567B.5000501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5706567B.5000501-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 07.04.2016 14:45, Peter Ujfalusi wrote:
> On 04/07/16 15:16, Petr Kulhavy wrote:
>> On 07.04.2016 13:34, Peter Ujfalusi wrote:
>>> On 04/06/16 16:21, Petr Kulhavy wrote:
>>>> Add SoC nodes for McBSP0 and McBSP1 as well as the corresponding pinmux
>>>> configurations.
>>>>
>>>> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>>    arch/arm/boot/dts/da850.dtsi | 45
>>>> +++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 44 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>>>> index 5996e765e59c..9e2b1e97377c 100644
>>>> --- a/arch/arm/boot/dts/da850.dtsi
>>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>>> @@ -148,7 +148,24 @@
>>>>                        0xc 0x88888888 0xffffffff
>>>>                    >;
>>>>                };
>>>> -
>>>> +            mcbsp0_pins: pinmux_mcbsp0_pins {
>>>> +                pinctrl-single,bits = <
>>>> +                    /* PINMUX2:
>>>> +                    * CLKS0, DX0, DR0, FSX0
>>>> +                    * FSR0, CLKX0, CLKR0
>>>> +                    */
>>>> +                    0x8 0x02222220 0xfffffff0
>>>> +                >;
>>>> +            };
>>>> +            mcbsp1_pins: pinmux_mcbsp1_pins {
>>>> +                pinctrl-single,bits = <
>>>> +                    /* PINMUX1:
>>>> +                    * CLKS1, DX1, DR1, FSX1,
>>>> +                    * FSR1, CLKX1, CLKR1
>>>> +                    */
>>>> +                    0x4 0x22222220 0xfffffff0
>>> This will conflict with the mcasp0_pins in da850-evm as AXR11 and AXR12 is
>>> used by the board for audio. When I say conflict, I mean that audio will be
>>> completely broken on the board.
>> I agree with you, the EVM uses the pins for other peripherals. However I
>> understand that the da850.dtsi is a generic description of the DA850 platform.
>> Other DA850 based designs that use the McBSP will not have conflicts. For
>> instance my two AM1808 based boards don't use the McASP.
>> Of course the board's DTS must enable only non-conflicting peripherals/pinmux
>> configurations.
>> But having the pinmuxes defined does not break anything and actually helps
>> creating the DTS file.
> I think what the da850.dtsi does is wrong. The dtsi file should not set any
> pinmux, those need to be set by the board .dts files If one board uses McASP0,
> it will set up the pins for that and leave McBSP pins as they were, but other
> board might use McBSP1 and not use McASP0, there you will have pincontrol for
> McBSP1.
It does not set the pinmux, it just defines the configurations.
As far as I understand the pin configuration is applied when a node 
includes these two lines:

                         pinctrl-names = "default";
                         pinctrl-0 = <&mcbspc0_pins>;

Petr

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
