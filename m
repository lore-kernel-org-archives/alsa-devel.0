From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Fri, 25 Nov 2011 13:10:08 +0100
Message-ID: <4ECF85A0.20504@gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090100010106030300080005"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F29DA2433C
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 13:10:11 +0100 (CET)
Received: by eaai13 with SMTP id i13so683005eaa.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 04:10:10 -0800 (PST)
In-Reply-To: <CAN8ccianih_LZZW6n+Ksa0gCo2i3gcbdnV_f8QMJNMjz7p=pbA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090100010106030300080005
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

W dniu 25.11.2011 07:39, Raymond Yau pisze:
> 2011/11/22 Julian Sikorski <belegdol@gmail.com>:
>> W dniu 22.11.2011 06:17, Raymond Yau pisze:
>>> 2011/11/21 Julian Sikorski <belegdol@gmail.com>:
>>>> W dniu 21.11.2011 07:47, Raymond Yau pisze:
>>>>> 2011/11/19 Julian Sikorski <belegdol@gmail.com>:
>>>>>>>> From the official (non-service) manual, page 309:
>>>>>>>>
>>>>>>>
>>>>>>> Refer to P170HM 's photo in user manual
>>>>>>>
>>>>>>> There are 3 speakers and a subwoofer at the bottom of the laptop =
and
>>>>>>> two speakers at the top
>>>>>>>
>>>>>>> Refer to user manual of P150HM,
>>>>>>>
>>>>>>> Plug the front speaker cables into the Headphone-Out Jack.
>>>>>>>
>>>>>>> =95 Line-In Jack =3D Rear Speaker Out
>>>>>>> =95 Microphone-In Jack =3D Center/Subwoofer Speaker Out
>>>>>>> =95 S/PDIF-Out Jack =3D Side Speaker Out (for 7.1 Surround Sound =
Only)
>>>>>
>>>>> You may need to ask Takashi , David, PA developers and Media
>>>>> controller developers how to handle this case
>>>>>
>>>>> since it may need to set_pin_ctl to PIN_HP and PIN_OUT of 0x1b and
>>>>> retasking of input jacks as output  whether PA or Media controller =
API
>>>>> expect to change the name of the volume control and switch from
>>>>> "Headphone" to "Front" by hda-reconfig
>>>>>
>>>>> http://thread.gmane.org/gmane.linux.alsa.devel/91334
>>>>>
>>>>>>>
>>>>>>> 7. As you plug in each cable a dialog box will pop up (see =93Aut=
o Popup
>>>>>>> Dialog=94 on
>>>>>>> page 2 - 9).
>>>>>>>
>>>>>>> Auto Popup Dialog mean support jack detect
>>>>>>>
>>>>>>> you can try David's hda-jack-sense-test.py
>>>>>>>
>>>>>>> http://thread.gmane.org/gmane.linux.alsa.devel/85051
>>>>>>
>>>>>> Yes, it is working:
>>>>>> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
>>>>>> Pin 0x18 (Black Mic): present =3D No
>>>>>> Pin 0x1a (Black Line In): present =3D No
>>>>>> Pin 0x1b (Black HP Out): present =3D Yes
>>>>>> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
>>>>>> Pin 0x18 (Black Mic): present =3D No
>>>>>> Pin 0x1a (Black Line In): present =3D No
>>>>>> Pin 0x1b (Black HP Out): present =3D No
>>>>>> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
>>>>>> Pin 0x18 (Black Mic): present =3D No
>>>>>> Pin 0x1a (Black Line In): present =3D Yes
>>>>>> Pin 0x1b (Black HP Out): present =3D No
>>>>>> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
>>>>>> Pin 0x18 (Black Mic): present =3D Yes
>>>>>> Pin 0x1a (Black Line In): present =3D No
>>>>>> Pin 0x1b (Black HP Out): present =3D No
>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Is Node 0x17 also the side jack of your p150hm ?
>>>>>>> pin cap support Detect and Trigger but Misc =3D NO_PRESENCE
>>>>>>
>>>>>> Yes, it is between mic and line in jacks, third one from the front=
. The
>>>>>> only difference is that there is red light coming out of it.
>>>>>>
>>>>>
>>>>> you can use hda-verb to set the pin default of 0x17 and use
>>>>> hda-jack-sense-test retest the side jack
>>>>
>>>> Well, it kind of works:
>>>> * I was able to assign 0x01011013 to pin 0x17 using user_pin_configs
>>>> * it then shows up in hda-jack-sense-test.py, which detects if the j=
ack
>>>> is connected
>>>> $ sudo python hda-jack-sense-test.py
>>>> [sudo] password for julas:
>>>> Pin 0x17 (Black Line Out): present =3D Yes
>>>> Pin 0x18 (Black Mic): present =3D No
>>>> Pin 0x1a (Black Line In): present =3D No
>>>> Pin 0x1b (Black HP Out): present =3D No
>>>> * for some reason this program started locking up after showing the
>>>> output, I am not sure if this is related.
>=20
> Don't have any realtek codec, not sure why hda-jack-sense-test.py
> locked up when you use user_pin_configs
>=20
>>>> I then applied your patch on top of Fedora 3.1.1 kernel (crude patch
>>>> attached). After reboot:
>>>> * hda-jack-sense-test.py was still working, without lockups this tim=
e
>>>> * alsamixer -c0 revealed a new "Front" slider, which was controlling=
 the
>>>> volume on 0x17
>>>> * there was still no 8-channel mode (probably related to what you wr=
ote
>>>> below)
>>>> * there were more options for auto mute (Disabled, Speaker Only, Lin=
e
>>>> Out+Speaker)
>>>> * here is the new alsa-info.sh:
>>>> http://www.alsa-project.org/db/?f=3D923b75ad3997dc8f5878852e327f9b99=
9a196052
>>>>
>>>
>>>
>>>>>
>>>>> To add the missing pin default of side jack 0x17
>>>>>
>>>>>       ALC662_FIXUP_ASUS_MODE8,
>>>>> +     ALC892_FIXUP_CLEVO_4ST_8CH,
>>>>> };
>>>>>
>>>>> static const struct alc_fixup alc662_fixups[] =3D {
>>>>>
>>>>>
>>>>> +     [ALC892_FIXUP_CLEVO_4ST_8CH] =3D {
>>>>> +             .type =3D ALC_FIXUP_PINS,
>>>>> +             .v.pins =3D (const struct alc_pincfg[]) {
>>>>> +/*
>>>>> +  need to be same location as the other jack
>>>>> +  may need to change the default association and sequence since
>>>>> +  Lower Default Association values would be higher in priority for=
 resources
>>>>> +  such as processing nodes or Input and Output Converters.
>>>>> +  A value of 0000b is reserved and should not be used
>>>>> +*/
>>>>> +                     { 0x17, 0x01011013 }, /* Side */
>>>>> +                     { }
>>>>> +             },
>>>>> +     },
>>>>>
>>>>>
>>>>> +     SND_PCI_QUIRK(0x1558, 0x5102, "Clevo P150HM", ALC892_FIXUP_CL=
EVO_4ST_8CH),
>>>>> +     SND_PCI_QUIRK(0x1558, 0x7100, "Clevo P170HM", ALC892_FIXUP_CL=
EVO_4ST_8CH),
>>>>>
>>>>> SImilar case are those notebooks  hda-emu/codecs/alc1200-msi-gx620
>>>>> which has 1 hp(green), 1 line-in(blue), 1 ext-mic(pink) and 1 line
>>>>> out(grey) at same location (ext rear)   for surround71 (and also 1
>>>>> speakers, 1 int mic)
>>>>>
>>>>>
>>>>> hda_codec: ALC1200: BIOS auto-probing.
>>>>> hda_codec: ALC1200: SKU not ready 0x598301f0
>>>>> autoconfig: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:line
>>>>>    speaker_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
>>>>>    hp_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
>>>>>    mono: mono_out=3D0x0
>>>>>    dig-out=3D0x1e/0x0
>>>>>    inputs: Mic=3D0x18 Internal Mic=3D0x19 Line=3D0x1a
>>>>>
>>>>>
>>>>> CTRL: add: Line-Out Jack:0
>>>>> CTRL: add: Headphone Jack:0
>>>>> CTRL: add: Mic Jack:0
>>>>> CTRL: add: Line Jack:0
>>>>>
>>>>>> get 1
>>>>> 1 Channel Mode:0
>>>>> ITEM: 0:2ch, 1:4ch, 2:6ch, VAL: [2ch]
>>>>>
>=20
> After the pin fixup, your notebook is almost like alc1200 msi gx460
> except speaker and hp are swapped, this mean that those volume
> controls and switches are similar to targa_mixer , targa_8ch_mixer of
> model=3D"targa-8ch-dig"
>=20
>>>>>
>>>>> This mean that when switch to 6/8 channel mode, it will conflict wi=
th
>>>>> automic detection since the pin cap alc892 's mic jack does not
>>>>> support impedance sense and the driver does not know the plug is mi=
c
>>>>> or speaker by measuring the impedance
>>>>>
>>>>> The driver have to disable automic detection when user switch "chan=
nel
>>>>> mode" to 6ch/8ch as the user should still able to use the internal =
mic
>>>>> when the external mic jack is retasked as output
>>>>>
>=20
> The are some difference between p170hm and your p150hm if p170hm has
> 5.1 speakers which still can have auto mic detection enabled.
>=20
>=20
> you can add the following code in alc_auto_ch_mode_put() for debugging
> and need to switch "auto mute mode" to "speaker" for 8 channels
>=20
>=20
> 	if (spec->need_dac_fix && !spec->const_channel_count)
> 		spec->multiout.num_dacs =3D spec->multiout.max_channels / 2;
>=20
> +	printk(KERN_INFO "ch =3D %d\n",ch);
> +	printk(KERN_INFO "max channel %d\n",spec->multiout.max_channels);
> +	for (i=3D0; i<spec->autocfg.hp_outs; i++)
> +		printk(KERN_INFO "hp dac(%d) %x pin %x\n", i,
> spec->multiout.hp_out_nid[i], spec->autocfg.hp_pins[i]);
> +	for (i=3D0; i<spec->multiout.num_dacs; i++)
> +		printk(KERN_INFO "private_dac(%d) %x\n", i, spec->private_dac_nids[i=
]);
> +	for (i=3D0; i<spec->autocfg.line_outs; i++)
> +		printk(KERN_INFO "line_out(%d) pin %x\n", i, spec->autocfg.line_out_=
pins[i]);
> +	for (i=3D0; i<spec->multiout.num_dacs-1; i++)
> +		printk(KERN_INFO "multi_io(%d) dac %x pin %x\n", i,
> spec->multi_io[i].dac, spec->multi_io[i].pin);
> +	for (i=3D0; i<spec->autocfg.speaker_outs; i++)
> +		printk(KERN_INFO "extra_out(%d) dac %x pin %x\n", i,
> spec->multiout.extra_out_nid[i], spec->autocfg.speaker_pins[i]);
>                return 1

This is what appears in /var/log/messages if you go from 8 to 2 channels
and back:

Nov 25 13:05:11 snowball2 kernel: [ 1515.853640] ch =3D 2
Nov 25 13:05:11 snowball2 kernel: [ 1515.853642] max channel 6
Nov 25 13:05:11 snowball2 kernel: [ 1515.853643] hp dac(0) 0 pin 1b
Nov 25 13:05:11 snowball2 kernel: [ 1515.853644] private_dac(0) 2
Nov 25 13:05:11 snowball2 kernel: [ 1515.853645] private_dac(1) 3
Nov 25 13:05:11 snowball2 kernel: [ 1515.853646] private_dac(2) 4
Nov 25 13:05:11 snowball2 kernel: [ 1515.853647] private_dac(3) 5
Nov 25 13:05:11 snowball2 kernel: [ 1515.853648] line_out(0) pin 17
Nov 25 13:05:11 snowball2 kernel: [ 1515.853649] multi_io(0) dac 3 pin 1a
Nov 25 13:05:11 snowball2 kernel: [ 1515.853650] multi_io(1) dac 4 pin 18
Nov 25 13:05:11 snowball2 kernel: [ 1515.853651] multi_io(2) dac 5 pin 17
Nov 25 13:05:11 snowball2 kernel: [ 1515.853652] extra_out(0) dac 0 pin 1=
4
Nov 25 13:05:24 snowball2 kernel: [ 1528.952829] ch =3D 1
Nov 25 13:05:24 snowball2 kernel: [ 1528.952835] max channel 4
Nov 25 13:05:24 snowball2 kernel: [ 1528.952840] hp dac(0) 0 pin 1b
Nov 25 13:05:24 snowball2 kernel: [ 1528.952843] private_dac(0) 2
Nov 25 13:05:24 snowball2 kernel: [ 1528.952846] private_dac(1) 3
Nov 25 13:05:24 snowball2 kernel: [ 1528.952849] private_dac(2) 4
Nov 25 13:05:24 snowball2 kernel: [ 1528.952852] private_dac(3) 5
Nov 25 13:05:24 snowball2 kernel: [ 1528.952855] line_out(0) pin 17
Nov 25 13:05:24 snowball2 kernel: [ 1528.952859] multi_io(0) dac 3 pin 1a
Nov 25 13:05:24 snowball2 kernel: [ 1528.952863] multi_io(1) dac 4 pin 18
Nov 25 13:05:24 snowball2 kernel: [ 1528.952866] multi_io(2) dac 5 pin 17
Nov 25 13:05:24 snowball2 kernel: [ 1528.952870] extra_out(0) dac 0 pin 1=
4
Nov 25 13:05:26 snowball2 kernel: [ 1531.378952] ch =3D 0
Nov 25 13:05:26 snowball2 kernel: [ 1531.378958] max channel 2
Nov 25 13:05:26 snowball2 kernel: [ 1531.378963] hp dac(0) 0 pin 1b
Nov 25 13:05:26 snowball2 kernel: [ 1531.378966] private_dac(0) 2
Nov 25 13:05:26 snowball2 kernel: [ 1531.378969] private_dac(1) 3
Nov 25 13:05:26 snowball2 kernel: [ 1531.378972] private_dac(2) 4
Nov 25 13:05:26 snowball2 kernel: [ 1531.378975] private_dac(3) 5
Nov 25 13:05:26 snowball2 kernel: [ 1531.378978] line_out(0) pin 17
Nov 25 13:05:26 snowball2 kernel: [ 1531.378982] multi_io(0) dac 3 pin 1a
Nov 25 13:05:26 snowball2 kernel: [ 1531.379002] multi_io(1) dac 4 pin 18
Nov 25 13:05:26 snowball2 kernel: [ 1531.379006] multi_io(2) dac 5 pin 17
Nov 25 13:05:26 snowball2 kernel: [ 1531.379010] extra_out(0) dac 0 pin 1=
4
Nov 25 13:06:29 snowball2 kernel: [ 1593.746269] ch =3D 1
Nov 25 13:06:29 snowball2 kernel: [ 1593.746275] max channel 4
Nov 25 13:06:29 snowball2 kernel: [ 1593.746279] hp dac(0) 0 pin 1b
Nov 25 13:06:29 snowball2 kernel: [ 1593.746283] private_dac(0) 2
Nov 25 13:06:29 snowball2 kernel: [ 1593.746286] private_dac(1) 3
Nov 25 13:06:29 snowball2 kernel: [ 1593.746289] private_dac(2) 4
Nov 25 13:06:29 snowball2 kernel: [ 1593.746291] private_dac(3) 5
Nov 25 13:06:29 snowball2 kernel: [ 1593.746295] line_out(0) pin 17
Nov 25 13:06:29 snowball2 kernel: [ 1593.746298] multi_io(0) dac 3 pin 1a
Nov 25 13:06:29 snowball2 kernel: [ 1593.746302] multi_io(1) dac 4 pin 18
Nov 25 13:06:29 snowball2 kernel: [ 1593.746306] multi_io(2) dac 5 pin 17
Nov 25 13:06:29 snowball2 kernel: [ 1593.746310] extra_out(0) dac 0 pin 1=
4
Nov 25 13:06:31 snowball2 kernel: [ 1596.174127] ch =3D 2
Nov 25 13:06:31 snowball2 kernel: [ 1596.174133] max channel 6
Nov 25 13:06:31 snowball2 kernel: [ 1596.174195] hp dac(0) 0 pin 1b
Nov 25 13:06:31 snowball2 kernel: [ 1596.174199] private_dac(0) 2
Nov 25 13:06:31 snowball2 kernel: [ 1596.174202] private_dac(1) 3
Nov 25 13:06:31 snowball2 kernel: [ 1596.174205] private_dac(2) 4
Nov 25 13:06:31 snowball2 kernel: [ 1596.174208] private_dac(3) 5
Nov 25 13:06:31 snowball2 kernel: [ 1596.174211] line_out(0) pin 17
Nov 25 13:06:31 snowball2 kernel: [ 1596.174215] multi_io(0) dac 3 pin 1a
Nov 25 13:06:31 snowball2 kernel: [ 1596.174219] multi_io(1) dac 4 pin 18
Nov 25 13:06:31 snowball2 kernel: [ 1596.174223] multi_io(2) dac 5 pin 17
Nov 25 13:06:31 snowball2 kernel: [ 1596.174226] extra_out(0) dac 0 pin 1=
4
Nov 25 13:06:33 snowball2 kernel: [ 1598.111893] ch =3D 3
Nov 25 13:06:33 snowball2 kernel: [ 1598.111900] max channel 8
Nov 25 13:06:33 snowball2 kernel: [ 1598.111904] hp dac(0) 0 pin 1b
Nov 25 13:06:33 snowball2 kernel: [ 1598.111908] private_dac(0) 2
Nov 25 13:06:33 snowball2 kernel: [ 1598.111911] private_dac(1) 3
Nov 25 13:06:33 snowball2 kernel: [ 1598.111914] private_dac(2) 4
Nov 25 13:06:33 snowball2 kernel: [ 1598.111917] private_dac(3) 5
Nov 25 13:06:33 snowball2 kernel: [ 1598.111920] line_out(0) pin 17
Nov 25 13:06:33 snowball2 kernel: [ 1598.111924] multi_io(0) dac 3 pin 1a
Nov 25 13:06:33 snowball2 kernel: [ 1598.111927] multi_io(1) dac 4 pin 18
Nov 25 13:06:33 snowball2 kernel: [ 1598.111931] multi_io(2) dac 5 pin 17
Nov 25 13:06:33 snowball2 kernel: [ 1598.111935] extra_out(0) dac 0 pin 1=
4

>=20
> Try the following code  which try to assign dac 02, 03, 04, and 05 to
> spec->private_dac front, surround, clfe and side.
>=20
> static int alc_auto_fill_dac_nids(struct hda_codec *codec)
> {
> ...
>  again:
> 	/* set num_dacs once to full for alc_auto_look_for_dac() */
> 	spec->multiout.num_dacs =3D cfg->line_outs;
> 	spec->multiout.hp_out_nid[0] =3D 0;
> 	spec->multiout.extra_out_nid[0] =3D 0;
> 	memset(spec->private_dac_nids, 0, sizeof(spec->private_dac_nids));
> 	spec->multiout.dac_nids =3D spec->private_dac_nids;
>=20
> +	if (cfg->hp_outs =3D=3D 1 && cfg->line_outs =3D=3D 1 &&
> +		cfg->num_inputs >=3D 3 && cfg->speaker_outs >=3D 1) {
> +/* assign 0x02 as Front DAC by using speaker or hp pins*/
> +		spec->private_dac_nids[0]  =3D alc_auto_look_for_dac(codec,
> cfg->speaker_pins[0]);
> +/* hp , mic and line-in at the same location
> +   use alc_auto_fill_multi_ios() to assign surround and clfe dacs
> +*/
> +		defcfg =3D snd_hda_codec_get_pincfg(codec, cfg->hp_pins[0]);
> +		location =3D get_defcfg_location(defcfg);
> +		spec->multiout.num_dacs =3D 1;
> +		num_pins =3D alc_auto_fill_multi_ios(codec, location, 1);
> +		if (num_pins > 0) {
> +			spec->multi_ios =3D num_pins;
> +			spec->ext_channel_count =3D 2;
> +			spec->multiout.num_dacs =3D num_pins + 1;
> +		}
> +/* an ugly hack to add side as multi io even side does not support inp=
ut
> +   set pin ctl to PIN_OUT to set multi_io[2].ctl_in to PIN_OUT */
> +		if (location =3D=3D get_defcfg_location(snd_hda_codec_get_pincfg(cod=
ec,
> cfg->line_out_pins[0]))) {
> +			spec->private_dac_nids[3] =3D alc_auto_look_for_dac(codec,
> cfg->line_out_pins[0]);
> +			spec->multi_io[2].dac =3D spec->private_dac_nids[3];
> +			spec->multi_io[2].pin =3D cfg->line_out_pins[0];
> +			snd_hda_codec_write(codec, cfg->line_out_pins[0], 0,
> 				AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
> +			spec->multi_ios++;
> +			spec->multiout.num_dacs++;
> +		}
> +		return 0;
> +	}

It is much better now. I applied the attached patch and 2, 4, 6 and 8
channel sound is working, enabling outputs incrementally as I change the
number of channels in alsamixer. Observations:
* there is no mute for side channel
* no matter if Auto-Mute is set to Speaker or Line Out+Speaker, speakers
will mute upon plugging a jack into either headphone or side/spdif socket
* there is a "front" slider which controls internal speakers and HP
jack, but the mute control under it does nothing. There are separate
mute controls for HP and Speakers, which work as advertised.
This is the alsa-info.sh output:
http://www.alsa-project.org/db/?f=3D7df8ccac0a5ae751110f7b7e56f9e0ba5cc3b=
302
Looks like we are almost there, thanks for all the input so far!

Regards,
Julian

--------------090100010106030300080005
Content-Type: text/x-patch;
 name="clevo-0x17-rawhide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="clevo-0x17-rawhide.patch"

--- ./sound/pci/hda/patch_realtek.c.orig	2011-11-25 11:37:01.303999976 +0100
+++ ./sound/pci/hda/patch_realtek.c	2011-11-25 11:39:02.780497718 +0100
@@ -3053,6 +3053,37 @@
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
+		return 0;
+	}
+
 	/* fill hard-wired DACs first */
 	if (!redone) {
 		for (i = 0; i < cfg->line_outs; i++)
@@ -3645,6 +3676,19 @@
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
 
@@ -5850,6 +5894,7 @@
 	ALC662_FIXUP_ASUS_MODE6,
 	ALC662_FIXUP_ASUS_MODE7,
 	ALC662_FIXUP_ASUS_MODE8,
+	ALC892_FIXUP_CLEVO_4ST_8CH,
 };
 
 static const struct alc_fixup alc662_fixups[] = {
@@ -5995,6 +6040,20 @@
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
@@ -6008,6 +6067,8 @@
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
+	SND_PCI_QUIRK(0x1558, 0x5102, "Clevo P150HM", ALC892_FIXUP_CLEVO_4ST_8CH),
+	SND_PCI_QUIRK(0x1558, 0x7100, "Clevo P170HM", ALC892_FIXUP_CLEVO_4ST_8CH),
 
 #if 0
 	/* Below is a quirk table taken from the old code.

--------------090100010106030300080005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090100010106030300080005--
