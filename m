From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Thu, 17 Nov 2011 09:55:22 +0100
Message-ID: <ja2i5r$5br$1@dough.gmane.org>
References: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
	<4EB8C132.7020906@gmail.com>
	<CAN8ccibXAd1h2Bb5SGLfRQzGESn+VCr35ZCW4XpApDjzyaPoUQ@mail.gmail.com>
	<ja0k2i$88i$1@dough.gmane.org>
	<CAN8ccibUGERTAXH64-sVkx02q0yDv=XiE4y423LS1=eLTGJaRA@mail.gmail.com>
	<ja2hkv$1lt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 981D2103A16
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 09:55:36 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1RQxkt-00038p-Pg
	for alsa-devel@alsa-project.org; Thu, 17 Nov 2011 09:55:35 +0100
Received: from 178-83-206-236.dynamic.hispeed.ch ([178.83.206.236])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 09:55:35 +0100
Received: from belegdol by 178-83-206-236.dynamic.hispeed.ch with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 09:55:35 +0100
In-Reply-To: <ja2hkv$1lt$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

W dniu 17.11.2011 09:46, Julian Sikorski pisze:
> W dniu 17.11.2011 03:08, Raymond Yau pisze:
>> 2011/11/16 Julian Sikorski <belegdol@gmail.com>:
>>> W dniu 16.11.2011 14:08, Raymond Yau pisze:
>>>> 2011/11/8 Julian Sikorski <belegdol@gmail.com>:
>>>>> W dniu 20.08.2011 09:33, Andrew Mahone pisze:
>>>>>> This laptop is detected as ALC892 audio (and by the codec ID this
>>>>>> seems to be valid), but none of the configurations for it quite match
>>>>>> this device. I've been working on documenting the connections with HDA
>>>>>> Analyzer.
>>>>>>
>>>>>> alsa-info output:
>>>>>> http://www.alsa-project.org/db/?f=b86e4c6447867fbd129a36d8a63e2f5caa836c52
>>>>>>
>>>>>> The laptop has built-in 5.1, and 5.1 or 7.1 output via jacks.
>>>>>>
>>>>>> DAC NIDs:
>>>>>> 0x02 front
>>>>>> 0x03 rear
>>>>>> 0x04 clfe
>>>>>> 0x05 side
>>>>>>
>>>>>> internal mixers:
>>>>>> 0x0c front
>>>>>> 0x0d rear
>>>>>> 0x0e clfe
>>>>>> 0x0f side
>>>>>>
>>>>>> internal speaker pins:
>>>>>> 0x14 front
>>>>>> 0x15 "rear" (front of laptop)
>>>>>> 0x16 clfe
>>>>>>
>>>>>> external ports:
>>>>>> fixed route:
>>>>>> 0x17 side
>>>>>>
>>>>>> can select any output:
>>>>>> 0x18 mic / output
>>>>>> 0x1a line-in / output
>>>>>> 0x1b headphone
>>>>>>
>>>>>> I've been experimenting with patch_realtek.c to add the extra DAC NID,
>>>>>> and have had some success with a 6-channel mode for the built-in
>>>>>> speakers and an 8-channel mode that mutes all internal speakers and
>>>>>> sets the jacks up for output. I still need to manually connect pins
>>>>>> 0x18, 0x1a, 0x1b to the correct internal mixers for 7.1 to work, and
>>>>>> headphone plugin does not mute internal speakers in 5.1 mode. I have
>>>>>> not added a plain stereo mode for internal speakers, although it
>>>>>> appears that i can probably configure the codec to mix the front
>>>>>> channels to center and LFE.
>>>>>>
>>>>>> Are there any suggestions for what to do next? My current state as a
>>>>>> patch against the linux-3.0.y repository is at
>>>>>> http://pastie.org/2400649
>>>>>>
>>>>
>>>> your patch only support 6ch and 8ch , you have to add
>>>> alc892_clevo_p170hm_ch2_init() ch for stereo playback and ext mic and
>>>> line-in jack
>>>>
>>>> seem the bios did not setup "side" jack 0x17 ?
>>>>
>>>> autoconfig: line_outs=3 (0x14/0x16/0x15/0x0/0x0) type:speaker
>>>>    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>>>>    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
>>>>    mono: mono_out=0x0
>>>>    dig-out=0x1e/0x0
>>>>    inputs: Mic=0x18 Internal Mic=0x19 Line=0x1a
>>>>
>>>> seem need to add  pin default of side jack 0x17 to force the auto
>>>> parser to put those speaker pins in correct places
>>>>
>>>> Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>>>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>>>   Amp-Out vals:  [0x80 0x80]
>>>>   Pincap 0x00000036: IN OUT Detect Trigger
>>>>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>>>     Conn = 1/8, Color = Black
>>>>     DefAssociation = 0xf, Sequence = 0x0
>>>>     Misc = NO_PRESENCE
>>>>   Pin-ctls: 0x40: OUT
>>>>   Unsolicited: tag=00, enabled=0
>>>>   Power states:  D0 D1 D2 D3 EPSS
>>>>   Power: setting=D0, actual=D0
>>>>   Connection: 1
>>>>      0x0f
>>>>
>>>>>> internal speaker pins:
>>>>>> 0x14 front
>>>>>> 0x15 "rear" (front of laptop)
>>>>>> 0x16 clfe
>>>>
>>>>
>>>> and sort the speaker pin by default association 02, 03, 04 (0x14, 0x15
>>>> and 0x16) when all pin defaults have same location
>>>>
>>>> autoconfig: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:line
>>>>    speaker_outs=3 (0x14/0x16/0x15/0x0/0x0)
>>>>    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
>>>>    mono: mono_out=0x0
>>>>    dig-out=0x1e/0x0
>>>>    inputs: Mic=0x18 Internal Mic=0x19 Line=0x1a
>>>>
>>>>
>>>>> Please check out this thread:
>>>>> http://thread.gmane.org/gmane.linux.alsa.devel/86475
>>>>> With linux-3.1, everything apart from 8-channel sound seems to work with
>>>>> autoparser, and I was able to get the sound going out from the analog
>>>>> part of the spdif jack by fiddling with hda-analyzer:
>>>>> http://article.gmane.org/gmane.linux.alsa.devel/87235
>>>>> To get this to work automatically, code needs to be written but this is
>>>>> beyond my skillset.
>>>>>
>>> Keep in mind that IIRC P170HM has 4.1 speakers while P150HM has 2.1. I
>>> think the other audio outputs are the same.
>>>
>>
>>>>>> internal speaker pins:
>>>>>> 0x14 front
>>>>>> 0x15 "rear" (front of laptop)
>>>>>> 0x16 clfe
>>
>> Do you mean the speaker info is incorrect as there is no center ?
>>
>> 0x16 is a stereo pin, and you have to check whether the subwoofer is
>> connected to left, right or both
>>
>> Let the auto parser to put the speakers pin in autocfg 's line out won't help
>>
>> the four jacks need alc883_4st_8ch mixer of "targa-8ch-dig" which has
>> been removed
>>
>> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=7a689ebcefe5feba626816929fd75046e455a96f;hp=34913cda7af335d748a424d91984576b8c9d9cae
>>
>> The main problem is the signal of "rear" speaker of the notebook is
>> not really at the rear of the user.
> I cannot speak for P170HM as I do not have one, but on P150HM there are
> two speakers between the screen and the keyboard and something supposed
> to act as a subwoofer on the bottom side of the laptop. On Windows 7 you
> need THX TruStudio PRO to make it work. No center speaker that I know of.
> There are service manuals with schematics for these laptops floating
> around the internet. ALC892 connections are described on page 86 for
> P150HM and page 91 for P170HM. You should be able to understand far more
> than I.
> 
> Regards,
> Julian
> 
>From the official (non-service) manual, page 309:

Audio
High Definition Audio
3D Enhanced Sound System
S/PDIF Digital Output
Built-In Microphone
THX TruStudio Pro
7.1CH Audio output supported by
headphone, microphone, S/PDIF & Line-
In Jack
Models A & B:
2 Built-In Speakers and One Sub Woofer
Model C:
5 Built-In Speakers and One Sub Woofer

Model A is P150HM, and model C is P170HM.

Regards,
Julian
