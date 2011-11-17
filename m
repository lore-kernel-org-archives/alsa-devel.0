From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Thu, 17 Nov 2011 10:08:54 +0800
Message-ID: <CAN8ccibUGERTAXH64-sVkx02q0yDv=XiE4y423LS1=eLTGJaRA@mail.gmail.com>
References: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
	<4EB8C132.7020906@gmail.com>
	<CAN8ccibXAd1h2Bb5SGLfRQzGESn+VCr35ZCW4XpApDjzyaPoUQ@mail.gmail.com>
	<ja0k2i$88i$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 11879103838
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 03:08:55 +0100 (CET)
Received: by bkat8 with SMTP id t8so1363267bka.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 18:08:54 -0800 (PST)
In-Reply-To: <ja0k2i$88i$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/11/16 Julian Sikorski <belegdol@gmail.com>:
> W dniu 16.11.2011 14:08, Raymond Yau pisze:
>> 2011/11/8 Julian Sikorski <belegdol@gmail.com>:
>>> W dniu 20.08.2011 09:33, Andrew Mahone pisze:
>>>> This laptop is detected as ALC892 audio (and by the codec ID this
>>>> seems to be valid), but none of the configurations for it quite match
>>>> this device. I've been working on documenting the connections with HDA
>>>> Analyzer.
>>>>
>>>> alsa-info output:
>>>> http://www.alsa-project.org/db/?f=3Db86e4c6447867fbd129a36d8a63e2f5caa=
836c52
>>>>
>>>> The laptop has built-in 5.1, and 5.1 or 7.1 output via jacks.
>>>>
>>>> DAC NIDs:
>>>> 0x02 front
>>>> 0x03 rear
>>>> 0x04 clfe
>>>> 0x05 side
>>>>
>>>> internal mixers:
>>>> 0x0c front
>>>> 0x0d rear
>>>> 0x0e clfe
>>>> 0x0f side
>>>>
>>>> internal speaker pins:
>>>> 0x14 front
>>>> 0x15 "rear" (front of laptop)
>>>> 0x16 clfe
>>>>
>>>> external ports:
>>>> fixed route:
>>>> 0x17 side
>>>>
>>>> can select any output:
>>>> 0x18 mic / output
>>>> 0x1a line-in / output
>>>> 0x1b headphone
>>>>
>>>> I've been experimenting with patch_realtek.c to add the extra DAC NID,
>>>> and have had some success with a 6-channel mode for the built-in
>>>> speakers and an 8-channel mode that mutes all internal speakers and
>>>> sets the jacks up for output. I still need to manually connect pins
>>>> 0x18, 0x1a, 0x1b to the correct internal mixers for 7.1 to work, and
>>>> headphone plugin does not mute internal speakers in 5.1 mode. I have
>>>> not added a plain stereo mode for internal speakers, although it
>>>> appears that i can probably configure the codec to mix the front
>>>> channels to center and LFE.
>>>>
>>>> Are there any suggestions for what to do next? My current state as a
>>>> patch against the linux-3.0.y repository is at
>>>> http://pastie.org/2400649
>>>>
>>
>> your patch only support 6ch and 8ch , you have to add
>> alc892_clevo_p170hm_ch2_init() ch for stereo playback and ext mic and
>> line-in jack
>>
>> seem the bios did not setup "side" jack 0x17 ?
>>
>> autoconfig: line_outs=3D3 (0x14/0x16/0x15/0x0/0x0) type:speaker
>> =A0 =A0speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
>> =A0 =A0hp_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
>> =A0 =A0mono: mono_out=3D0x0
>> =A0 =A0dig-out=3D0x1e/0x0
>> =A0 =A0inputs: Mic=3D0x18 Internal Mic=3D0x19 Line=3D0x1a
>>
>> seem need to add =A0pin default of side jack 0x17 to force the auto
>> parser to put those speaker pins in correct places
>>
>> Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>> =A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>> =A0 Amp-Out vals: =A0[0x80 0x80]
>> =A0 Pincap 0x00000036: IN OUT Detect Trigger
>> =A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>> =A0 =A0 Conn =3D 1/8, Color =3D Black
>> =A0 =A0 DefAssociation =3D 0xf, Sequence =3D 0x0
>> =A0 =A0 Misc =3D NO_PRESENCE
>> =A0 Pin-ctls: 0x40: OUT
>> =A0 Unsolicited: tag=3D00, enabled=3D0
>> =A0 Power states: =A0D0 D1 D2 D3 EPSS
>> =A0 Power: setting=3DD0, actual=3DD0
>> =A0 Connection: 1
>> =A0 =A0 =A00x0f
>>
>>>> internal speaker pins:
>>>> 0x14 front
>>>> 0x15 "rear" (front of laptop)
>>>> 0x16 clfe
>>
>>
>> and sort the speaker pin by default association 02, 03, 04 (0x14, 0x15
>> and 0x16) when all pin defaults have same location
>>
>> autoconfig: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:line
>> =A0 =A0speaker_outs=3D3 (0x14/0x16/0x15/0x0/0x0)
>> =A0 =A0hp_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
>> =A0 =A0mono: mono_out=3D0x0
>> =A0 =A0dig-out=3D0x1e/0x0
>> =A0 =A0inputs: Mic=3D0x18 Internal Mic=3D0x19 Line=3D0x1a
>>
>>
>>> Please check out this thread:
>>> http://thread.gmane.org/gmane.linux.alsa.devel/86475
>>> With linux-3.1, everything apart from 8-channel sound seems to work with
>>> autoparser, and I was able to get the sound going out from the analog
>>> part of the spdif jack by fiddling with hda-analyzer:
>>> http://article.gmane.org/gmane.linux.alsa.devel/87235
>>> To get this to work automatically, code needs to be written but this is
>>> beyond my skillset.
>>>
> Keep in mind that IIRC P170HM has 4.1 speakers while P150HM has 2.1. I
> think the other audio outputs are the same.
>

>>>> internal speaker pins:
>>>> 0x14 front
>>>> 0x15 "rear" (front of laptop)
>>>> 0x16 clfe

Do you mean the speaker info is incorrect as there is no center ?

0x16 is a stereo pin, and you have to check whether the subwoofer is
connected to left, right or both

Let the auto parser to put the speakers pin in autocfg 's line out won't he=
lp

the four jacks need alc883_4st_8ch mixer of "targa-8ch-dig" which has
been removed

http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommitdiff;h=3D7a689eb=
cefe5feba626816929fd75046e455a96f;hp=3D34913cda7af335d748a424d91984576b8c9d=
9cae

The main problem is the signal of "rear" speaker of the notebook is
not really at the rear of the user.
