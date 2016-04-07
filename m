From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 6/6] ARM: DTS: da850: Add McBSP0 and McBSP1
Date: Thu, 7 Apr 2016 16:04:47 +0300
Message-ID: <57065AEF.9080002@ti.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-7-git-send-email-petr@barix.com> <570645B4.6060606@ti.com>
 <57064F8B.3020501@barix.com> <5706567B.5000501@ti.com>
 <570658BF.9010802@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EEFE266559
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 15:04:55 +0200 (CEST)
In-Reply-To: <570658BF.9010802@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 04/07/16 15:55, Petr Kulhavy wrote:
> =

> =

> On 07.04.2016 14:45, Peter Ujfalusi wrote:
>> On 04/07/16 15:16, Petr Kulhavy wrote:
>>> On 07.04.2016 13:34, Peter Ujfalusi wrote:
>>>> On 04/06/16 16:21, Petr Kulhavy wrote:
>>>>> Add SoC nodes for McBSP0 and McBSP1 as well as the corresponding pinm=
ux
>>>>> configurations.
>>>>>
>>>>> Signed-off-by: Petr Kulhavy <petr@barix.com>
>>>>> ---
>>>>>    arch/arm/boot/dts/da850.dtsi | 45
>>>>> +++++++++++++++++++++++++++++++++++++++++++-
>>>>>    1 file changed, 44 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.d=
tsi
>>>>> index 5996e765e59c..9e2b1e97377c 100644
>>>>> --- a/arch/arm/boot/dts/da850.dtsi
>>>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>>>> @@ -148,7 +148,24 @@
>>>>>                        0xc 0x88888888 0xffffffff
>>>>>                    >;
>>>>>                };
>>>>> -
>>>>> +            mcbsp0_pins: pinmux_mcbsp0_pins {
>>>>> +                pinctrl-single,bits =3D <
>>>>> +                    /* PINMUX2:
>>>>> +                    * CLKS0, DX0, DR0, FSX0
>>>>> +                    * FSR0, CLKX0, CLKR0
>>>>> +                    */
>>>>> +                    0x8 0x02222220 0xfffffff0
>>>>> +                >;
>>>>> +            };
>>>>> +            mcbsp1_pins: pinmux_mcbsp1_pins {
>>>>> +                pinctrl-single,bits =3D <
>>>>> +                    /* PINMUX1:
>>>>> +                    * CLKS1, DX1, DR1, FSX1,
>>>>> +                    * FSR1, CLKX1, CLKR1
>>>>> +                    */
>>>>> +                    0x4 0x22222220 0xfffffff0
>>>> This will conflict with the mcasp0_pins in da850-evm as AXR11 and AXR1=
2 is
>>>> used by the board for audio. When I say conflict, I mean that audio wi=
ll be
>>>> completely broken on the board.
>>> I agree with you, the EVM uses the pins for other peripherals. However I
>>> understand that the da850.dtsi is a generic description of the DA850 pl=
atform.
>>> Other DA850 based designs that use the McBSP will not have conflicts. F=
or
>>> instance my two AM1808 based boards don't use the McASP.
>>> Of course the board's DTS must enable only non-conflicting peripherals/=
pinmux
>>> configurations.
>>> But having the pinmuxes defined does not break anything and actually he=
lps
>>> creating the DTS file.
>> I think what the da850.dtsi does is wrong. The dtsi file should not set =
any
>> pinmux, those need to be set by the board .dts files If one board uses M=
cASP0,
>> it will set up the pins for that and leave McBSP pins as they were, but =
other
>> board might use McBSP1 and not use McASP0, there you will have pincontro=
l for
>> McBSP1.
> It does not set the pinmux, it just defines the configurations.
> As far as I understand the pin configuration is applied when a node inclu=
des
> these two lines:
> =

>                         pinctrl-names =3D "default";
>                         pinctrl-0 =3D <&mcbspc0_pins>;

Yeah, true. just ignore my comment for the pinctrl part...

> =

> Petr
> =



-- =

P=E9ter
