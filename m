From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Tue, 29 Nov 2011 07:45:07 +0800
Message-ID: <CAN8ccibQX-Lqdn0T-WWtkqjM427TenpLX4OuzuwSCOz7j4RcWQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EE3510393E
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 00:45:08 +0100 (CET)
Received: by bkat8 with SMTP id t8so8308894bka.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 15:45:07 -0800 (PST)
In-Reply-To: <javv4p$olp$1@dough.gmane.org>
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
>
> This is what is shown in /var/log/messages:
>
> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156689] Front playback volume 2
> pin 14
> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156695] Front playback switch =
14
> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156789] Surround playback
> volume 3 pin 1a
> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156794] Surround playback swit=
ch 1a
> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156956] Side playback volume 5
> pin 17
> Nov 28 11:59:27 snowball2 kernel: [ =A0 19.156960] Side playback switch 17
>
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
>
> With the above version and everything is almost perfect:
>
> http://www.alsa-project.org/db/?f=3D35d300b2eaec79699ec37febc6321687a894b=
e50
>
> * mute for side channel is present and functions correctly
> * auto-mute situation is unchanged, but I don't think it matters
> * speaker/HP controls are much neater
> =A0- front mute and slider control the internal speakers
> =A0- headphone mute and slider control the headphone jack
>
> The only nitpick would be that the alt device does not work:

There was a patch which add "Independent hp" swtich and create device
2 for alc892 desktop with 6 jacks at rear panel

http://thread.gmane.org/gmane.linux.alsa.devel/84653/focus=3D84695

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 3: ALC892 Digital [ALC892 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

you can change "independent_hp" to "alt playback" in that patch

	hda_nid_t alt_dac_nid;
+	int alt_playback;
+	int alt_playback_max;


static int alc_alt_playback_info(struct snd_kcontrol *kcontrol,
				   struct snd_ctl_elem_info *uinfo)
{
	struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
	struct alc_spec *spec =3D codec->spec;
	static const char * const texts[] =3D { "OFF", "Headphone", "Side", NULL};
	int index;
	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
	uinfo->count =3D 1;
	uinfo->value.enumerated.items =3D spec->alt_playback_max;
	index =3D uinfo->value.enumerated.item;
	if (index >=3D spec->alt_playback_max)
		index =3D 1;
	strcpy(uinfo->value.enumerated.name, texts[index]);
	return 0;
}

static int alc_alt_playback_get(struct snd_kcontrol *kcontrol,
				  struct snd_ctl_elem_value *ucontrol)
{
	struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
	struct alc_spec *spec =3D codec->spec;
	ucontrol->value.enumerated.item[0] =3D spec->alt_playback;
	return 0;
}

static int alc_alt_playback_put(struct snd_kcontrol *kcontrol,
				  struct snd_ctl_elem_value *ucontrol)
{
	struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
	struct alc_spec *spec =3D codec->spec;
	unsigned int select =3D ucontrol->value.enumerated.item[0];
	if (spec->alt_playback !=3D select) {
	        spec->alt_playback =3D select;
		switch(spec->alt_playback) {
			spec->multiout.hp_out_nid[0] =3D 0;
			break;
		case 1:
			spec->multiout.hp_out_nid[0] =3D spec->alt_dac_nid;
			break;
		case 2:
			break;
		}
		return 1;
	}
	return 0;
}

static const struct snd_kcontrol_new alc_alt_playback_switch[] =3D {
	{
		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
		.name =3D "Alternate Playback Switch",
		.info =3D alc_alt_playback_info,
		.get =3D alc_alt_playback_get,
		.put =3D alc_alt_playback_put,
	},
	{ } /* end */
};

>
> $ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 1: ALC892 Digital [ALC892 Digital]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 1: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 1: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 1: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
>
> And that the sound is coming out of the side jack no matter the number
> of channels.
>
>>
>> b) use "Headphone" for "alt playback"
>>
>> In function alc_auto_fill_dac_nids()
>>
>> + =A0 =A0 =A0spec->alt_dac_nid =3D spec->multiout.hp_out_nid[0];
>> =A0 =A0 =A0 return 0;
>
> I also tried this version (attached with versionb suffix), it works even
> better. As with version a), controls are working correctly. Auto-mute
> still mutes upon plugging into either side or headphone jack no matter
> the alsamixer setting. Alt device is still not there. The improvement is
> that sound only comes out of the side jack when alsamixer is set to 8
> channels.
>
> http://www.alsa-project.org/db/?f=3D31f808d43fc26c29718d239600741b5b069ce=
427
>
> So it seems like the version b does everything it is supposed to, maybe
> aside from the side jack muting behaviour.
> Summing up, when it comes to P150HM, the only missing piece is the
> internal subwoofer. I tried emailing Andrew, who started this thread,
> but got no answer so far. The problem might be that we might need to
> figure out what is that THX TruStudio PRO is doing under Windows that
> makes the internal subwoofer work.


Take a look at the removed model=3D"targa_8ch_dig" which touch those gpio

Have you ask the notebook vendor clevo support/engineer the subwoofer
is connected to which pin of alc892 ?

> Once again, thank you for all the input so far.
>
> Best regards,
> Julian
>
