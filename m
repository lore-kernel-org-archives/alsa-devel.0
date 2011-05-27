From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Fri, 27 May 2011 16:49:05 +0200
Message-ID: <BANLkTimR1_tT57o7iLbv4_QdirNbUORbfA@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
	<BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
	<BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4230E103828
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 16:49:09 +0200 (CEST)
Received: by wyg36 with SMTP id 36so1471746wyg.38
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2011 07:49:08 -0700 (PDT)
In-Reply-To: <BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
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

2011/5/18 Raymond Yau <superquad.vortex2@gmail.com>:
> 2011/5/17 alex dot baldacchino dot alsasub at gmail dot com
> <alex.baldacchino.alsasub@gmail.com>
>>
>> Hello,
>> It took me a while before I could post again here, sorry.
>>
>> I've installed the snapshot tarball I had downloaded, with debug
>> support enabled, result at following link; results are close to
>> previous ones.
>>[...]
>> It seems configure script for the snapshot has found correct source
>> and installation paths, overwriting existing sound drivers, as
>> expectable; I've left userspace configuration untouched (installed new
>> modules with 'make install-modules' to leave alsa script in
>> /etc/init.d as it was).
>
>
> !!Aplay/Arecord output
> !!------------
>
> APLAY
>
> aplay: device_list:240: no soundcards found...
>
> ARECORD
>
> arecord: device_list:240: no soundcards found...
>
> !!Amixer output
> !!-------------
>
> !!-------Mixer controls for card 0 [SB]
>
> Invalid card number.
> Usage: amixer <options> [command]
>
>
>
> You may need the expert to tell you what 's wrong since you need
> amixer to change the controls and aplay/arecord to perform test
>
>

As I wrote in my first mail, there's a mixer in my system failing an
assertion in alsa-lib; starting from there I've investigated what was
going on there in (by adding some fprintf to stderr to a few library
functions) and have found a sort of inconsistency across /dev/snd/*
files minors, udev and the driver. Alsa-lib was using files in
/dev/snd, which are statically created with minors that work in kernel
2.6.33.2 + alsa driver 1.0.21, but seems to be unusable for driver
version 1.0.23 - 1.0.24. At the same time, udev created sound related
stuff in /dev (which weren't used), with the very same major/minor as
those ones in /dev/snd in k .33 + alsa 1.0.21, but different minors
with a newer alsa driver (e.g. I get /dev/controlC0 with minor 6 (by
udev) vs /dev/snd/controlC0 (statically existing) with minor 0,
/dev/controlC1 with minor 9 vs /dev/snd/controlC1 with minor 32 and so
on). Changing some macros in alsa lib, such as SND_FILE_CONTROL in
cards.c, so that files in /dev where used seemed to solve, so I've
rebuild alsa lib with option "--with-alsa-devdir=3D/dev" and now things
seem to work... (please, note that's the same regardless of compiling
the driver with or without support for dynamic minors, actually it
works without dynamic minors using udev created files) alsa-info
output at following link:

http://pastebin.ca/2069512


As an aside, I've noted there are different macros defined in
different files (in alsa-lib source) to access the same resource. For
instance, in file cards.c

#define SND_FILE_CONTROL	ALSA_DEVICE_DIRECTORY "controlC%i"

and in file control_hw.c

#define SNDRV_FILE_CONTROL	ALSA_DEVICE_DIRECTORY "controlC%i"

those are/can be used in the same 'context', I mean, at some point
function _snd_ctl_hw_open() (in file control_hw.c) can call function
snd_card_get_index() (in file cards.c) which uses function
snd_card_load1() which uses SND_FILE_CONTROL; then (at
last)_snd_ctl_hw_open() calls snd_ctl_hw_open() (same file) which uses
SNDRV_FILE_CONTROL, but then snd_ctl_hw_open() can call snd_card_load
(cards.c) and again snd_card_load1(). It might look a bit complicated
(and somehow duplicated, but both _snd_ctl_hw_open() and
snd_ctl_hw_open() are interface functions and could be eventually
called independently), but I understand one may need to open a device
ro and call an ioctl to get info about it before (re-)opening it rw
(though I think functions in cards.c could avoid calling both
snd_ctl_hw_open() and snd_ctl_card_info() with a simple change to
snd_card_load2(), but that's another story). Anyway, the overall
mechanism requires consistency between macros used to identify a
control's path, so, perhaps, using just one and moving it into a
(local, non-interface) header could improve maintainability a bit,
eventually (just a little consideration).

Moreover, it looks like there's a bug in snd_ctl_hw_open() (but it
could have been fixed and I could have missed it - just using the
stable source I got a while ago for lib 1.0.24.1). In the end it
executes the following block - I've added a comment where I think
something else should be done:

              err =3D snd_ctl_new(&ctl, SND_CTL_TYPE_HW, name);
	if (err < 0) {
		close(fd);
		free(hw);
		/* COMMENT ADDED BY ME */
		/* should return -ENOMEM (that is err) ?*/
	}
	ctl->ops =3D &snd_ctl_hw_ops;
	ctl->private_data =3D hw;
	ctl->poll_fd =3D fd;
	*handle =3D ctl;
	return 0;

If snd_ctl_new() failed, variable ctl would rest uninitialized and a
random memory area would be overwritten by successive assignments to
dereferenced offsets of ctl.

For the rest, I need some more learning of the driver and architecture
insights. For the moment, I can tell the following.

First of all, I was misinterpreting entries in a connection list as
outputs instead of inputs (as per hd audio specs), so I was a bit
confused on what widget was driving what widget.

I've not applied the lines you were suggesting, because I'm still
trying to understand how things work and how would work after any
change (and have been more focused on solving driver installation
issues).


>>
>> Front panel disconnected but enabled in bios:
>>
>> http://pastebin.ca/2060448
>>>
>> [..]
>
> Misc=3DNO_PRESENCE mean the external circuitry is not capable of
> supporting the functionality
>
> Misc[3:0] is a bit field used to indicate other information about the jac=
k.
> Currently, only bit 0 is defined. If bit 0 is set, it indicates that
> the jack has no presence detect capability, so even if a Pin Complex
> indicates that the codec hardware supports the presence detect
> functionality on the jack, the external circuitry is not capable of
> supporting the functionality.
>

That's meaningful. Since the panel wasn't connected to the
motherboard, just enabled in bios, the driver must have checked what
signals came from that path and got none. It seems it worked as it
should be supposed to.


> Do you mean the BIOS is able to differentiate HD front panel and AC97
> Front panel without user to setup ?
>
> I think those first generation HDA codecs are AC97 compatible
>

My BIOS has only two options for the front panel: [Auto] and
[Disabled], thus it should be capable of autodetection (though, the
manual would suggest there should be a third option [Enabled] to set
the front panel up as AC97, but there's no such option).

>
>>
>> > if vt2020 is as same as vt1718s, =A0you need to find a correct nid in =
the
>> > function side_mute_channel() for update_side_mute_status() which mute/=
unmute
>> > side channel when independent HP Is "ON"/"OFF"
>> >
>> >
>
> it seem that vt1718s does not need to update_side_mute_status if there
> is a grey jack
>
> http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommit;h=3D4d02d1b63=
8af580ae3d69367248539a8b3893064
>
>
> static const struct snd_kcontrol_new via_hp_mixer[2] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "Independent HP",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.info =3D via_independent_hp_info,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.get =3D via_independent_hp_get,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.put =3D via_independent_hp_put,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iface =3D NID_MAPPING,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "Independent HP",
> =A0 =A0 =A0 =A0},
> };
>
>

Must these controls be always coupled? Is it a specification
constraint? What if via_hp_build() didn't execute

knew =3D via_clone_control(spec, &via_hp_mixer[1]);

when side_mute_status() returned '0' ?

>>
>> Given actual implementation, those should be at least compatible to
>> some extent; in case there were differences between nids in different
>> 'flavours' of vt1718s ( for the sake of side_mute_channel(struct
>> via_spec *spec) ), it should be possible to check
>> spec->codec->vendor_id within the switch statement when
>> spec->codec_type is VT1718S - the problem is finding the right nid
>
>
> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/772638
>
> There is codec info of vt1718s on ASRock H55M Pro
>
> comparing the nodes and topology with those of vt1718s
>
> vt2020 has
>
> Node 0x13 [Audio Input] wcaps 0x100711: Stereo Digital
> Node 0x22 [Beep Generator Widget] wcaps 0x70040c: Mono Amp-Out
> Node 0x2f [Pin Complex] wcaps 0x400601: Stereo Digital
>
> 1) grey jack at 0x27 is connected to 0x0b through 0x1a and=A0 HP is
> connected to 0x0c through 0x1b
>
>
> what the driver need is a "channel mode" switch from 6 to 8 which
> configure 0x2a as output/input , and change max_channels between 6 and
> 8
>
>
> 2) without grey jack ,
>
>>>note there can be an error in my MoBo manual,
>
> There are two choice
> a) 0x2a is really can be retask as output and connected to =A00x0c so HP
> may need to connect to 0x0b
>
> b) HP is retasked as Side
>
>

I haven't got an 8-channel system to test it; according to the manual,
line in should be used to create an 8 channel setup. As I understand
it, line-in (blue jack) should be a replacement for the gray jack when
retasked.

>
> http://www.viaarena.com/forums/showthread.php?t=3D41015
>
> Refer to administrator 's answer
>
> The Headphone Configuration Panel is shown in Figure 18. There are two
> headphone configurations that can be chosen: =93Independent Headphone=94
> or =93Redirected Headphone=94.
> The =93Independent Headphone=94 feature enables the user to play separate
> music on the headphone and speaker. For example, the user can use a
> multi-channel device (such as 5.1 surround sound) to watch a movie
> while simultaneously using the independent headphone feature to make
> phone calls through a VoIP Internet phone.
>
> The =93Redirected Headphone=94 feature enables the user to hear the same
> audio that is being channeled to the front speakers. In this mode,
> once the headphone has been inserted the audio will be redirected from
> the speakers to the headphone.
> Please note that the =93Independent Headphone=94 function requires two
> channels. Therefore, only six
> channels will be available if =93Independent Headphone=94 is being used.
>

The last part is interesting. If vt2020 works the same way, the
8-channel setup should disallow the "Independent HP" function, that is
it should be automatically turned off and 0x28 should be either muted,
or used as a 'duplicate' for 0x0c (same sound of blue jack) or 0x08
(same sound as rear green jack, as in 'redirected audio' ). If I'm not
misunderstanding everything, of course.

BTW, 0x2a is connected to (gets input from) 0x09, which is labeled
'Surround Playback Volume' and is also an input for 0x25 ('Surround
Playback Switch', black jack, rear speaker according to manual)
throughout 0x19; 0x27 (missing gray jack) would be connected to 0x0b
throughout 0x1a...

>
> In alsa,
>
> when independent HP is on,
>
> The HP jack is supposed to connected to [Audio Output] which is not
> used by the rear panel jacks (i.e. 0x25) and application has to use
> sudevice 1
>
> you can use aplay -Dhw:0,0,1 stereo.wav

Tested: it works. I can get different streams out of rear (front
playback) and front (hp) line out jacks (used mplayer on the 'default'
rear channel(s) and aplay as above on the front panel)

>
> When Independent HP is off, (it is similar to Redirected Headphone)
> when automute is not enabled
>
>

Turning off Independent HP I can notice the following change:

Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
  Control: name=3D"Independent HP", index=3D0, device=3D0
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 3
     0x08* 0x0b 0x0c

Node 0x08 is connected to rear green jack, and I get same sound on
both rear and front jacks

>>
>> > Seem no "Stereo Mix" , =A00x28 is HP and only 0x2c, 0x2b and 0x29 are =
input
>> > sources and the other must be muted
>> >
>> > node 0x2a "Line Playback Switch" have to be muted and write-protect wh=
enever
>> > blue jack is retask
>> >
>> > need to modify vt1718S_auto_create_analog_input_ctls()
>>
>> I have no idea how to do that, my understanding of the code is to
>> limited for now. Perhaps it should be also considered if one needs to
>> modify only vt1718S_auto_create_analog_input_ctls(), both this one and
>> vt_auto_create_analog_input_ctls() or just the latter (but perhaps you
>> just mean the former function should pass a different array to the
>> latter one, and I'm misunderstanding they should also take care
>> somehow of node 0x2a retasking, at least on creation)
>>
>
> Can you record from blue jack ?
>
> you should able to hear the input signal of blue jack at green jack
> when you unmute "Line Playback Volume"
>

I cannot test it properly at the moment. I've tried to use my
headset's mic connected to blue jack, setting 'line' as first input
source and executing 'arecord -vv -d 5 test.wav'. Playing the
resulting file with "aplay -vv test.wav" showed a noisy and highly
distorted, yet understandable (mono) sound (with all controls set to
their max value); recording from rear mic jack, selecting both 'stereo
mix' and 'rear mic' as input source created a more natural but still
noisy sound (playing with the mixer solves the problem, but I needed
top volumes to get sound from line-in without an external amplifier).

By the way, when I select 'Line' as input source with a mixer
(selected both sources), I can notice the following changes:


Node 0x1e [Audio Selector] wcaps 0x300501: Stereo
  Control: name=3D"Input Source", index=3D0, device=3D0
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 6
     0x2c 0x2b 0x2a* 0x29 0x28 0x21
Node 0x1f [Audio Selector] wcaps 0x300501: Stereo
  Control: name=3D"Input Source", index=3D1, device=3D0
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 6
     0x2c 0x2b 0x2a* 0x29 0x28 0x21


Selecting 'stereo mixer' those are:


Node 0x1e [Audio Selector] wcaps 0x300501: Stereo
  Control: name=3D"Input Source", index=3D0, device=3D0
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 6
     0x2c 0x2b 0x2a 0x29 0x28 0x21*
Node 0x1f [Audio Selector] wcaps 0x300501: Stereo
  Control: name=3D"Input Source", index=3D1, device=3D0
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 6
     0x2c 0x2b 0x2a 0x29 0x28 0x21*


>>
>> Node 0x2c [Pin Complex] wcaps 0x400401: Stereo
>> =A0Pincap 0x00000020: IN
>> =A0Pin Default 0x593701f8: [N/A] CD at Int ATAPI
>> =A0 =A0Conn =3D Analog, Color =3D Unknown
>> =A0 =A0DefAssociation =3D 0xf, Sequence =3D 0x8
>> =A0 =A0Misc =3D NO_PRESENCE
>> =A0Pin-ctls: 0x00:
>> =A0Power states: =A0D0 D1 D2 D3
>> =A0Power: setting=3DD0, actual=3DD0
>>
>>
>> What should this be? It doesn't seem to me there's any CD Audio
>> connector in my motherboard. Is it supported by the codec anyway?
>>
>
> This mean that No physical connection for CD connector at the motherboard
>
> Pin Default 0x593701f8
>
> Bit 31:30 Port connectiviy
>
> 00b The Port Complex is connected to a jack (1/8", ATAPI, etc.).
> 01b No physical connection for Port.
> 10b A fixed function device (integrated speaker, integrated mic, etc.)
> is attached.
> 11b Both a jack and an internal device are attached. The Information
> provided in all other fields refers to the integrated device. The PD
> pin will reflect the status of the jack; the user will need to be
> queried to figure out what it is.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Thank you for your clarification.

Regards
