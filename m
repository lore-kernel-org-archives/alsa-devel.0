From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next v2 1/9] arm64: r8a7795: add dma request number
 for busif0 ~ busif7
Date: Thu, 4 Oct 2018 12:15:43 +0900
Message-ID: <bd6eb187-8064-97f5-fe87-fc68f0cc1190@mentor.com>
References: <20181003085855.4305-1-jiada_wang@mentor.com>
 <20181003085855.4305-2-jiada_wang@mentor.com>
 <87y3bepmgb.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3bepmgb.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san


On 2018/10/04 9:55, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your patch
>
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> This patch adds dma request number for busif0 ~ busif7
>> to be used by GEN3 series. GEN2 continues to use rxu/txu
>> for busif data transfer.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 164 ++++++++++++++++++++---
>>   1 file changed, 144 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> index b5f2273caca4..fc6100eddfed 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> @@ -1923,53 +1923,177 @@
>>   			rcar_sound,ssi {
>>   				ssi0: ssi-0 {
>>   					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
>> -					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
>> -					dma-names = "rx", "tx", "rxu", "txu";
>> +					dmas = <&audma0 0x01>, <&audma1 0x02>,
>> +					       <&audma0 0x15>, <&audma1 0x16>,
>> +					       <&audma0 0x15>, <&audma1 0x16>,
>> +					       <&audma0 0x35>, <&audma1 0x36>,
>> +					       <&audma0 0x37>, <&audma1 0x38>,
>> +					       <&audma0 0x47>, <&audma1 0x48>,
>> +					       <&audma0 0x3f>, <&audma1 0x40>,
>> +					       <&audma0 0x43>, <&audma1 0x44>,
>> +					       <&audma0 0x4f>, <&audma1 0x50>,
>> +					       <&audma0 0x53>, <&audma1 0x54>;
>> +					dma-names = "rx", "tx",
>> +						    "rxu", "txu",
>> +						    "rxu0", "txu0",
>> +						    "rxu1", "txu1",
>> +						    "rxu2", "txu2",
>> +						    "rxu3", "txu3",
>> +						    "rxu4", "txu4",
>> +						    "rxu5", "txu5",
>> +						    "rxu6", "txu6",
>> +						    "rxu7", "txu7";
> In theory, I think DT side patch should be posted/applied
> if driver side patch was accepted.
> And, Gen3 side DT doesn't need "rxu/txu" I think.
OK, I will separate DT and driver side change,
will remove DT change in next version.


Thanks,
Jiada
