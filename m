From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Audio play problem with tlv320aic3106 in mainline.
Date: Mon, 1 Jun 2015 15:10:23 +0300
Message-ID: <556C4BAF.900@ti.com>
References: <CAFqH_5332TNp+3cTH6O-UgqP8Ah-ZUiZpaTJpy3ZoL4-42fo_g@mail.gmail.com>	<5568133A.6010006@ti.com>	<CAFqH_511rLmDPEBLmXou6_iqNTj9t2uFNVvaW=+RmpumM9GmyA@mail.gmail.com>	<556858AD.1030609@ti.com>
 <CAFqH_527Ttu5wAVJ2ZtXZH0yMAg3J0YSGWdV_nvX6Ao0ub80cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 76A66260492
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 14:10:31 +0200 (CEST)
In-Reply-To: <CAFqH_527Ttu5wAVJ2ZtXZH0yMAg3J0YSGWdV_nvX6Ao0ub80cg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 06/01/2015 12:16 PM, Enric Balletbo Serra wrote:
> Hi,
> =

> 2015-05-29 14:16 GMT+02:00 Peter Ujfalusi <peter.ujfalusi@ti.com>:
>> On 05/29/2015 12:24 PM, Enric Balletbo Serra wrote:
>>>> It might be really 24MHz.
>>>> If the MCLK in your board is wired like am335x-evmsk or how BeagleBone=
's audio
>>>> capes are wired (MCLK is coming from AM335x's EVENT_INTR0/1 pin as CLK=
OUT1/2)
>>>> then 24MHz is correct. On the am335x-evm there is a dedicated crystal
>>>> providing the 12MHz.
>>>>
>>> Well, in my board there is also a dedicated crystal providing the
>>> 12MHz, so I expect that the correct value for clock-frequency is 12MHz
>>> not 24MHz.
>>
>> I was wrong with the BBW audio cape.. At least the RevA which I have doe=
s have
>> 12MHz crystal connected to aic3106 MCLK, but there is a line to the SoC's
>> CLKOUT2. By default the codec runs using the 12MHz.
>> I have checked with a scope and yep, I have 12MHz for MCLK.
>>
>>>
>>>     clocks {
>>>         compatible =3D "simple-bus";
>>>         #address-cells =3D <1>;
>>>         #size-cells =3D <0>;
>>>
>>>         /* audio external oscillator */
>>>         tlv320aic3x_mclk: oscillator@0 {
>>>             compatible =3D "fixed-clock";
>>>             #clock-cells =3D <0>;
>>>             clock-frequency  =3D <12000000>;    /* 12MHz */
>>>         };
>>>     };
>>>
>>>     sound {
>>>         compatible =3D "ti,da830-evm-audio";
>>>         ti,model =3D "AM335x-SL50";
>>>         ti,audio-codec =3D <&audio_codec>;
>>>         ti,mcasp-controller =3D <&mcasp0>;
>>>
>>>         clocks =3D <&tlv320aic3x_mclk>;
>>>         clock-names =3D "mclk";
>>>
>>>         ti,audio-routing =3D
>>>             "Headphone Jack",    "HPLOUT",
>>>             "Headphone Jack",    "HPROUT",
>>>             "LINE1R",               "Line In",
>>>             "LINE1L",        "Line In";
>>>     };
>>
>> If I use this with my BBW+Audio cape: audio is fine.
>>
> =

> Tested with linux-next and same problem here, I also checked with a
> scope my clock and it's 12MHz but I need to apply this patch to make
> it work.
> =

> diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-=
evm.c
> index 731fb0d..8ce0d32 100644
> --- a/sound/soc/davinci/davinci-evm.c
> +++ b/sound/soc/davinci/davinci-evm.c
> @@ -64,6 +64,11 @@ static int evm_hw_params(struct snd_pcm_substream *sub=
stream,
>         unsigned sysclk =3D ((struct snd_soc_card_drvdata_davinci *)
>                            snd_soc_card_get_drvdata(soc_card))->sysclk;
> =

> +    ret =3D snd_soc_dai_set_clkdiv(cpu_dai, 0, 2);
> +    if (ret < 0)
> +            return ret;

This does not make sense... McASP is supposed to be slave when used with
compatible =3D "ti,da830-evm-audio"
This means that the reference clock is coming from internal source and AHCL=
KX
pin is output.
Setting the divider for the high-frequency clock should not be needed since
the McASP is not generating any of the clocks.

BTW: I see that in the DTS you are configuring the mcasp0.ahclkx pin. How t=
his
is used?
While we are here, you can change the AXR2 pinmux to output.

I have 'cloned' your setup on my BBW+AudioCape where I also have 12MHz MCLK=
. I
don't have any problem with the playback speed.

-- =

P=E9ter
