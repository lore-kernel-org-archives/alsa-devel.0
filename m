From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Tue, 22 Nov 2011 13:45:20 +0100
Message-ID: <jag5h0$ioh$1@dough.gmane.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DE6E2433C
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 13:45:36 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1RSpjB-0001S8-SR
	for alsa-devel@alsa-project.org; Tue, 22 Nov 2011 13:45:33 +0100
Received: from 217-162-57-177.dynamic.hispeed.ch ([217.162.57.177])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 13:45:33 +0100
Received: from belegdol by 217-162-57-177.dynamic.hispeed.ch with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 13:45:33 +0100
In-Reply-To: <CAN8cciYju3PPZRHf8--oubYc7vVe7-X0D36iGEX=W=uxRpM9sg@mail.gmail.com>
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

W dniu 22.11.2011 06:17, Raymond Yau pisze:
> 2011/11/21 Julian Sikorski <belegdol@gmail.com>:
>> W dniu 21.11.2011 07:47, Raymond Yau pisze:
>>> 2011/11/19 Julian Sikorski <belegdol@gmail.com>:
>>>>>> From the official (non-service) manual, page 309:
>>>>>>
>>>>>
>>>>> Refer to P170HM 's photo in user manual
>>>>>
>>>>> There are 3 speakers and a subwoofer at the bottom of the laptop and
>>>>> two speakers at the top
>>>>>
>>>>> Refer to user manual of P150HM,
>>>>>
>>>>> Plug the front speaker cables into the Headphone-Out Jack.
>>>>>
>>>>> =95 Line-In Jack =3D Rear Speaker Out
>>>>> =95 Microphone-In Jack =3D Center/Subwoofer Speaker Out
>>>>> =95 S/PDIF-Out Jack =3D Side Speaker Out (for 7.1 Surround Sound Only)
>>>
>>> You may need to ask Takashi , David, PA developers and Media
>>> controller developers how to handle this case
>>>
>>> since it may need to set_pin_ctl to PIN_HP and PIN_OUT of 0x1b and
>>> retasking of input jacks as output  whether PA or Media controller API
>>> expect to change the name of the volume control and switch from
>>> "Headphone" to "Front" by hda-reconfig
>>>
>>> http://thread.gmane.org/gmane.linux.alsa.devel/91334
>>>
>>>>>
>>>>> 7. As you plug in each cable a dialog box will pop up (see =93Auto Po=
pup
>>>>> Dialog=94 on
>>>>> page 2 - 9).
>>>>>
>>>>> Auto Popup Dialog mean support jack detect
>>>>>
>>>>> you can try David's hda-jack-sense-test.py
>>>>>
>>>>> http://thread.gmane.org/gmane.linux.alsa.devel/85051
>>>>
>>>> Yes, it is working:
>>>> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
>>>> Pin 0x18 (Black Mic): present =3D No
>>>> Pin 0x1a (Black Line In): present =3D No
>>>> Pin 0x1b (Black HP Out): present =3D Yes
>>>> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
>>>> Pin 0x18 (Black Mic): present =3D No
>>>> Pin 0x1a (Black Line In): present =3D No
>>>> Pin 0x1b (Black HP Out): present =3D No
>>>> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
>>>> Pin 0x18 (Black Mic): present =3D No
>>>> Pin 0x1a (Black Line In): present =3D Yes
>>>> Pin 0x1b (Black HP Out): present =3D No
>>>> [julas@snowball2 ~]$ sudo python hda-jack-sense-test.py
>>>> Pin 0x18 (Black Mic): present =3D Yes
>>>> Pin 0x1a (Black Line In): present =3D No
>>>> Pin 0x1b (Black HP Out): present =3D No
>>>
>>>>>
>>>>>
>>>>> Is Node 0x17 also the side jack of your p150hm ?
>>>>> pin cap support Detect and Trigger but Misc =3D NO_PRESENCE
>>>>
>>>> Yes, it is between mic and line in jacks, third one from the front. The
>>>> only difference is that there is red light coming out of it.
>>>>
>>>
>>> you can use hda-verb to set the pin default of 0x17 and use
>>> hda-jack-sense-test retest the side jack
>>
>> Well, it kind of works:
>> * I was able to assign 0x01011013 to pin 0x17 using user_pin_configs
>> * it then shows up in hda-jack-sense-test.py, which detects if the jack
>> is connected
>> $ sudo python hda-jack-sense-test.py
>> [sudo] password for julas:
>> Pin 0x17 (Black Line Out): present =3D Yes
>> Pin 0x18 (Black Mic): present =3D No
>> Pin 0x1a (Black Line In): present =3D No
>> Pin 0x1b (Black HP Out): present =3D No
>> * for some reason this program started locking up after showing the
>> output, I am not sure if this is related.
>> I then applied your patch on top of Fedora 3.1.1 kernel (crude patch
>> attached). After reboot:
>> * hda-jack-sense-test.py was still working, without lockups this time
>> * alsamixer -c0 revealed a new "Front" slider, which was controlling the
>> volume on 0x17
>> * there was still no 8-channel mode (probably related to what you wrote
>> below)
>> * there were more options for auto mute (Disabled, Speaker Only, Line
>> Out+Speaker)
>> * here is the new alsa-info.sh:
>> http://www.alsa-project.org/db/?f=3D923b75ad3997dc8f5878852e327f9b999a19=
6052
>>
> =

> You can add the following code to assign dac and pin in alc_auto_fill_dac=
_nids()
> =

> However this cannot create "Headphone Playback Volume" and "Speaker
> Playback Volume"
> =


I am also not sure what you mean by HP and Speaker Playback Volumes - it
is working now, even with unpatched Fedora kernels (3.1.1-2.fc16).
With this patch applied on top of sound/master tree it is much worse:
* Front and HP sliders are gone
* only 2-ch sound is working, changing to 4, 6, or 8 does not produce
output on any of the other jacks
* just to be sure, I checked sound/master tree without both of your
patches, and both Headphone/Speaker, as well as 4 and 6 channel sound
are working fine.

> =

>  again:
> 	/* set num_dacs once to full for alc_auto_look_for_dac() */
> 	spec->multiout.num_dacs =3D cfg->line_outs;
> 	spec->multiout.hp_out_nid[0] =3D 0;
> 	spec->multiout.extra_out_nid[0] =3D 0;
> 	memset(spec->private_dac_nids, 0, sizeof(spec->private_dac_nids));
> 	spec->multiout.dac_nids =3D spec->private_dac_nids;
> =

> +/*
> +	may check bit 2 of SKU ID in alc_subsystem_id() to determine this is
> a laptop with 4 jacks
> +	 * 2 : 0 --> Desktop, 1 --> Laptop
> +*/
> +	if (cfg->hp_outs =3D=3D 1 && cfg->line_outs =3D=3D 1 && cfg->speaker_ou=
ts >=3D 1) {
> +		num_pins =3D 0;
> +		spec->private_dac_nids[0]  =3D alc_auto_look_for_dac(codec, cfg->hp_pi=
ns[0]);
> +		spec->multi_io[num_pins].pin =3D cfg->hp_pins[0];
> +		spec->multi_io[num_pins].dac =3D spec->private_dac_nids[0];
> +		num_pins++;
> +		defcfg =3D snd_hda_codec_get_pincfg(codec, cfg->hp_pins[0]);
> +		location =3D get_defcfg_location(defcfg);
> +		spec->multiout.num_dacs =3D 1;
> +		num_pins =3D alc_auto_fill_multi_ios(codec, location, 0);
> +		if (num_pins > 0) {
> +			spec->multi_ios =3D num_pins;
> +			spec->ext_channel_count =3D 2;
> +		}
> +		spec->private_dac_nids[3] =3D alc_auto_look_for_dac(codec,
> cfg->line_out_pins[0]);
> +		spec->multi_io[num_pins].pin =3D cfg->line_out_pins[0];
> +		spec->multi_io[num_pins].dac =3D spec->private_dac_nids[3];
> +		spec->multi_ios++;
> +		spec->multiout.max_channels =3D 2;
> +		spec->multiout.num_dacs =3D 1;
> +/*
> +	Still missing
> +	1) need to swap dac of hp with speaker to create speaker volume
> +	2) hda-jack of mic, line and side
> +       3) p170hm has 5.1 speakers
> +*/
> +		spec->multiout.extra_out_nid[0] =3D
> +			get_dac_if_single(codec, cfg->speaker_pins[0]);
> +		return 0;
> +	}
> =

> =

>>>
>>> To add the missing pin default of side jack 0x17
>>>
>>>       ALC662_FIXUP_ASUS_MODE8,
>>> +     ALC892_FIXUP_CLEVO_4ST_8CH,
>>> };
>>>
>>> static const struct alc_fixup alc662_fixups[] =3D {
>>>
>>>
>>> +     [ALC892_FIXUP_CLEVO_4ST_8CH] =3D {
>>> +             .type =3D ALC_FIXUP_PINS,
>>> +             .v.pins =3D (const struct alc_pincfg[]) {
>>> +/*
>>> +  need to be same location as the other jack
>>> +  may need to change the default association and sequence since
>>> +  Lower Default Association values would be higher in priority for res=
ources
>>> +  such as processing nodes or Input and Output Converters.
>>> +  A value of 0000b is reserved and should not be used
>>> +*/
>>> +                     { 0x17, 0x01011013 }, /* Side */
>>> +                     { }
>>> +             },
>>> +     },
>>>
>>>
>>> +     SND_PCI_QUIRK(0x1558, 0x5102, "Clevo P150HM", ALC892_FIXUP_CLEVO_=
4ST_8CH),
>>> +     SND_PCI_QUIRK(0x1558, 0x7100, "Clevo P170HM", ALC892_FIXUP_CLEVO_=
4ST_8CH),
>>>
>>> SImilar case are those notebooks  hda-emu/codecs/alc1200-msi-gx620
>>> which has 1 hp(green), 1 line-in(blue), 1 ext-mic(pink) and 1 line
>>> out(grey) at same location (ext rear)   for surround71 (and also 1
>>> speakers, 1 int mic)
>>>
>>>
>>> hda_codec: ALC1200: BIOS auto-probing.
>>> hda_codec: ALC1200: SKU not ready 0x598301f0
>>> autoconfig: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:line
>>>    speaker_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
>>>    hp_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
>>>    mono: mono_out=3D0x0
>>>    dig-out=3D0x1e/0x0
>>>    inputs: Mic=3D0x18 Internal Mic=3D0x19 Line=3D0x1a
>>>
>>>
>>> CTRL: add: Line-Out Jack:0
>>> CTRL: add: Headphone Jack:0
>>> CTRL: add: Mic Jack:0
>>> CTRL: add: Line Jack:0
>>>
>>>> get 1
>>> 1 Channel Mode:0
>>> ITEM: 0:2ch, 1:4ch, 2:6ch, VAL: [2ch]
>>>
>>> what is missing are
>>> 1) 8ch in "Channel Mode" ,
>>> 2) Side Playback Volume
>>> 3)Side Playback Switch
>>>
>>> Study the logic to add 8ch and "side" in
>>>
>>> 1) alc_auto_fill_dac_nids()
>>> 2) alc_auto_fill_multi_ios() which add line-in and mic jack to multi_io=
s,
>>
>> I am sorry, I am afraid I lack the knowledge to do that. What I can do
>> is test patches and commands, but writing new code is beyond my skillset.
>>
>>>
>>>
>>> This mean that when switch to 6/8 channel mode, it will conflict with
>>> automic detection since the pin cap alc892 's mic jack does not
>>> support impedance sense and the driver does not know the plug is mic
>>> or speaker by measuring the impedance
>>>
>>> The driver have to disable automic detection when user switch "channel
>>> mode" to 6ch/8ch as the user should still able to use the internal mic
>>> when the external mic jack is retasked as output
>>>
>>>
>>>>>
>>>>> which node is your subwoofer ?
>>>>
>>>> This I have not figured out yet unfortunately. Keep in mind that in
>>>> windows you need THX TruStudio PRO to get it working, and the config is
>>>> advertised as stereo. There was a discussion about this on
>>>> notebookreview forums [1], so maybe it configured in some weird way?
>>>>
>>>
>>> you have to find out whether subwoofer is connected to 0x16 of your
>>> p150hm since your mic jack (retasked as clfe) is connected to dac 0x4.
>>
>> Simply changing this pin to out and unmuting it did not work (this is
>> the way I discovered 0x17.
>>
