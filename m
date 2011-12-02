From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Fri, 2 Dec 2011 08:52:40 +0800
Message-ID: <CAN8cciaa327+_XA-BarL9-st=J4Zic=iYp3pDCKm_gtCohWd9w@mail.gmail.com>
References: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
	<4EB8C132.7020906@gmail.com>
	<CAN8ccibXAd1h2Bb5SGLfRQzGESn+VCr35ZCW4XpApDjzyaPoUQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6FCAA24584
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 01:52:41 +0100 (CET)
Received: by bkcjk13 with SMTP id jk13so868663bkc.38
	for <alsa-devel@alsa-project.org>; Thu, 01 Dec 2011 16:52:41 -0800 (PST)
In-Reply-To: <jb8abo$vtb$1@dough.gmane.org>
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
>>>>> There is a bug in hda-emu which cannot detect two playback switches
>>>>> "Front" and "Side" create at same switch pin
>>>>>
>>>>> Try add the following to dump the value of switch pin
>>>>>
>>>>> In function alc_auto_create_multi_out_ctls()
>>>>>
>>>>>
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s playba=
ck volume %x pin %x\n",name,vol,pin);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D alc_auto_add_ster=
eo_vol(codec, name, index, vol);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return er=
r;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s playba=
ck switch %x\n",name,sw);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D alc_auto_add_ster=
eo_sw(codec, name, index, sw);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return er=
r;
>>>>
>>>> This is what is shown in /var/log/messages:
>>>>
>>>> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156689] Front playback volu=
me 2
>>>> pin 14
>>>> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156695] Front playback swit=
ch 14

Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name=3D"Front Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
  EAPD 0x2: EAPD
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0



>>>> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156789] Surround playback
>>>> volume 3 pin 1a
>>>> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156794] Surround playback s=
witch 1a
>>>> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156956] Side playback volum=
e 5
>>>> pin 17
>>>> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156960] Side playback switc=
h 17
>>>>

Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name=3D"Side Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Line-Out Jack", index=3D0, device=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x01011013: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x1, Sequence =3D 0x3
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D02, enabled=3D1
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x0f

>>>>>
>>>>>>>>>>>>> Plug the front speaker cables into the Headphone-Out Jack.
>>>>>>>>>>>>>
>>>>>>>>>>>>> =95 Line-In Jack =3D Rear Speaker Out
>>>>>>>>>>>>> =95 Microphone-In Jack =3D Center/Subwoofer Speaker Out
>>>>>>>>>>>>> =95 S/PDIF-Out Jack =3D Side Speaker Out (for 7.1 Surround So=
und Only)
>>>>>
>>>>>
>>>>> Method 1) HP Playback volume for HP jack and Speaker Playback Volume
>>>>>
>>>>>
>>>>> =A0fix the "Side Playback Switch" and "Front playback Switch"
>>>>>
>>>>> In function alc_auto_create_multi_out_ctls()
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin =3D cfg->line_out_pins[=
i];
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cfg->speaker_pins[0] &&
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_defcfg_=
location(snd_hda_codec_get_pincfg(codec, cfg->hp_pins[0])) =3D=3D
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_defcf=
g_location(snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0])))
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin =3D cfg=
->speaker_pins[0];
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin =3D cfg=
->line_out_pins[i];
>>>>>
>>>>> add "Headpone Playback Volume" by using dac 0x25
>>>>>
>>>>> In function alc_auto_fill_dac_nids() and the end of previous patch in
>>>>> previous email
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multi_ios++;
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.num_dacs++;
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.hp_out_nid[0] =3D alc_auto_l=
ook_for_dac(codec, cfg->hp_pins[0]);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>>>>
>>>>>
>>>>>>>>>>>>> =95 S/PDIF-Out Jack =3D Side Speaker Out (for 7.1 Surround So=
und Only)
>>>>>
>>>>> assign dac spec->alt_dac_nid for creating alt playback device
>>>>>
>>>>> aplay -Dhw:0,2 any.wav
>>>>>
>>>>> Try either a) or b) but not both
>>>>> a) use "side jack" for "alt playback" but device 2 be disabled when
>>>>> channel mode is 8ch
>>>>>
>>>>> In function alc_auto_fill_dac_nids()
>>>>>
>>>>> + =A0 =A0 spec->alt_dac_nid =3D spec->private_dac_nids[3];
>>>>> =A0 =A0 =A0 return 0;
>>>>>
>>>>> in function alc_set_multi_io()
>>>>>
>>>>>
>>>>> =A0 =A0 =A0 } else {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( i < 2 ) {
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_amp_stereo(=
codec, nid, HDA_OUTPUT, 0,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0HDA_AMP_MUTE, HDA_AMP_MUTE);
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_update_cache(codec, nid, 0,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0AC_VERB_SET_PIN_WIDGET_CONTROL,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0spec->multi_io[idx].ctl_in);
>>>>>
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (get_wcaps(codec, nid) & =
AC_WCAP_OUT_AMP)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_=
amp_stereo(codec, nid, HDA_OUTPUT, 0,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0HDA_AMP_MUTE, HDA_AMP_MUTE);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_update_cache(=
codec, nid, 0,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0AC_VERB_SET_PIN_WIDGET_CONTROL,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0spec->multi_io[idx].ctl_in);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>>
>>>>
>>>> With the above version and everything is almost perfect:
>>>>
>>>> http://www.alsa-project.org/db/?f=3D35d300b2eaec79699ec37febc6321687a8=
94be50
>>>>
>>>> * mute for side channel is present and functions correctly
>>>> * auto-mute situation is unchanged, but I don't think it matters
>>>> * speaker/HP controls are much neater
>>>> =A0- front mute and slider control the internal speakers
>>>> =A0- headphone mute and slider control the headphone jack
>>>>
>>>> The only nitpick would be that the alt device does not work:
>>>
>>
>> I tried 0001-Add-Multistreaming-Playback-using-Front-Panel-Headph.patch,
>> but unfortunately it does not apply on top of current kernels anymore,
>> and it is not trivial enough for me to fix.
>> Anyway, in my opinion it does not make a lot of sense, as the jacks are
>> 2 cm away from each other and I don't see a use case where someone would
>> want to play a different sound on each of them.
>>

  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x01011013: [Jack] Line Out at Ext Rear

As the pincaps of "side" jack does not support HP,  so it cannot used
as dual headphone

it is strange that alt_device cannot be create if you have assign a
valid dac to spec->alt_dac_nid

>>>>
>>>> $ aplay -l
>>>> **** List of PLAYBACK Hardware Devices ****
>>>> card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
>>>> =A0Subdevices: 1/1
>>>> =A0Subdevice #0: subdevice #0
>>>> card 0: PCH [HDA Intel PCH], device 1: ALC892 Digital [ALC892 Digital]
>>>> =A0Subdevices: 1/1
>>>> =A0Subdevice #0: subdevice #0
>>>> card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
>>>> =A0Subdevices: 1/1
>>>> =A0Subdevice #0: subdevice #0
>>>> card 1: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
>>>> =A0Subdevices: 1/1
>>>> =A0Subdevice #0: subdevice #0
>>>> card 1: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
>>>> =A0Subdevices: 1/1
>>>> =A0Subdevice #0: subdevice #0
>>>> card 1: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
>>>> =A0Subdevices: 1/1
>>>> =A0Subdevice #0: subdevice #0
>>>>

How many hdmi connectors on your nvidia ?

>From the viewpoint of the user, I expect only one PCM device for each
hdmi connector


>>>> And that the sound is coming out of the side jack no matter the number
>>>> of channels.
>>>>
>>>>>
>>>>> b) use "Headphone" for "alt playback"
>>>>>
>>>>> In function alc_auto_fill_dac_nids()
>>>>>
>>>>> + =A0 =A0 =A0spec->alt_dac_nid =3D spec->multiout.hp_out_nid[0];
>>>>> =A0 =A0 =A0 return 0;
>>>>
>>>> I also tried this version (attached with versionb suffix), it works ev=
en
>>>> better. As with version a), controls are working correctly. Auto-mute
>>>> still mutes upon plugging into either side or headphone jack no matter
>>>> the alsamixer setting. Alt device is still not there. The improvement =
is
>>>> that sound only comes out of the side jack when alsamixer is set to 8
>>>> channels.
>>>>
>>>> http://www.alsa-project.org/db/?f=3D31f808d43fc26c29718d239600741b5b06=
9ce427
>>>>
>>>> So it seems like the version b does everything it is supposed to, maybe
>>>> aside from the side jack muting behaviour.

if you compled alsa-driver in debug mode, you should see the following
message in system log.

realtek: Enable HP auto-muting on NID 0x1b
realtek: Enable Line-Out auto-muting on NID 0x17

The drawback is "Front Playback Volume" and "Front Playback Switch"
does not control the "Headphone Jack" which used as "Front" jack


Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Headphone Jack", index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x0:
  Pin Default 0x0121101f: [Jack] HP Out at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x1, Sequence =3D 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=3D01, enabled=3D1
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*

The other method is using  "hp_pin" instead of "speaker_pin" to assign
"Front" dac 0x02

but this method won't create "headphone playback volume" and
"Headphone playback switch" since "hp_pin" is used to create "Front
Playback Volume" and "Front Playback Switch"


>>>> Summing up, when it comes to P150HM, the only missing piece is the
>>>> internal subwoofer. I tried emailing Andrew, who started this thread,
>>>> but got no answer so far. The problem might be that we might need to
>>>> figure out what is that THX TruStudio PRO is doing under Windows that
>>>> makes the internal subwoofer work.
>>>
>>>
>>> Take a look at the removed model=3D"targa_8ch_dig" which touch those gp=
io
>>>
>>> Have you ask the notebook vendor clevo support/engineer the subwoofer
>>> is connected to which pin of alc892 ?
>>
>> I have just sent an email to Clevo UK Support. Let's see what they answe=
r.
>
> I was forwarded to realtek. Is there any way to figure it out ourselves?
>
>>

The remaining unused output pin is 0x15 and 0x16
