From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Sat, 19 Nov 2011 10:11:36 +0100
Message-ID: <ja7rs9$fth$1@dough.gmane.org>
References: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
	<4EB8C132.7020906@gmail.com>
	<CAN8ccibXAd1h2Bb5SGLfRQzGESn+VCr35ZCW4XpApDjzyaPoUQ@mail.gmail.com>
	<ja0k2i$88i$1@dough.gmane.org>
	<CAN8ccibUGERTAXH64-sVkx02q0yDv=XiE4y423LS1=eLTGJaRA@mail.gmail.com>
	<ja2hkv$1lt$1@dough.gmane.org> <ja2i5r$5br$1@dough.gmane.org>
	<CAN8cciZRGvYU8FcnEA1JfBUwe277ce3c3xSC_ftt+oa1vhzWdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id F07BE103B70
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2011 10:11:53 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1RRgxj-00012i-OV
	for alsa-devel@alsa-project.org; Sat, 19 Nov 2011 10:11:51 +0100
Received: from 178-83-206-236.dynamic.hispeed.ch ([178.83.206.236])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2011 10:11:51 +0100
Received: from belegdol by 178-83-206-236.dynamic.hispeed.ch with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2011 10:11:51 +0100
In-Reply-To: <CAN8cciZRGvYU8FcnEA1JfBUwe277ce3c3xSC_ftt+oa1vhzWdw@mail.gmail.com>
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

W dniu 19.11.2011 03:31, Raymond Yau pisze:
> 2011/11/17 Julian Sikorski <belegdol@gmail.com>:
> =

>>>>
>>>> the four jacks need alc883_4st_8ch mixer of "targa-8ch-dig" which has
>>>> been removed
>>>>
>>>> http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommitdiff;h=3D7a=
689ebcefe5feba626816929fd75046e455a96f;hp=3D34913cda7af335d748a424d91984576=
b8c9d9cae
>>>>
>>>> The main problem is the signal of "rear" speaker of the notebook is
>>>> not really at the rear of the user.
>>> I cannot speak for P170HM as I do not have one, but on P150HM there are
>>> two speakers between the screen and the keyboard and something supposed
>>> to act as a subwoofer on the bottom side of the laptop. On Windows 7 you
>>> need THX TruStudio PRO to make it work. No center speaker that I know o=
f.
>>> There are service manuals with schematics for these laptops floating
>>> around the internet. ALC892 connections are described on page 86 for
>>> P150HM and page 91 for P170HM. You should be able to understand far more
>>> than I.
>>>
>>> Regards,
>>> Julian
>>>
>> From the official (non-service) manual, page 309:
>>
>> Audio
>> High Definition Audio
>> 3D Enhanced Sound System
>> S/PDIF Digital Output
>> Built-In Microphone
>> THX TruStudio Pro
>> 7.1CH Audio output supported by
>> headphone, microphone, S/PDIF & Line-
>> In Jack
>> Models A & B:
>> 2 Built-In Speakers and One Sub Woofer
>> Model C:
>> 5 Built-In Speakers and One Sub Woofer
>>
>> Model A is P150HM, and model C is P170HM.
>>
> =

> Refer to P170HM 's photo in user manual
> =

> There are 3 speakers and a subwoofer at the bottom of the laptop and
> two speakers at the top
> =

> Refer to user manual of P150HM,
> =

> Plug the front speaker cables into the Headphone-Out Jack.
> =

> =95 Line-In Jack =3D Rear Speaker Out
> =95 Microphone-In Jack =3D Center/Subwoofer Speaker Out
> =95 S/PDIF-Out Jack =3D Side Speaker Out (for 7.1 Surround Sound Only)
> =

> 7. As you plug in each cable a dialog box will pop up (see =93Auto Popup
> Dialog=94 on
> page 2 - 9).
> =

> Auto Popup Dialog mean support jack detect
> =

> you can try David's hda-jack-sense-test.py
> =

> http://thread.gmane.org/gmane.linux.alsa.devel/85051

Yes, it is working:
[julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
Pin 0x18 (Black Mic): present =3D No
Pin 0x1a (Black Line In): present =3D No
Pin 0x1b (Black HP Out): present =3D Yes
[julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
Pin 0x18 (Black Mic): present =3D No
Pin 0x1a (Black Line In): present =3D No
Pin 0x1b (Black HP Out): present =3D No
[julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
Pin 0x18 (Black Mic): present =3D No
Pin 0x1a (Black Line In): present =3D Yes
Pin 0x1b (Black HP Out): present =3D No
[julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
Pin 0x18 (Black Mic): present =3D Yes
Pin 0x1a (Black Line In): present =3D No
Pin 0x1b (Black HP Out): present =3D No

> =

> =

> Is Node 0x17 also the side jack of your p150hm ?
> pin cap support Detect and Trigger but Misc =3D NO_PRESENCE

Yes, it is between mic and line in jacks, third one from the front. The
only difference is that there is red light coming out of it.

> =

> which node is your subwoofer ?

This I have not figured out yet unfortunately. Keep in mind that in
windows you need THX TruStudio PRO to get it working, and the config is
advertised as stereo. There was a discussion about this on
notebookreview forums [1], so maybe it configured in some weird way?

[1]
http://forum.notebookreview.com/sager-clevo/577492-subwoofer-p150hm-not-wor=
king.html

> =

> Refer to your P150HM alsa-info
> =

> http://thread.gmane.org/gmane.linux.alsa.devel/86475/focus=3D86601
> =

> =

> Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x00000036: IN OUT Detect Trigger
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn =3D 1/8, Color =3D Black
>     DefAssociation =3D 0xf, Sequence =3D 0x0
>     Misc =3D NO_PRESENCE
>   Pin-ctls: 0x20: IN
>   Unsolicited: tag=3D00, enabled=3D0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=3DD0, actual=3DD0
>   Connection: 1
>      0x0f
> =

> =

> =

> autoconfig: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
>    speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
>    hp_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
>    mono: mono_out=3D0x0
>    dig-out=3D0x1e/0x0
>    inputs: Mic=3D0x18 Internal Mic=3D0x19 Line=3D0x1a
> =

> CTRL: add: Channel Mode:0
> CTRL: add: Headphone Playback Volume:0
> CTRL: add: Headphone Playback Switch:0
> CTRL: add: Surround Playback Volume:0
> CTRL: add: Surround Playback Switch:0
> CTRL: add: Center Playback Volume:0
> CTRL: add: LFE Playback Volume:0
> CTRL: add: Center Playback Switch:0
> CTRL: add: LFE Playback Switch:0
> CTRL: add: Speaker Playback Volume:0
> CTRL: add: Speaker Playback Switch:0
>> jack
> NID 0x14: cfg 0x99130110: [Fixed] Speaker at Int ATAPI
> NID 0x18: cfg 0x01a11c30: [Jack] Mic at Ext Rear
> NID 0x19: cfg 0x99a30931: [Fixed] Mic at Int ATAPI
> NID 0x1a: cfg 0x0181143f: [Jack] Line In at Ext Rear
> NID 0x1b: cfg 0x0121101f: [Jack] HP Out at Ext Rear
> NID 0x1e: cfg 0x01451120: [Jack] SPDIF Out at Ext Rear
>> get 1
> 1 Channel Mode:0
> ITEM: 0:2ch, 1:4ch, 2:6ch, VAL: [2ch]
> =

> =

> =

> Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
>     Vref caps: HIZ 50 GRD 80 100
>   EAPD 0x2: EAPD
>   Pin Default 0x0121101f: [Jack] HP Out at Ext Rear
>     Conn =3D 1/8, Color =3D Black
>     DefAssociation =3D 0x1, Sequence =3D 0xf
>   Pin-ctls: 0xc0: OUT HP VREF_HIZ
>   Unsolicited: tag=3D04, enabled=3D1
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=3DD0, actual=3DD0
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
