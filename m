From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] hda - is_jack_detectable()
Date: Wed, 9 Nov 2011 12:06:04 +0800
Message-ID: <CAN8cciacfUwDh4+oK7sBnRDhyoh-rLrFxYnnZUHnNiZxn1P3Yw@mail.gmail.com>
References: <CAN8cciZ4z5Jx9oHxoSt2K=NoOsOVMFjmaZjxPCXSDD05J5NdVA@mail.gmail.com>
	<CAN8ccia3XSQ0TxD2CqH7bSv=stf4Z8qbdeo=sOt_NUZ5+GNM=w@mail.gmail.com>
	<4EB05EA1.1060701@canonical.com> <s5hy5vzknvk.wl%tiwai@suse.de>
	<CAN8cciZYTq7MCu18nF6ovJa9Km61HUjyBiRfFP3E4gp60i0yhA@mail.gmail.com>
	<s5h8vntl7ix.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A915103940
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 05:06:06 +0100 (CET)
Received: by faaa20 with SMTP id a20so1353098faa.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 20:06:04 -0800 (PST)
In-Reply-To: <s5h8vntl7ix.wl%tiwai@suse.de>
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

2011/11/6 Takashi Iwai <tiwai@suse.de>:
> At Sat, 5 Nov 2011 13:30:21 +0800,
> Raymond Yau wrote:
>>
>> 2011/11/2 Takashi Iwai <tiwai@suse.de>:
>> > At Tue, 01 Nov 2011 17:03:29 -0400,
>> > David Henningsson wrote:
>> >>
>> >> 2011-10-24 23:31, Raymond Yau skrev:
>> >> > sorry, it should be
>> >> >
>> >> > static inline bool is_jack_detectable(struct hda_codec *codec, hda_=
nid_t nid)
>> >> > {
>> >> > =A0 =A0 =A0 =A0 =A0return (snd_hda_query_pin_caps(codec, nid)& =A0A=
C_PINCAP_PRES_DETECT)&&
>> >> > + =A0 =A0 =A0 =A0 =A0 !(get_defcfg_misc(snd_hda_codec_get_pincfg(co=
dec, nid)
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =A0AC_DEFCFG_MISC_NO_PRES=
ENCE))&&
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(get_wcaps(codec, nid)& =A0AC_WC=
AP_UNSOL_CAP);
>> >> > }
>> >> >
>> >> I also think it is a good idea, in fact I thought it was this way
>> >> already. Can we merge this patch?
>> >
>> > OK, I checked through alsa-info series and confirmed that this causes
>> > no harm, so I merged it now.
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>> >
>> >
>>
>> Sorry the previous patch is wrong
>
> Ugh, so actually changing it would may bring too many changes, and
> most likely regressions, too. =A0I disabled the code for now for 3.2-rc1.
> Once when we cover all test cases and fix broken BIOS devices enough,
> we can re-enable it in near future.
>
>> attach the patch and test cases =A0(pins 0x11 and 0x14) front panel
>> green and pink jacks when set Front Audio Panel to AC97 or HD in BIOS
>> setup
>
> OK, thanks, we can refer to this for more tests.
>
>
> Takashi
>

 If bit 0 is set, it indicates that the jack has no presence detect capabil=
ity


The Configuration Default register is defined as shown in Figure 66.
 31:30         29:24     23:20         19:16         15:12     11:8
7:4         3:0
 Port          Location  Default       Connection    Color     Misc
Default     Sequence
 Connectivity            Device        Type                          Associ=
ation
                           Figure 66. Configuration Data Structure


This mean that bit 0 of Misc is bit 8 of the Configuration Default register


             !(get_defcfg_misc(snd_hda_codec_get_pincfg(codec, nid))
                     &  AC_DEFCFG_MISC_NO_PRESENCE)&&



Node 0x18 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x9933112e: [Fixed] CD at Int ATAPI
    Conn =3D ATAPI, Color =3D Black
    DefAssociation =3D 0x2, Sequence =3D 0xe
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1a [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x99f301f0: [Fixed] Other at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1b [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Control: name=3D"IEC958 Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"IEC958 Playback Source", index=3D0, device=3D0
  Amp-Out caps: ofs=3D0x27, nsteps=3D0x27, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x0145f1f0: [Jack] SPDIF Out at Ext Rear
    Conn =3D Optical, Color =3D Other
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
