From: John Talbut <john@dpets.demon.co.uk>
Subject: Setup when compiled in 2.6 kernel
Date: Sun, 19 Feb 2006 17:21:27 +0000
Message-ID: <43F8A917.8010008@dpets.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have ALSA compiled in my 2.6.8 kernel and I have failed to get it to 
work after months, many hours, reading loads and trying just about 
everything suggested.

So, unless someone can point me straight to the answer, I am hoping to 
start a thread that could be the basis of a definitive howto on how to 
do this.  As far as I can see many people have had the same problem and 
all of them seem to have given up, or resorted to installing ALSA as a 
module.  There do seem to be some for whom it seemed to work from the start.

I am using the Debian unstable (etch) distribution.  My sound problems 
started when I upgraded from a 2.4 kernel, with ALSA installed as a 
module, to the 2.6.8 one.

The suggestion seems to be that if ALSA is compiled into the kernel that 
should be all that is needed.  Applications that use sound should just 
work.  So, first question, should this be so, and if not what else is 
needed?

I am looking for answers for someone who is computer literate and 
familiar with Linux but not at a programming level.  In other words, 
please do not just suggest trying this package or that - I have done all 
that.

Am I correct in believing that the kernel will set up and communicate 
with device files?  If so, how can I test them?  I have tried on various 
devices, e.g.

>  sox -V -b -c 1 -r 448000 -t alsa /dev/snd/pcmC2D0p -t .wav test.wav
and I get
> ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM /dev/snd/pcmC2D0p sox: Failed reading /dev/snd/pcmC2D0p: cannot open audio device
and
 > cat /dos/Workspace/Music/originaldedodedo.wav > /dev/snd/pcmC2D0pD
and I get nothing.

If the device files are set up correctly, how do applications know which 
to use?  Gnome seems to be looking for an asound.conf file, but the 
http://alsa.opensrc.org/.asoundrc page suggests that it should not be 
necessary.  If it is necessary is there a straightforward way of 
creating one?  Does alsaconf do this?  If so, it is not much help in 
this case as it is also about installing modules, and just kicks out 
without doing anything.

OK, that will do for now and I will see what answers you all can come up 
with.  This is one or two more error messages and my set up.

# alsamixer -c2 ALSA lib control.c:817:(snd_ctl_open_noupdate) Invalid 
CTL hw:2
alsamixer: function snd_ctl_open failed for hw:2: No such file or directory

# /usr/bin/gnome-settings-daemon
gnome-settings-daemon: conf.c:3109: snd_config_update_free: Assertion 
`update->count > 0 && update->finfo' failed.
[1140368784,000,xklavier.c:XklStartListen/]     The backend does not 
require manual layout management - but it is provided by the application

Relevant parts of  kernel-source:

# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_RTCTIMER=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_MEMORY is not set
# CONFIG_SND_DEBUG_DETECT is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=y
CONFIG_SND_VIRMIDI=y
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
#(none set)
#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
# (only
CONFIG_SND_ENS1371=y
#set)
#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=y
#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set
#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

/proc/asound/cards:

0 [Dummy          ]: Dummy - Dummy
                      Dummy 1
1 [VirMIDI        ]: VirMIDI - VirMIDI
                      Virtual MIDI Card 1
2 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                      Ensoniq AudioPCI ENS1371 at 0xdf00, irq 10

/proc/asound/devices

1:       : sequencer
   0: [0- 0]: ctl
  16: [0- 0]: digital audio playback
  24: [0- 0]: digital audio capture
  33:       : timer
  32: [1- 0]: ctl
  43: [1- 3]: raw midi
  42: [1- 2]: raw midi
  41: [1- 1]: raw midi
  40: [1- 0]: raw midi
  64: [2- 0]: ctl
  72: [2- 0]: raw midi
  81: [2- 1]: digital audio playback
  80: [2- 0]: digital audio playback
  88: [2- 0]: digital audio capture

  /dev/snd:

controlC0  hwC1D2  midiC0D0  midiC1D2  midiC2D4  midiC3D6  pcmC0D4c 
pcmC1D1c  pcmC1D6c   pcmC2D2p  pcmC2D7p  pcmC3D4p
controlC1  hwC1D3  midiC0D1  midiC1D3  midiC2D5  midiC3D7  pcmC0D4p 
pcmC1D1p  pcmC1D6p   pcmC2D3c  pcmC3D0c  pcmC3D5c
controlC2  hwC2D0  midiC0D2  midiC1D4  midiC2D6  pcmC0D0c  pcmC0D5c 
pcmC1D2c  pcmC1D7c   pcmC2D3p  pcmC3D0p  pcmC3D5p
controlC3  hwC2D1  midiC0D3  midiC1D5  midiC2D7  pcmC0D0p  pcmC0D5p 
pcmC1D2p  pcmC1D7p   pcmC2D4c  pcmC3D1c  pcmC3D6c
hwC0D0     hwC2D2  midiC0D4  midiC1D6  midiC3D0  pcmC0D1c  pcmC0D6c 
pcmC1D3c  pcmC2D0c   pcmC2D4p  pcmC3D1p  pcmC3D6p
hwC0D1     hwC2D3  midiC0D5  midiC1D7  midiC3D1  pcmC0D1p  pcmC0D6p 
pcmC1D3p  pcmC2D0p   pcmC2D5c  pcmC3D2c  pcmC3D7c
hwC0D2     hwC3D0  midiC0D6  midiC2D0  midiC3D2  pcmC0D2c  pcmC0D7c 
pcmC1D4c  pcmC2D0pD  pcmC2D5p  pcmC3D2p  pcmC3D7p
hwC0D3     hwC3D1  midiC0D7  midiC2D1  midiC3D3  pcmC0D2p  pcmC0D7p 
pcmC1D4p  pcmC2D1c   pcmC2D6c  pcmC3D3c  seq
hwC1D0     hwC3D2  midiC1D0  midiC2D2  midiC3D4  pcmC0D3c  pcmC1D0c 
pcmC1D5c  pcmC2D1p   pcmC2D6p  pcmC3D3p  timer
hwC1D1     hwC3D3  midiC1D1  midiC2D3  midiC3D5  pcmC0D3p  pcmC1D0p 
pcmC1D5p  pcmC2D2c   pcmC2D7c  pcmC3D4c






-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
