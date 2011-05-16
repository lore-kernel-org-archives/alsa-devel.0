From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Mon, 16 May 2011 18:03:21 +0200
Message-ID: <BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 30E9D2451E
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 18:03:24 +0200 (CEST)
Received: by wwf26 with SMTP id 26so4056894wwf.20
	for <alsa-devel@alsa-project.org>; Mon, 16 May 2011 09:03:22 -0700 (PDT)
In-Reply-To: <BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,
It took me a while before I could post again here, sorry.

I've installed the snapshot tarball I had downloaded, with debug
support enabled, result at following link; results are close to
previous ones.

http://pastebin.ca/2056960


2011/5/10 Raymond Yau <superquad.vortex2@gmail.com>:
> 2011/5/9 alex dot baldacchino dot alsasub at gmail dot com <
> alex.baldacchino.alsasub@gmail.com>
>
> you have to ask the distribution maintainer how to test the latest
> alsa-driver without upgrading the kernel.
>

It seems configure script for the snapshot has found correct source
and installation paths, overwriting existing sound drivers, as
expectable; I've left userspace configuration untouched (installed new
modules with 'make install-modules' to leave alsa script in
/etc/init.d as it was).

In my previous messages I forgot to mention my chassis has a front
panel with mic and hp jacks; it is said to support both hd and ac'97
audio - it's got a multi-pin single connector labeled 'hd audio' with
all available pins wired (fully fitting the MoBo header, and is
actually inserted); from that one, another connector is derived,
labeled 'ac97 audio', with a pair of pins missing and some other
'duplicated' (I'm not using it). I've made a few tests, one with front
panel disabled in bios, one with front panel enabled in bios (bios
option set to auto - please, note there can be an error in my MoBo
manual, since only available options for the front panel are 'Auto'
and 'Disabled', there's no 'Enabled' ) but physically unconnected.
Results are at following addresses:

Front panel disabled in bios:

http://pastebin.ca/2060444

Front panel disconnected but enabled in bios:

http://pastebin.ca/2060448


Please, notice the following excerpts (perhaps it sounds normal at
you, but I'm trying to understand how to interpret things at this
stage):

With panel disabled in bios:

Node 0x0c [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x2a, nsteps=3D0x2a, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0


( missing lines:
  Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0 )


Node 0x28 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x422140f0: [N/A] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=3D21, enabled=3D1
  Power states:  D0 D1 D2 D3
  Power: setting=3DD3, actual=3DD3
  Connection: 1
     0x1b


( missing lines:
  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  different 'Pin Default', different 'DefAssociation' )


Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 3
     0x08 0x0b 0x0c*


( missing line:
   Control: name=3D"Independent HP", index=3D0, device=3D0 )


/sys/class/sound/hwC0D0/init_pin_configs:
0x24 0x01014010
0x25 0x01011012
0x26 0x01016011
0x27 0x410120f0
0x28 0x422140f0
0x29 0x42a190f7
0x2a 0x0181303e
0x2b 0x01a19036
0x2c 0x593701f8
0x2d 0x074510f0
0x2e 0x474401f0
0x2f 0x47c411f0


( different pin configurations with respect to the normal case - the
first link in this message - and the following case )


ALSA hda_intel.c:1457: Enable sync_write for AMD chipset
ALSA hda_codec.c:4707: autoconfig: line_outs=3D3
(0x24/0x25/0x26/0x0/0x0) type:line
ALSA hda_codec.c:4711:    speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
ALSA hda_codec.c:4715:    hp_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
ALSA hda_codec.c:4716:    mono: mono_out=3D0x0
ALSA hda_codec.c:4719:    dig-out=3D0x2d/0x0
ALSA hda_codec.c:4720:    inputs:
ALSA hda_codec.c:4726:


( it seems there's no hp output, 0x28 is _not_ listed )


With front panel disconnected but enabled in bios:


Node 0x0c [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x2a, nsteps=3D0x2a, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0


( as if panel were connected )


Node 0x28 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x0221411f: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x1, Sequence =3D 0xf
    Misc =3D NO_PRESENCE
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=3D21, enabled=3D1
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x1b


Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
  Control: name=3D"Independent HP", index=3D0, device=3D0
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 3


( again, as when panel is connected, but for line:
    Misc =3D NO_PRESENCE )


/sys/class/sound/hwC0D0/init_pin_configs:
0x24 0x01014010
0x25 0x01011012
0x26 0x01016011
0x27 0x410120f0
0x28 0x0221411f
0x29 0x02a19137
0x2a 0x0181303e
0x2b 0x01a19036
0x2c 0x593701f8
0x2d 0x074510f0
0x2e 0x474401f0
0x2f 0x47c411f0


ALSA hda_codec.c:4707: autoconfig: line_outs=3D3
(0x24/0x25/0x26/0x0/0x0) type:line
ALSA hda_codec.c:4711:    speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
ALSA hda_codec.c:4715:    hp_outs=3D1 (0x28/0x0/0x0/0x0/0x0)
ALSA hda_codec.c:4716:    mono: mono_out=3D0x0
ALSA hda_codec.c:4719:    dig-out=3D0x2d/0x0
ALSA hda_codec.c:4720:    inputs:
ALSA hda_codec.c:4726:


It seems that node 0x28 represents the front panel line-out and
connection 0x0c is not used by anyone else (possible? rigth to work
this way? am I misunderstanding the log?). On the other hand, it is
labeled as "[Jack] HP Out at Ext Front", so it was expectable to work
this way (right?).

Now, I'm courious about node 0x24, which represents the rear green
line-out (and is the only rear line-out involved in all output
configurations, from 2 to 8 channels); in all cases it is presented
the following way:


Node 0x24 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name=3D"Front Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D20, enabled=3D1
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x18


Node 0x18 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x08 0x21


Node 0x08 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name=3D"Front Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Device: name=3D"VT2020 Analog", type=3D"Audio", device=3D0
  Amp-Out caps: ofs=3D0x2a, nsteps=3D0x2a, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0


0x08 is also listed as possible connection for node 0x034 and 0x035

Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
  Control: name=3D"Independent HP", index=3D0, device=3D0
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 3
     0x08 0x0b 0x0c*
Node 0x35 [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 3
     0x08 0x0b* 0x0c


Therefore, could 0x18 be a suitable return value for
side_mute_channel() function? (though I'd suppose an 'Audio Selector'
should be looked for instead of an 'Audio Mixer') How could I check
that?

In other words, I need also to understand what are exactly the
"Independent HP"s looked for and how they're enumerated, whether by
counting all possible output configurations that could be involved in
a Multi-Stream scenario (hence including rear channels) or just those
ones which exist beside the 'main group' (the rear group of line-outs
making up multichannel configurations).

In the latter case, are they always coupled? I'm asking because it
seems to me that via_hp_build() assumes there are either exactly 2
Independent HP controls (when snd_hda_get_connections() returns a
value greater than 1) or none (otherwise). Could there be just one
such control instead?


> it look like the driver is not installed correctly
>[...cut...]

All is possible... but I wonder how... All I've done is downloading
the new kernel, patching it according to older kernels for my distro
(nothing related to sound, just lowering DEFAULT_CONSOLE_LOGLEVEL from
7 to 3, adding a few printk's to usb-storage, additional vortex device
ids, aufs), configuring it through 'make menuconfig' (using older
kernel configuration as a hint), issuing 'make bzImage', issuing 'make
modules', issuing 'make INSTALL_MOD_PATH=3D/some/path modules_install",
copying modules in their final destination ( /lib/modules/<version> ),
updating my initrd (which doesn't handle sound) and rebooting.... I've
left sound configuration (userspace-side) untouched.

That worked with the older kernel I'm using (from my distro - it was
yet configured and patched, but I've updated patches - such as aufs -
tuned it a few times to create different flavours, build and installed
it as above). Unless there's something only working for alsa 1.0.21
and causing problems with alsa 1.0.23 - alsa 1.0.24 in
/etc/init.d/alsa, /etc/modprobe.d/* files (I have no .asoundrc),
drivers installation shouldn't be the problem, AFAICT...


>
>
> Most likely you will need this patch
>
> cb34c207af4944e9c93e2b462e351430f15daad6
>
> so that the driver do not create "smart5.1" control since blue jack may n=
eed
> to retask as side according to the user manual
>
> ALSA: hda - VIA: Fix Smart5.1 isn't useful for 6 audio jacks motherboard.
>
>

I guess that should be embedded in the snapshot I've installed... In
file 'patch_via.c', function 'via_smart51_build' checks for line_outs
number before cloning smart5.1 controls; anyway, there's nothing
connected to my blue jack at the moment.

>
>>
>> Lastly, do I need to enable debug? (that is, is it required for better
>> alsa-info output?)
>>
>>
> The driver print debug messages in system log , you are able to know which
> [Audio Output] is used when switch "Independent HP" on/off or retask blue
> jack as output
>
>

Well, alsa-info.sh collects those messages related to sound, I was
asking if people here wish to read them for a better understanding of
the problem (I've enabled debug in the snapshot, so those lines are in
my new alsa-info posts). Sorry I wasn't clear about my doubt.

>
>> For now, below I'm posting alsa-info.sh output for current
>> configuration and for kernel 2.6.33.2 (with working sound), hoping
>> this can help for comparison.
>>
>> >
>> > Post the output of alsa-info.sh
>> >
>> > What is the model of your computer (desktop/notebook) ?
>> >
>>
>> Mine is a home-build desktop with an Asrock motherboard (I don't know of
>> any
>> notebook with asrock MoBo), model '890GX Extreme3', with integrated
>> graphics (Radeon HD4290) and audio (via vt2020 codec and ati hdmi), NB
>> AMD 890GX, SB850;
>>
>> > How many audio jacks ?
>> >
>>
>> Rear panel: 5 jacks for 7.1 channels audio + 1 Optical SPDIF OUT port
>> On board: front panel audio header for ac97/hd audio (connectors for
>> mic, left, right -
>
>
>
> Refer to page 12 of 890GX Extreme3 's user manual
>
> TABLE for Audio Output Connection
>
> Blue jack is re-tasked for "Side" channel to support 8 channels
>

I was trying to count the max number of jacks my MoBo can support,
regardless they're in the rear or front panel, present or not. I guess
you were asking for rear ones only, sorry for my misunderstanding.

>
>>> "hda-codec: no NID for mapping control Independent HP:0:0".
>
> Node 0x28 HP =A0is connected to 0x34 through 0x1b
>
> [Audio Output] 0x0c has the "Headphone Volume" control
>
> As "Line in" can only be connected to 0x0c
>
> so the fix mainly depend on whether 0x0b can be used or not
>

How can I check that? (that is, 0x0b usability for the purpose?)

Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
  Control: name=3D"Independent HP", index=3D0, device=3D0
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 3
     0x08 0x0b 0x0c*

What does the asterisk mean? Is it to indicate the active/used connection?

It seems to me that

Node 0x29 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name=3D"Front Mic Boost Capture Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x02a19037: [Jack] Mic at Ext Front
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x3, Sequence =3D 0x7
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=3D20, enabled=3D1
  Power states:  D0 D1 D2 D3
  Power: setting=3DD3, actual=3DD3
  Connection: 1
     0x1c

is connected through

Node 0x1c [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x35 0x21

to

Node 0x35 [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 3
     0x08 0x0b* 0x0c

which uses

Node 0x0b [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x2a, nsteps=3D0x2a, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=3DD3, actual=3DD3

Am I wrong?
Should it work differently?

> if vt2020 is as same as vt1718s, =A0you need to find a correct nid in the
> function side_mute_channel() for update_side_mute_status() which mute/unm=
ute
> side channel when independent HP Is "ON"/"OFF"
>
>

Given actual implementation, those should be at least compatible to
some extent; in case there were differences between nids in different
'flavours' of vt1718s ( for the sake of side_mute_channel(struct
via_spec *spec) ), it should be possible to check
spec->codec->vendor_id within the switch statement when
spec->codec_type is VT1718S - the problem is finding the right nid

> Node 0x2a [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
> =A0Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0Amp-Out vals: =A0[0x80 0x80]
> =A0Pincap 0x00002334: IN OUT Detect
> =A0 =A0Vref caps: HIZ 50 100
> =A0Pin Default 0x0181303e: [Jack] Line In at Ext Rear
> =A0 =A0Conn =3D 1/8, Color =3D Blue
> =A0 =A0DefAssociation =3D 0x3, Sequence =3D 0xe
> =A0Pin-ctls: 0x20: IN VREF_HIZ
> =A0Unsolicited: tag=3D04, enabled=3D1
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD3, actual=3DD3
> =A0Connection: 2
> =A0 =A0 0x09* 0x0c
>
>
> send: NID=3D0x21, VERB=3D0x370(set_amp_gain_mute,I:LR#0), PARM=3D0x80
> send: NID=3D0x21, VERB=3D0x371(set_amp_gain_mute,I:LR#1), PARM=3D0x80
> send: NID=3D0x21, VERB=3D0x372(set_amp_gain_mute,I:LR#2), PARM=3D0x80
> send: NID=3D0x21, VERB=3D0x373(set_amp_gain_mute,I:LR#3), PARM=3D0x80
> send: NID=3D0x21, VERB=3D0x375(set_amp_gain_mute,I:LR#5), PARM=3D0x0
> invalid amp index 5 (conns=3D5)
>


How did you get these values?



> Seem no "Stereo Mix" ,  0x28 is HP and only 0x2c, 0x2b and 0x29 are input
> sources and the other must be muted
>
> node 0x2a "Line Playback Switch" have to be muted and write-protect whene=
ver
> blue jack is retask
>
> need to modify vt1718S_auto_create_analog_input_ctls()

I have no idea how to do that, my understanding of the code is to
limited for now. Perhaps it should be also considered if one needs to
modify only vt1718S_auto_create_analog_input_ctls(), both this one and
vt_auto_create_analog_input_ctls() or just the latter (but perhaps you
just mean the former function should pass a different array to the
latter one, and I'm misunderstanding they should also take care
somehow of node 0x2a retasking, at least on creation)

Node 0x2c [Pin Complex] wcaps 0x400401: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x593701f8: [N/A] CD at Int ATAPI
    Conn =3D Analog, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x8
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0

What should this be? It doesn't seem to me there's any CD Audio
connector in my motherboard. Is it supported by the codec anyway?

Regards
