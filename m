From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v2 13/14] ARM: dts: sun6i: hummingbird:
 Enable internal audio codec
Date: Fri, 4 Nov 2016 16:12:11 +0800
Message-ID: <CAGb2v67N3G8+MC4iKFSg=fumLVv9hnswPXLEfBGHvADdVbdAGA@mail.gmail.com>
References: <20161103075556.29018-1-wens@csie.org> <20161103075556.29018-14-wens@csie.org>
 <20161103084543.m4zvwhscpaa3y5ay@lukather>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBB5MF6HAAKGQEDNIKTIQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161103084543.m4zvwhscpaa3y5ay@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 3, 2016 at 4:45 PM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Thu, Nov 03, 2016 at 03:55:55PM +0800, Chen-Yu Tsai wrote:
>> The Hummingbird A31 has headset and line in audio jacks and an onboard
>> mic routed to the pins for the SoC's internal codec. The line out pins
>> are routed to an onboard speaker amp, whose output is available on a
>> pin header.
>>
>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> index 9a74637f677f..48c041b75aab 100644
>> --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> @@ -69,6 +69,19 @@
>>       };
>>  };
>>
>> +&codec {
>> +     allwinner,audio-routing =
>> +             "Headphone", "HP",
>> +             "Speaker", "LINEOUT",
>> +             "LINEIN", "Line In",
>> +             "MIC1", "Mic",
>> +             "MIC2", "Headset Mic",
>> +             "Mic",  "MBIAS",
>> +             "Headset Mic", "HBIAS";
>> +     allwinner,pa-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
>> +     status = "okay";
>> +};
>> +
>>  &cpu0 {
>>       cpu-supply = <&reg_dcdc3>;
>>  };
>> @@ -152,6 +165,13 @@
>>  };
>>
>>  &pio {
>> +     codec_pa_pin: codec_pa_pin@0 {
>> +             allwinner,pins = "PH22";
>> +             allwinner,function = "gpio_out";
>> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +     };
>> +
>
> This pin group isn't used anywhere. Because of the strict thing in
> pinctrl, I'd say it's better to not set it, but then, the pin group is
> useless.

I'll drop the pinmux setting then.

ChenYu
