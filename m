From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] hda - is_jack_detectable()
Date: Wed, 16 Nov 2011 15:14:17 +0800
Message-ID: <CAN8cciYT=tvXVzCyMjEpf=FKMA0OqTvqxtgEkEPJwbGfxH+hBA@mail.gmail.com>
References: <CAN8cciZ4z5Jx9oHxoSt2K=NoOsOVMFjmaZjxPCXSDD05J5NdVA@mail.gmail.com>
	<CAN8ccia3XSQ0TxD2CqH7bSv=stf4Z8qbdeo=sOt_NUZ5+GNM=w@mail.gmail.com>
	<4EB05EA1.1060701@canonical.com> <s5hy5vzknvk.wl%tiwai@suse.de>
	<CAN8cciZYTq7MCu18nF6ovJa9Km61HUjyBiRfFP3E4gp60i0yhA@mail.gmail.com>
	<s5h8vntl7ix.wl%tiwai@suse.de>
	<CAN8cciacfUwDh4+oK7sBnRDhyoh-rLrFxYnnZUHnNiZxn1P3Yw@mail.gmail.com>
	<s5hy5vplqn2.wl%tiwai@suse.de> <s5hpqh1lopc.wl%tiwai@suse.de>
	<CAN8ccibAoNQfDNWJ-zE_DGH6mc-ipmmdhBDQW+fjOMT8xHcD+Q@mail.gmail.com>
	<s5h4ny76naa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 15F6C24377
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 08:14:18 +0100 (CET)
Received: by bkat8 with SMTP id t8so172336bka.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 23:14:17 -0800 (PST)
In-Reply-To: <s5h4ny76naa.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/11/14 Takashi Iwai <tiwai@suse.de>:
> At Sat, 12 Nov 2011 19:31:20 +0800,
> Raymond Yau wrote:
>>
>> 2011/11/9 Takashi Iwai <tiwai@suse.de>:
>> > At Wed, 09 Nov 2011 08:08:17 +0100,
>> > Takashi Iwai wrote:
>> >>
>> >> At Wed, 9 Nov 2011 12:06:04 +0800,
>> >> Raymond Yau wrote:
>> >> >
>> >> > 2011/11/6 Takashi Iwai <tiwai@suse.de>:
>> >> > > At Sat, 5 Nov 2011 13:30:21 +0800,
>> >> > > Raymond Yau wrote:
>> >> > >>
>> >> > >> 2011/11/2 Takashi Iwai <tiwai@suse.de>:
>> >> > >> > At Tue, 01 Nov 2011 17:03:29 -0400,
>> >> > >> > David Henningsson wrote:
>> >> > >> >>
>> >> > >> >> 2011-10-24 23:31, Raymond Yau skrev:
>> >> > >> >> > sorry, it should be
>> >> > >> >> >
>> >> > >> >> > static inline bool is_jack_detectable(struct hda_codec *cod=
ec, hda_nid_t nid)
>> >> > >> >> > {
>> >> > >> >> > =A0 =A0 =A0 =A0 =A0return (snd_hda_query_pin_caps(codec, ni=
d)& =A0AC_PINCAP_PRES_DETECT)&&
>> >> > >> >> > + =A0 =A0 =A0 =A0 =A0 !(get_defcfg_misc(snd_hda_codec_get_p=
incfg(codec, nid)
>> >> > >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =A0AC_DEFCFG_MISC=
_NO_PRESENCE))&&
>> >> > >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(get_wcaps(codec, nid)& =
=A0AC_WCAP_UNSOL_CAP);
>> >> > >> >> > }
>> >> > >> >> >
>> >> > >> >> I also think it is a good idea, in fact I thought it was this=
 way
>> >> > >> >> already. Can we merge this patch?
>> >> > >> >
>> >> > >> > OK, I checked through alsa-info series and confirmed that this=
 causes
>> >> > >> > no harm, so I merged it now.
>> >> > >> >
>> >> > >> >
>> >> > >> > thanks,
>> >> > >> >
>> >> > >> > Takashi
>> >> > >> >
>> >> > >> >
>> >> > >>
>> >> > >> Sorry the previous patch is wrong
>> >> > >
>> >> > > Ugh, so actually changing it would may bring too many changes, and
>> >> > > most likely regressions, too. =A0I disabled the code for now for =
3.2-rc1.
>> >> > > Once when we cover all test cases and fix broken BIOS devices eno=
ugh,
>> >> > > we can re-enable it in near future.
>> >> > >
>> >> > >> attach the patch and test cases =A0(pins 0x11 and 0x14) front pa=
nel
>> >> > >> green and pink jacks when set Front Audio Panel to AC97 or HD in=
 BIOS
>> >> > >> setup
>> >> > >
>> >> > > OK, thanks, we can refer to this for more tests.
>> >> > >
>> >> > >
>> >> > > Takashi
>> >> > >
>> >> >
>> >> > =A0If bit 0 is set, it indicates that the jack has no presence dete=
ct capability
>> >> >
>> >> >
>> >> > The Configuration Default register is defined as shown in Figure 66.
>> >> > =A031:30 =A0 =A0 =A0 =A0 29:24 =A0 =A0 23:20 =A0 =A0 =A0 =A0 19:16 =
=A0 =A0 =A0 =A0 15:12 =A0 =A0 11:8
>> >> > 7:4 =A0 =A0 =A0 =A0 3:0
>> >> > =A0Port =A0 =A0 =A0 =A0 =A0Location =A0Default =A0 =A0 =A0 Connecti=
on =A0 =A0Color =A0 =A0 Misc
>> >> > Default =A0 =A0 Sequence
>> >> > =A0Connectivity =A0 =A0 =A0 =A0 =A0 =A0Device =A0 =A0 =A0 =A0Type =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Association
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Figure 66. C=
onfiguration Data Structure
>> >> >
>> >> >
>> >> > This mean that bit 0 of Misc is bit 8 of the Configuration Default =
register
>> >> >
>> >> >
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0!(get_defcfg_misc(snd_hda_codec_get_pinc=
fg(codec, nid))
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& =A0AC_DEFCFG_MISC_NO_P=
RESENCE)&&
>> >> >
>> >>
>> >> Yeah, I already tried it and it still gives too many false-positives.
>> >> Many ASUS laptops (also mobo) set this bit to all pins no matter
>> >> whether it's an obviously detectable jack or not. =A0Some Toshiba
>> >> laptops do so, too.
>> >>
>> >> That being said, checking this bit alone isn't reliable because of too
>> >> many BIOS bugs. =A0A bit more clever test is necessary.
>> >
>> > It seems that a broken BIOS sets this bit on all pins in general.
>> > So, the patch below (against the latest sound git tree or 3.2-rc1
>> > kernel) seems working well by filtering out such a brokenness.
>> >
>> > Let me know if this works. =A0If it's OK, I'll try to merge it for
>> > 3.2-rc2.
>> >
>>
>> The patch seem ok
>>
>> Need a hack to build the hda-jack branch
>>
>> It is quite simple to enable unsolicited event for all proper jacks by
>>
>> snd_hda_jack_add_kctrls(codec,(codec->spec->autocfg));
>>
>> and
>>
>> static void ad1988_unsol_event(struct hda_codec *codec, unsigned int res)
>> {
>> =A0 =A0 =A0 struct ad198x_spec *spec =3D codec->spec;
>> =A0 =A0 =A0 struct hda_jack_tbl *jack;
>> =A0 =A0 =A0 u32 sense, caps;
>> =A0 =A0 =A0 int pin;
>> =A0 =A0 =A0 jack =3D snd_hda_jack_tbl_get_from_tag(codec, res >> 26);
>> =A0 =A0 =A0 pin =3D jack->nid;
>> =A0 =A0 =A0 caps =3D snd_hda_codec_get_pincfg(codec, pin);
>> =A0 =A0 =A0 sense =3D snd_hda_codec_read(codec, pin, 0, AC_VERB_GET_PIN_=
SENSE, 0);
>> =A0 =A0 =A0 if (sense & AC_PINSENSE_PRESENCE)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printdd("Pin 0x%x =A0pd=3D1 imp=3D%d %s =
at %s %s %s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sense & AC_PINSENSE_IMPEDANC=
E_MASK,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_get_jack_type(caps),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_get_jack_connectivit=
y(caps),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_get_jack_location(ca=
ps),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_jack_color(caps));
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printdd("Pin 0x%x =A0pd=3D0 %s at %s %s =
%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_get_jack_type(caps),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_get_jack_connectivit=
y(caps),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_get_jack_location(ca=
ps),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_jack_color(caps));
>>
>> =A0 =A0 =A0 =A0 if (pin =3D=3D spec->autocfg.hp_pins[0] && !spec->indepe=
ndent_hp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad198x_hp_automute(codec);
>> =A0 =A0 =A0 if (pin =3D=3D spec->ext_mic_pin)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad198x_mic_automute(codec);
>> }
>>
>>
>> However it seem that result is different in kctl
>>
>>
>> amixer -c1 contents
>> numid=3D5,iface=3DCARD,name=3D'Front Headphone Jack'
>> =A0 ; type=3DBOOLEAN,access=3Dr-------,values=3D1
>> =A0 : values=3Doff
>> numid=3D6,iface=3DCARD,name=3D'Front Mic Jack'
>> =A0 ; type=3DBOOLEAN,access=3Dr-------,values=3D1
>> =A0 : values=3Doff
>> numid=3D8,iface=3DCARD,name=3D'Line Jack'
>> =A0 ; type=3DBOOLEAN,access=3Dr-------,values=3D1
>> =A0 : values=3Doff
>> numid=3D1,iface=3DCARD,name=3D'Line-Out Jack'
>> =A0 ; type=3DBOOLEAN,access=3Dr-------,values=3D1
>> =A0 : values=3Doff
>> numid=3D2,iface=3DCARD,name=3D'Line-Out Jack',index=3D1
>> =A0 ; type=3DBOOLEAN,access=3Dr-------,values=3D1
>> =A0 : values=3Doff
>> numid=3D3,iface=3DCARD,name=3D'Line-Out Jack',index=3D2
>> =A0 ; type=3DBOOLEAN,access=3Dr-------,values=3D1
>> =A0 : values=3Doff
>> numid=3D4,iface=3DCARD,name=3D'Line-Out Jack',index=3D3
>> =A0 ; type=3DBOOLEAN,access=3Dr-------,values=3D1
>> =A0 : values=3Doff
>> numid=3D7,iface=3DCARD,name=3D'Rear Mic Jack'
>> =A0 ; type=3DBOOLEAN,access=3Dr-------,values=3D1
>> =A0 : values=3Doff
>>
>>
>>
>>
>> ./hda-jack-sense-test.py -c1
>> Pin 0x11 Green HP Out (Ext Front): Present =3D NO
>> Pin 0x12 Green Line Out (Ext Rear): Present =3D YES =A0 Impedance =3D 19
>> Pin 0x14 Pink Mic (Ext Front): Present =3D NO
>> Pin 0x15 Blue Line In (Ext Rear): Present =3D NO
>> Pin 0x16 Black Line Out (Ext Rear): Present =3D YES =A0 Impedance =3D 32=
00
>> Pin 0x17 Pink Mic (Ext Rear): Present =3D YES =A0 Impedance =3D 896
>> Pin 0x18 Black CD (Int ATAPI): No jack detect capability
>> Pin 0x1a Other (Int ATAPI): No jack detect capability
>> Pin 0x1b Other SPDIF Out (Ext Rear): No jack detect capability
>> Pin 0x24 Orange Line Out (Ext Rear): Present =3D NO
>> Pin 0x25 Grey Line Out (Ext Rear): Present =3D YES =A0 Impedance =3D 3200
>>
>>
>> It need =A0"SET_PIN_SENSE" and some delay to get the correct impedance
>> of the jacks during driver load
>>
>>
>> int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned char=
 action)
>> {
>> + =A0 =A0 int ret;
>> =A0 =A0 =A0 struct hda_jack_tbl *jack =3D snd_hda_jack_tbl_new(codec, ni=
d);
>> =A0 =A0 =A0 if (!jack)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> =A0 =A0 =A0 if (jack->jack_detect)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0; /* already registered */
>> =A0 =A0 =A0 jack->jack_detect =3D 1;
>> =A0 =A0 =A0 if (action)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 jack->action =3D action;
>> + =A0 =A0 ret =3D snd_hda_codec_write_cache(codec, nid, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0AC_VERB_SET_UNSOLICITED_ENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0AC_USRSP_EN | jack->tag);
>> + =A0 =A0 if (snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_IMP_SENSE) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_read(codec, nid, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 AC_VERB_SET_PIN_SENSE, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 msleep(200);
>> + =A0 =A0 }
>> + =A0 =A0 return ret;
>
> The lack of the initial pin-state of kclts was fixed in a different
> patch now. =A0But, the need of 200ms delay worries me whether it's
> needed generically at each pin-sense reading or it's just only for the
> initial reading.
>
> Does the pin-sense reading work in general after loading the driver
> stably?
>
>
>

Presence detect bit is alway correct, without the delay.

the only issue is the impedance measurement of the plugged jacks at
computer boot need a delay 200ms

For the user application to know the impedance ,
it seem the client application have to issue
1) set_pin_sense
2) delay
3) get_pin_sense to get the correct impedance of the attached device

just like my modified hda-jack-sense-test in previous email

Can it measure the impedance of the jacks of your computer ?
