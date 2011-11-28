From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Mon, 28 Nov 2011 13:34:33 +0100
Message-ID: <javv4p$olp$1@dough.gmane.org>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050800080809080403020405"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 2075C24413
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 13:34:58 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1RV0Q8-0008OV-95
	for alsa-devel@alsa-project.org; Mon, 28 Nov 2011 13:34:52 +0100
Received: from 217-162-57-177.dynamic.hispeed.ch ([217.162.57.177])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 13:34:52 +0100
Received: from belegdol by 217-162-57-177.dynamic.hispeed.ch with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 13:34:52 +0100
In-Reply-To: <CAN8cciYn_CSgrXHThe=TRBmC98e_XhkT=W8f=UaPp5Tg-c7vSw@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------050800080809080403020405
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

W dniu 28.11.2011 01:42, Raymond Yau pisze:
> 2011/11/25 Julian Sikorski <belegdol@gmail.com>:
>> W dniu 25.11.2011 07:39, Raymond Yau pisze:
>>> 2011/11/22 Julian Sikorski <belegdol@gmail.com>:
>>>
>>> Don't have any realtek codec, not sure why hda-jack-sense-test.py
>>> locked up when you use user_pin_configs
>>>
>>>>>> I then applied your patch on top of Fedora 3.1.1 kernel (crude pat=
ch
>>>>>> attached). After reboot:
>>>>>> * hda-jack-sense-test.py was still working, without lockups this t=
ime
>>>>>> * alsamixer -c0 revealed a new "Front" slider, which was controlli=
ng the
>>>>>> volume on 0x17
>>>>>> * there was still no 8-channel mode (probably related to what you =
wrote
>>>>>> below)
>>>>>> * there were more options for auto mute (Disabled, Speaker Only, L=
ine
>>>>>> Out+Speaker)
>>>>>> * here is the new alsa-info.sh:
>>>>>> http://www.alsa-project.org/db/?f=3D923b75ad3997dc8f5878852e327f9b=
999a196052
>>>>>>
>>>>>
>>>>>
>>>>>>>
>>>>>>> To add the missing pin default of side jack 0x17
>>>>>>>
>>>>>>>       ALC662_FIXUP_ASUS_MODE8,
>>>>>>> +     ALC892_FIXUP_CLEVO_4ST_8CH,
>>>>>>> };
>>>>>>>
>>>>>>> static const struct alc_fixup alc662_fixups[] =3D {
>>>>>>>
>>>>>>>
>>>>>>> +     [ALC892_FIXUP_CLEVO_4ST_8CH] =3D {
>>>>>>> +             .type =3D ALC_FIXUP_PINS,
>>>>>>> +             .v.pins =3D (const struct alc_pincfg[]) {
>>>>>>> +/*
>>>>>>> +  need to be same location as the other jack
>>>>>>> +  may need to change the default association and sequence since
>>>>>>> +  Lower Default Association values would be higher in priority f=
or resources
>>>>>>> +  such as processing nodes or Input and Output Converters.
>>>>>>> +  A value of 0000b is reserved and should not be used
>>>>>>> +*/
>>>>>>> +                     { 0x17, 0x01011013 }, /* Side */
>>>>>>> +                     { }
>>>>>>> +             },
>>>>>>> +     },
>>>>>>>
>>>>>>>
>>>>>>> +     SND_PCI_QUIRK(0x1558, 0x5102, "Clevo P150HM", ALC892_FIXUP_=
CLEVO_4ST_8CH),
>>>>>>> +     SND_PCI_QUIRK(0x1558, 0x7100, "Clevo P170HM", ALC892_FIXUP_=
CLEVO_4ST_8CH),
>>>>>>>
>>>>>>> SImilar case are those notebooks  hda-emu/codecs/alc1200-msi-gx62=
0
>>>>>>> which has 1 hp(green), 1 line-in(blue), 1 ext-mic(pink) and 1 lin=
e
>>>>>>> out(grey) at same location (ext rear)   for surround71 (and also =
1
>>>>>>> speakers, 1 int mic)
>>>>>>>
>>>>>>>
>>>>>>> hda_codec: ALC1200: BIOS auto-probing.
>>>>>>> hda_codec: ALC1200: SKU not ready 0x598301f0
>>>>>>> autoconfig: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:line
>>>>>>>    speaker_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
>>>>>>>    hp_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
>>>>>>>    mono: mono_out=3D0x0
>>>>>>>    dig-out=3D0x1e/0x0
>>>>>>>    inputs: Mic=3D0x18 Internal Mic=3D0x19 Line=3D0x1a
>>>>>>>
>>>>>>>
>>>>>>> CTRL: add: Line-Out Jack:0
>>>>>>> CTRL: add: Headphone Jack:0
>>>>>>> CTRL: add: Mic Jack:0
>>>>>>> CTRL: add: Line Jack:0
>>>>>>>
>>>>>>>> get 1
>>>>>>> 1 Channel Mode:0
>>>>>>> ITEM: 0:2ch, 1:4ch, 2:6ch, VAL: [2ch]
>>>>>>>
>>>
>>> After the pin fixup, your notebook is almost like alc1200 msi gx460
>>> except speaker and hp are swapped, this mean that those volume
>>> controls and switches are similar to targa_mixer , targa_8ch_mixer of
>>> model=3D"targa-8ch-dig"
>>>
>>>>>>>
>>>>>>> This mean that when switch to 6/8 channel mode, it will conflict =
with
>>>>>>> automic detection since the pin cap alc892 's mic jack does not
>>>>>>> support impedance sense and the driver does not know the plug is =
mic
>>>>>>> or speaker by measuring the impedance
>>>>>>>
>>>>>>> The driver have to disable automic detection when user switch "ch=
annel
>>>>>>> mode" to 6ch/8ch as the user should still able to use the interna=
l mic
>>>>>>> when the external mic jack is retasked as output
>>>>>>>
>>>
>>> The are some difference between p170hm and your p150hm if p170hm has
>>> 5.1 speakers which still can have auto mic detection enabled.
>>>
>>>
>>> you can add the following code in alc_auto_ch_mode_put() for debuggin=
g
>>> and need to switch "auto mute mode" to "speaker" for 8 channels
>>>
>>>
>>>       if (spec->need_dac_fix && !spec->const_channel_count)
>>>               spec->multiout.num_dacs =3D spec->multiout.max_channels=
 / 2;
>>>
>>> +     printk(KERN_INFO "ch =3D %d\n",ch);
>>> +     printk(KERN_INFO "max channel %d\n",spec->multiout.max_channels=
);
>>> +     for (i=3D0; i<spec->autocfg.hp_outs; i++)
>>> +             printk(KERN_INFO "hp dac(%d) %x pin %x\n", i,
>>> spec->multiout.hp_out_nid[i], spec->autocfg.hp_pins[i]);
>>> +     for (i=3D0; i<spec->multiout.num_dacs; i++)
>>> +             printk(KERN_INFO "private_dac(%d) %x\n", i, spec->priva=
te_dac_nids[i]);
>>> +     for (i=3D0; i<spec->autocfg.line_outs; i++)
>>> +             printk(KERN_INFO "line_out(%d) pin %x\n", i, spec->auto=
cfg.line_out_pins[i]);
>>> +     for (i=3D0; i<spec->multiout.num_dacs-1; i++)
>>> +             printk(KERN_INFO "multi_io(%d) dac %x pin %x\n", i,
>>> spec->multi_io[i].dac, spec->multi_io[i].pin);
>>> +     for (i=3D0; i<spec->autocfg.speaker_outs; i++)
>>> +             printk(KERN_INFO "extra_out(%d) dac %x pin %x\n", i,
>>> spec->multiout.extra_out_nid[i], spec->autocfg.speaker_pins[i]);
>>>                return 1
>>
>> This is what appears in /var/log/messages if you go from 8 to 2 channe=
ls
>> and back:
>>
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853640] ch =3D 2
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853642] max channel 6
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853643] hp dac(0) 0 pin 1b
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853644] private_dac(0) 2
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853645] private_dac(1) 3
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853646] private_dac(2) 4
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853647] private_dac(3) 5
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853648] line_out(0) pin 17
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853649] multi_io(0) dac 3 pin=
 1a
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853650] multi_io(1) dac 4 pin=
 18
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853651] multi_io(2) dac 5 pin=
 17
>> Nov 25 13:05:11 snowball2 kernel: [ 1515.853652] extra_out(0) dac 0 pi=
n 14
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952829] ch =3D 1
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952835] max channel 4
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952840] hp dac(0) 0 pin 1b
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952843] private_dac(0) 2
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952846] private_dac(1) 3
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952849] private_dac(2) 4
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952852] private_dac(3) 5
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952855] line_out(0) pin 17
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952859] multi_io(0) dac 3 pin=
 1a
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952863] multi_io(1) dac 4 pin=
 18
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952866] multi_io(2) dac 5 pin=
 17
>> Nov 25 13:05:24 snowball2 kernel: [ 1528.952870] extra_out(0) dac 0 pi=
n 14
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378952] ch =3D 0
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378958] max channel 2
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378963] hp dac(0) 0 pin 1b
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378966] private_dac(0) 2
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378969] private_dac(1) 3
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378972] private_dac(2) 4
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378975] private_dac(3) 5
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378978] line_out(0) pin 17
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.378982] multi_io(0) dac 3 pin=
 1a
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.379002] multi_io(1) dac 4 pin=
 18
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.379006] multi_io(2) dac 5 pin=
 17
>> Nov 25 13:05:26 snowball2 kernel: [ 1531.379010] extra_out(0) dac 0 pi=
n 14
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746269] ch =3D 1
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746275] max channel 4
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746279] hp dac(0) 0 pin 1b
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746283] private_dac(0) 2
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746286] private_dac(1) 3
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746289] private_dac(2) 4
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746291] private_dac(3) 5
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746295] line_out(0) pin 17
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746298] multi_io(0) dac 3 pin=
 1a
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746302] multi_io(1) dac 4 pin=
 18
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746306] multi_io(2) dac 5 pin=
 17
>> Nov 25 13:06:29 snowball2 kernel: [ 1593.746310] extra_out(0) dac 0 pi=
n 14
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174127] ch =3D 2
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174133] max channel 6
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174195] hp dac(0) 0 pin 1b
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174199] private_dac(0) 2
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174202] private_dac(1) 3
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174205] private_dac(2) 4
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174208] private_dac(3) 5
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174211] line_out(0) pin 17
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174215] multi_io(0) dac 3 pin=
 1a
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174219] multi_io(1) dac 4 pin=
 18
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174223] multi_io(2) dac 5 pin=
 17
>> Nov 25 13:06:31 snowball2 kernel: [ 1596.174226] extra_out(0) dac 0 pi=
n 14
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111893] ch =3D 3
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111900] max channel 8
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111904] hp dac(0) 0 pin 1b
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111908] private_dac(0) 2
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111911] private_dac(1) 3
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111914] private_dac(2) 4
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111917] private_dac(3) 5
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111920] line_out(0) pin 17
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111924] multi_io(0) dac 3 pin=
 1a
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111927] multi_io(1) dac 4 pin=
 18
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111931] multi_io(2) dac 5 pin=
 17
>> Nov 25 13:06:33 snowball2 kernel: [ 1598.111935] extra_out(0) dac 0 pi=
n 14
>>
>>>
>>> Try the following code  which try to assign dac 02, 03, 04, and 05 to
>>> spec->private_dac front, surround, clfe and side.
>>>
>>> static int alc_auto_fill_dac_nids(struct hda_codec *codec)
>>> {
>>> ...
>>>  again:
>>>       /* set num_dacs once to full for alc_auto_look_for_dac() */
>>>       spec->multiout.num_dacs =3D cfg->line_outs;
>>>       spec->multiout.hp_out_nid[0] =3D 0;
>>>       spec->multiout.extra_out_nid[0] =3D 0;
>>>       memset(spec->private_dac_nids, 0, sizeof(spec->private_dac_nids=
));
>>>       spec->multiout.dac_nids =3D spec->private_dac_nids;
>>>
>>> +     if (cfg->hp_outs =3D=3D 1 && cfg->line_outs =3D=3D 1 &&
>>> +             cfg->num_inputs >=3D 3 && cfg->speaker_outs >=3D 1) {
>>> +/* assign 0x02 as Front DAC by using speaker or hp pins*/
>>> +             spec->private_dac_nids[0]  =3D alc_auto_look_for_dac(co=
dec,
>>> cfg->speaker_pins[0]);
>>> +/* hp , mic and line-in at the same location
>>> +   use alc_auto_fill_multi_ios() to assign surround and clfe dacs
>>> +*/
>>> +             defcfg =3D snd_hda_codec_get_pincfg(codec, cfg->hp_pins=
[0]);
>>> +             location =3D get_defcfg_location(defcfg);
>>> +             spec->multiout.num_dacs =3D 1;
>>> +             num_pins =3D alc_auto_fill_multi_ios(codec, location, 1=
);
>>> +             if (num_pins > 0) {
>>> +                     spec->multi_ios =3D num_pins;
>>> +                     spec->ext_channel_count =3D 2;
>>> +                     spec->multiout.num_dacs =3D num_pins + 1;
>>> +             }
>>> +/* an ugly hack to add side as multi io even side does not support i=
nput
>>> +   set pin ctl to PIN_OUT to set multi_io[2].ctl_in to PIN_OUT */
>>> +             if (location =3D=3D get_defcfg_location(snd_hda_codec_g=
et_pincfg(codec,
>>> cfg->line_out_pins[0]))) {
>>> +                     spec->private_dac_nids[3] =3D alc_auto_look_for=
_dac(codec,
>>> cfg->line_out_pins[0]);
>>> +                     spec->multi_io[2].dac =3D spec->private_dac_nid=
s[3];
>>> +                     spec->multi_io[2].pin =3D cfg->line_out_pins[0]=
;
>>> +                     snd_hda_codec_write(codec, cfg->line_out_pins[0=
], 0,
>>>                               AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT=
);
>>> +                     spec->multi_ios++;
>>> +                     spec->multiout.num_dacs++;
>>> +             }
>>> +             return 0;
>>> +     }
>>
>> It is much better now. I applied the attached patch and 2, 4, 6 and 8
>> channel sound is working, enabling outputs incrementally as I change t=
he
>> number of channels in alsamixer. Observations:
>=20
>=20
>> * there is no mute for side channel
>=20
>> * no matter if Auto-Mute is set to Speaker or Line Out+Speaker, speake=
rs
>> will mute upon plugging a jack into either headphone or side/spdif soc=
ket
>> * there is a "front" slider which controls internal speakers and HP
>> jack, but the mute control under it does nothing. There are separate
>> mute controls for HP and Speakers, which work as advertised.
>> This is the alsa-info.sh output:
>> http://www.alsa-project.org/db/?f=3D7df8ccac0a5ae751110f7b7e56f9e0ba5c=
c3b302
>> Looks like we are almost there, thanks for all the input so far!
>=20
>=20
> There is a bug in hda-emu which cannot detect two playback switches
> "Front" and "Side" create at same switch pin
>=20
> Try add the following to dump the value of switch pin
>=20
> In function alc_auto_create_multi_out_ctls()
>=20
>=20
> +			printk(KERN_INFO "%s playback volume %x pin %x\n",name,vol,pin);
> 			err =3D alc_auto_add_stereo_vol(codec, name, index, vol);
> 			if (err < 0)
> 				return err;
> +			printk(KERN_INFO "%s playback switch %x\n",name,sw);
> 			err =3D alc_auto_add_stereo_sw(codec, name, index, sw);
> 			if (err < 0)
> 				return err;

This is what is shown in /var/log/messages:

Nov 28 11:59:27 snowball2 kernel: [   19.156689] Front playback volume 2
pin 14
Nov 28 11:59:27 snowball2 kernel: [   19.156695] Front playback switch 14
Nov 28 11:59:27 snowball2 kernel: [   19.156789] Surround playback
volume 3 pin 1a
Nov 28 11:59:27 snowball2 kernel: [   19.156794] Surround playback switch=
 1a
Nov 28 11:59:27 snowball2 kernel: [   19.156956] Side playback volume 5
pin 17
Nov 28 11:59:27 snowball2 kernel: [   19.156960] Side playback switch 17

>=20
>>>>>>>>> Plug the front speaker cables into the Headphone-Out Jack.
>>>>>>>>>
>>>>>>>>> =95 Line-In Jack =3D Rear Speaker Out
>>>>>>>>> =95 Microphone-In Jack =3D Center/Subwoofer Speaker Out
>>>>>>>>> =95 S/PDIF-Out Jack =3D Side Speaker Out (for 7.1 Surround Soun=
d Only)
>=20
>=20
> Method 1) HP Playback volume for HP jack and Speaker Playback Volume
>=20
>=20
>  fix the "Side Playback Switch" and "Front playback Switch"
>=20
> In function alc_auto_create_multi_out_ctls()
>=20
> 		else
> -			pin =3D cfg->line_out_pins[i];
> +			if (cfg->speaker_pins[0] &&
> +				get_defcfg_location(snd_hda_codec_get_pincfg(codec, cfg->hp_pins[0=
])) =3D=3D
> 				get_defcfg_location(snd_hda_codec_get_pincfg(codec, cfg->line_out_p=
ins[0])))
> +				pin =3D cfg->speaker_pins[0];
> +			else
> +				pin =3D cfg->line_out_pins[i];
>=20
> add "Headpone Playback Volume" by using dac 0x25
>=20
> In function alc_auto_fill_dac_nids() and the end of previous patch in
> previous email
>=20
> 			spec->multi_ios++;
> 			spec->multiout.num_dacs++;
> 		}
> +		spec->multiout.hp_out_nid[0] =3D alc_auto_look_for_dac(codec, cfg->h=
p_pins[0]);
> 		return 0;
>=20
>=20
>>>>>>>>> =95 S/PDIF-Out Jack =3D Side Speaker Out (for 7.1 Surround Soun=
d Only)
>=20
> assign dac spec->alt_dac_nid for creating alt playback device
>=20
> aplay -Dhw:0,2 any.wav
>=20
> Try either a) or b) but not both
> a) use "side jack" for "alt playback" but device 2 be disabled when
> channel mode is 8ch
>=20
> In function alc_auto_fill_dac_nids()
> 	=09
> +	spec->alt_dac_nid =3D spec->private_dac_nids[3];
> 	return 0;
>=20
> in function alc_set_multi_io()
>=20
>=20
> 	} else {
> +              if ( i < 2 ) {
> -		if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
> 			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
> 						 HDA_AMP_MUTE, HDA_AMP_MUTE);
> -		snd_hda_codec_update_cache(codec, nid, 0,
> 					   AC_VERB_SET_PIN_WIDGET_CONTROL,
> 					   spec->multi_io[idx].ctl_in);
>=20
> +		       if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
> 			     snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
> 						 HDA_AMP_MUTE, HDA_AMP_MUTE);
> +		        snd_hda_codec_update_cache(codec, nid, 0,
> 					   AC_VERB_SET_PIN_WIDGET_CONTROL,
> 					   spec->multi_io[idx].ctl_in);
> +             }
>=20

With the above version and everything is almost perfect:

http://www.alsa-project.org/db/?f=3D35d300b2eaec79699ec37febc6321687a894b=
e50

* mute for side channel is present and functions correctly
* auto-mute situation is unchanged, but I don't think it matters
* speaker/HP controls are much neater
  - front mute and slider control the internal speakers
  - headphone mute and slider control the headphone jack

The only nitpick would be that the alt device does not work:

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: ALC892 Digital [ALC892 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

And that the sound is coming out of the side jack no matter the number
of channels.

>=20
> b) use "Headphone" for "alt playback"
>=20
> In function alc_auto_fill_dac_nids()
>=20
> +      spec->alt_dac_nid =3D spec->multiout.hp_out_nid[0];
> 	return 0;

I also tried this version (attached with versionb suffix), it works even
better. As with version a), controls are working correctly. Auto-mute
still mutes upon plugging into either side or headphone jack no matter
the alsamixer setting. Alt device is still not there. The improvement is
that sound only comes out of the side jack when alsamixer is set to 8
channels.

http://www.alsa-project.org/db/?f=3D31f808d43fc26c29718d239600741b5b069ce=
427

So it seems like the version b does everything it is supposed to, maybe
aside from the side jack muting behaviour.
Summing up, when it comes to P150HM, the only missing piece is the
internal subwoofer. I tried emailing Andrew, who started this thread,
but got no answer so far. The problem might be that we might need to
figure out what is that THX TruStudio PRO is doing under Windows that
makes the internal subwoofer work.
Once again, thank you for all the input so far.

Best regards,
Julian




--------------050800080809080403020405
Content-Type: text/x-patch;
 name="clevo-0x17-rawhide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="clevo-0x17-rawhide.patch"

diff -up ./sound/pci/hda/patch_realtek.c.clevo ./sound/pci/hda/patch_realtek.c
--- ./sound/pci/hda/patch_realtek.c.clevo	2011-11-28 10:38:29.643369001 +0100
+++ ./sound/pci/hda/patch_realtek.c	2011-11-28 11:32:31.622653828 +0100
@@ -3053,6 +3053,38 @@ static int alc_auto_fill_dac_nids(struct
 	memset(spec->private_dac_nids, 0, sizeof(spec->private_dac_nids));
 	spec->multiout.dac_nids = spec->private_dac_nids;
 
+	if (cfg->hp_outs == 1 && cfg->line_outs == 1 &&
+		cfg->num_inputs >= 3 && cfg->speaker_outs >= 1) {
+	/* assign 0x02 as Front DAC by using speaker or hp pins */
+		spec->private_dac_nids[0]  = alc_auto_look_for_dac(codec, cfg->speaker_pins[0]);
+	/* hp , mic and line-in at the same location
+	 * use alc_auto_fill_multi_ios() to assign surround and clfe dacs
+	 */
+		defcfg = snd_hda_codec_get_pincfg(codec, cfg->hp_pins[0]);
+		location = get_defcfg_location(defcfg);
+		spec->multiout.num_dacs = 1;
+		num_pins = alc_auto_fill_multi_ios(codec, location, 1);
+		if (num_pins > 0) {
+			spec->multi_ios = num_pins;
+			spec->ext_channel_count = 2;
+			spec->multiout.num_dacs = num_pins + 1;
+		}
+	/* an ugly hack to add side as multi io even side does not support input
+	 * set pin ctl to PIN_OUT to set multi_io[2].ctl_in to PIN_OUT
+	 */
+		if (location == get_defcfg_location(snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0]))) {
+			spec->private_dac_nids[3] = alc_auto_look_for_dac(codec, cfg->line_out_pins[0]);
+			spec->multi_io[2].dac = spec->private_dac_nids[3];
+			spec->multi_io[2].pin = cfg->line_out_pins[0];
+			snd_hda_codec_write(codec, cfg->line_out_pins[0], 0,
+				AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+			spec->multi_ios++;
+			spec->multiout.num_dacs++;
+		}
+		spec->multiout.hp_out_nid[0] = alc_auto_look_for_dac(codec, cfg->hp_pins[0]);
+		return 0;
+	}
+
 	/* fill hard-wired DACs first */
 	if (!redone) {
 		for (i = 0; i < cfg->line_outs; i++)
@@ -3126,6 +3158,7 @@ static int alc_auto_fill_dac_nids(struct
 		}
 	}
 
+	spec->alt_dac_nid = spec->private_dac_nids[3];
 	return 0;
 }
 
@@ -3255,7 +3288,12 @@ static int alc_auto_create_multi_out_ctl
 		if (i >= cfg->line_outs)
 			pin = spec->multi_io[i - 1].pin;
 		else
-			pin = cfg->line_out_pins[i];
+			if (cfg->speaker_pins[0] &&
+				get_defcfg_location(snd_hda_codec_get_pincfg(codec, cfg->hp_pins[0])) ==
+				get_defcfg_location(snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0])))
+				pin = cfg->speaker_pins[0];
+			else
+				pin = cfg->line_out_pins[i];
 
 		sw = alc_look_for_out_mute_nid(codec, pin, dac);
 		vol = alc_look_for_out_vol_nid(codec, pin, dac);
@@ -3275,9 +3313,11 @@ static int alc_auto_create_multi_out_ctl
 			if (err < 0)
 				return err;
 		} else {
+			printk(KERN_INFO "%s playback volume %x pin %x\n",name,vol,pin);
 			err = alc_auto_add_stereo_vol(codec, name, index, vol);
 			if (err < 0)
 				return err;
+			printk(KERN_INFO "%s playback switch %x\n",name,sw);
 			err = alc_auto_add_stereo_sw(codec, name, index, sw);
 			if (err < 0)
 				return err;
@@ -3617,12 +3657,16 @@ static int alc_set_multi_io(struct hda_c
 						 HDA_AMP_MUTE, 0);
 		alc_auto_select_dac(codec, nid, spec->multi_io[idx].dac);
 	} else {
-		if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
+		if ( idx < 2 ) {
 			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
 						 HDA_AMP_MUTE, HDA_AMP_MUTE);
-		snd_hda_codec_update_cache(codec, nid, 0,
-					   AC_VERB_SET_PIN_WIDGET_CONTROL,
-					   spec->multi_io[idx].ctl_in);
+			if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
+				snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
+							 HDA_AMP_MUTE, HDA_AMP_MUTE);
+				snd_hda_codec_update_cache(codec, nid, 0,
+							   AC_VERB_SET_PIN_WIDGET_CONTROL,
+							   spec->multi_io[idx].ctl_in);
+		}
 	}
 	return 0;
 }
@@ -3645,6 +3689,19 @@ static int alc_auto_ch_mode_put(struct s
 	spec->multiout.max_channels = spec->ext_channel_count;
 	if (spec->need_dac_fix && !spec->const_channel_count)
 		spec->multiout.num_dacs = spec->multiout.max_channels / 2;
+
+	printk(KERN_INFO "ch = %d\n",ch);
+	printk(KERN_INFO "max channel %d\n",spec->multiout.max_channels);
+	for (i=0; i<spec->autocfg.hp_outs; i++)
+		printk(KERN_INFO "hp dac(%d) %x pin %x\n", i, spec->multiout.hp_out_nid[i], spec->autocfg.hp_pins[i]);
+	for (i=0; i<spec->multiout.num_dacs; i++)
+		printk(KERN_INFO "private_dac(%d) %x\n", i, spec->private_dac_nids[i]);
+	for (i=0; i<spec->autocfg.line_outs; i++)
+		printk(KERN_INFO "line_out(%d) pin %x\n", i, spec->autocfg.line_out_pins[i]);
+	for (i=0; i<spec->multiout.num_dacs-1; i++)
+		printk(KERN_INFO "multi_io(%d) dac %x pin %x\n", i, spec->multi_io[i].dac, spec->multi_io[i].pin);
+	for (i=0; i<spec->autocfg.speaker_outs; i++)
+		printk(KERN_INFO "extra_out(%d) dac %x pin %x\n", i, spec->multiout.extra_out_nid[i], spec->autocfg.speaker_pins[i]);
 	return 1;
 }
 
@@ -5850,6 +5907,7 @@ enum {
 	ALC662_FIXUP_ASUS_MODE6,
 	ALC662_FIXUP_ASUS_MODE7,
 	ALC662_FIXUP_ASUS_MODE8,
+	ALC892_FIXUP_CLEVO_4ST_8CH,
 };
 
 static const struct alc_fixup alc662_fixups[] = {
@@ -5995,6 +6053,20 @@ static const struct alc_fixup alc662_fix
 		.chained = true,
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
+	[ALC892_FIXUP_CLEVO_4ST_8CH] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+/*
+  need to be same location as the other jack
+  may need to change the default association and sequence since
+  Lower Default Association values would be higher in priority for resources
+  such as processing nodes or Input and Output Converters.
+  A value of 0000b is reserved and should not be used
+*/
+			{ 0x17, 0x01011013 }, /* Side */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -6008,6 +6080,8 @@ static const struct snd_pci_quirk alc662
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
+	SND_PCI_QUIRK(0x1558, 0x5102, "Clevo P150HM", ALC892_FIXUP_CLEVO_4ST_8CH),
+	SND_PCI_QUIRK(0x1558, 0x7100, "Clevo P170HM", ALC892_FIXUP_CLEVO_4ST_8CH),
 
 #if 0
 	/* Below is a quirk table taken from the old code.



--------------050800080809080403020405
Content-Type: text/x-patch;
 name="clevo-0x17-rawhide-versionb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="clevo-0x17-rawhide-versionb.patch"

diff -up ./sound/pci/hda/patch_realtek.c.clevo ./sound/pci/hda/patch_realtek.c
--- ./sound/pci/hda/patch_realtek.c.clevo	2011-11-28 12:48:50.083700918 +0100
+++ ./sound/pci/hda/patch_realtek.c	2011-11-28 12:50:49.175466448 +0100
@@ -3053,6 +3053,38 @@ static int alc_auto_fill_dac_nids(struct
 	memset(spec->private_dac_nids, 0, sizeof(spec->private_dac_nids));
 	spec->multiout.dac_nids = spec->private_dac_nids;
 
+	if (cfg->hp_outs == 1 && cfg->line_outs == 1 &&
+		cfg->num_inputs >= 3 && cfg->speaker_outs >= 1) {
+	/* assign 0x02 as Front DAC by using speaker or hp pins */
+		spec->private_dac_nids[0]  = alc_auto_look_for_dac(codec, cfg->speaker_pins[0]);
+	/* hp , mic and line-in at the same location
+	 * use alc_auto_fill_multi_ios() to assign surround and clfe dacs
+	 */
+		defcfg = snd_hda_codec_get_pincfg(codec, cfg->hp_pins[0]);
+		location = get_defcfg_location(defcfg);
+		spec->multiout.num_dacs = 1;
+		num_pins = alc_auto_fill_multi_ios(codec, location, 1);
+		if (num_pins > 0) {
+			spec->multi_ios = num_pins;
+			spec->ext_channel_count = 2;
+			spec->multiout.num_dacs = num_pins + 1;
+		}
+	/* an ugly hack to add side as multi io even side does not support input
+	 * set pin ctl to PIN_OUT to set multi_io[2].ctl_in to PIN_OUT
+	 */
+		if (location == get_defcfg_location(snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0]))) {
+			spec->private_dac_nids[3] = alc_auto_look_for_dac(codec, cfg->line_out_pins[0]);
+			spec->multi_io[2].dac = spec->private_dac_nids[3];
+			spec->multi_io[2].pin = cfg->line_out_pins[0];
+			snd_hda_codec_write(codec, cfg->line_out_pins[0], 0,
+				AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+			spec->multi_ios++;
+			spec->multiout.num_dacs++;
+		}
+		spec->multiout.hp_out_nid[0] = alc_auto_look_for_dac(codec, cfg->hp_pins[0]);
+		return 0;
+	}
+
 	/* fill hard-wired DACs first */
 	if (!redone) {
 		for (i = 0; i < cfg->line_outs; i++)
@@ -3126,6 +3158,7 @@ static int alc_auto_fill_dac_nids(struct
 		}
 	}
 
+	spec->alt_dac_nid = spec->multiout.hp_out_nid[0];
 	return 0;
 }
 
@@ -3255,7 +3288,12 @@ static int alc_auto_create_multi_out_ctl
 		if (i >= cfg->line_outs)
 			pin = spec->multi_io[i - 1].pin;
 		else
-			pin = cfg->line_out_pins[i];
+			if (cfg->speaker_pins[0] &&
+				get_defcfg_location(snd_hda_codec_get_pincfg(codec, cfg->hp_pins[0])) ==
+				get_defcfg_location(snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0])))
+				pin = cfg->speaker_pins[0];
+			else
+				pin = cfg->line_out_pins[i];
 
 		sw = alc_look_for_out_mute_nid(codec, pin, dac);
 		vol = alc_look_for_out_vol_nid(codec, pin, dac);
@@ -3275,9 +3313,11 @@ static int alc_auto_create_multi_out_ctl
 			if (err < 0)
 				return err;
 		} else {
+			printk(KERN_INFO "%s playback volume %x pin %x\n",name,vol,pin);
 			err = alc_auto_add_stereo_vol(codec, name, index, vol);
 			if (err < 0)
 				return err;
+			printk(KERN_INFO "%s playback switch %x\n",name,sw);
 			err = alc_auto_add_stereo_sw(codec, name, index, sw);
 			if (err < 0)
 				return err;
@@ -3645,6 +3685,19 @@ static int alc_auto_ch_mode_put(struct s
 	spec->multiout.max_channels = spec->ext_channel_count;
 	if (spec->need_dac_fix && !spec->const_channel_count)
 		spec->multiout.num_dacs = spec->multiout.max_channels / 2;
+
+	printk(KERN_INFO "ch = %d\n",ch);
+	printk(KERN_INFO "max channel %d\n",spec->multiout.max_channels);
+	for (i=0; i<spec->autocfg.hp_outs; i++)
+		printk(KERN_INFO "hp dac(%d) %x pin %x\n", i, spec->multiout.hp_out_nid[i], spec->autocfg.hp_pins[i]);
+	for (i=0; i<spec->multiout.num_dacs; i++)
+		printk(KERN_INFO "private_dac(%d) %x\n", i, spec->private_dac_nids[i]);
+	for (i=0; i<spec->autocfg.line_outs; i++)
+		printk(KERN_INFO "line_out(%d) pin %x\n", i, spec->autocfg.line_out_pins[i]);
+	for (i=0; i<spec->multiout.num_dacs-1; i++)
+		printk(KERN_INFO "multi_io(%d) dac %x pin %x\n", i, spec->multi_io[i].dac, spec->multi_io[i].pin);
+	for (i=0; i<spec->autocfg.speaker_outs; i++)
+		printk(KERN_INFO "extra_out(%d) dac %x pin %x\n", i, spec->multiout.extra_out_nid[i], spec->autocfg.speaker_pins[i]);
 	return 1;
 }
 
@@ -5850,6 +5903,7 @@ enum {
 	ALC662_FIXUP_ASUS_MODE6,
 	ALC662_FIXUP_ASUS_MODE7,
 	ALC662_FIXUP_ASUS_MODE8,
+	ALC892_FIXUP_CLEVO_4ST_8CH,
 };
 
 static const struct alc_fixup alc662_fixups[] = {
@@ -5995,6 +6049,20 @@ static const struct alc_fixup alc662_fix
 		.chained = true,
 		.chain_id = ALC662_FIXUP_SKU_IGNORE
 	},
+	[ALC892_FIXUP_CLEVO_4ST_8CH] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+/*
+  need to be same location as the other jack
+  may need to change the default association and sequence since
+  Lower Default Association values would be higher in priority for resources
+  such as processing nodes or Input and Output Converters.
+  A value of 0000b is reserved and should not be used
+*/
+			{ 0x17, 0x01011013 }, /* Side */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -6008,6 +6076,8 @@ static const struct snd_pci_quirk alc662
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
+	SND_PCI_QUIRK(0x1558, 0x5102, "Clevo P150HM", ALC892_FIXUP_CLEVO_4ST_8CH),
+	SND_PCI_QUIRK(0x1558, 0x7100, "Clevo P170HM", ALC892_FIXUP_CLEVO_4ST_8CH),
 
 #if 0
 	/* Below is a quirk table taken from the old code.



--------------050800080809080403020405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050800080809080403020405--
