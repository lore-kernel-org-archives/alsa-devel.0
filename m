From: Will <walsac@liam2.demon.co.uk>
Subject: Invalid MIDI recordings and silent external playback
Date: Mon, 26 Aug 2002 00:12:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020825235321.A8218@liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Description: Invalid MIDI files recorded and silent playback

Raw MIDI input/output is not working in ALSA 0.9.0rc3 on a
Soundblaster AWE64 Gold ISA and external MIDI instruments.
Everything else works fine including MIDI file playback on
the synth.  Playback on external MIDI gives total silence.
For comparison, raw MIDI input works perfectly on the very
same hardware on OSS/Linux 2.0.x [MIDI output was never
implemented in OSS/2.0.x].   In detail:

1) Every MIDI file recording from external MIDI instruments
   contains invalid time values in each MIDI event,
   meaning the file can't be played back.  The recorded
   MIDI files do contain note-on and note-off events but
   the files are useless without correct time values.
   An example invalid MIDI files is in the attachment.
   The recording was made in the Rosegarden sequencer
   (it works ok on OSS/Linux 2.0.x)

   Is anyone working on a patch for rawmidi.c?

2) Valid MIDI files won't playback to external MIDI
   instruments -- there is no sound output.

3) make install didn't install the ALSA headers
   /usr/include/alsa/* like it did with old ALSA betas.
   Is this new behaviour correct?  How do you get a
   complete set of ALSA headers installed automatically?
   rm -rf existing headers doesn't trigger a re-install.

4) BTW, is anyone working on MIDI RESET for ALSA 1.0.0?
   alsa-kernel/core/rawmidi.c says MIDI reset is in the
   TODO stage. I have instruments that sometimes need
   MIDI reset.  OSS/Linux 2.0.x had a handy seq_reset()
   in drivers/sound/sequencer.c which mostly worked well.

Thanks,

Will
-------------------------------

--3MwIy2ne0vdjdPXF
Content-Type: audio/midi
Content-Disposition: attachment; filename="recording.mid"
Content-Transfer-Encoding: base64

TVRoZAAAAAYAAQABAeBNVHJrAAAC5AD/AxBSZWNvcmRlZCBUcmFjayAwAP8GI0NyZWF0ZWQg
YnkgdGhlIFJvc2VnYXJkZW4gc2VxdWVuY2VyAP9RAwehIACQPgAAgD5/2rpDkDwmPYA8fwCQ
UQAASjQAgEp/g0yQPiE0TDKQ3DaATH+P4RlRf7n8dD5/gaGZVJA8JGmAPH8AkE4oAD4fAIA+
fwCQTzcAgE9/AJA8LACAPH/a13ZOf631b5BKMhuASn+BnMEJkDsNd4A7f4Hm2W+QPiYagD5/
gZy+TJBKLCuASn+B+9QXkEw1aYBMf5DcNpA8GEqAPH8AkE4sAIBOf4H71BeQPh5pgD5/2rpD
kE8wPYBPfwCQPCaYAFE5AIBRfwCQPikAgD5/AJA7IQBTOACAU38AkD4UAIA+f4Grygg8f9CK
Dzt/AJBWN2mAVn8AkFQ5AFM1ADksAIA5fwCQUTMAgFF/AJA8DwCAPH8AkFQ6AIBUfwCQUywA
gFN/AJBRMwCAUX8AkD4eAIA+fwCQTzQAgE9/AJBRNACAUX8AkE8aAIBPfwCQUy0AgFN/AJBR
LQCAUX8AkE8rAIBPfwCQTwsAgE9/AJBTKwCAU38AkFExAIBRfwCQTy8AgE9/AJBOLgCATn8A
kDwpAIA8fwCQMiUAgDJ/AJA5LQCAOX8AkFEvAIBRfwCQSjIAgEp/AJBOLACATn8AkDcRAIA3
fwCQTysAgE9/AJA7AQCAO38AkEMrAIBDfwCQRSoAgEV/AJBHKQCAR38AkEgrAIBIfwCQSjsA
gEp/AJBMGwCATH8AkE4uAIBOfwCQTzEAgE9/AJBRNwCAUX8AkFMzAIBTfwCQOTMAgDl/AJA8
MQCAPH8AkFQ+AIBUfwCQTzAAgE9/AJA5JACAOX8AkDwmAIA8fwCQUycAgFN/AJBUHQCAVH8A
kFMYAIBTfwCQPCwAgDx/AJBUPgCAVH8AkDkxAIA5fwCQUTIAgFF/AJBWMgCAVn8A/y8ACYBT
f9q6OlR/

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Description: Was: [Empty MIDI recordings with ALSA]

I want to make external MIDI instruments work with ALSA.
I don't mean just being able to play MIDI files on the
soundcard using soundfont samples.  I want to play external
MIDI instruments and have the PC be able to record the
MIDI events into a MIDI file.  I also want the PC to be
able to play MIDI files on an external MIDI keyboard.
Is anyone else successfully using ALSA to record the
playing of MIDI instruments or playing MIDI files on
external MIDI instruments?

I'm using an ISA SoundBlaster AWE64 Gold card and ALSA
sound driver 0.9.0rc2 as well as a patched ALSA using
Clemens Ladisch' patch to rawmidi.c  ALSA compiles fine
with 2.4.x kernels/devfsd and apparently installs fine
(lsmod output in attachment).  The ALSA config looks fine
(see attachments) apart from what might be one odd feature
(see below after next paragraph).

I'm using the excellent Rosegarden MIDI software v2.1
(www.all-day-breakfast.com/rosegarden/) to read the MIDI
events into a MIDI file and to create musical scores.
Without Clemens' patch I don't get any MIDI sequencer
input from the MIDI instruments.  The recorded MIDI files
are empty with no MIDI events.  With Clemens' patch the
recorded MIDI files are non-empty but have invalid time
values making them unplayable.  This is odd because MIDI
input works perfectly when I play the same MIDI instruments
connected to a PC with an old 2.0.x kernel, OSS and an old
ISA SoundBlaster 16 (CreativeTech original).  I get valid
MIDI files as recordings.  I want to do the same with ALSA.

One difference in the OSS /dev/sndstat outputs (full
outputs in attachments) is that "Card config:" is missing
the MPU registration which you do get in OSS/Linux 2.0.x
but maybe that's simply because ALSA uses /dev/sndstat
differently -- in fact, the MPU401 port is in /proc/ioports
(see attachment).

ALSA/Linux 2.4.x:

   [...]
   Card config:
   Sound Blaster 16 at 0x220, irq 5, dma 1&5
>>>[ MPU is not mentioned here ]

   [...]
   Midi devices:
   0: MPU-401 (UART)

   [...]

OSS/Linux 2.0.x:

   [...]
   Card config:
   Sound Blaster at 0x220 irq 5 drq 1,5
>>>SB MPU-401 at 0x300 irq 5
   OPL-2/OPL-3 FM at 0x388 drq 0

   [...]
   Midi devices:
   0: Sound Blaster 16

   [...]

lsmod output shows I've got the usual ALSA SnowStorm(R)
of 10^2 loaded modules:-) including snd-mpu401-uart
together with snd-seq-oss, snd-seq-device, snd-rawmidi,
snd-seq-midi, snd-seq-virmidi, and snd-seq-midi-emul.

BTW, what is the minimum correct modules.conf to use with ALSA?
Is something wrong with my modules.conf?  Any ideas?
Thanks,

Will


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Description: /dev/sndstat ALSA/Linux 2.4.19
Content-Disposition: attachment; filename=sndstat

Sound Driver:3.8.1a-980706 (ALSA v0.9.0rc2 emulation code)
Kernel: Linux alsatest 2.4.19 #5 Wed Aug 14 17:10:26 BST 2002 i686
Config options: 0

Installed drivers: 
Type 10: ALSA emulation

Card config: 
Sound Blaster 16 at 0x220, irq 5, dma 1&5

Audio devices:
0: DSP v4.16 (DUPLEX)

Synth devices:
0: OPL3 FM

Midi devices:
0: MPU-401 (UART)

Timers:
7: system timer

Mixers:
0: mixer00

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Description: /dev/sndstat OSS/Linux 2.0.39
Content-Disposition: attachment; filename=sndstat

Sound Driver:3.5.4-960630 (Fri Dec 15 14:42:06 GMT 2000 will,
Linux osstest 2.0.39 #6 Thu Dec 14 19:01:13 GMT 2000 i686)
Kernel: Linux osstest 2.0.39 #8 Fri Dec 15 08:21:13 GMT 2000 i686
Config options: 0

Installed drivers: 
Type 1: OPL-2/OPL-3 FM
Type 2: Sound Blaster
Type 7: SB MPU-401

Card config: 
Sound Blaster at 0x220 irq 5 drq 1,5
SB MPU-401 at 0x300 irq 5
OPL-2/OPL-3 FM at 0x388 drq 0

Audio devices:
0: Sound Blaster 16 (4.13)

Synth devices:
0: Yamaha OPL-3

Midi devices:
0: Sound Blaster 16

Timers:
0: System clock

Mixers:
0: Sound Blaster

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Description: /etc/modules.conf ALSA/Linux 2.4.19
Content-Disposition: attachment; filename="modules.conf"

alias usb-controller usb-uhci

# For ALSA sound drivers and a SoundBlaster 32/64 AWE only:
alias	sound		snd-sbawe
alias	char-major-14	soundcore
alias	char-major-116	sound
alias	/dev/dsp	sound
alias	/dev/music	sound
alias	/dev/sound	sound
alias	/dev/sequencer	sound
alias	/dev/sndstat	sound
options			snd-sbawe snd_isapnp=1 snd_awe_port=0x620
add above		snd-sbawe snd-pcm-oss snd-mixer-oss snd-seq-oss
alias snd-card-1 off
alias snd-card-2 off
alias snd-card-3 off
alias snd-card-4 off
alias snd-card-5 off
alias snd-card-6 off
alias snd-card-7 off

# For ALSA sound drivers and an ordinary SoundBlaster 16 only:
#alias	sound	sb
#options	sb io=0x220 irq=5 dma=1 dma16=5 mpu_io=0x300
#alias	char-major-116	sb
#alias	/dev/dsp	sb
#alias	/dev/music	sb
#alias	/dev/sound	sb
#alias	/dev/sequencer	sb
#alias	/dev/sndstat	sb
#add above		sb snd-pcm-oss snd-mixer-oss snd-seq-oss

# For ALSA sound drivers and a SoundBlaster 32/64 AWE only:
#post-install		snd-mixer-oss	/bin/sound-mixer-init

# For OSS/Free sound drivers only:
alias	char-major-14	soundcore

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Description: lsmod ALSA/Linux 2.4.19
Content-Disposition: attachment; filename=lsmod

Module                  Size  Used by    Tainted: P  
snd-seq-midi            3328   0  (autoclean) (unused)
snd-emu8000-synth       8584   0  (autoclean) (unused)
snd-pcm-oss            35684   0  (autoclean) (unused)
snd-mixer-oss           9212   1  (autoclean) [snd-pcm-oss]
snd-emux-synth         24060   0  (autoclean) [snd-emu8000-synth]
snd-seq-virmidi         2584   0  (autoclean) [snd-emux-synth]
snd-util-mem            1200   0  (autoclean) [snd-emu8000-synth snd-emux-synth]
snd-seq-oss            22336   0  (autoclean) (unused)
snd-seq-midi-event      2984   0  (autoclean) [snd-seq-midi snd-seq-virmidi snd-seq-oss]
snd-opl3-synth          8836   0  (autoclean) (unused)
snd-seq-instr           4304   0  (autoclean) [snd-opl3-synth]
snd-seq-midi-emul       4320   0  (autoclean) [snd-emux-synth snd-opl3-synth]
snd-seq                33936   2  (autoclean) [snd-seq-midi snd-emux-synth snd-seq-virmidi snd-seq-oss snd-seq-midi-event snd-opl3-synth snd-seq-instr snd-seq-midi-emul]
snd-ainstr-fm           1396   0  (autoclean) [snd-opl3-synth]
snd-sbawe              16128   1  (autoclean) [snd-emu8000-synth]
snd-sb16-csp           15080   0  (autoclean) [snd-sbawe]
isa-pnp                27908   0  (autoclean) [snd-sbawe]
snd-opl3-lib            5092   0  (autoclean) [snd-opl3-synth snd-sbawe]
snd-hwdep               3424   0  (autoclean) [snd-sb16-csp snd-opl3-lib]
snd-sb16-dsp            5224   0  (autoclean) [snd-sbawe]
snd-pcm                48128   0  (autoclean) [snd-emu8000-synth snd-pcm-oss snd-sb16-dsp]
snd-timer               9576   0  (autoclean) [snd-seq snd-opl3-lib snd-pcm]
snd-sb-common           5960   0  (autoclean) [snd-sbawe snd-sb16-csp snd-sb16-dsp]
snd-mpu401-uart         2544   0  (autoclean) [snd-sbawe snd-sb16-dsp]
snd-rawmidi            11968   0  (autoclean) [snd-seq-midi snd-seq-virmidi snd-mpu401-uart]
snd-seq-device          3824   0  (autoclean) [snd-seq-midi snd-emu8000-synth snd-emux-synth snd-seq-oss snd-opl3-synth snd-seq snd-sbawe snd-opl3-lib snd-rawmidi]
snd                    24204   0  (autoclean) [snd-seq-midi snd-emu8000-synth snd-pcm-oss snd-mixer-oss snd-emux-synth snd-seq-virmidi snd-util-mem snd-seq-oss snd-seq-midi-event snd-opl3-synth snd-seq-instr snd-seq snd-sbawe snd-sb16-csp snd-opl3-lib snd-hwdep snd-sb16-dsp snd-pcm snd-timer snd-sb-common snd-mpu401-uart snd-rawmidi snd-seq-device]

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Description: /proc/... ALSA/Linux 2.4.19
Content-Disposition: attachment; filename=misc

 # cat /proc/asound/cards
0 [card0          ]: SB AWE - Sound Blaster 16
                     Sound Blaster 16 at 0x220, irq 5, dma 1&5

 # cat /proc/asound/devices
  0: [0- 0]: ctl
  4: [0- 0]: hardware dependent
  8: [0- 0]: raw midi
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
  9: [0- 1]: raw midi
 10: [0- 2]: raw midi
 17: [0- 1]: digital audio playback
 33:       : timer

 # cat /proc/asound/oss/devices
 10: [0-10]: hardware dependent
  2: [0- 2]: raw midi
  0: [0- 0]: mixer
  1:       : sequencer
  8:       : sequencer
 13: [0-13]: raw midi

 # cat /proc/bus/isapnp/devices 
0100    CTL009eCTL0044  0102200330038800000000000000000000010100000105050000000000000000000000000000000000
0101    CTL009eCTL7002  0000000000000000000000000000000000000200000404040000000000000000000000000000000000
0102    CTL009eCTL0023  0106200a200e2000000000000000000000000200000404040000000000000000000000000000000000

 # cat /proc/interrupts 
           CPU0       
   [...]
  5:          1          XT-PIC  SoundBlaster
   [...]
NMI:          0 
LOC:          4 
ERR:          5
MIS:          0

 # cat /proc/ioports 
0000-001f : dma1
[...]
0080-008f : dma page reg
[...]
00c0-00df : dma2
[...]
0213-0213 : isapnp read
0220-022f : SoundBlaster
[...]
0330-0331 : MPU401 UART
[...]
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
[...]
0620-0623 : Emu8000-1
0a20-0a23 : Emu8000-2
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e20-0e23 : Emu8000-3
[...]


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Description: /etc/devfsd.conf ALSA/Linux 2.4.19
Content-Disposition: attachment; filename=devfsd.conf

 % cat /etc/devfsd.conf
# Enable full compatibility mode for old device names. You may comment these
# out if you don't use the old device names. Make sure you know what you're
# doing!
REGISTER        .*      MKOLDCOMPAT
UNREGISTER      .*      RMOLDCOMPAT

# You may comment these out if you don't use the original "new" names
REGISTER        .*      MKNEWCOMPAT
UNREGISTER      .*      RMNEWCOMPAT

# Enable module autoloading. You may comment this out if you don't use
# autoloading
LOOKUP          .*      MODLOAD

#
# Uncomment this if you want the old /dev/cdrom symlink
# (e.g. those specifying CD-ROM type, mouse port, modem port etc)
#
LOOKUP          ^cdrom$         CFUNCTION GLOBAL symlink cdroms/cdrom0 $devpath
REGISTER        ^cdrom/cdrom0$  CFUNCTION GLOBAL symlink cdroms/cdrom0 cdrom
UNREGISTER      ^cdrom/cdrom0$  CFUNCTION GLOBAL unlink cdrom

LOOKUP          ^audio$         CFUNCTION GLOBAL symlink sound/audio $devpath
REGISTER        ^audio/audio$   CFUNCTION GLOBAL symlink sound/audio audio
UNREGISTER      ^audio/audio$   CFUNCTION GLOBAL unlink audio

LOOKUP          ^midi$          CFUNCTION GLOBAL symlink sound/midi00 $devpath
REGISTER        ^midi/midi00$   CFUNCTION GLOBAL symlink sound/midi00 midi
UNREGISTER      ^midi/midi00$   CFUNCTION GLOBAL unlink midi

LOOKUP          ^music$         CFUNCTION GLOBAL symlink sound/sequencer2 $devpath
REGISTER        ^music/sequencer2$      CFUNCTION GLOBAL symlink sound/sequencer2 music
UNREGISTER      ^music/sequencer2$      CFUNCTION GLOBAL unlink music

LOOKUP          ^sbdsp$         CFUNCTION GLOBAL symlink sound/dsp $devpath
REGISTER        ^sbdsp/dsp$     CFUNCTION GLOBAL symlink sound/dsp sbdsp
UNREGISTER      ^sbdsp/dsp$     CFUNCTION GLOBAL unlink sbdsp

LOOKUP          ^sndstat$       CFUNCTION GLOBAL symlink /proc/asound/sndstat $devpath
REGISTER        ^sndstat/proc/asound/sndstat$   CFUNCTION GLOBAL symlink /proc/asound/sndstat sndstat
UNREGISTER      ^sndstat/proc/asound/sndstat$   CFUNCTION GLOBAL unlink sndstat

# Set the correct owner/group permissions on the sound driver device files:
LOOKUP          snd		MODLOAD ACTION snd
REGISTER        sound/.*        PERMISSIONS root.audio 660
REGISTER        snd/.*          PERMISSIONS root.audio 660

--3MwIy2ne0vdjdPXF--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
