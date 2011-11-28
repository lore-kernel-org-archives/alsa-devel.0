From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Mon, 28 Nov 2011 19:46:46 +0800
Message-ID: <CAN8ccibQjaSh9LUmab75hY6VDw4nm2RLPxa9Gj2p3s-FHBBkwA@mail.gmail.com>
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
	<javnn0$m3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id EE8BD245E8
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 12:46:46 +0100 (CET)
Received: by faat7 with SMTP id t7so78393faa.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 03:46:46 -0800 (PST)
In-Reply-To: <javnn0$m3$1@dough.gmane.org>
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

2011/11/28 Julian Sikorski <belegdol@gmail.com>:
> W dniu 28.11.2011 01:42, Raymond Yau pisze:
>> 2011/11/25 Julian Sikorski <belegdol@gmail.com>:
>>> W dniu 25.11.2011 07:39, Raymond Yau pisze:
>>>> 2011/11/22 Julian Sikorski <belegdol@gmail.com>:
>>>>
>>>> Don't have any realtek codec, not sure why hda-jack-sense-test.py
>>>> locked up when you use user_pin_configs
>>>>
>>>>>>> I then applied your patch on top of Fedora 3.1.1 kernel (crude patch
>>>>>>> attached). After reboot:
>>>>>>> * hda-jack-sense-test.py was still working, without lockups this ti=
me
>>>>>>> * alsamixer -c0 revealed a new "Front" slider, which was controllin=
g the
>>>>>>> volume on 0x17
>>>>>>> * there was still no 8-channel mode (probably related to what you w=
rote
>>>>>>> below)
>>>>>>> * there were more options for auto mute (Disabled, Speaker Only, Li=
ne
>>>>>>> Out+Speaker)
>>>>>>> * here is the new alsa-info.sh:
>>>>>>> http://www.alsa-project.org/db/?f=3D923b75ad3997dc8f5878852e327f9b9=
99a196052
>>>>>>>
>>>>>>
>>>>>>
>>>>>>>>
>>>>>>>> To add the missing pin default of side jack 0x17
>>>>>>>>
>>>>>>>> =A0 =A0 =A0 ALC662_FIXUP_ASUS_MODE8,
>>>>>>>> + =A0 =A0 ALC892_FIXUP_CLEVO_4ST_8CH,
>>>>>>>> };
>>>>>>>>
>>>>>>>> static const struct alc_fixup alc662_fixups[] =3D {
>>>>>>>>
>>>>>>>>
>>>>>>>> + =A0 =A0 [ALC892_FIXUP_CLEVO_4ST_8CH] =3D {
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .type =3D ALC_FIXUP_PINS,
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .v.pins =3D (const struct alc_pincfg[]) {
>>>>>>>> +/*
>>>>>>>> + =A0need to be same location as the other jack
>>>>>>>> + =A0may need to change the default association and sequence since
>>>>>>>> + =A0Lower Default Association values would be higher in priority =
for resources
>>>>>>>> + =A0such as processing nodes or Input and Output Converters.
>>>>>>>> + =A0A value of 0000b is reserved and should not be used
>>>>>>>> +*/
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { 0x17, 0x01011013 }, /*=
 Side */
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { }
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>>>>>>>> + =A0 =A0 },
>>>>>>>>
>>>>>>>>
>>>>>>>> + =A0 =A0 SND_PCI_QUIRK(0x1558, 0x5102, "Clevo P150HM", ALC892_FIX=
UP_CLEVO_4ST_8CH),
>>>>>>>> + =A0 =A0 SND_PCI_QUIRK(0x1558, 0x7100, "Clevo P170HM", ALC892_FIX=
UP_CLEVO_4ST_8CH),
>>>>>>>>
>>>>>>>> SImilar case are those notebooks =A0hda-emu/codecs/alc1200-msi-gx6=
20
>>>>>>>> which has 1 hp(green), 1 line-in(blue), 1 ext-mic(pink) and 1 line
>>>>>>>> out(grey) at same location (ext rear) =A0 for surround71 (and also=
 1
>>>>>>>> speakers, 1 int mic)
>>>>>>>>
>>>>>>>>
>>>>>>>> hda_codec: ALC1200: BIOS auto-probing.
>>>>>>>> hda_codec: ALC1200: SKU not ready 0x598301f0
>>>>>>>> autoconfig: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:line
>>>>>>>> =A0 =A0speaker_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
>>>>>>>> =A0 =A0hp_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
>>>>>>>> =A0 =A0mono: mono_out=3D0x0
>>>>>>>> =A0 =A0dig-out=3D0x1e/0x0
>>>>>>>> =A0 =A0inputs: Mic=3D0x18 Internal Mic=3D0x19 Line=3D0x1a
>>>>>>>>
>>>>>>>>
>>>>>>>> CTRL: add: Line-Out Jack:0
>>>>>>>> CTRL: add: Headphone Jack:0
>>>>>>>> CTRL: add: Mic Jack:0
>>>>>>>> CTRL: add: Line Jack:0
>>>>>>>>
>>>>>>>>> get 1
>>>>>>>> 1 Channel Mode:0
>>>>>>>> ITEM: 0:2ch, 1:4ch, 2:6ch, VAL: [2ch]
>>>>>>>>
>>>>
>>>> After the pin fixup, your notebook is almost like alc1200 msi gx460
>>>> except speaker and hp are swapped, this mean that those volume
>>>> controls and switches are similar to targa_mixer , targa_8ch_mixer of
>>>> model=3D"targa-8ch-dig"
>>>>
>>>>>>>>
>>>>>>>> This mean that when switch to 6/8 channel mode, it will conflict w=
ith
>>>>>>>> automic detection since the pin cap alc892 's mic jack does not
>>>>>>>> support impedance sense and the driver does not know the plug is m=
ic
>>>>>>>> or speaker by measuring the impedance
>>>>>>>>
>>>>>>>> The driver have to disable automic detection when user switch "cha=
nnel
>>>>>>>> mode" to 6ch/8ch as the user should still able to use the internal=
 mic
>>>>>>>> when the external mic jack is retasked as output
>>>>>>>>
>>>>
>>>> The are some difference between p170hm and your p150hm if p170hm has
>>>> 5.1 speakers which still can have auto mic detection enabled.
>>>>
>>>>
>>>> you can add the following code in alc_auto_ch_mode_put() for debugging
>>>> and need to switch "auto mute mode" to "speaker" for 8 channels
>>>>
>>>>
>>>> =A0 =A0 =A0 if (spec->need_dac_fix && !spec->const_channel_count)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.num_dacs =3D spec->multiout=
.max_channels / 2;
>>>>
>>>> + =A0 =A0 printk(KERN_INFO "ch =3D %d\n",ch);
>>>> + =A0 =A0 printk(KERN_INFO "max channel %d\n",spec->multiout.max_chann=
els);
>>>> + =A0 =A0 for (i=3D0; i<spec->autocfg.hp_outs; i++)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "hp dac(%d) %x pin %x\n", i,
>>>> spec->multiout.hp_out_nid[i], spec->autocfg.hp_pins[i]);
>>>> + =A0 =A0 for (i=3D0; i<spec->multiout.num_dacs; i++)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "private_dac(%d) %x\n", i, =
spec->private_dac_nids[i]);
>>>> + =A0 =A0 for (i=3D0; i<spec->autocfg.line_outs; i++)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "line_out(%d) pin %x\n", i,=
 spec->autocfg.line_out_pins[i]);
>>>> + =A0 =A0 for (i=3D0; i<spec->multiout.num_dacs-1; i++)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "multi_io(%d) dac %x pin %x=
\n", i,
>>>> spec->multi_io[i].dac, spec->multi_io[i].pin);
>>>> + =A0 =A0 for (i=3D0; i<spec->autocfg.speaker_outs; i++)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "extra_out(%d) dac %x pin %=
x\n", i,
>>>> spec->multiout.extra_out_nid[i], spec->autocfg.speaker_pins[i]);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1
>>>
>>> This is what appears in /var/log/messages if you go from 8 to 2 channels
>>> and back:
>>>
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853640] ch =3D 2
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853642] max channel 6
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853643] hp dac(0) 0 pin 1b
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853644] private_dac(0) 2
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853645] private_dac(1) 3
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853646] private_dac(2) 4
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853647] private_dac(3) 5
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853648] line_out(0) pin 17
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853649] multi_io(0) dac 3 pin =
1a
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853650] multi_io(1) dac 4 pin =
18
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853651] multi_io(2) dac 5 pin =
17
>>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853652] extra_out(0) dac 0 pin=
 14
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952829] ch =3D 1
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952835] max channel 4
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952840] hp dac(0) 0 pin 1b
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952843] private_dac(0) 2
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952846] private_dac(1) 3
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952849] private_dac(2) 4
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952852] private_dac(3) 5
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952855] line_out(0) pin 17
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952859] multi_io(0) dac 3 pin =
1a
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952863] multi_io(1) dac 4 pin =
18
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952866] multi_io(2) dac 5 pin =
17
>>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952870] extra_out(0) dac 0 pin=
 14
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378952] ch =3D 0
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378958] max channel 2
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378963] hp dac(0) 0 pin 1b
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378966] private_dac(0) 2
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378969] private_dac(1) 3
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378972] private_dac(2) 4
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378975] private_dac(3) 5
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378978] line_out(0) pin 17
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378982] multi_io(0) dac 3 pin =
1a
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.379002] multi_io(1) dac 4 pin =
18
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.379006] multi_io(2) dac 5 pin =
17
>>> Nov 25 13:05:26 snowball2 kernel: [ 1531.379010] extra_out(0) dac 0 pin=
 14
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746269] ch =3D 1
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746275] max channel 4
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746279] hp dac(0) 0 pin 1b
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746283] private_dac(0) 2
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746286] private_dac(1) 3
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746289] private_dac(2) 4
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746291] private_dac(3) 5
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746295] line_out(0) pin 17
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746298] multi_io(0) dac 3 pin =
1a
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746302] multi_io(1) dac 4 pin =
18
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746306] multi_io(2) dac 5 pin =
17
>>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746310] extra_out(0) dac 0 pin=
 14
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174127] ch =3D 2
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174133] max channel 6
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174195] hp dac(0) 0 pin 1b
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174199] private_dac(0) 2
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174202] private_dac(1) 3
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174205] private_dac(2) 4
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174208] private_dac(3) 5
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174211] line_out(0) pin 17
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174215] multi_io(0) dac 3 pin =
1a
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174219] multi_io(1) dac 4 pin =
18
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174223] multi_io(2) dac 5 pin =
17
>>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174226] extra_out(0) dac 0 pin=
 14
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111893] ch =3D 3
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111900] max channel 8
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111904] hp dac(0) 0 pin 1b
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111908] private_dac(0) 2
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111911] private_dac(1) 3
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111914] private_dac(2) 4
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111917] private_dac(3) 5
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111920] line_out(0) pin 17
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111924] multi_io(0) dac 3 pin =
1a
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111927] multi_io(1) dac 4 pin =
18
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111931] multi_io(2) dac 5 pin =
17
>>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111935] extra_out(0) dac 0 pin=
 14
>>>
>>>>
>>>> Try the following code =A0which try to assign dac 02, 03, 04, and 05 to
>>>> spec->private_dac front, surround, clfe and side.
>>>>
>>>> static int alc_auto_fill_dac_nids(struct hda_codec *codec)
>>>> {
>>>> ...
>>>> =A0again:
>>>> =A0 =A0 =A0 /* set num_dacs once to full for alc_auto_look_for_dac() */
>>>> =A0 =A0 =A0 spec->multiout.num_dacs =3D cfg->line_outs;
>>>> =A0 =A0 =A0 spec->multiout.hp_out_nid[0] =3D 0;
>>>> =A0 =A0 =A0 spec->multiout.extra_out_nid[0] =3D 0;
>>>> =A0 =A0 =A0 memset(spec->private_dac_nids, 0, sizeof(spec->private_dac=
_nids));
>>>> =A0 =A0 =A0 spec->multiout.dac_nids =3D spec->private_dac_nids;
>>>>
>>>> + =A0 =A0 if (cfg->hp_outs =3D=3D 1 && cfg->line_outs =3D=3D 1 &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 cfg->num_inputs >=3D 3 && cfg->speaker_outs =
>=3D 1) {
>>>> +/* assign 0x02 as Front DAC by using speaker or hp pins*/
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 spec->private_dac_nids[0] =A0=3D alc_auto_lo=
ok_for_dac(codec,
>>>> cfg->speaker_pins[0]);
>>>> +/* hp , mic and line-in at the same location
>>>> + =A0 use alc_auto_fill_multi_ios() to assign surround and clfe dacs
>>>> +*/
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 defcfg =3D snd_hda_codec_get_pincfg(codec, c=
fg->hp_pins[0]);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 location =3D get_defcfg_location(defcfg);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.num_dacs =3D 1;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 num_pins =3D alc_auto_fill_multi_ios(codec, =
location, 1);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (num_pins > 0) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multi_ios =3D num_pins;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->ext_channel_count =3D =
2;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.num_dacs =3D =
num_pins + 1;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> +/* an ugly hack to add side as multi io even side does not support in=
put
>>>> + =A0 set pin ctl to PIN_OUT to set multi_io[2].ctl_in to PIN_OUT */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (location =3D=3D get_defcfg_location(snd_=
hda_codec_get_pincfg(codec,
>>>> cfg->line_out_pins[0]))) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->private_dac_nids[3] =
=3D alc_auto_look_for_dac(codec,
>>>> cfg->line_out_pins[0]);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multi_io[2].dac =3D sp=
ec->private_dac_nids[3];
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multi_io[2].pin =3D cf=
g->line_out_pins[0];
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write(codec, c=
fg->line_out_pins[0], 0,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_VERB_SE=
T_PIN_WIDGET_CONTROL, PIN_OUT);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multi_ios++;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.num_dacs++;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>>> + =A0 =A0 }
>>>
>>> It is much better now. I applied the attached patch and 2, 4, 6 and 8
>>> channel sound is working, enabling outputs incrementally as I change the
>>> number of channels in alsamixer. Observations:
>>
>>
>>> * there is no mute for side channel
>>
>>> * no matter if Auto-Mute is set to Speaker or Line Out+Speaker, speakers
>>> will mute upon plugging a jack into either headphone or side/spdif sock=
et
>>> * there is a "front" slider which controls internal speakers and HP
>>> jack, but the mute control under it does nothing. There are separate
>>> mute controls for HP and Speakers, which work as advertised.
>>> This is the alsa-info.sh output:
>>> http://www.alsa-project.org/db/?f=3D7df8ccac0a5ae751110f7b7e56f9e0ba5cc=
3b302
>>> Looks like we are almost there, thanks for all the input so far!
>>
>>
>> There is a bug in hda-emu which cannot detect two playback switches
>> "Front" and "Side" create at same switch pin
>>
>> Try add the following to dump the value of switch pin
>>
>> In function alc_auto_create_multi_out_ctls()
>>
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s playback =
volume %x pin %x\n",name,vol,pin);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D alc_auto_add_stereo_=
vol(codec, name, index, vol);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s playback =
switch %x\n",name,sw);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D alc_auto_add_stereo_=
sw(codec, name, index, sw);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>
>>>>>>>>>> Plug the front speaker cables into the Headphone-Out Jack.
>>>>>>>>>>
>>>>>>>>>> =95 Line-In Jack =3D Rear Speaker Out
>>>>>>>>>> =95 Microphone-In Jack =3D Center/Subwoofer Speaker Out
>>>>>>>>>> =95 S/PDIF-Out Jack =3D Side Speaker Out (for 7.1 Surround Sound=
 Only)
>>
>>
>> Method 1) HP Playback volume for HP jack and Speaker Playback Volume
>>
>>
>> =A0fix the "Side Playback Switch" and "Front playback Switch"
>>
>> In function alc_auto_create_multi_out_ctls()
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin =3D cfg->line_out_pins[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cfg->speaker_pins[0] &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_defcfg_loc=
ation(snd_hda_codec_get_pincfg(codec, cfg->hp_pins[0])) =3D=3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_defcfg_l=
ocation(snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0])))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin =3D cfg->s=
peaker_pins[0];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin =3D cfg->l=
ine_out_pins[i];
>>
>> add "Headpone Playback Volume" by using dac 0x25
>>
>> In function alc_auto_fill_dac_nids() and the end of previous patch in
>> previous email
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multi_ios++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.num_dacs++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.hp_out_nid[0] =3D alc_auto_look=
_for_dac(codec, cfg->hp_pins[0]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>>
>>>>>>>>>> =95 S/PDIF-Out Jack =3D Side Speaker Out (for 7.1 Surround Sound=
 Only)
>>
>> assign dac spec->alt_dac_nid for creating alt playback device
>>
>> aplay -Dhw:0,2 any.wav
>>
>> Try either a) or b) but not both
>> a) use "side jack" for "alt playback" but device 2 be disabled when
>> channel mode is 8ch
>>
>> In function alc_auto_fill_dac_nids()
>>
>> + =A0 =A0 spec->alt_dac_nid =3D spec->private_dac_nids[3];
>> =A0 =A0 =A0 return 0;
>>
>> in function alc_set_multi_io()
>>
>>
>> =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( i < 2 ) {
>
> Patched kernel does not build (the patch I used is attached):
> sound/pci/hda/patch_realtek.c: In function 'alc_set_multi_io':
> sound/pci/hda/patch_realtek.c:3660:8: error: 'i' undeclared (first use
> in this function)
> sound/pci/hda/patch_realtek.c:3660:8: note: each undeclared identifier
> is reported only once for each function it appears in
> make[3]: *** [sound/pci/hda/patch_realtek.o] Error 1
>
> Regards,
> Julian
>
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_amp_stereo(cod=
ec, nid, HDA_OUTPUT, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0HDA_AMP_MUTE, HDA_AMP_MUTE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_update_cache(codec, nid, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0AC_VERB_SET_PIN_WIDGET_CONTROL,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0spec->multi_io[idx].ctl_in);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (get_wcaps(codec, nid) & AC_=
WCAP_OUT_AMP)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_amp=
_stereo(codec, nid, HDA_OUTPUT, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0HDA_AMP_MUTE, HDA_AMP_MUTE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_update_cache(cod=
ec, nid, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0AC_VERB_SET_PIN_WIDGET_CONTROL,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0spec->multi_io[idx].ctl_in);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>>
>> b) use "Headphone" for "alt playback"
>>
>> In function alc_auto_fill_dac_nids()
>>
>> + =A0 =A0 =A0spec->alt_dac_nid =3D spec->multiout.hp_out_nid[0];
>> =A0 =A0 =A0 return 0;
>
>

Sorry, it should be  idx instead of i

             if ( idx < 2)

it is a hack to set PIN_WIDGET_CONTROL of two input pins (idx=3D0 or
idx=3D1) to ctl.in (PIN_IN and PIN_MIC) and does not mute side jack when
idx =3D 2 for alt_playback when channel mode is not 8ch
