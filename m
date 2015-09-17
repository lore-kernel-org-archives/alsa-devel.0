From: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Subject: Re: Multiple codecs on one sound card for
 multi-channel sound card
Date: Thu, 17 Sep 2015 10:51:17 +0200
Message-ID: <55FA7F05.4020001@invoxia.com>
References: <CAG5mAdyL-xH2ZNTtDMhCWW-nAX_GVtRxFS5b5FANFnK64kE65g@mail.gmail.com>
 <CAG5mAdzyQgOmTcAmHrjWRQzuv-ih9p-qXQsYxdTD_Qmr-Fep3A@mail.gmail.com>
 <55F93CF6.50208@invoxia.com>
 <CAG5mAdyeOruLj+Tndda9Efvi3mrFDZK3XkkgWkU067yQH2rs=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 73719265196
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 10:51:22 +0200 (CEST)
Received: by wicfx3 with SMTP id fx3so13969505wic.1
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 01:51:22 -0700 (PDT)
In-Reply-To: <CAG5mAdyeOruLj+Tndda9Efvi3mrFDZK3XkkgWkU067yQH2rs=Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Caleb,

freescale SSI is fine with more than 2 channels.
I have planed to publish a set of patch in this direction but we still =

have some corner cases to fix first (rare issues with channels alignment)

Yet, this following is far enough to have it working.
And since the max/min rate is at the end the intersection of what the =

SSI, the codec and the card are declaring, it will not change anything =

until you connect the SSI to a codec with more than 2 channels, or a =

multi-codec solution.

Arnaud

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c25a1e8..26e980b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1082,14 +1082,14 @@ static struct snd_soc_dai_driver =

fsl_ssi_dai_template =3D {
         .playback =3D {
                 .stream_name =3D "CPU-Playback",
                 .channels_min =3D 1,
-               .channels_max =3D 2,
+               .channels_max =3D 4,
                 .rates =3D FSLSSI_I2S_RATES,
                 .formats =3D FSLSSI_I2S_FORMATS,
         },
         .capture =3D {
                 .stream_name =3D "CPU-Capture",
                 .channels_min =3D 1,
-               .channels_max =3D 2,
+               .channels_max =3D 4,
                 .rates =3D FSLSSI_I2S_RATES,
                 .formats =3D FSLSSI_I2S_FORMATS,
         },


Le 17/09/2015 00:07, Caleb Crome a =E9crit :
> Ah Ha!  thank you Arnaud!  I'll understand this stuff eventually.
> I'll implement as you've shown and see how it goes.
>
> I see that you have 'fsl,imx-audio-foo', using an SSI.  from what I
> can see the SSIs only support channels_max=3D2.  How do you get
> multi-channel TDM to work with the freescale SSI port?  I need to get
> this TDM working on both TI & Freescale, and the freescale has been
> quite problematic because the multi-channel doesn't seem to be
> supported in the driver.
>
> I have just checked out and verified that
>
> http://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/
>
> sound/soc/fsl/*ssi*
>
> all have channels_max =3D 2
>
> We're very motivated to get this working on the freescale MX6, and
> getting it to work sure does not seem as simple as changing 2 to a
> bigger number :-)
>
>
> Thanks,
>    -Caleb
>
>
> On Wed, Sep 16, 2015 at 2:57 AM, arnaud.mouiche@invoxia.com
> <arnaud.mouiche@invoxia.com> wrote:
>> Hello Caleb,
>>
>> Multi-codec support is now working fine the current linux releases.
>> for previous releases, check if commit
>>      [PATCH] ASoC: dapm: Don't add prefix to widget stream name
>> is included. I remember this is the last required patch.
>>
>> After that, I don't know if the "simple-card" can be configured for multi
>> codec support as you wish.
>>
>> On my side, I cooked a particular sound card for the purpose.
>> here is some tips:
>>
>>
>>      struct snd_soc_dai_link_component codecs[2];
>>      struct snd_soc_codec_conf codecs_conf[2];
>> [...]
>>      for (num_codecs=3D0; num_codecs<2; num_codecs++) {
>>          struct device_node *of_node;
>>          of_node =3D of_parse_phandle(pdev->dev.of_node, "audio-codec",
>> num_codecs);
>>          if (!of_node) break;
>>          data->codecs[num_codecs].of_node =3D of_node;
>>          data->codecs[num_codecs].dai_name =3D "tlv320aic3x-foo";
>>
>>          /* add a "C2" name prefix for every control of the 2nd codec */
>>          data->codecs_conf[num_codecs].of_node =3D of_node;
>>          if (num_codecs =3D=3D 1) {
>>              data->codecs_conf[num_codecs].name_prefix =3D "C2";
>>          }
>>      }
>> [...]
>>      data->dai.codecs =3D data->codecs;
>>      data->dai.num_codecs =3D num_codecs;
>>      data->card.dai_link =3D &data->dai;
>>      data->card.codec_conf =3D data->codecs_conf;
>>      data->card.num_configs =3D num_codecs;
>> [...]
>>
>>
>> On DTS side, I have something like
>>
>>      sound@0 {
>>          compatible =3D "fsl,imx-audio-foo";
>>          model =3D "foo-audio";
>>          ssi-controller =3D <&ssi1>;
>>
>>          /*
>>           * list phandles for the 2 codecs used in the same TDM network
>>           */
>>          audio-codec =3D <&codec1>, <&codec2>;
>>
>>          [...]
>>
>>      };
>>
>>
>> You also need to have a particular hw_params() method to dispatch the TDM
>> and sysclk configuration to your codecs, making the difference between y=
our
>> first codec (your bus master) and the others.
>>
>>
>> Arnaud
>>
>>
>> Le 15/09/2015 03:07, Caleb Crome a =E9crit :
>>> (re-sending hope it's not a duplicate -- I think I must have had HTML
>>> in my previous email and it was ignored)
>>>
>>>    Hi all,
>>>       What are the current best practices to specify multiple codecs on
>>> one sound card, with all codecs sharing a single TDM bus?
>>>
>>>    I have a card with up to 32 TLV320AIC33 codecs on it.  For the
>>> moment, we can limit the discussion to only 16 codecs, so we don't
>>> have to get extra serializers involved...
>>>
>>>    I currently have something like this in my am335x-boneblack.dts file:
>>>
>>>    (i.e. attempting to set tdm slot width and num in the i2c codec)
>>>
>>>    but it doesn't seem to be picking up the fact that I want all the
>>> codecs linked together as one.
>>>
>>>    (FYI, the first codec, i.e. tlv32aic3x_a should be the master, and
>>> all others including the CPU will be slaves).
>>>
>>>    Thanks for any help!
>>>
>>>    BTW, I'm happy to use whatever kernel will support me with the
>>> minimal amount of effort, currently using 4.1
>>>
>>>
>>>
>>> Thank you!
>>>      -Caleb
>>>
>>> &i2c1 {
>>>    ...
>>> tlv320aic3x_a: tlv320aic3x@18 {
>>> #sound-dai-cells =3D <1>;
>>> compatible =3D "ti,tlv320aic3x";
>>> reg =3D <0x18>;
>>> tdm-offset =3D <0>;
>>> status =3D "okay";
>>> };
>>> tlv320aic3x_b: tlv320aic3x@19 {
>>> #sound-dai-cells =3D <1>;
>>> compatible =3D "ti,tlv320aic3x";
>>> reg =3D <0x19>;
>>> tdm-offset =3D <32>;
>>> status =3D "okay";
>>> };
>>> tlv320aic3x_c: tlv320aic3x@1a {
>>> #sound-dai-cells =3D <1>;
>>> compatible =3D "ti,tlv320aic3x";
>>> reg =3D <0x1a>;
>>> tdm-offset =3D <64>;
>>> status =3D "okay";
>>> };
>>> tlv320aic3x_d: tlv320aic3x@1b {
>>> #sound-dai-cells =3D <1>;
>>> compatible =3D "ti,tlv320aic3x";
>>> reg =3D <0x1b>;
>>> tdm-offset =3D <96>;
>>> status =3D "okay";
>>> };
>>> };
>>>
>>> &mcasp0 {
>>> #sound-dai-cells =3D <0>;
>>> pinctrl-names =3D "default";
>>> pinctrl-0 =3D <&mcasp_0_pins_default>;
>>> status =3D "okay";
>>>
>>> op-mode =3D <0>;          /* MCASP_IIS_MODE */
>>> tdm-slots =3D <16>;
>>> num-serializer =3D <16>;
>>> serial-dir =3D <  /* 0: INACTIVE, 1: TX, 2: RX */
>>> 0 0 1 2
>>> 0 0 0 0
>>> 0 0 0 0
>>> 0 0 0 0
>>>> ;
>>> tx-num-evt =3D <1>;
>>> rx-num-evt =3D <1>;
>>> };
>>>
>>> / {
>>> sound {
>>> compatible =3D "simple-audio-card";
>>> simple-audio-card,name =3D "puppy-audio";
>>> simple-audio-card,mclk-fs =3D <256>;
>>> system-clock-frequency =3D <12288000>;
>>> status =3D "okay";
>>> simple-audio-card,bitclock-master =3D <&tlv320aic3x_a>;
>>>         simple-audio-card,frame-master    =3D <&tlv320aic3x_a>;
>>> simple-audio-card,widgets =3D
>>> "Line", "Line Out",
>>> "Line", "Line In";
>>> simple-audio-card,routing =3D
>>> "Line Out",       "HPLOUT",
>>> "Line Out",       "HPROUT",
>>> "Line In",        "LINE1L",
>>> "Line In",        "LINE1R";
>>>
>>> simple-audio-card,dai-link@0 {
>>> format =3D "left_j";
>>> cpu {
>>> sound-dai =3D <&mcasp0>;
>>> };
>>> codec {
>>> sound-dai =3D <&tlv320aic3x_a 0>;
>>> dai-tdm-slot-num =3D <0>;
>>> dai-tdm-slot-width =3D <16>;
>>> };
>>> };
>>> /**** The stuff below doesn't work -- I can't figure out how to get
>>> the name_prefixes set
>>>    on each codec... .How do I set up so that each codec gets its own na=
me
>>> prfix
>>> and so that the soc core thinks all codecs are on the same DAI?
>>> **** */
>>>
>>> // simple-audio-card,dai-link@1 {
>>> // format =3D "left_j";
>>> // cpu {
>>> // sound-dai =3D <&mcasp0>;
>>> // };
>>> // codec {
>>> // sound-dai =3D <&tlv320aic3x_b 0>;
>>> // dai-tdm-slot-num =3D <2>;
>>> // dai-tdm-slot-width =3D <16>;
>>> // };
>>> // };
>>> // simple-audio-card,dai-link@2 {
>>> // format =3D "left_j";
>>> // cpu {
>>> // sound-dai =3D <&mcasp0>;
>>> // };
>>> // codec {
>>> // sound-dai =3D <&tlv320aic3x_c>;
>>> // dai-tdm-slot-num =3D <4>;
>>> // dai-tdm-slot-width =3D <16>;
>>> // };
>>> // };
>>> // simple-audio-card,dai-link@3 {
>>> // format =3D "left_j";
>>> // cpu {
>>> // sound-dai =3D <&mcasp0>;
>>> // };
>>> // codec {
>>> // sound-dai =3D <&tlv320aic3x_d>;
>>> // dai-tdm-slot-num =3D <6>;
>>> // dai-tdm-slot-width =3D <16>;
>>> // };
>>> // };
>>> };
>>> };
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
