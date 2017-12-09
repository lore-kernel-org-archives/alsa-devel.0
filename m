From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 9/9] arm64: dts: allwinner: a64: Enable
 sound on Pine64 and SoPine
Date: Sat, 9 Dec 2017 11:54:56 -0800
Message-ID: <CA+E=qVepqg-_vqvKcUNaxyhds17xKZoJkoMm25R2AmmC==-HRg@mail.gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-10-anarsoul@gmail.com>
 <CAGb2v65XC=0zwYu3Wjv0OcYrHfLbycBfaA4eW=HNN_8CzmcvRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98F8E266E4B
 for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2017 20:55:20 +0100 (CET)
Received: by mail-ot0-f193.google.com with SMTP id h9so11793189oti.0
 for <alsa-devel@alsa-project.org>; Sat, 09 Dec 2017 11:55:20 -0800 (PST)
In-Reply-To: <CAGb2v65XC=0zwYu3Wjv0OcYrHfLbycBfaA4eW=HNN_8CzmcvRA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 4, 2017 at 7:24 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Mon, Dec 4, 2017 at 4:41 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>> This commit enables I2S, digital and analog parts of audiocodec on
>> Pine64 and SoPine boards.
>>
>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts      | 16 ++++++++++++++++
>>  .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts   | 16 ++++++++++++++++
>>  2 files changed, 32 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> index 806442d3e846..369d9b749521 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> @@ -64,6 +64,18 @@
>>         };
>>  };
>>
>> +&codec {
>> +       status = "okay";
>> +};
>> +
>> +&codec_analog {
>> +       status = "okay";
>> +};
>> +
>> +&dai {
>> +       status = "okay";
>> +};
>> +
>>  &ehci0 {
>>         status = "okay";
>>  };
>> @@ -229,6 +241,10 @@
>>         regulator-name = "vcc-rtc";
>>  };
>>
>> +&sound {
>> +       status = "okay";
>
> This is missing all the board level widgets and routing.
> Yes I know that it works right now, but that's because simple-card
> isn't a strict card, i.e. it doesn't force the need for actual inputs
> and outputs at both ends of the DAPM graph.
>
> Later on you'll find that missing the routing leaves the microphone
> unusable, because the microphone bias is not turned on.

sun8i-codec driver doesn't support capture at the moment. What else it
could be missing?

>
> ChenYu
>
>> +};
>> +
>>  /* On Exp and Euler connectors */
>>  &uart0 {
>>         pinctrl-names = "default";
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
>> index 0eb2acedf8c3..9de5ddcc3656 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
>> @@ -69,6 +69,18 @@
>>         };
>>  };
>>
>> +&codec {
>> +       status = "okay";
>> +};
>> +
>> +&codec_analog {
>> +       status = "okay";
>> +};
>> +
>> +&dai {
>> +       status = "okay";
>> +};
>> +
>>  &ehci0 {
>>         status = "okay";
>>  };
>> @@ -133,6 +145,10 @@
>>         regulator-name = "vcc-wifi";
>>  };
>>
>> +&sound {
>> +       status = "okay";
>> +};
>> +
>>  &uart0 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&uart0_pins_a>;
>> --
>> 2.15.0
>>
