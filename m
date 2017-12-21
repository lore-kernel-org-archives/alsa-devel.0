From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v1 1/1] ASoC: rsnd: ssi: Fix issue in dma data address
 assignment
Date: Thu, 21 Dec 2017 01:16:39 -0800
Message-ID: <5A3B7BF7.7060400@mentor.com>
References: <1513832314-29727-1-git-send-email-jiada_wang@mentor.com> <87k1xgbnfz.wl%kuninori.morimoto.gx@renesas.com> <5A3B5EFE.8070606@mentor.com> <87ind0bkte.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ind0bkte.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san

On 12/20/2017 11:39 PM, Kuninori Morimoto wrote:
> Hi Jiada
>
>> diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
>> b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
>> index a298df7..16f3214 100644
>> --- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
>> @@ -94,14 +94,24 @@
>>          };
>>
>>          rsnd_ak4613: sound {
>> -               compatible = "simple-audio-card";
>> +               compatible = "simple-scu-audio-card";
>>
>>                  simple-audio-card,format = "left_j";
>>                  simple-audio-card,bitclock-master =<&sndcpu>;
>>                  simple-audio-card,frame-master =<&sndcpu>;
>>
>> -               sndcpu: simple-audio-card,cpu {
>> -                       sound-dai =<&rcar_sound>;
>> +               simple-audio-card,prefix = "ak4613";
>> +                simple-audio-card,routing =
>> +                        "ak4613 Playback", "DAI0 Playback",
>> +                        "DAI0 Capture", "ak4613 Capture",
>> +                        "ak4613 Playback", "DAI1 Playback";
>> +
>> +               sndcpu: simple-audio-card,cpu@0 {
>> +                       sound-dai =<&rcar_sound 0>;
>> +               };
>> +
>> +               simple-audio-card,cpu@1 {
>> +                       sound-dai =<&rcar_sound 1>;
>>                  };
>>
>>                  sndcodec: simple-audio-card,codec {
>> @@ -517,7 +527,7 @@
>>          pinctrl-names = "default";
>>
>>          /* Single DAI */
>> -       #sound-dai-cells =<0>;
>> +       #sound-dai-cells =<1>;
>>
>>          /* audio_clkout0/1/2/3 */
>>   #clock-cells =<1>;
>> @@ -549,6 +559,9 @@
>>                          playback =<&ssi0&src0&dvc0>;
>>                          capture  =<&ssi1&src1&dvc1>;
>>                  };
>> +               dai1 {
>> +                       playback =<&ssi0>;
>> +               };
>>          };
>>   };
>>
>> playing with dai1 will have issue.
> I guess so because you are using strange settings...
> What do you want to do ?
this is just an example setting to reproduce the issue with current 
mainline kernel,

We have enabled TDM Split and Ex-Split mode in our kernel,
and SSI(U)'s dma address diffs based on the BUSIF it is using,
so have a single dma data struct per rsnd_ssi will cause issue when
SSI isn't working with BUSIF0.

Do you have any suggestion to address this issue?


Thanks,
Jiada
> Best regards
> ---
> Kuninori Morimoto
