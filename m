From: Caleb Crome <caleb@crome.org>
Subject: Re: Kernel Device Tree entries for simple-audio-card
Date: Mon, 28 Sep 2015 15:22:19 -0700
Message-ID: <CAG5mAdxgTzGjnvwno0D_Jo9_53stmGfsc9OQS05f3thrSFKpkw@mail.gmail.com>
References: <4D7C68FE-B884-489C-91DD-395FE7CE181D@latencyzero.com>
 <CAG5mAdxc5-UuTnz24zByA64ZsrB4qnfMKF57GBVeFfWvY44xsw@mail.gmail.com>
 <4D1E67E6-437D-490D-A577-35EB7E474A3A@latencyzero.com>
 <CAG5mAdxnjZUBiOFU6+MBn0znUCBaGpeVQ-RaYhXch=-4n7J4uw@mail.gmail.com>
 <F3A7E580-2E91-45D0-9C27-2FD190110686@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 98FBD2616F3
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 00:22:39 +0200 (CEST)
Received: by wiclk2 with SMTP id lk2so125450944wic.0
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2015 15:22:39 -0700 (PDT)
In-Reply-To: <F3A7E580-2E91-45D0-9C27-2FD190110686@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 28, 2015 at 11:55 AM, Rick Mann <rmann@latencyzero.com> wrote:
> That's very similar to what I have (I use ax40 & axr2). I also use macsp0_ahclkx, but I'm not seeing a signal on it (or any other pin).
>


> Does this work for you with a 4.1.x kernel?

Yes, it works for me.  I assume your codec is master, do you see WCLK
and BCLK running?  How about MCLK?

Who is supposed to be driving MCLK in your case, the BBB or the codec?

I see that you have the AHCLKX set to INPUT.  This should probably
either be output (if the CPU is driving it), or not connected if the
codec is driving it.

> 0x1ac (PIN_INPUT | MUX_MODE0) // P9_25 MCLK MCLK mcasp0_ahclkx

-Caleb




>
>> On Sep 28, 2015, at 09:11 , Caleb Crome <caleb@crome.org> wrote:
>>
>> I used these pins to get the audio cape going.
>>
>> +/*
>> +   * MCASP pin mapping
>> +   *                          ball   BBB
>> +   * MCASP0_ACLKX             A13    P9.31
>> +   * MCASP0_AFSX              B13    P9.29
>> +   * MCASP0_AXR2  (mcasp OUT) C12    P9.28
>> +   * MCASP0_AXR3  (mcasp IN)  A14    P9.25
>> +*/
>>
>> mcasp_0_pins_default: mcasp_0_pins_default {
>>  pinctrl-single,pins = <
>>     0x190 ( PIN_INPUT | MUX_MODE0 ) /* (A13) mcasp0_aclkx.mcasp0_aclkx */
>>    0x194 ( PIN_INPUT | MUX_MODE0 ) /* (B13) mcasp0_fsx.mcasp0_fsx */
>>    0x19c ( PIN_OUTPUT | MUX_MODE2 ) /* (C12) mcasp0_ahclkr.mcasp0_axr2 */
>>    0x1ac ( PIN_INPUT | MUX_MODE2 ) /* (A14) mcasp0_ahclkx.mcasp0_axr3 */
>>> ;
>> };
>>
>> And importantly, the audio cape needs to use the AXR2 and AXR3 for my use.
>>
>> +&mcasp0 {
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&mcasp_0_pins_default>;
>> + status = "okay";
>> +
>> + op-mode = <0>;          /* MCASP_IIS_MODE */
>> + tdm-slots = <8>;
>> + num-serializer = <16>;
>> + serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
>> + 0 0 1 2
>> + 0 0 0 0
>> + 0 0 0 0
>> + 0 0 0 0
>> + >;
>> + tx-num-evt = <1>;
>> + rx-num-evt = <1>;
>> };
>>
>>
>> Hope that can be of some help.
>>
>>
>> -Caleb
>>
>>
>> On Sun, Sep 27, 2015 at 10:14 PM, Rick Mann <rmann@latencyzero.com> wrote:
>>> Yeah, it turned out I needed a -cells = <0> on the mcasp0 peripheral.
>>>
>>> I've got it finding it and creating a sound card, and if I run speaker-test, it sends a bunch of i2c commands to the codec (which aren't quite right). But the McASP/IIS pins never change state, so, I've made progress, but I'm still stuck.
>>>
>>> Latest DTBO:
>>>
>>>        https://github.com/JetForMe/podtique/blob/v1/bbb/cape/Podtique1/BB-ENABLE-PRU.dts
>>>
>>>> On Sep 27, 2015, at 14:52 , Caleb Crome <caleb@crome.org> wrote:
>>>>
>>>> I found that too.  Check out the documentation here:
>>>> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/sound/simple-card.txt
>>>>
>>>> You need to put in the #sound-dai-cells cell.   Your value will likely
>>>> be 0 for the codec, and maybe 1 for the SOC dai, but I"m not sure.
>>>>
>>>> Unfortunately, I don't really understand how it works.
>>>>
>>>> -Caleb
>>>>
>>>>
>>>> On Fri, Sep 25, 2015 at 10:57 PM, Rick Mann <rmann@latencyzero.com> wrote:
>>>>> Hi. I've built a Beaglebone Black Cape that has, among other things, a TI Audio CODEC on it (TLV320AIC3104). This is the same CODEC as the BBB Audio Cape (http://elinux.org/CircuitCo:Audio_Cape_RevB), and it's connected in almost the exact same way.
>>>>>
>>>>> The last few days I've been figuring out the Device Tree overlay needed to get Linux (4.1.4) to recognize it. It's finding the device and instantiating the low-level driver (tlv320aic3x-codec), although I'm not sure at this point if it's actually talking to it (I have verified that low-level i2c commands do work).
>>>>>
>>>>> But when it comes to the sound card setup, I'm having trouble getting the Device Tree right. I'm hoping someone on this list can offer some insight. The DT is here:
>>>>>
>>>>>       https://github.com/JetForMe/podtique/blob/master/bbb/cape/Podtique1/BB-ENABLE-PRU.dts
>>>>>
>>>>> And this is dmesg when I try to load that (note the name of my overlay is BB-ENABLE-PRU, which is an artifact of the experimentation I've been doing; it'll change to something more appropriate):
>>>>>
>>>>> [   65.859275] bone_capemgr bone_capemgr: part_number 'BB-ENABLE-PRU', version 'N/A'
>>>>> [   65.859318] bone_capemgr bone_capemgr: slot #4: override
>>>>> [   65.859336] bone_capemgr bone_capemgr: Using override eeprom data at slot 4
>>>>> [   65.859355] bone_capemgr bone_capemgr: slot #4: 'Override Board Name,00A0,Override Manuf,BB-ENABLE-PRU'
>>>>> [   65.859488] bone_capemgr: bone_capemgr bone_capemgr: slot #4: Requesting part number/version based 'BB-ENABLE-PRU-00A0.dtbo
>>>>> [   65.859506] bone_capemgr: bone_capemgr bone_capemgr: slot #4: Requesting firmware 'BB-ENABLE-PRU-00A0.dtbo' for board-name 'Override Board Name', version '00A0'
>>>>> [   65.861105] bone_capemgr: bone_capemgr bone_capemgr: slot #4: dtbo 'BB-ENABLE-PRU-00A0.dtbo' loaded; converting to live tree
>>>>> [   65.875618] gpio-of-helper ocp:gpio_helper: ready
>>>>> [   65.876327] gpiolib_of: of_get_named_gpiod_flags: parsed 'gpio' property of node '//fixedregulator@1[0]' - status (0)
>>>>> [   65.876619] core: lz-codec-reg: no parameters
>>>>> [   65.876713] fixed: reg-fixed-voltage fixedregulator@1: lz-codec-reg supplying 0uV
>>>>> [   65.883284] pruss_uio 4a300000.pruss: pins are not configured from the driver
>>>>> [   65.900080] bone_capemgr bone_capemgr: slot #4: dtbo 'BB-ENABLE-PRU-00A0.dtbo' loaded; overlay id #0
>>>>> [   65.946254] gpiolib_of: of_get_named_gpiod_flags: parsed 'gpio-reset' property of node '/ocp/i2c@4819c000/tlv320aic3104@0[0]' - status (0)
>>>>> [   65.946317] core: tlv320aic3x-codec 2-0018: Looking up IOVDD-supply from device tree
>>>>> [   65.946405] core: tlv320aic3x-codec 2-0018: Looking up DVDD-supply from device tree
>>>>> [   65.946468] core: tlv320aic3x-codec 2-0018: Looking up AVDD-supply from device tree
>>>>> [   65.946544] core: tlv320aic3x-codec 2-0018: Looking up DRVDD-supply from device tree
>>>>> [   65.946606] snd_soc_core: tlv320aic3x-codec 2-0018: codec register 2-0018
>>>>> [   65.946640] snd_soc_core: tlv320aic3x-codec 2-0018: ASoC: dai register 2-0018 #1
>>>>> [   65.946655] snd_soc_core: tlv320aic3x-codec 2-0018: ASoC: Registered DAI 'tlv320aic3x-hifi'
>>>>> [   65.946671] snd_soc_core: tlv320aic3x-codec 2-0018: ASoC: Registered codec 'tlv320aic3x-codec.2-0018'
>>>>> [   65.956491] //sound/simple-audio-card,cpu: could not get #sound-dai-cells for /ocp/mcasp@48038000
>>>>> [   65.978759] snd_soc_core: davinci-mcasp 48038000.mcasp: ASoC: dai register 48038000.mcasp #1
>>>>> [   65.978795] snd_soc_core: davinci-mcasp 48038000.mcasp: ASoC: Registered DAI '48038000.mcasp'
>>>>> [   65.978954] snd_soc_core: davinci-mcasp 48038000.mcasp: ASoC: Registered platform '48038000.mcasp'
>>>>> [   66.012427] asoc-simple-card sound: parse error -22
>>>>> [   66.042609] asoc-simple-card: probe of sound failed with error -22
>>>>>
>>>>> Note the bit about "#sound-dai-cells". I'm not sure what's wrong here, and it seems like it might be something in the distro-provided DTB, not my own.
>>>>>
>>>>> aplay lists nothing (I think in part because I have yet to put in a proper asound.conf file):
>>>>>
>>>>> # aplay -l
>>>>> aplay: device_list:268: no soundcards found...
>>>>>
>>>>> Can someone suggest some diagnostics I can do to see what the state of things is? I'm just not sure what to look for. Thanks!
>>>>>
>>>>> --
>>>>> Rick Mann
>>>>> rmann@latencyzero.com
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Alsa-devel mailing list
>>>>> Alsa-devel@alsa-project.org
>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>> _______________________________________________
>>>> Alsa-devel mailing list
>>>> Alsa-devel@alsa-project.org
>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>
>>>
>>> --
>>> Rick Mann
>>> rmann@latencyzero.com
>>>
>>>
>
>
> --
> Rick Mann
> rmann@latencyzero.com
>
>
