From: Thomas Fjellstrom <tfjellstrom@shaw.ca>
Subject: no output with 0.9.0beta12 rawmidi
Date: Fri, 12 Apr 2002 01:23:30 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0GUG006L21R3KR@l-daemon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
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

HI!

Im trying to figure out the rawmidi API for a project. Unfortunatly I cant 
hear anything when playing a midi with my code or with the alsa-lib rawmidi 
demo. I have a soundfont loaded, and I can hear the midis if I play them with 
pmidi, But rawmidi just doesn't want to work.

System:
SBLive! Value
MSI K7T Pro w/RAID
Linux 1.4.18 (+rml preempt)
glibc 2.2.5
gcc 2.95.4
alsa 0.9.0beta12 (driver + lib + utils + oss)

/proc/asound/sndstat:
Sound Driver:3.8.1a-980706 (ALSA v0.9.0beta12 emulation code)
Kernel: Linux natasha 2.4.18 #4 Sat Mar 30 16:57:24 MST 2002 i686
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
Sound Blaster Live! at 0xb000, irq 7

Audio devices:
0: EMU10K1 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices:
0: EMU10K1 MPU-401 (UART)

Timers:
7: system timer

Mixers:
0: mixer00


/sbin/lsmod:
Module                  Size  Used by    Not tainted
snd-seq-midi            3232   0 (autoclean) (unused)
snd-seq-oss            25248   0 (autoclean)
snd-pcm-oss            36160   0 (autoclean)
snd-mixer-oss           9504   0 (autoclean) [snd-pcm-oss]
mousedev                3968   1 (autoclean)
hid                    19168   0 (unused)
input                   3424   0 (autoclean) [mousedev hid]
snd-emu10k1-synth       3968   0
snd-emux-synth         24960   0 [snd-emu10k1-synth]
snd-seq-midi-emul       4560   0 [snd-emux-synth]
snd-seq-virmidi         2728   0 [snd-emux-synth]
snd-seq-midi-event      3128   0 [snd-seq-midi snd-seq-oss snd-seq-virmidi]
snd-seq                39244   2 [snd-seq-midi snd-seq-oss snd-emux-synth 
snd-seq-midi-emul snd-seq-virmidi snd-seq-midi-event]
snd-emu10k1            57600   0 [snd-emu10k1-synth]
snd-pcm                51616   0 [snd-pcm-oss snd-emu10k1]
snd-timer              11104   0 [snd-seq snd-pcm]
snd-rawmidi            13440   0 [snd-seq-midi snd-seq-virmidi snd-emu10k1]
snd-seq-device          4096   0 [snd-seq-midi snd-seq-oss snd-emu10k1-synth 
snd-emux-synth snd-seq snd-emu10k1 snd-rawmidi]
snd-hwdep               3808   0 [snd-emu10k1]
snd-util-mem            1232   0 [snd-emux-synth snd-emu10k1]
snd-ac97-codec         22976   0 [snd-emu10k1]
snd                    26952   1 [snd-seq-midi snd-seq-oss snd-pcm-oss 
snd-mixer-oss snd-emux-synth snd-seq-virmidi snd-seq-midi-event snd-seq 
snd-emu10k1 snd-pcm snd-timer snd-rawmidi snd-seq-device snd-hwdep 
snd-util-mem snd-ac97-codec]
nls_iso8859-1           2848   1 (autoclean)
nls_cp437               4384   1 (autoclean)
ide-scsi                7744   0
ide-cd                 26720   0
cdrom                  28960   0 [ide-cd]
tulip                  37856   1

/etc/modules.conf:
alias char-major-116 snd
alias snd-card-0 snd-emu10k1

# MIDI Synth setup
alias midi snd-emu10k1-synth
below snd-seq-oss snd-emu10k1-synth
post-install snd-emu10k1-synth /bin/sfxload \ 
/home/moose/soundfont/8MBGMSFX.SF2; /usr/sbin/alsactl restore
pre-remove snd-emu10k1-synth /usr/sbin/alsactl store
post-install snd-emu10k1 modprobe snd-emu10k1-synth

# OSS/Free Emulation
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

everything but rawmidi works fine. (rawmidi used to work with 0.5.*)

Thanks.

-- 
Thomas Fjellstrom
tfjellstrom@shaw.ca
http://strangesoft.net
