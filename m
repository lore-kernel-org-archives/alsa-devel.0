From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
Date: Wed, 6 Sep 2017 10:44:48 +0200
Message-ID: <62c203f0-4718-fc32-9054-771f265e3ef0@denx.de>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
 <CAOMZO5BpEo2+kSrzkM90xS-h6i5Ozy8Wr2tn0pmhsXnY0x6Lrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5BpEo2+kSrzkM90xS-h6i5Ozy8Wr2tn0pmhsXnY0x6Lrg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

> On Tue, Sep 5, 2017 at 6:13 PM, Łukasz Majewski <lukma@denx.de> wrote:
> 
>> &i2c1 {
>>          clock-frequency = <400000>;
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&pinctrl_i2c1>;
>>          status = "okay";
>>
>>          codec: tfa9879@6C {
>>                  #sound-dai-cells = <0>;
>>                  compatible = "tfa9879";
> 
> This codec seems to miss device tree support. Don't you need something
> like this?
> 
> --- a/sound/soc/codecs/tfa9879.c
> +++ b/sound/soc/codecs/tfa9879.c
> @@ -312,9 +312,15 @@ static const struct i2c_device_id tfa9879_i2c_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, tfa9879_i2c_id);
> 
> +static const struct of_device_id tfa9879_of_match[] = {
> +       { .compatible = "nxp,tfa9879", },
> +       { }
> +};
> +
>   static struct i2c_driver tfa9879_i2c_driver = {
>          .driver = {
>                  .name = "tfa9879",
> +               .of_match_table = tfa9879_of_match,
>          },
>          .probe = tfa9879_i2c_probe,
>          .remove = tfa9879_i2c_remove,
> 


Maybe it should be added, but the driver is probed via I2C "node" in dts.

I took the codec (tfa9879) driver as-is.


-- 
Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
