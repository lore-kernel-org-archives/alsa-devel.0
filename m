From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Mon, 21 Nov 2011 14:47:06 +0800
Message-ID: <CAN8ccib2wjGOp+2mwU=q48bmv+1w48vaPU=RyXU_fnY8JUSQ-Q@mail.gmail.com>
References: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
	<4EB8C132.7020906@gmail.com>
	<CAN8ccibXAd1h2Bb5SGLfRQzGESn+VCr35ZCW4XpApDjzyaPoUQ@mail.gmail.com>
	<ja0k2i$88i$1@dough.gmane.org>
	<CAN8ccibUGERTAXH64-sVkx02q0yDv=XiE4y423LS1=eLTGJaRA@mail.gmail.com>
	<ja2hkv$1lt$1@dough.gmane.org> <ja2i5r$5br$1@dough.gmane.org>
	<CAN8cciZRGvYU8FcnEA1JfBUwe277ce3c3xSC_ftt+oa1vhzWdw@mail.gmail.com>
	<ja7rs9$fth$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7B573245CE
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 07:47:08 +0100 (CET)
Received: by bkat8 with SMTP id t8so6152068bka.38
	for <alsa-devel@alsa-project.org>; Sun, 20 Nov 2011 22:47:06 -0800 (PST)
In-Reply-To: <ja7rs9$fth$1@dough.gmane.org>
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

2011/11/19 Julian Sikorski <belegdol@gmail.com>:
>>> From the official (non-service) manual, page 309:
>>>
>>> Audio
>>> High Definition Audio
>>> 3D Enhanced Sound System
>>> S/PDIF Digital Output
>>> Built-In Microphone
>>> THX TruStudio Pro
>>> 7.1CH Audio output supported by
>>> headphone, microphone, S/PDIF & Line-
>>> In Jack
>>> Models A & B:
>>> 2 Built-In Speakers and One Sub Woofer
>>> Model C:
>>> 5 Built-In Speakers and One Sub Woofer
>>>
>>> Model A is P150HM, and model C is P170HM.
>>>
>>
>> Refer to P170HM 's photo in user manual
>>
>> There are 3 speakers and a subwoofer at the bottom of the laptop and
>> two speakers at the top
>>
>> Refer to user manual of P150HM,
>>
>> Plug the front speaker cables into the Headphone-Out Jack.
>>
>> =95 Line-In Jack =3D Rear Speaker Out
>> =95 Microphone-In Jack =3D Center/Subwoofer Speaker Out
>> =95 S/PDIF-Out Jack =3D Side Speaker Out (for 7.1 Surround Sound Only)

You may need to ask Takashi , David, PA developers and Media
controller developers how to handle this case

since it may need to set_pin_ctl to PIN_HP and PIN_OUT of 0x1b and
retasking of input jacks as output  whether PA or Media controller API
expect to change the name of the volume control and switch from
"Headphone" to "Front" by hda-reconfig

http://thread.gmane.org/gmane.linux.alsa.devel/91334

>>
>> 7. As you plug in each cable a dialog box will pop up (see =93Auto Popup
>> Dialog=94 on
>> page 2 - 9).
>>
>> Auto Popup Dialog mean support jack detect
>>
>> you can try David's hda-jack-sense-test.py
>>
>> http://thread.gmane.org/gmane.linux.alsa.devel/85051
>
> Yes, it is working:
> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
> Pin 0x18 (Black Mic): present =3D No
> Pin 0x1a (Black Line In): present =3D No
> Pin 0x1b (Black HP Out): present =3D Yes
> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
> Pin 0x18 (Black Mic): present =3D No
> Pin 0x1a (Black Line In): present =3D No
> Pin 0x1b (Black HP Out): present =3D No
> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
> Pin 0x18 (Black Mic): present =3D No
> Pin 0x1a (Black Line In): present =3D Yes
> Pin 0x1b (Black HP Out): present =3D No
> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
> Pin 0x18 (Black Mic): present =3D Yes
> Pin 0x1a (Black Line In): present =3D No
> Pin 0x1b (Black HP Out): present =3D No

>>
>>
>> Is Node 0x17 also the side jack of your p150hm ?
>> pin cap support Detect and Trigger but Misc =3D NO_PRESENCE
>
> Yes, it is between mic and line in jacks, third one from the front. The
> only difference is that there is red light coming out of it.
>

you can use hda-verb to set the pin default of 0x17 and use
hda-jack-sense-test retest the side jack

The red light is due to you turn "IEC958 Default PCM" on since this
switch copy the signal to digital out

If you don't use SPDIF, may need to turn off this switch to turn off
red light and save power for your notebook

Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]


To add the missing pin default of side jack 0x17

	ALC662_FIXUP_ASUS_MODE8,
+	ALC892_FIXUP_CLEVO_4ST_8CH,
};

static const struct alc_fixup alc662_fixups[] =3D {


+	[ALC892_FIXUP_CLEVO_4ST_8CH] =3D {
+		.type =3D ALC_FIXUP_PINS,
+		.v.pins =3D (const struct alc_pincfg[]) {
+/*
+  need to be same location as the other jack
+  may need to change the default association and sequence since
+  Lower Default Association values would be higher in priority for resourc=
es
+  such as processing nodes or Input and Output Converters.
+  A value of 0000b is reserved and should not be used
+*/
+			{ 0x17, 0x01011013 }, /* Side */
+			{ }
+		},
+	},


+	SND_PCI_QUIRK(0x1558, 0x5102, "Clevo P150HM", ALC892_FIXUP_CLEVO_4ST_8CH),
+	SND_PCI_QUIRK(0x1558, 0x7100, "Clevo P170HM", ALC892_FIXUP_CLEVO_4ST_8CH),

SImilar case are those notebooks  hda-emu/codecs/alc1200-msi-gx620
which has 1 hp(green), 1 line-in(blue), 1 ext-mic(pink) and 1 line
out(grey) at same location (ext rear)   for surround71 (and also 1
speakers, 1 int mic)


hda_codec: ALC1200: BIOS auto-probing.
hda_codec: ALC1200: SKU not ready 0x598301f0
autoconfig: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:line
   speaker_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
   hp_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
   mono: mono_out=3D0x0
   dig-out=3D0x1e/0x0
   inputs: Mic=3D0x18 Internal Mic=3D0x19 Line=3D0x1a


CTRL: add: Line-Out Jack:0
CTRL: add: Headphone Jack:0
CTRL: add: Mic Jack:0
CTRL: add: Line Jack:0

> get 1
1 Channel Mode:0
ITEM: 0:2ch, 1:4ch, 2:6ch, VAL: [2ch]

what is missing are
1) 8ch in "Channel Mode" ,
2) Side Playback Volume
3)Side Playback Switch

Study the logic to add 8ch and "side" in

1) alc_auto_fill_dac_nids()
2) alc_auto_fill_multi_ios() which add line-in and mic jack to multi_ios,


This mean that when switch to 6/8 channel mode, it will conflict with
automic detection since the pin cap alc892 's mic jack does not
support impedance sense and the driver does not know the plug is mic
or speaker by measuring the impedance

The driver have to disable automic detection when user switch "channel
mode" to 6ch/8ch as the user should still able to use the internal mic
when the external mic jack is retasked as output


>>
>> which node is your subwoofer ?
>
> This I have not figured out yet unfortunately. Keep in mind that in
> windows you need THX TruStudio PRO to get it working, and the config is
> advertised as stereo. There was a discussion about this on
> notebookreview forums [1], so maybe it configured in some weird way?
>

you have to find out whether subwoofer is connected to 0x16 of your
p150hm since your mic jack (retasked as clfe) is connected to dac 0x4.
