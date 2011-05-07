From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Sat, 7 May 2011 19:30:12 +0200
Message-ID: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id C414D24502
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 19:30:12 +0200 (CEST)
Received: by wyg36 with SMTP id 36so3455026wyg.38
	for <alsa-devel@alsa-project.org>; Sat, 07 May 2011 10:30:12 -0700 (PDT)
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

Hello,
First of all let me apologize if I'm not fulfilling any requirements for
this list, and for any errors in my English.
I've sent a mail with same subject and content to this list as a non-subscriber
on April, 26, but perhaps that's gone lost, or perhaps is still under moderation
or didn't pass it, so I'm resending this from a different address as a
subscriber.
So, please, ignore my previous mail if it came out from moderation.

As per subject, I'm experiencing problems with my motherboard built-in audio
device (an Asrock with ATI SB8xx), embedding a Via VT2020 codec (I haven't
tested the ATI HDMI part in same conditions).

The card is recognized 'about' correctly (later in this mail something about
dmesg and other issues), and stuff in /proc/asound seems correct, also I
have no apparent problem with /dev special files, but I get no sound after
having installed kernel 2.6.38.2 and updated to version 2.6.38.3 (both
compiled from source); no mixer seems to work (later specific errors), but
everything still works with older kernel 2.6.33.2 I've kept in my system
(built with the same build environment). Since I'm using the very same
userspace environment in both cases, I deem it to be a driver(s) related
issue more likely; though, I've updated my alsa-lib and -utils to latest
versions (were such when I downloaded sources - alsa-lib 1.0.24.1 &
alsa-utils 1.0.24.2) and still get the very same results.

But let me go into more details. Here is an excerpt from dmesg called with
kernel 2.6.33.2 (sound works, but I'm just using headphone jack, so I can't tell
about anything related with later issue with smart5.1 and hda I've seen in list
archives):

[...]
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
HDA Intel 0000:01:05.1: irq 28 for MSI/MSI-X
HDA Intel 0000:01:05.1: setting latency timer to 64
[...]
ohci1394 0000:04:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ohci1394 0000:04:00.0: setting latency timer to 64
[...]
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16] MMIO=[fe9ff800-fe9fffff]
Max Packet=[2048] IR/IT contexts=[4/8]
ieee1394: Host added: ID:BUS[0-00:1023] GUID[008f130043910900]
[...]
hda-intel: azx_get_response timeout, switching to polling mode: last
cmd=0x000f0001
[...]

Notice last line is an harmless warning (sound works) and is there because
msi seems to be enabled by default; by adding "options snd-hda-intel
enable_msi=0" to
/etc/modprobe.d/alsa-base.conf both the warning and any reference to
MSI/MSI-X disappear; same effect with pci=nomsi on command line (this time
affecting other drivers, such as r8169). VT2020 is part of device
0000:00:14.2 sharing IRQ 16 with ohci1394; device 0000:01:05.1 is ATI HDMI,
while device 0000:05.0 should be embedded radeon vga (bridged together
according with lspci -t with 0000:00:01.0 on top); for each bridge I can
find with lspci -t corresponding msi_bus file in sys filesystem (in
/sys/bus/pci/devices/*) is always 1, regardless of any boot command (this
with kernel 2.6.33.2).

Now an excerpt from dmesg in kernel 2.6.38.3:

[...]
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
hda-codec: no NID for mapping control Independent HP:0:0
HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
HDA Intel 0000:01:05.1: setting latency timer to 64
[...]
r8169 0000:03:00.0: irq 43 for MSI/MSI-X
[...]
firewire_ohci 0000:04:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
firewire_ohci 0000:04:00.0: setting latency timer to 64
[...]
firewire_ohci: Added fw-ohci device 0000:04:00.0, OHCI v1.10, 4 IR + 8 IT
contexts, quirks 0x11
firewire_core: created device fw0: GUID 008f130043910900, S400
[...]

Now firewire_ohci replaces ohci1394, again sharing IRQ 16 with hda-intel for
vt2020. Line about r8169 is just for reference, since it gets a different
irq for msi now. Similar behaviour for MSI: enabled/disabled with pci=nomsi
(seems to be enabled by
default without pci=msi) and msi_bus == 1 for bridges regardless of boot
options, *but for bridge on top of ati hdmi device*: now msi seems to be
disabled regardless of both 'enable_msi' option and pci=* boot command and
corresponding bridge
(device at bus 0000:00:01.0) holds a value of 0 for msi_bus...

Notice there are no more warnings about response timeouts, as it
happened in older
kernel after disabling msi (both globally and for alsa through alsa
config options).

Notice also line "hda-codec: no NID for mapping control Independent HP:0:0".
That's because function

'snd_hda_get_connections'      (patch_via.c)

called by

'via_hp_build'

returns 3 ( test for 'nums <= 1' fails and the function doesn't return),
but function

'side_mute_channel',

called to init knew->subdevice when 'registering' via_hp_mixer[1], returns 0
(default value) and so condition 'if(nid > 0)', in function

'snd_hda_add_nid'      (hda_codec.c),

is not met and the error is triggered (by the way, param nid is of type
hda_nid_t which in turn is an unsigned integer (u16), so, should that be
'if(nid != 0)' instead? just to avoid the risk of giving the impression that
negative values are possible but mistaken (hda_nid_t is defined elsewhere).
Also: param @nid, in function
comment/documentation is defined as optional, but it doesn't seem to be).
Incidentally, in /proc/asound/card0/codec#0 node 0x35 looks much like node
0x34 (with both older and newer kernel; posting excerpt for kernel
2.6.38.3):

Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
Control: name="Independent HP", index=0, device=0
Power states: D0 D1 D2 D3
Power: setting=D0, actual=D0
Connection: 3
0x08 0x0b 0x0c*
Node 0x35 [Audio Selector] wcaps 0x300501: Stereo
Power states: D0 D1 D2 D3
Power: setting=D0, actual=D0
Connection: 3
0x08 0x0b* 0x0c

(notice connections and wcaps similarity, if relevant at all)

Since I'm quite crazy, I've tried to modify 'side_mute_channel' to have it
returning '0x35' for codec type 'VT1718S', but to no avail; I also tried to
bypass 'snd_hda_add_nid', both avoiding 'via_hp_build' to clone
via_hp_mixer[<something>] and/or modifying 'via_build_controls' and
'snd_hda_add_new_ctls' (hda_control.c) so
that "Independent HP" ctls were handled by the latter (achieving this was just
a matter of a pair of strcmp's to choose skipping the rest of an
iteration or not),
as I deem it was done in alsa 1.0.21 (embedded in kernel 2.6.33.2),
but it didn't
work (the only result I got this ways was to avoid that error message about nids
in system logs).

Additional infos from userspace applications:

mplayer works fine with kernel 2.6.33.2 (again, only using one exit, I
haven't tested
all jacks combinations); called from cmdline (under X - but
that's the same shutting X down) with default options ('mplayer
<path/to/file>') it gives the following output (relevant excerpt, as I
deem it, after codec choice, can provide more if needed):

socket(): Address family not supported by protocol
AO: [pulse] Init failed: Connection refused
Failed to initialize audio driver 'pulse'
AO: [alsa] 48000Hz 2ch s16le (2 bytes per sample)
Starting playback...

(notice I'm not using alsa-tools, such as pulse-audio; with the above
invocation sound/video works)

running mplayer with option '-ao sdl' (using sdl audio, same file) I get the
following output:

[AO SDL] Samplerate: 44100Hz Channels: Stereo Format s16le
AO: [sdl] 44100Hz 2ch s16le (2 bytes per sample)
Starting playback...

Again, sound works. In both cases, I can notice a change in
/proc/asound/card0/codec#0 as follows:

In nodes 0x08, 0x09, 0x0a, 0x0e (all [Audio Output] nodes, first 3 with
'wcaps 0x41d: Stereo Amp-Out', last with
'wcaps 0x611: Stereo Digital'), the following line:

Converter: stream=0, channel=0

changes into:

Converter: stream=5, channel=0

With kernel 2.6.38.x I get the following:

running mplayer with no option, I get no sound and following output:

socket(): Address family not supported by protocol
AO: [pulse] Init failed: Connection refused
Failed to initialize audio driver 'pulse'
[AO_ALSA] alsa-lib: confmisc.c:768:(parse_card) cannot find card '0'
[AO_ALSA] alsa-lib: conf.c:4184:(_snd_config_evaluate) function
snd_func_card_driver returned error: No such device
[AO_ALSA] alsa-lib: confmisc.c:392:(snd_func_concat) error evaluating
strings
[AO_ALSA] alsa-lib: conf.c:4184:(_snd_config_evaluate) function
snd_func_concat returned error: No such device
[AO_ALSA] alsa-lib: confmisc.c:1251:(snd_func_refer) error evaluating name
[AO_ALSA] alsa-lib: conf.c:4184:(_snd_config_evaluate) function
snd_func_refer returned error: No such device
[AO_ALSA] alsa-lib: conf.c:4663:(snd_config_expand) Evaluate error: No such
device
[AO_ALSA] alsa-lib: pcm.c:2212:(snd_pcm_open_noupdate) Unknown PCM default
[AO_ALSA] Playback open error: No such device
Failed to initialize audio driver 'alsa'
[AO SDL] Samplerate: 44100Hz Channels: Stereo Format s16le
[AO SDL] using aalib audio driver.
[AO SDL] Unable to open audio: No available audio device
Failed to initialize audio driver 'sdl:aalib'
Could not open/initialize audio device -> no sound.
Audio: no sound

and nothing changes in codec#0 file; with option -ao sdl, instead:

[AO SDL] Samplerate: 44100Hz Channels: Stereo Format s16le
ALSA lib confmisc.c:768:(parse_card) cannot find card '0'
ALSA lib conf.c:4184:(_snd_config_evaluate) function snd_func_card_driver
returned error: No such device
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:4184:(_snd_config_evaluate) function snd_func_concat
returned error: No such device
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:4184:(_snd_config_evaluate) function snd_func_refer returned
error: No such device
ALSA lib conf.c:4663:(snd_config_expand) Evaluate error: No such device
ALSA lib pcm.c:2212:(snd_pcm_open_noupdate) Unknown PCM default
AO: [sdl] 44100Hz 2ch s16le (2 bytes per sample)

And sound works! Same changes as per (working) playback with kernel 33.2
(alsa 1.0.21) are noticeable in /proc/asound/card0/codec#0 in this case
(that is, when getting sound with kernel 2.6.38.x); in addition, node 0x0c,
now changes as well (again, '[Audio Output] wcaps 0x41d: Stereo Amp-Out.'
and 'Converter: stream=5, channel=0')

Moreover: with kernel 38.2, 38.3 alsamixer fails telling about problems
finding device:

cannot open mixer: No such device

And amixer says:

amixer: Mixer attach default error: No such device

But there's no problem with /dev stuff (and same devices works pretty fine
with kernel 2.6.33.2) - aplay -l doesn't work
as well:

aplay: device_list:240: no soundcards found...

With kernel 2.6.33.2, aplay -l says:

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT2020 Analog [VT2020 Analog]
Subdevices: 2/2
Subdevice #0: subdevice #0
Subdevice #1: subdevice #1
card 0: SB [HDA ATI SB], device 1: VT2020 Digital [VT2020 Digital]
Subdevices: 2/2
Subdevice #0: subdevice #0
Subdevice #1: subdevice #1
card 1: HDMI [HDA ATI HDMI], device 3: ATI HDMI [ATI HDMI]
Subdevices: 1/1
Subdevice #0: subdevice #0

A 'third party' mixer embedded in my distribution aborts by hitting a failed
assertion in function

'snd_hctl_load' (hcontrol.c)

failing assertion being 'assert(hctl->count == 0)' - I've added a few simple
lines above the assertion to print out some info on stderr, and got the
following results:

In kernel 2.6.33.2:

hctl->count: 0
hctl->ctl: 134748144 (0x80817F0)
hctl->ctl->name: hw:0

which seems reasonable - according to /proc/iomem address 0x80817F0 is in
range 00100000-cf83ffff (system ram) and higher than kernel stuff subranges
( 01000000-012c3be7: Kernel code - 012c3be8-0141dadf : Kernel data -
01481000-014b1e03 : Kernel bss);

In kernel 2.6.38.2 & .38.3:

hctl->count: 1156
hctl->ctl: 5398 (0x1516)
Segmentation fault

suggesting memory corruption (that's always the same address) - according to
/proc/iomem address 0x1516 is in first range (0x0000-0xffff) which is
reserved.

I thought (and hoped) that could have been somehow related to
cached/noncached pages issue solved by commit
c27b92295ab4c6b90b1cee94c4c9c1b4732e1c2e, but applying diff patch for kernel
2.6.38.3 didn't change anything. After that, I've read changelog for
kermel 2.6.38.4
but such didn't seem to me to present related material, so I didn't updgrade.

I hope this post can help solving this issue and improving alsa
infrastracture (I cannot easily go further).
Best regards.
