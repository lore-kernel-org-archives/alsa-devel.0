From: Paul Davis <pbd@op.net>
Subject: Re: HDSP -- how to configure modules.conf?
Date: Wed, 15 May 2002 08:41:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205151240.g4FCe3T22265@post2.fast.net>
References: <000001c1fbb5$e50cd3c0$ac1f830a@ico>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Tue, 14 May 2002 22:11:59 EDT."
             <000001c1fbb5$e50cd3c0$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Sorry Paul for cluttering your inbox :-(
>
>Just a quick question:
>
>Do I use snd-rme9652.o module for hdsp or which one?

snd-hdsp.o

>Obviously, I also need to modprobe snd-hammerfall-mem.o.

yes, and almost certainly early in the boot sequence. i use
/etc/rc.d/rc.sysinit, and do it before running fsck.

>Could you please just post your example of the modules.conf for this
>beast so that I know for sure that there are no extra flags I need to
>worry about.

this is the audio-related section. the only option you need worry
about is the snd-enable option to snd-hammerfall-mem.o, and even that
is optional because by default the module will just allocate memory
for every Hammerfall or Hammerfall DSP device that it finds.

--p

----------------------------------------------------------------------
# Audio

# soundcore is the multiplexer for any and all sound drivers
# and ALSA hangs from major device 116

alias char-major-14 soundcore
alias char-major-116 snd

# soundcore/OSS service number notes:
# 0: /dev/mixer
# 1: /dev/sequencer
# 2: /dev/midi
# 3: /dev/dsp
# 4: /dev/audio
# 5: /dev/dspW
# 6: sndstat
# 8: /dev/music
# 9: /dev/synth
# 10: /dev/dmfm
# 12: /dev/adsp

# Four soundcards. 
# OSS-style opens look for sound-slot-N
# ALSA-style opens look for snd-card-N

alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
alias sound-slot-2 snd-card-2
alias sound-slot-3 snd-card-3

alias snd-card-0 snd-wavefront
alias snd-card-1 snd-trident
alias snd-card-2 snd-rme9652
alias snd-card-3 snd-hdsp

# First soundcard is a Turtle Beach Tropez+, which has a CS4232 (with
# an ad1848 CODEC), the usual OPL3, and an ICS2115 wavetable
# synthesizer with its own MIDI interface.  

# Here, we leave the CS4232 MIDI interface undefined, since it uses a
# physical interface that is only accessible from within the case of
# the machine and I'm not interested in using it. To use it, set:
#
#	snd_cs4232_mpu_port
#	snd_cs4232_mpu_irq

options snd-wavefront snd_id="Tropez+"
options snd-wavefront-synth \
	reset_time=100 \
	debug_default=0xffff \
	wf_raw=1

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-12 snd-pcm-oss

# Second soundcard is HoonTech SoundWave 4D-NX, based on
# the Trident 4D-NX chip. 

options snd-trident snd_id="4D"

alias sound-service-1-0  snd-mixer-oss
alias sound-service-1-3  snd-pcm-oss
alias sound-service-1-12 snd-pcm-oss

# Both the RME9652 and Hammerfall DSP drivers use
# the snd-hammerfall_mem module.

options snd-hammerfall_mem snd_enable=1,1

# Third card is an RME Digi9652 (Hammerfall)
# It offers nothing but pure digital PCM 

options snd-rme9652 snd_id="9652"

# Fourth card is an RME Hammerfall DSP card
# It offers variety of things

options snd-hdsp snd_id="hdsp"

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
