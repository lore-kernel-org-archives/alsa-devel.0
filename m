From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Sun, 4 Dec 2011 07:59:15 +0800
Message-ID: <CAN8cciZGmMZO+mm=CKSLOSV4s36hgE2czy_ppxBcj_dJ138U+g@mail.gmail.com>
References: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
	<ja0k2i$88i$1@dough.gmane.org>
	<CAN8ccibUGERTAXH64-sVkx02q0yDv=XiE4y423LS1=eLTGJaRA@mail.gmail.com>
	<ja2hkv$1lt$1@dough.gmane.org> <ja2i5r$5br$1@dough.gmane.org>
	<CAN8cciZRGvYU8FcnEA1JfBUwe277ce3c3xSC_ftt+oa1vhzWdw@mail.gmail.com>
	<ja7rs9$fth$1@dough.gmane.org>
	<CAN8ccib2wjGOp+2mwU=q48bmv+1w48vaPU=RyXU_fnY8JUSQ-Q@mail.gmail.com>
	<jadd9f$9e1$1@dough.gmane.org>
	<CAN8cciYju3PPZRHf8--oubYc7vVe7-X0D36iGEX=W=uxRpM9sg@mail.gmail.com>
	<jag5h0$ioh$1@dough.gmane.org>
	<CAN8ccianih_LZZW6n+Ksa0gCo2i3gcbdnV_f8QMJNMjz7p=pbA@mail.gmail.com>
	<4ECF85A0.20504@gmail.com>
	<CAN8cciYn_CSgrXHThe=TRBmC98e_XhkT=W8f=UaPp5Tg-c7vSw@mail.gmail.com>
	<javv4p$olp$1@dough.gmane.org>
	<CAN8ccibQX-Lqdn0T-WWtkqjM427TenpLX4OuzuwSCOz7j4RcWQ@mail.gmail.com>
	<jb2bui$bre$1@dough.gmane.org> <jb8abo$vtb$1@dough.gmane.org>
	<CAN8cciaa327+_XA-BarL9-st=J4Zic=iYp3pDCKm_gtCohWd9w@mail.gmail.com>
	<jbark0$7e6$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C80402441A
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 00:59:23 +0100 (CET)
Received: by wgbdr1 with SMTP id dr1so2962718wgb.20
	for <alsa-devel@alsa-project.org>; Sat, 03 Dec 2011 15:59:23 -0800 (PST)
In-Reply-To: <jbark0$7e6$1@dough.gmane.org>
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

2011/12/2 Julian Sikorski <belegdol@gmail.com>:
> W dniu 02.12.2011 01:52, Raymond Yau pisze:
>>>>>>
>>>>>> $ aplay -l
>>>>>> **** List of PLAYBACK Hardware Devices ****
>>>>>> card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
>>>>>> =A0Subdevices: 1/1
>>>>>> =A0Subdevice #0: subdevice #0
>>>>>> card 0: PCH [HDA Intel PCH], device 1: ALC892 Digital [ALC892 Digita=
l]
>>>>>> =A0Subdevices: 1/1
>>>>>> =A0Subdevice #0: subdevice #0
>>>>>> card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
>>>>>> =A0Subdevices: 1/1
>>>>>> =A0Subdevice #0: subdevice #0
>>>>>> card 1: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
>>>>>> =A0Subdevices: 1/1
>>>>>> =A0Subdevice #0: subdevice #0
>>>>>> card 1: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
>>>>>> =A0Subdevices: 1/1
>>>>>> =A0Subdevice #0: subdevice #0
>>>>>> card 1: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
>>>>>> =A0Subdevices: 1/1
>>>>>> =A0Subdevice #0: subdevice #0
>>>>>>
>>
>> How many hdmi connectors on your nvidia ?
>>
>> From the viewpoint of the user, I expect only one PCM device for each
>> hdmi connector
>
> There is one hdmi and one dvi. I did not try sending sound via hdmi, thou=
gh.
>

http://thread.gmane.org/gmane.linux.alsa.devel/92097

>>
>>
>> if you compled alsa-driver in debug mode, you should see the following
>> message in system log.
>>
> How would I do that? Which config option do I need to change?
>
>> realtek: Enable HP auto-muting on NID 0x1b
>> realtek: Enable Line-Out auto-muting on NID 0x17
>>

configure --with-debug=3Dverbose

In theory, , the driver can automatically mute IEC958 Playback Switch
(turn off the red light for power saving) when you plug/unplug the
side jack which share with spdif

>> The drawback is "Front Playback Volume" and "Front Playback Switch"
>> does not control the "Headphone Jack" which used as "Front" jack
>
> Not really a drawback, since in an unpatched 3.1.2 kernel there are
> separate "Speaker" and "Headphone" controls which are independent of
> each other:
>
> http://www.alsa-project.org/db/?f=3Dc8a6fc8ced6993631bad6f754249454323422=
d1a
>

speaker test or pulseaudio expect the "front volume" control the front
jack (i.e. your HP jack) in surround 40 , 51 or 71


>>
>>
>> Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>> =A0 Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
>> =A0 =A0 ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
>> =A0 Control: name=3D"Headphone Jack", index=3D0, device=3D0
>> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>> =A0 Amp-In vals: =A0[0x00 0x00]
>> =A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>> =A0 Amp-Out vals: =A0[0x00 0x00]
>> =A0 Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
>> =A0 =A0 Vref caps: HIZ 50 GRD 80 100
>> =A0 EAPD 0x0:
>> =A0 Pin Default 0x0121101f: [Jack] HP Out at Ext Rear
>> =A0 =A0 Conn =3D 1/8, Color =3D Black
>> =A0 =A0 DefAssociation =3D 0x1, Sequence =3D 0xf
>> =A0 Pin-ctls: 0xc0: OUT HP VREF_HIZ
>> =A0 Unsolicited: tag=3D01, enabled=3D1
>> =A0 Power states: =A0D0 D1 D2 D3
>> =A0 Power: setting=3DD0, actual=3DD0
>> =A0 Connection: 5
>> =A0 =A0 =A00x0c 0x0d 0x0e 0x0f 0x26*
>>
>> The other method is using =A0"hp_pin" instead of "speaker_pin" to assign
>> "Front" dac 0x02
>>
>> but this method won't create "headphone playback volume" and
>> "Headphone playback switch" since "hp_pin" is used to create "Front
>> Playback Volume" and "Front Playback Switch"
>>
>>
>>>>>> Summing up, when it comes to P150HM, the only missing piece is the
>>>>>> internal subwoofer. I tried emailing Andrew, who started this thread,
>>>>>> but got no answer so far. The problem might be that we might need to
>>>>>> figure out what is that THX TruStudio PRO is doing under Windows that
>>>>>> makes the internal subwoofer work.
>>>>>
>>>>>
>>>>> Take a look at the removed model=3D"targa_8ch_dig" which touch those =
gpio
>>>>>
>>>>> Have you ask the notebook vendor clevo support/engineer the subwoofer
>>>>> is connected to which pin of alc892 ?
>>>>
>>>> I have just sent an email to Clevo UK Support. Let's see what they ans=
wer.
>>>
>>> I was forwarded to realtek. Is there any way to figure it out ourselves?
>>>
>>>>
>>
>> The remaining unused output pin is 0x15 and 0x16
>
> Yes, this is what we figured earlier already. If P170hm is any similar,
> 0x16 is the sub:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-August/042981.h=
tml
> The problem is that, as opposed to 0x17, simply switching the pin from
> in to out and unmuting it does not make sound come out of the subwoofer.
> Can it be because the center/lfe channel is already assigned to the mic
> pin? Or do you think that THX is doing some sort of pre-amplification
> which we need to emulate?
>
> Julian
>

change one of the unused pin to  speaker pin by hda-jack-retask

http://thread.gmane.org/gmane.linux.alsa.devel/92229

assign hp to get dac 0x02 instead of speaker_pins[0]

you have to assign your 0x14 speaker and one of the unused pin of  to
spec->extra_out
and increase spec->speaker_outs from 1 to 2


8fa7ab48acb636d24669dab291807b487dfb2804

ALSA: hda - Fix surround/CLFE headphone and speaker pins order
