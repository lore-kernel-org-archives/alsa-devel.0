From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Wed, 16 Nov 2011 21:08:14 +0800
Message-ID: <CAN8ccibXAd1h2Bb5SGLfRQzGESn+VCr35ZCW4XpApDjzyaPoUQ@mail.gmail.com>
References: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
	<4EB8C132.7020906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id EF57E244D3
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 14:08:17 +0100 (CET)
Received: by bkat8 with SMTP id t8so491428bka.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 05:08:16 -0800 (PST)
In-Reply-To: <4EB8C132.7020906@gmail.com>
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

2011/11/8 Julian Sikorski <belegdol@gmail.com>:
> W dniu 20.08.2011 09:33, Andrew Mahone pisze:
>> This laptop is detected as ALC892 audio (and by the codec ID this
>> seems to be valid), but none of the configurations for it quite match
>> this device. I've been working on documenting the connections with HDA
>> Analyzer.
>>
>> alsa-info output:
>> http://www.alsa-project.org/db/?f=b86e4c6447867fbd129a36d8a63e2f5caa836c52
>>
>> The laptop has built-in 5.1, and 5.1 or 7.1 output via jacks.
>>
>> DAC NIDs:
>> 0x02 front
>> 0x03 rear
>> 0x04 clfe
>> 0x05 side
>>
>> internal mixers:
>> 0x0c front
>> 0x0d rear
>> 0x0e clfe
>> 0x0f side
>>
>> internal speaker pins:
>> 0x14 front
>> 0x15 "rear" (front of laptop)
>> 0x16 clfe
>>
>> external ports:
>> fixed route:
>> 0x17 side
>>
>> can select any output:
>> 0x18 mic / output
>> 0x1a line-in / output
>> 0x1b headphone
>>
>> I've been experimenting with patch_realtek.c to add the extra DAC NID,
>> and have had some success with a 6-channel mode for the built-in
>> speakers and an 8-channel mode that mutes all internal speakers and
>> sets the jacks up for output. I still need to manually connect pins
>> 0x18, 0x1a, 0x1b to the correct internal mixers for 7.1 to work, and
>> headphone plugin does not mute internal speakers in 5.1 mode. I have
>> not added a plain stereo mode for internal speakers, although it
>> appears that i can probably configure the codec to mix the front
>> channels to center and LFE.
>>
>> Are there any suggestions for what to do next? My current state as a
>> patch against the linux-3.0.y repository is at
>> http://pastie.org/2400649
>>

your patch only support 6ch and 8ch , you have to add
alc892_clevo_p170hm_ch2_init() ch for stereo playback and ext mic and
line-in jack

seem the bios did not setup "side" jack 0x17 ?

autoconfig: line_outs=3 (0x14/0x16/0x15/0x0/0x0) type:speaker
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   dig-out=0x1e/0x0
   inputs: Mic=0x18 Internal Mic=0x19 Line=0x1a

seem need to add  pin default of side jack 0x17 to force the auto
parser to put those speaker pins in correct places

Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0f

>> internal speaker pins:
>> 0x14 front
>> 0x15 "rear" (front of laptop)
>> 0x16 clfe


and sort the speaker pin by default association 02, 03, 04 (0x14, 0x15
and 0x16) when all pin defaults have same location

autoconfig: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:line
   speaker_outs=3 (0x14/0x16/0x15/0x0/0x0)
   hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   dig-out=0x1e/0x0
   inputs: Mic=0x18 Internal Mic=0x19 Line=0x1a


> Please check out this thread:
> http://thread.gmane.org/gmane.linux.alsa.devel/86475
> With linux-3.1, everything apart from 8-channel sound seems to work with
> autoparser, and I was able to get the sound going out from the analog
> part of the spdif jack by fiddling with hda-analyzer:
> http://article.gmane.org/gmane.linux.alsa.devel/87235
> To get this to work automatically, code needs to be written but this is
> beyond my skillset.
>
