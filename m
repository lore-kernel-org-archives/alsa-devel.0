From: Luis Alberto Sanchez <luisalbertosanchez3@gmail.com>
Subject: Re: [RFC v2 PATCH] ASoC: wm8904: add CCF support
Date: Tue, 25 Mar 2014 08:09:17 -0400
Message-ID: <CANexs9pLzVMotCqaHkc2_QOGZqgF_zMWgA-G3D6s19ML+mLqxw@mail.gmail.com>
References: <1395741416-23981-1-git-send-email-voice.shen@atmel.com>
 <53316F99.6080709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
 [209.85.213.175])
 by alsa0.perex.cz (Postfix) with ESMTP id F03A0262618
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 13:09:18 +0100 (CET)
Received: by mail-ig0-f175.google.com with SMTP id ur14so10468408igb.2
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 05:09:17 -0700 (PDT)
In-Reply-To: <53316F99.6080709@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Boris BREZILLON <b.brezillon.dev@gmail.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

El mar 25, 2014 7:59 AM, "Boris BREZILLON" <b.brezillon.dev@gmail.com>
escribi=F3:

> Hello Bo,
>
> Le 25/03/2014 10:56, Bo Shen a =E9crit :
>
>> Enable WM8904 to support common clock framework.
>>    - Now it supports use SoC provided clock or external oscillator
>>      as MCLK.
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>>   Documentation/devicetree/bindings/sound/wm8904.txt | 48
>> ++++++++++++++++++++++
>>   sound/soc/codecs/wm8904.c                          | 17 ++++++++
>>   2 files changed, 65 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/wm8904.txt
>> b/Documentation/devicetree/bindings/sound/wm8904.txt
>> new file mode 100644
>> index 0000000..bcf4aa0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/wm8904.txt
>> @@ -0,0 +1,48 @@
>> +WM8904 audio CODEC
>> +
>> +This device supports I2C only.
>> +
>> +Required properties:
>> +  - compatible: "wlf,wm8904"
>> +  - reg: the I2C address of the device.
>> +  - clocks and clock-names: reference to
>> +    <Documentation/devicetree/bindings/clock/clock-bindings.txt>
>> +
>> +Pins on the device (for linking into audio routes):
>> +
>> +  * IN1L
>> +  * IN1R
>> +  * IN2L
>> +  * IN2R
>> +  * IN3L
>> +  * IN3R
>> +  * HPOUTL
>> +  * HPOUTR
>> +  * LINEOUTL
>> +  * LINEOUTR
>> +  * MICBIAS
>> +
>> +Examples:
>> +
>> +1. Using SoC provided clock as mclk:
>> +codec: wm8904@1a {
>> +       compatible =3D "wlf,wm8904";
>> +       reg =3D <0x1a>;
>> +       clocks =3D <&pck0>;
>> +       clock-names =3D "mclk";
>> +};
>>
>
>
>  +
>> +2. Using external oscillator as mclk:
>> +codec: wm8904@1a {
>> +       compatible =3D "wlf,wm8904";
>> +       reg =3D <0x1a>;
>> +
>> +       wm8904_osc {
>> +               compatible =3D "fixed-clock";
>> +               #clock-cells =3D <0>;
>> +               #clock-frequency =3D <12000000>;
>> +       }
>> +
>> +       clocks =3D <&wm8904_osc>;
>> +       clock-names =3D "mclk";
>> +};
>>
>
> I think there is a misunderstanding here (and it certainly comes from my
> explanations during our last talk :)): both cases should be handled the
> same
> way because an external oscillator is no more or less than an external clk
> (we don't care how this clk is generated).
>
> I suggested to put the osc node inside the wm8904 one but I thought you
> were
> trying to represent the internal 12MHz clk generated when using the fll
> free
> running mode.
>
>  diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
>> index 49c35c3..4db6a26 100644
>> --- a/sound/soc/codecs/wm8904.c
>> +++ b/sound/soc/codecs/wm8904.c
>> @@ -11,6 +11,7 @@
>>    * published by the Free Software Foundation.
>>    */
>>   +#include <linux/clk.h>
>>   #include <linux/module.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/init.h>
>> @@ -49,6 +50,7 @@ static const char *wm8904_supply_names[WM8904_NUM_SUPP=
LIES]
>> =3D {
>>   /* codec private data */
>>   struct wm8904_priv {
>>         struct regmap *regmap;
>> +       struct clk *mclk;
>>         enum wm8904_type devtype;
>>   @@ -1828,6 +1830,9 @@ static int wm8904_set_bias_level(struct
>> snd_soc_codec *codec,
>>         switch (level) {
>>         case SND_SOC_BIAS_ON:
>> +               if (IS_ENABLED(CONFIG_COMMON_CLK))
>> +                       if (wm8904->mclk)
>> +                               clk_prepare_enable(wm8904->mclk);
>>                 break;
>>         case SND_SOC_BIAS_PREPARE:
>> @@ -1894,6 +1899,9 @@ static int wm8904_set_bias_level(struct
>> snd_soc_codec *codec,
>>                 regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies),
>>                                        wm8904->supplies);
>> +               if (IS_ENABLED(CONFIG_COMMON_CLK))
>> +                       if (wm8904->mclk)
>> +                               clk_disable_unprepare(wm8904->mclk);
>>                 break;
>>         }
>>         codec->dapm.bias_level =3D level;
>> @@ -2139,6 +2147,15 @@ static int wm8904_i2c_probe(struct i2c_client *i2=
c,
>>                 return ret;
>>         }
>>   +     if (IS_ENABLED(CONFIG_COMMON_CLK)) {
>> +               wm8904->mclk =3D devm_clk_get(&i2c->dev, "mclk");
>> +               if (IS_ERR(wm8904->mclk)) {
>> +                       dev_err(&i2c->dev, "Failed to get MCLK\n");
>> +                       ret =3D PTR_ERR(wm8904->mclk);
>> +                       goto err_enable;
>> +               }
>> +       }
>> +
>>         ret =3D regmap_read(wm8904->regmap, WM8904_SW_RESET_AND_ID, &val=
);
>>         if (ret < 0) {
>>                 dev_err(&i2c->dev, "Failed to read ID register: %d\n",
>> ret);
>>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
