From: Will <walsac@liam2.demon.co.uk>
Subject: OSS-mode invalid MIDI recordings and silent external playback
Date: Fri, 15 Nov 2002 14:21:32 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021115142132.A3493@liam2.demon.co.uk>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Description: Invalid MIDI files recorded and silent playback

Jaroslav, Clemens and Takashi,

Thank you for your helpful suggestions.  Unfortunately the
ALSArc5 OSS-mode sequencer still fails giving invalid input
and silent output using an external MIDI keyboard.

The ALSA-mode sequencer does work for input and output,
e.g. "pmidi -p 64:0" plays midi files to external MIDI
keyboards on port 64, and "aconnect 64:0 65:0" enables
notes played on external MIDI keyboards to be played
simultaneously on the soundcard synth.  midiloop tests ok.
However, I need the OSS-mode sequencer to run OSS software
like Rosegarden to convert MIDI input to music notation.
I know Noteedit 2.0.16 works with the ALSA-mode sequencer
and I could use it but even though it's very good the
interface is still not as quick to use as Rosegarden for
note/chord editing on big scores.

Config details for my SB AWE64Gold (EISA card) are in attachments
(see also my previous msgs of 6/23/26 Aug 2002).

1) OSS-mode sequencer: Invalid MIDI recordings

   Has anyone tested the OSS-mode sequencer in ALSA
   by recording from external MIDI instruments?  If so,
   which OSS-mode software and which keyboard did you use?
   Please mail me an example MIDI file you've recorded.

   Re: my example of a MIDI file with invalid time values
       recorded from the OSS-mode sequencer:

   "rawmidi does not care about timing at all"

   Ok, I wasn't talking about event delivery speed.
   I meant the timing data in the MIDI files you get by
   recording an external MIDI instrument were invalid,
   i.e. the MIDI tick values that define the timing of
   events like note on and note off had silly values.
   The tick values should be stored in the midi event
   structures which OSS software e.g. Rosegarden reads
   from /dev/sequencer but ALSA seems to be corrupting
   the tick values.  I've tried Rosegarden, Brahms, Muse
   and ARTs with the OSS-mode sequencer from ALSA but I
   still don't get valid MIDI recordings in any of them.
   But if I use the original Linux 2.0.x OSS sound driver
   with OSS software like Rosegarden, I get correct time
   values and valid MIDI recordings.  And if I use the
   ALSA-mode sequencer with ALSA software like Noteedit
   I get correct time values and valid MIDI recordings.

   Please could you test the Rosegarden OSS sequencer on
   your hardware by making a recording from a MIDI instrument.
   Please download this statically linked bzip2'd version
      http://www.demon.net/homepages/liam2/sequencer.static.bz2
   Click "Record" in the "File" menu, then "Stop" and
   then save the MIDI recording to a file using "Save As"
   also in the "File" menu.

   This is how Rosegarden reads MIDI events from /dev/sequencer
   which works perfectly in OSS/Linux 2.0.x:

      typedef struct {
           unsigned long int    Time;
           unsigned char        Bytes[3];
      } MidiEvent;

      unsigned char     RawMidiEvent[4];
      int               devseq = open("/dev/sequencer", O_RDONLY, 0);
      MidiEvent         ev;

      read(devseq, &RawMidiEvent, sizeof(RawMidiEvent));
      switch ( RawMidiEvent[0] ) {
          case SEQ_WAIT:
             ev.Time = ((RawMidiEvent[3]<<16) | (RawMidiEvent[2]<<8) | RawMidiEvent[1]);
             break;
          case SEQ_ECHO:
             /* process MIDI echo here */
                break;
          case SEQ_MIDIPUTC:
             /* process MIDI putc here */
                break;
          /* etc */

2) OSS-mode sequencer: Silent external playback

   Playing valid MIDI files to external MIDI instruments
   using the OSS-mode sequencer gives silence.
   Only the ALSA-mode sequencer works.

Clemens wrote:
> Try "cat /dev/midi???" with your device. This will output the
> incoming data as ASCII (i.e. garbage), but the garbage should
> ppear at the same moment you press the keys on your MIDI
> keyboard.

  "cat /dev/midi*" (I tried all midi* and sound/midi* devices)
  gives hardly any output (a few characters per minute)
  and characters appear randomly not at the same time as
  external keys are pressed.

Jaroslav wrote:
> Note that throughput for MIDI output for SB16/AWE cards is only 200 bytes 
> per second, because of hardware limitations when no loops are used in 
> kernel. Try to increase your HZ value in linux/include/asm/params.h to 
> 1000 or 2000. You should have better results.

   I recompiled different 2.4.19 kernels after setting
   HZ=2000 in asm-i386/param.h (I had to fix the SHIFT_HZ
   definition which breaks when HZ>=1536 in linux/timex.h)
   but recordings are still silent.  Setting HZ=2000 also
   has the horrible side-effect of converting my speedy
   1800Mhz CPU into a crawling 66MHz CPU (BYTE benchmark
   fell from 32 to 0.08).
   
   Is there a way to get external MIDI playback working on
   the OSS-mode sequencer without increasing HZ?  Why does
   the ALSA-mode sequencer work perfectly without requiring
   a higher HZ?
   

3) Will MIDI RESET be implemented in ALSA 1.0.0 ?

Jaroslav wrote:
> I've removed these unimplemented functions. Actually, the current 
> implementation sends 0xfe byte (active sensing) at close().
> Sure, we may modify this code to satisfy some non-standard devices.

  I'm not using non-standard devices.  I've got standard
  MIDI instruments like Yamaha, Roland etc.  I want
  to send MIDI reset from ALSA to my MIDI instruments.
  It's extremely useful when you need to quickly restore
  the default settings in a MIDI instrument.  I don't
  want to close() the device every time I need to do a
  reset.  Having a reliable MIDI RESET function like the
  seq_reset() in OSS/Linux 2.0.x which explicitly switches
  off notes as well as sending 0xfe and which doesn't
  close() the device would be useful.  Would you like
  seq_reset() from OSS/Linux 2.0.x ported to ALSA?

Takashi wrote:
> > > > 4) BTW, is anyone working on MIDI RESET for ALSA 1.0.0?
> > > >    alsa-kernel/core/rawmidi.c says MIDI reset is in the
> > > >    TODO stage. I have instruments that sometimes need
> > > >    MIDI reset.  OSS/Linux 2.0.x had a handy seq_reset()
> > > >    in drivers/sound/sequencer.c which mostly worked well.
> > >
> > > I've removed these unimplemented functions. Actually, the current
> > > implementation sends 0xfe byte (active sensing) at close(). Sure, we
> > > may modify this code to satisfy some non-standard devices.
> >
> > I don't understand. Can't an application that wants to reset a device
> > just send 0xff?
>
> yes.  it should work (mostly).
>
> > And why send 0xfe at close? So the receiving device
> > will detect a connection loss 300msec later?
> > Shouldn't this all be left to the application?
>
> some (mainly old) devices required the active sensing for resetting.
> and please note that this feature can be enabled/disabled via API,
> too.

Some of my Yamaha devices need explicit note off for reliable resetting
like seq_reset() does in the old Linux 2.0.x OSS driver.
Do you mean an API exists to en(dis)able sending 0xfe at close?
Where is this API?

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

The MPU registration which you do get in the original
Linux 2.0.x OSS driver output from /dev/sndstat under
"Card config:" is missing in ALSA.  The /dev/sndstat
outputs below (full outputs in attachments) are different
but maybe that's simply because ALSA uses /dev/sndstat
differently?  The MPU401 port is in /proc/ioports
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

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Description: /dev/sndstat ALSA/Linux 2.4.19
Content-Disposition: attachment; filename=sndstat

Sound Driver:3.8.1a-980706 (ALSA v0.9.0rc5 emulation code)
Kernel: Linux alsatest 2.4.19 #7 Thu Nov 14 17:52:19 GMT 2002 i686
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

# For ALSA driver and (EISA) SoundBlaster 32/64 AWE only:
alias	sound		snd-sbawe
alias	char-major-14	soundcore
alias	char-major-116	sound
alias	/dev/dsp	sound
alias	/dev/music	sound
alias	/dev/sound	sound
alias	/dev/sequencer	sound
alias	/dev/sndstat	sound
options			snd-sbawe snd_isapnp=1 snd_awe_port=0x620
# if using devfsd you must use add-above to get the OSS modules loaded:
add above		snd-sbawe snd-pcm-oss snd-mixer-oss snd-seq-oss snd-opl3-synth
alias snd-card-1 off
alias snd-card-2 off
alias snd-card-3 off
alias snd-card-4 off
alias snd-card-5 off
alias snd-card-6 off
alias snd-card-7 off

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
  1:       : sequencer
  8:       : sequencer
  0: [0- 0]: mixer
  3: [0- 3]: digital audio
 13: [0-13]: raw midi
 12: [0-12]: digital audio

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
REGISTER        ^cdroms/cdrom0$  CFUNCTION GLOBAL mksymlink $devname cdrom
UNREGISTER      ^cdroms/cdrom0$  CFUNCTION GLOBAL unlink cdrom

REGISTER        ^sound/audio$   CFUNCTION GLOBAL mksymlink $devname audio
UNREGISTER      ^sound/audio$   CFUNCTION GLOBAL unlink audio

REGISTER        ^sound/midi00$   CFUNCTION GLOBAL mksymlink $devname midi
UNREGISTER      ^sound/midi00$   CFUNCTION GLOBAL unlink midi

REGISTER        ^sound/sequencer2$      CFUNCTION GLOBAL mksymlink $devname music
UNREGISTER      ^sound/sequencer2$      CFUNCTION GLOBAL unlink music

REGISTER        ^/proc/asound/oss/sndstat$   CFUNCTION GLOBAL mksymlink $devname sndstat
UNREGISTER      ^/proc/asound/oss/sndstat$   CFUNCTION GLOBAL unlink sndstat

# Set the correct owner/group permissions on the sound driver device files:
LOOKUP          snd		MODLOAD ACTION snd
REGISTER        sound/.*        PERMISSIONS root.audio 660
REGISTER        snd/.*          PERMISSIONS root.audio 660

--3MwIy2ne0vdjdPXF--



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
