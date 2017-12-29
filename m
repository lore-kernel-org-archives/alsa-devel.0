From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Cherry Trail + RT5645 devices analog microphone
	not working.
Date: Fri, 29 Dec 2017 01:22:03 +0100
Message-ID: <7dcc5148-dd01-ddbb-516b-51ffd4f1c31a@redhat.com>
References: <d42279d7-0350-563f-fca7-27f32cb9e9ee@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D7027476BE@RTITMBSV02.realtek.com.tw>
 <6ccb2c4c-042f-46c0-5247-90f79d49c840@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D70274A822@RTITMBSV02.realtek.com.tw>
 <a0540986-369c-5bca-424f-102391d85095@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D70274DD33@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com
 [209.85.128.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A9E8267148
 for <alsa-devel@alsa-project.org>; Fri, 29 Dec 2017 01:22:07 +0100 (CET)
Received: by mail-wr0-f174.google.com with SMTP id o101so11846551wrb.6
 for <alsa-devel@alsa-project.org>; Thu, 28 Dec 2017 16:22:07 -0800 (PST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70274DD33@RTITMBSV02.realtek.com.tw>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 28-12-17 04:05, Bard Liao wrote:
>> -----Original Message-----
>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>> Sent: Thursday, December 28, 2017 3:13 AM
>> To: Bard Liao
>> Cc: Pierre-Louis Bossart; alsa-devel@alsa-project.org
>> Subject: Re: Cherry Trail + RT5645 devices analog microphone not working.
>>
>> Hi,
>>
>> On 26-12-17 06:29, Bard Liao wrote:
>>>> -----Original Message-----
>>>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>>>> Sent: Monday, December 25, 2017 8:03 PM
>>>> To: Bard Liao
>>>> Cc: Pierre-Louis Bossart; alsa-devel@alsa-project.org
>>>> Subject: Re: Cherry Trail + RT5645 devices analog microphone not working.
>>>>
>>>> Hi,
>>>>
>>>> On 25-12-17 03:15, Bard Liao wrote:
>>>>>> -----Original Message-----
>>>>>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>>>>>> Sent: Sunday, December 24, 2017 6:43 PM
>>>>>> To: Bard Liao
>>>>>> Cc: Pierre-Louis Bossart; alsa-devel@alsa-project.org
>>>>>> Subject: Cherry Trail + RT5645 devices analog microphone not working.
>>>>>>
>>>>>> Hi Bard,
>>>>>>
>>>>>> I've been looking into getting the microphone to work on
>>>>>> some Cherry Trail + RT5645 devices with what appears to
>>>>>> be a simple analog microphone.
>>>>>>
>>>>>> You can see the microphone on one of the models I'm trying
>>>>>> to get it to work on soldered onto the right side of the PCB
>>>>>> here: https://i.imgur.com/bJzBQWe.jpg
>>>>>>
>>>>>> I'm using this ucm config:
>>>>>>
>>>>>> https://fedorapeople.org/~jwrdegoede/chtrt5645/
>>>>>>
>>>>>> Which is basically Pierre-Louis Bossart's config from:
>>>>>> https://github.com/plbossart/UCM
>>>>>>
>>>>>> Adjusted because the devices all have a mono speaker.
>>>>>>
>>>>>> I've been trying to get this to work myself and I can get
>>>>>> some sound while recording by adding:
>>>>>>
>>>>>>                     cset "name='RECMIXL BST2 Switch' on"
>>>>>>                     cset "name='RECMIXR BST2 Switch' on"
>>>>>>
>>>>>> But then I mainly get noise, I do get some sound from the
>>>>>> microphone if I talk really really loudly, but it is
>>>>>> barely above the noise-floor. I've the feeling that BST2
>>>>>> is only picking up the microphone via cross-talk and
>>>>>> that BST1 indeed is the correct input, but for some reason
>>>>>> I get complete silence when recording when only BST1 is
>>>>>> selected in the RECMIXR, and yes I've checked / set the
>>>>>> "IN1 boost volume".
>>>>>>
>>>>>> TL;DR: I'm trying to get an analog mic to work on 3
>>>>>> different models Cherry Trail + RT5645 devices and I've
>>>>>> been unable to get this to work. I've put a registerdump
>>>>>> of the rt5645 with gnome-sound-recorder running here:
>>>>>> https://fedorapeople.org/~jwrdegoede/rt5645-mic-red.dump
>>>>>>
>>>>>> Any insights / help with this would be very much
>>>>>> welcome.
>>>>>
>>>>> I don't have the schematic, but I think you probably need micbias
>>>>> for the capture. Please add both "micbias1" and "micbias2" in
>>>>> the audio route since I don't know which one is needed.
>>>>> for example
>>>>> static const struct snd_soc_dapm_route cht_rt5645_audio_map[] = {
>>>>> ...
>>>>> 	{"Int Mic", NULL, "micbias1"},
>>>>> 	{"Int Mic", NULL, "micbias2"},
>>>>> ...
>>>>> };
>>>>
>>>> Thank you for your reply. I've tested this, but unfortunately it
>>>> does not help.
>>>>
>>>> Do you perhaps have a cherrytrail device withrt5645 codec where you
>>>> can test an analog mic input with the upstream driver + latest ucm
>>>> file from Pierre-Louis with yourself ? I've the feeling that this is
>>>> not specific to the 3 devices I've access to but a general problem
>>>> in the driver and/or the ucm files.
>>>
>>> Please try the attached patch. I don't have any cherrytrail device with
>>> rt5645 codec. But I verified the register settings on my rt5645 EVB.
>>> If the patch doesn't work, please dump register for me.
>>> Note that adding "micbias1" and "micbias2 in the audio route is also
>>> needed.
>>
>> Thank you, modifying the RT5645_GEN_CTRL2 reg seems to help, for
>> some reason the patch does not work and neither MB1 and MB2 in reg
>> 0x64 nor the RT5645_GEN_CTRL2 changes happen, but after manually
>> applying these with i2cset I can actual use the mic, although there
>> is still quite a bit of white noise in the background.
> 
> I think the reason why the patch didn't work is because "micbias1"
> and "micbias2" are not connected to the audio route. The white
> noise probably because the gain is too high. And if you are using a
> differential mic, please set rt5645->pdata.in2_diff = true;
> 
>>
>> Attached is a regdump after making the manual changes to reg 0x64 and
>> reg 0xfb.
>>
>> I did add the micbias audio routes:
>>
>> @@ -2297,6 +2297,9 @@ static const struct snd_soc_dapm_route
>> rt5645_dapm_routes[] = {
>>    	{ "DMIC2", NULL, "DMIC L2" },
>>    	{ "DMIC2", NULL, "DMIC R2" },
>>
>> +	{ "Int Mic", NULL, "micbias1" },
>> +	{ "Int Mic", NULL, "micbias2" },
>> +
>>    	{ "BST1", NULL, "IN1P" },
>>    	{ "BST1", NULL, "IN1N" },
>>    	{ "BST1", NULL, "JD Power" },
> 
>   +	{ "Int Mic", NULL, "micbias1" },
>   +	{ "Int Mic", NULL, "micbias2" },
> should add in machine driver.
> Please make sure "Int Mic" is registered and its connected to
> "IN1P" and "IN1N". Like
> {"IN1P", NULL, "Int Mic"},
> {"IN1N", NULL, "Int Mic"},
> Or you can share your machine driver so I can check it.

Ah yes, adding these in the machine driver instead of
the codec driver did the trick.

Actually I ended up making some changes, as mentioned
before the BST2 input seemed to be the one which had the mic,
so I ended up doing this:

--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -126,6 +126,8 @@ static const struct snd_soc_dapm_widget cht_dapm_widgets[] =
  static const struct snd_soc_dapm_route cht_rt5645_audio_map[] = {
         {"IN1P", NULL, "Headset Mic"},
         {"IN1N", NULL, "Headset Mic"},
+       {"IN2P", NULL, "Int Mic"},
+       {"IN2N", NULL, "Int Mic"},
         {"DMIC L1", NULL, "Int Mic"},
         {"DMIC R1", NULL, "Int Mic"},
         {"Headphone", NULL, "HPOL"},
@@ -135,6 +137,7 @@ static const struct snd_soc_dapm_route cht_rt5645_audio_map[
         {"Headphone", NULL, "Platform Clock"},
         {"Headset Mic", NULL, "Platform Clock"},
         {"Int Mic", NULL, "Platform Clock"},
+       {"Int Mic", NULL, "micbias2"},
         {"Ext Spk", NULL, "Platform Clock"},
  };


As you can see I only need micbas2 and I routed IN2P and IN2N to Int Mic,
not IN1P and IN2P, this combined with changing the ucm file to
enable disable BST2 rather then BST1 in RECMIXL/R makes the analog
microphone work on one of my devices (I've not yet tested the others).

When I've some more time for this I will also try this on the 2 other
cht + rt5645 devices I've and I will also try the headphone mic input,
I guess that that may need micbias1 enabling.

Some questions for you:

1) I think enabling micbias2 may be a problem on devices with a DMIC,
could this be a problem?  Currently the codec driver itself contains
quirks for dmic pin-mapping, maybe we should leave micbias2 disabled
if dmic pin-mapping is specified through a quirk?

2) Do headset mics normally need a bias current? Could this be headset
dependent?

Regards,

Hans



> 
>>
>> But I believe that your tree has some patches which are not upstream yet,
>> the last patch you attached expects the micbias1 and micbias2 lines
>> in the widget lists to be of the "SND_SOC_DAPM_SUPPLY" type, but here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/tree/sound/
>> soc/codecs/rt5645.c?h=topic/rt5645
>>
>> They are still of the SND_SOC_DAPM_MICBIAS type.
> 
> Sorry, I forget to send the attached patch to upstream.
> Please apply it first.
> 
>>
>> Regards,
>>
>> Hans
>>
>>
>>>
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>>> ------Please consider the environment before printing this e-mail.
