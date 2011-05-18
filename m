From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Wed, 18 May 2011 11:36:33 +0800
Message-ID: <BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
	<BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 84EFD10380E
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 05:36:36 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1062320fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 17 May 2011 20:36:34 -0700 (PDT)
In-Reply-To: <BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
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

2011/5/17 alex dot baldacchino dot alsasub at gmail dot com
<alex.baldacchino.alsasub@gmail.com>
>
> Hello,
> It took me a while before I could post again here, sorry.
>
> I've installed the snapshot tarball I had downloaded, with debug
> support enabled, result at following link; results are close to
> previous ones.
>
> http://pastebin.ca/2056960
>
> 2011/5/10 Raymond Yau <superquad.vortex2@gmail.com>:
> > 2011/5/9 alex dot baldacchino dot alsasub at gmail dot com <
> > alex.baldacchino.alsasub@gmail.com>
> >
> > you have to ask the distribution maintainer how to test the latest
> > alsa-driver without upgrading the kernel.
> >
>
> It seems configure script for the snapshot has found correct source
> and installation paths, overwriting existing sound drivers, as
> expectable; I've left userspace configuration untouched (installed new
> modules with 'make install-modules' to leave alsa script in
> /etc/init.d as it was).


!!Aplay/Arecord output
!!------------

APLAY

aplay: device_list:240: no soundcards found...

ARECORD

arecord: device_list:240: no soundcards found...

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [SB]

Invalid card number.
Usage: amixer <options> [command]



You may need the expert to tell you what 's wrong since you need
amixer to change the controls and aplay/arecord to perform test


>
> In my previous messages I forgot to mention my chassis has a front
> panel with mic and hp jacks; it is said to support both hd and ac'97
> audio - it's got a multi-pin single connector labeled 'hd audio' with
> all available pins wired (fully fitting the MoBo header, and is
> actually inserted); from that one, another connector is derived,
> labeled 'ac97 audio', with a pair of pins missing and some other
> 'duplicated' (I'm not using it). I've made a few tests, one with front
> panel disabled in bios, one with front panel enabled in bios (bios
> option set to auto - please, note there can be an error in my MoBo
> manual, since only available options for the front panel are 'Auto'
> and 'Disabled', there's no 'Enabled' ) but physically unconnected.
> Results are at following addresses:
>
> Front panel disabled in bios:
>
> http://pastebin.ca/2060444
>
>
> With panel disabled in bios:
>
> Node 0x28 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>  Amp-Out vals:  [0x80 0x80]
>  Pincap 0x0000233c: IN OUT HP Detect
>    Vref caps: HIZ 50 100
>  Pin Default 0x422140f0: [N/A] HP Out at Ext Front
>    Conn =3D 1/8, Color =3D Green
>    DefAssociation =3D 0xf, Sequence =3D 0x0
>  Pin-ctls: 0x00: VREF_HIZ
>  Unsolicited: tag=3D21, enabled=3D1
>  Power states:  D0 D1 D2 D3
>  Power: setting=3DD3, actual=3DD3
>  Connection: 1
>     0x1b
>
>
> ALSA hda_intel.c:1457: Enable sync_write for AMD chipset
> ALSA hda_codec.c:4707: autoconfig: line_outs=3D3
> (0x24/0x25/0x26/0x0/0x0) type:line
> ALSA hda_codec.c:4711: =A0 =A0speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> ALSA hda_codec.c:4715: =A0 =A0hp_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> ALSA hda_codec.c:4716: =A0 =A0mono: mono_out=3D0x0
> ALSA hda_codec.c:4719: =A0 =A0dig-out=3D0x2d/0x0
> ALSA hda_codec.c:4720: =A0 =A0inputs:
> ALSA hda_codec.c:4726:
>
>
> ( it seems there's no hp output, 0x28 is _not_ listed )
>
>

Some part of the code in the driver seem expect HP jack always present
but this is not true any more
As someone mention in the bug report that his small desktop (used as
media center) does not even has the front audio panel,

using hda-emu and your codec info

send: NID=3D0x0, VERB=3D0xf00(get_parameters), PARM=3D0xc(pin_cap)
receive: 0x0
send: NID=3D0x0, VERB=3D0xf09(get_pin_sense), PARM=3D0x0
Invalid pin node
receive: 0x0


The driver should not create "Independent HP" switch when there is no hp ja=
ck

There shold be only one subdevice when there is no "Independent HP" switch

=A0=A0=A0 info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =3D
=A0=A0=A0 =A0=A0=A0 spec->multiout.dac_nids[0];
+=A0=A0=A0 info->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams =3D
+=A0=A0=A0 =A0=A0=A0( snd_hda_find_mixer_ctl(codec, "Independent HP") ? 2 :=
 1);

=A0=A0=A0 info->stream[SNDRV_PCM_STREAM_CAPTURE] =3D *(spec->stream_analog_=
capture);


>
> Front panel disconnected but enabled in bios:
>
> http://pastebin.ca/2060448
>>
>
> Node 0x28 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
> =A0Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
> =A0Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0Amp-Out vals: =A0[0x00 0x00]
> =A0Pincap 0x0000233c: IN OUT HP Detect
> =A0 =A0Vref caps: HIZ 50 100
> =A0Pin Default 0x0221411f: [Jack] HP Out at Ext Front
> =A0 =A0Conn =3D 1/8, Color =3D Green
> =A0 =A0DefAssociation =3D 0x1, Sequence =3D 0xf
> =A0 =A0Misc =3D NO_PRESENCE
> =A0Pin-ctls: 0xc0: OUT HP VREF_HIZ
> =A0Unsolicited: tag=3D21, enabled=3D1
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
> =A0Connection: 1
> =A0 =A0 0x1b

Misc=3DNO_PRESENCE mean the external circuitry is not capable of
supporting the functionality

Misc[3:0] is a bit field used to indicate other information about the jack.
Currently, only bit 0 is defined. If bit 0 is set, it indicates that
the jack has no presence detect capability, so even if a Pin Complex
indicates that the codec hardware supports the presence detect
functionality on the jack, the external circuitry is not capable of
supporting the functionality.


>
> ( again, as when panel is connected, but for line:
> =A0 =A0Misc =3D NO_PRESENCE )
>
> ALSA hda_codec.c:4707: autoconfig: line_outs=3D3
> (0x24/0x25/0x26/0x0/0x0) type:line
> ALSA hda_codec.c:4711: =A0 =A0speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> ALSA hda_codec.c:4715: =A0 =A0hp_outs=3D1 (0x28/0x0/0x0/0x0/0x0)
> ALSA hda_codec.c:4716: =A0 =A0mono: mono_out=3D0x0
> ALSA hda_codec.c:4719: =A0 =A0dig-out=3D0x2d/0x0
> ALSA hda_codec.c:4720: =A0 =A0inputs:
> ALSA hda_codec.c:4726:
>
>
> It seems that node 0x28 represents the front panel line-out and
> connection 0x0c is not used by anyone else (possible? rigth to work
> this way? am I misunderstanding the log?). On the other hand, it is
> labeled as "[Jack] HP Out at Ext Front", so it was expectable to work
> this way (right?).

Do you mean the BIOS is able to differentiate HD front panel and AC97
Front panel without user to setup ?

I think those first generation HDA codecs are AC97 compatible

>
> Now, I'm courious about node 0x24, which represents the rear green
> line-out (and is the only rear line-out involved in all output
> configurations, from 2 to 8 channels); in all cases it is presented
> the following way:
>
>
> Node 0x24 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
> =A0Control: name=3D"Front Playback Switch", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
> =A0Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0Amp-Out vals: =A0[0x00 0x00]
> =A0Pincap 0x0001001c: OUT HP EAPD Detect
> =A0EAPD 0x2: EAPD
> =A0Pin Default 0x01014010: [Jack] Line Out at Ext Rear
> =A0 =A0Conn =3D 1/8, Color =3D Green
> =A0 =A0DefAssociation =3D 0x1, Sequence =3D 0x0
> =A0Pin-ctls: 0x40: OUT
> =A0Unsolicited: tag=3D20, enabled=3D1
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
> =A0Connection: 1
> =A0 =A0 0x18
>
>
> Node 0x18 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
> =A0Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0Amp-In vals: =A0[0x00 0x00] [0x00 0x00]
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
> =A0Connection: 2
> =A0 =A0 0x08 0x21
>
>
> Node 0x08 [Audio Output] wcaps 0x41d: Stereo Amp-Out
> =A0Control: name=3D"Front Playback Volume", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
> =A0Device: name=3D"VT2020 Analog", type=3D"Audio", device=3D0
> =A0Amp-Out caps: ofs=3D0x2a, nsteps=3D0x2a, stepsize=3D0x05, mute=3D0
> =A0Amp-Out vals: =A0[0x2a 0x2a]
> =A0Converter: stream=3D0, channel=3D0
> =A0PCM:
> =A0 =A0rates [0x5e0]: 44100 48000 88200 96000 192000
> =A0 =A0bits [0xe]: 16 20 24
> =A0 =A0formats [0x1]: PCM
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
>
>
> 0x08 is also listed as possible connection for node 0x034 and 0x035
>
> Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
> =A0Control: name=3D"Independent HP", index=3D0, device=3D0
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
> =A0Connection: 3
> =A0 =A0 0x08 0x0b 0x0c*
> Node 0x35 [Audio Selector] wcaps 0x300501: Stereo
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
> =A0Connection: 3
> =A0 =A0 0x08 0x0b* 0x0c
>
>
> Therefore, could 0x18 be a suitable return value for
> side_mute_channel() function? (though I'd suppose an 'Audio Selector'
> should be looked for instead of an 'Audio Mixer') How could I check
> that?
>
> In other words, I need also to understand what are exactly the
> "Independent HP"s looked for and how they're enumerated, whether by
> counting all possible output configurations that could be involved in
> a Multi-Stream scenario (hence including rear channels) or just those
> ones which exist beside the 'main group' (the rear group of line-outs
> making up multichannel configurations).

The usage of those [Audio Output] are defined in
vt1718S_auto_create_multi_out_ctls()

>
> In the latter case, are they always coupled? I'm asking because it
> seems to me that via_hp_build() assumes there are either exactly 2
> Independent HP controls (when snd_hda_get_connections() returns a
> value greater than 1) or none (otherwise). Could there be just one
> such control instead?
>
>
> > it look like the driver is not installed correctly
> >[...cut...]
>
> All is possible... but I wonder how... All I've done is downloading
> the new kernel, patching it according to older kernels for my distro
> (nothing related to sound, just lowering DEFAULT_CONSOLE_LOGLEVEL from
> 7 to 3, adding a few printk's to usb-storage, additional vortex device
> ids, aufs), configuring it through 'make menuconfig' (using older
> kernel configuration as a hint), issuing 'make bzImage', issuing 'make
> modules', issuing 'make INSTALL_MOD_PATH=3D/some/path modules_install",
> copying modules in their final destination ( /lib/modules/<version> ),
> updating my initrd (which doesn't handle sound) and rebooting.... I've
> left sound configuration (userspace-side) untouched.
>
> That worked with the older kernel I'm using (from my distro - it was
> yet configured and patched, but I've updated patches - such as aufs -
> tuned it a few times to create different flavours, build and installed
> it as above). Unless there's something only working for alsa 1.0.21
> and causing problems with alsa 1.0.23 - alsa 1.0.24 in
> /etc/init.d/alsa, /etc/modprobe.d/* files (I have no .asoundrc),
> drivers installation shouldn't be the problem, AFAICT...
>
>
> >
> >
> > Most likely you will need this patch
> >
> > cb34c207af4944e9c93e2b462e351430f15daad6
> >
> > so that the driver do not create "smart5.1" control since blue jack may=
 need
> > to retask as side according to the user manual
> >
> > ALSA: hda - VIA: Fix Smart5.1 isn't useful for 6 audio jacks motherboar=
d.
> >
> >
>
> I guess that should be embedded in the snapshot I've installed... In
> file 'patch_via.c', function 'via_smart51_build' checks for line_outs
> number before cloning smart5.1 controls; anyway, there's nothing
> connected to my blue jack at the moment.
>
> >
> >>
> >> Lastly, do I need to enable debug? (that is, is it required for better
> >> alsa-info output?)
> >>
> >>
> > The driver print debug messages in system log , you are able to know wh=
ich
> > [Audio Output] is used when switch "Independent HP" on/off or retask bl=
ue
> > jack as output
> >
> >
>
> Well, alsa-info.sh collects those messages related to sound, I was
> asking if people here wish to read them for a better understanding of
> the problem (I've enabled debug in the snapshot, so those lines are in
> my new alsa-info posts). Sorry I wasn't clear about my doubt.
>
> >
> >> For now, below I'm posting alsa-info.sh output for current
> >> configuration and for kernel 2.6.33.2 (with working sound), hoping
> >> this can help for comparison.
> >>
> >> >
> >> > Post the output of alsa-info.sh
> >> >
> >> > What is the model of your computer (desktop/notebook) ?
> >> >
> >>
> >> Mine is a home-build desktop with an Asrock motherboard (I don't know =
of
> >> any
> >> notebook with asrock MoBo), model '890GX Extreme3', with integrated
> >> graphics (Radeon HD4290) and audio (via vt2020 codec and ati hdmi), NB
> >> AMD 890GX, SB850;
> >>
> >> > How many audio jacks ?
> >> >
> >>
> >> Rear panel: 5 jacks for 7.1 channels audio + 1 Optical SPDIF OUT port
> >> On board: front panel audio header for ac97/hd audio (connectors for
> >> mic, left, right -
> >
> >
> >
> > Refer to page 12 of 890GX Extreme3 's user manual
> >
> > TABLE for Audio Output Connection
> >
> > Blue jack is re-tasked for "Side" channel to support 8 channels
> >
>
> I was trying to count the max number of jacks my MoBo can support,
> regardless they're in the rear or front panel, present or not. I guess
> you were asking for rear ones only, sorry for my misunderstanding.
>
> >
> >>> "hda-codec: no NID for mapping control Independent HP:0:0".
> >
> > Node 0x28 HP =A0is connected to 0x34 through 0x1b
> >
> > [Audio Output] 0x0c has the "Headphone Volume" control
> >
> > As "Line in" can only be connected to 0x0c
> >
> > so the fix mainly depend on whether 0x0b can be used or not
> >
>
> How can I check that? (that is, 0x0b usability for the purpose?)

static int vt1718S_auto_create_multi_out_ctls(struct via_spec *spec,
					     const struct auto_pin_cfg *cfg)
{
	char name[32];
	static const char * const chname[4] =3D {
		"Front", "Surround", "C/LFE", "Side"
	};
	hda_nid_t nid_vols[] =3D {0x8, 0x9, 0xa, 0xb};
	hda_nid_t nid_mutes[] =3D {0x24, 0x25, 0x26, 0x27};


the current driver only support 6 channels since it cannot find the
grey jack at node 0x27

spec->multiout.max_channels =3D spec->multiout.num_dacs * 2;

The current driver seem work with 6 jacks motherboard and need fix to
work with 5 jacks motherboard


>
> Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
> =A0Control: name=3D"Independent HP", index=3D0, device=3D0
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
> =A0Connection: 3
> =A0 =A0 0x08 0x0b 0x0c*
>
> What does the asterisk mean? Is it to indicate the active/used connection?
>
> It seems to me that
>
> Node 0x29 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
> =A0Control: name=3D"Front Mic Boost Capture Volume", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
> =A0Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0Amp-Out vals: =A0[0x80 0x80]
> =A0Pincap 0x0000233c: IN OUT HP Detect
> =A0 =A0Vref caps: HIZ 50 100
> =A0Pin Default 0x02a19037: [Jack] Mic at Ext Front
> =A0 =A0Conn =3D 1/8, Color =3D Pink
> =A0 =A0DefAssociation =3D 0x3, Sequence =3D 0x7
> =A0Pin-ctls: 0x21: IN VREF_50
> =A0Unsolicited: tag=3D20, enabled=3D1
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD3, actual=3DD3
> =A0Connection: 1
> =A0 =A0 0x1c
>
> is connected through
>
> Node 0x1c [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
> =A0Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0Amp-In vals: =A0[0x00 0x00] [0x80 0x80]
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
> =A0Connection: 2
> =A0 =A0 0x35 0x21
>
> to
>
> Node 0x35 [Audio Selector] wcaps 0x300501: Stereo
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
> =A0Connection: 3
> =A0 =A0 0x08 0x0b* 0x0c
>
> which uses
>
> Node 0x0b [Audio Output] wcaps 0x41d: Stereo Amp-Out
> =A0Amp-Out caps: ofs=3D0x2a, nsteps=3D0x2a, stepsize=3D0x05, mute=3D0
> =A0Amp-Out vals: =A0[0x2a 0x2a]
> =A0Converter: stream=3D0, channel=3D0
> =A0PCM:
> =A0 =A0rates [0x5e0]: 44100 48000 88200 96000 192000
> =A0 =A0bits [0xe]: 16 20 24
> =A0 =A0formats [0x1]: PCM
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD3, actual=3DD3
>
> Am I wrong?
> Should it work differently?

Take a look at via_independent_get() and via_independent_put()

pinsel determine the connection of [Audio Selector] to [Audio Output]
0x08 ,  0x0b and 0x0c

so it depend on using 0x0b or 0x0c as [Audio Output] for headphone


>
> > if vt2020 is as same as vt1718s, =A0you need to find a correct nid in t=
he
> > function side_mute_channel() for update_side_mute_status() which mute/u=
nmute
> > side channel when independent HP Is "ON"/"OFF"
> >
> >

it seem that vt1718s does not need to update_side_mute_status if there
is a grey jack

http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommit;h=3D4d02d1b638a=
f580ae3d69367248539a8b3893064


static const struct snd_kcontrol_new via_hp_mixer[2] =3D {
	{
		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
		.name =3D "Independent HP",
		.info =3D via_independent_hp_info,
		.get =3D via_independent_hp_get,
		.put =3D via_independent_hp_put,
	},
	{
		.iface =3D NID_MAPPING,
		.name =3D "Independent HP",
	},
};


>
> Given actual implementation, those should be at least compatible to
> some extent; in case there were differences between nids in different
> 'flavours' of vt1718s ( for the sake of side_mute_channel(struct
> via_spec *spec) ), it should be possible to check
> spec->codec->vendor_id within the switch statement when
> spec->codec_type is VT1718S - the problem is finding the right nid


https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/772638

There is codec info of vt1718s on ASRock H55M Pro

comparing the nodes and topology with those of vt1718s

vt2020 has

Node 0x13 [Audio Input] wcaps 0x100711: Stereo Digital
Node 0x22 [Beep Generator Widget] wcaps 0x70040c: Mono Amp-Out
Node 0x2f [Pin Complex] wcaps 0x400601: Stereo Digital

1) grey jack at 0x27 is connected to 0x0b through 0x1a and=A0 HP is
connected to 0x0c through 0x1b


what the driver need is a "channel mode" switch from 6 to 8 which
configure 0x2a as output/input , and change max_channels between 6 and
8


2) without grey jack ,

>>note there can be an error in my MoBo manual,

There are two choice
a) 0x2a is really can be retask as output and connected to  0x0c so HP
may need to connect to 0x0b

b) HP is retasked as Side



http://www.viaarena.com/forums/showthread.php?t=3D41015

Refer to administrator 's answer

The Headphone Configuration Panel is shown in Figure 18. There are two
headphone configurations that can be chosen: =93Independent Headphone=94
or =93Redirected Headphone=94.
The =93Independent Headphone=94 feature enables the user to play separate
music on the headphone and speaker. For example, the user can use a
multi-channel device (such as 5.1 surround sound) to watch a movie
while simultaneously using the independent headphone feature to make
phone calls through a VoIP Internet phone.

The =93Redirected Headphone=94 feature enables the user to hear the same
audio that is being channeled to the front speakers. In this mode,
once the headphone has been inserted the audio will be redirected from
the speakers to the headphone.
Please note that the =93Independent Headphone=94 function requires two
channels. Therefore, only six
channels will be available if =93Independent Headphone=94 is being used.


In alsa,

when independent HP is on,

The HP jack is supposed to connected to [Audio Output] which is not
used by the rear panel jacks (i.e. 0x25) and application has to use
sudevice 1

you can use aplay -Dhw:0,0,1 stereo.wav

When Independent HP is off, (it is similar to Redirected Headphone)
when automute is not enabled


>
> >
> >
> > send: NID=3D0x21, VERB=3D0x370(set_amp_gain_mute,I:LR#0), PARM=3D0x80
> > send: NID=3D0x21, VERB=3D0x371(set_amp_gain_mute,I:LR#1), PARM=3D0x80
> > send: NID=3D0x21, VERB=3D0x372(set_amp_gain_mute,I:LR#2), PARM=3D0x80
> > send: NID=3D0x21, VERB=3D0x373(set_amp_gain_mute,I:LR#3), PARM=3D0x80
> > send: NID=3D0x21, VERB=3D0x375(set_amp_gain_mute,I:LR#5), PARM=3D0x0
> > invalid amp index 5 (conns=3D5)
> >
>
>
> How did you get these values?
>

hda-emu show this error since 0x21 only has 5 connections

ode 0x21 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
=A0 Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0 Amp-In vals:=A0 [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x97 0=
x97]
=A0 Power states:=A0 D0 D1 D2 D3
=A0 Power: setting=3DD0, actual=3DD0
=A0 Connection: 5
=A0=A0=A0=A0 0x2c 0x2b 0x2a 0x29 0x28

Fix seem to be

static const struct hda_verb vt1718S_volume_init_verbs[] =3D {

	/* Amp Indices: CD =3D 1, Mic1 =3D 2, Line =3D 3, Mic2 =3D 4 */
	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
-	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},


>
>
> > Seem no "Stereo Mix" , =A00x28 is HP and only 0x2c, 0x2b and 0x29 are i=
nput
> > sources and the other must be muted
> >
> > node 0x2a "Line Playback Switch" have to be muted and write-protect whe=
never
> > blue jack is retask
> >
> > need to modify vt1718S_auto_create_analog_input_ctls()
>
> I have no idea how to do that, my understanding of the code is to
> limited for now. Perhaps it should be also considered if one needs to
> modify only vt1718S_auto_create_analog_input_ctls(), both this one and
> vt_auto_create_analog_input_ctls() or just the latter (but perhaps you
> just mean the former function should pass a different array to the
> latter one, and I'm misunderstanding they should also take care
> somehow of node 0x2a retasking, at least on creation)
>

Can you record from blue jack ?

you should able to hear the input signal of blue jack at green jack
when you unmute "Line Playback Volume"

>
> Node 0x2c [Pin Complex] wcaps 0x400401: Stereo
> =A0Pincap 0x00000020: IN
> =A0Pin Default 0x593701f8: [N/A] CD at Int ATAPI
> =A0 =A0Conn =3D Analog, Color =3D Unknown
> =A0 =A0DefAssociation =3D 0xf, Sequence =3D 0x8
> =A0 =A0Misc =3D NO_PRESENCE
> =A0Pin-ctls: 0x00:
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
>
>
> What should this be? It doesn't seem to me there's any CD Audio
> connector in my motherboard. Is it supported by the codec anyway?
>

This mean that No physical connection for CD connector at the motherboard

Pin Default 0x593701f8

Bit 31:30 Port connectiviy

00b The Port Complex is connected to a jack (1/8", ATAPI, etc.).
01b No physical connection for Port.
10b A fixed function device (integrated speaker, integrated mic, etc.)
is attached.
11b Both a jack and an internal device are attached. The Information
provided in all other fields refers to the integrated device. The PD
pin will reflect the status of the jack; the user will need to be
queried to figure out what it is.
