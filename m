From: Jonathan Kraut <jak76@columbia.edu>
Subject: alsa-driver-1.0.0pre2, cmipci, opl3, mpu401 problems
Date: Mon, 24 Nov 2003 02:20:07 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1AOB0L-0005K4-00@harrier.mail.pas.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-ID: <11340.1069658407.1@localhost>
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

Everything works really well (hooray dmix! and thanks) with 
alsa-driver-1.0.0pre2 and cmedia-8738 except the following midi related 
things, which were working fine in version 0.9.8 and earlier:

here's what i did (on gentoo)

$ /etc/init.d/alsasound start

$ cat /proc/asound/cards
0 [CMI8738MC6     ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
                     C-Media PCI CMI8738-MC6 (model 55) at 0xd400, irq 9
1 [VirMIDI        ]: VirMIDI - VirMIDI
                     Virtual MIDI Card 1
2 [M2x2           ]: USB-Audio - Midisport 2x2
                     Midiman Midisport 2x2 at usb-00:02.2-1
3 [Dummy          ]: Dummy - Dummy
                     Dummy 1

$ aconnect -o
client 72: 'Virtual Raw MIDI 1-0' [type=kernel]
    0 'VirMIDI 1-0     '
client 73: 'Virtual Raw MIDI 1-1' [type=kernel]
    0 'VirMIDI 1-1     '
client 74: 'Virtual Raw MIDI 1-2' [type=kernel]
    0 'VirMIDI 1-2     '
client 75: 'Virtual Raw MIDI 1-3' [type=kernel]
    0 'VirMIDI 1-3     '
client 80: 'Rawmidi 2 - Midisport 2x2' [type=kernel]
    0 'Midisport 2x2 Port 0'
    1 'Midisport 2x2 Port 1'

note: in previous releases at this point i was also able to see the 
mpu-401-uart port and the opl3 synth port. so here i modprobed them to make 
sure. but though they seemed to load ok with modprobe, i still can't connect 
to them.

$ modprobe snd-mpu401-uart
$ modprobe snd-opl3-synth
$ lsmod
Module                  Size  Used by    Tainted: P  
snd-opl3-synth         10564   0  (unused)
snd-seq-instr           6096   0  [snd-opl3-synth]
snd-seq-midi-emul       5344   0  [snd-opl3-synth]
snd-ainstr-fm           1972   0  [snd-opl3-synth]
snd-pcm-oss            39012   0  (autoclean)
snd-mixer-oss          13552   0  (autoclean) [snd-pcm-oss]
snd-seq-midi            4160   0  (autoclean) (unused)
snd-dummy               4248   0 
snd-usb-audio          46176   0 
snd-virmidi             1408   0 
snd-seq-virmidi         3432   0  [snd-virmidi]
snd-seq-midi-event      3840   0  [snd-seq-midi snd-seq-virmidi]
snd-seq                39920   0  [snd-opl3-synth snd-seq-instr 
snd-seq-midi-emul snd-seq-midi snd-seq-virmidi snd-seq-midi-event]
snd-cmipci             20820   0 
snd-opl3-lib            6628   0  [snd-opl3-synth snd-cmipci]
snd-hwdep               5408   0  [snd-opl3-lib]
snd-mpu401-uart         3808   0  [snd-cmipci]
snd-rawmidi            14720   0  [snd-seq-midi snd-usb-audio snd-seq-virmidi 
snd-mpu401-uart]
snd-seq-device          4320   0  [snd-opl3-synth snd-seq-midi snd-seq 
snd-opl3-lib snd-rawmidi]
snd-pcm                64416   0  [snd-pcm-oss snd-dummy snd-usb-audio 
snd-cmipci]
snd-timer              15876   0  [snd-seq snd-opl3-lib snd-pcm]
snd                    34244   1  [snd-opl3-synth snd-seq-instr snd-pcm-oss 
snd-mixer-oss snd-seq-midi snd-dummy snd-usb-audio snd-virmidi snd-seq-virmidi 
snd-seq-midi-event snd-seq snd-cmipci snd-opl3-lib snd-hwdep snd-mpu401-uart 
snd-rawmidi snd-seq-device snd-pcm snd-timer]
soundcore               4196  15  [snd]
snd-page-alloc          6484   0  [snd-dummy snd-pcm]

$ aconnect -o
client 72: 'Virtual Raw MIDI 1-0' [type=kernel]
    0 'VirMIDI 1-0     '
client 73: 'Virtual Raw MIDI 1-1' [type=kernel]
    0 'VirMIDI 1-1     '
client 74: 'Virtual Raw MIDI 1-2' [type=kernel]
    0 'VirMIDI 1-2     '
client 75: 'Virtual Raw MIDI 1-3' [type=kernel]
    0 'VirMIDI 1-3     '
client 80: 'Rawmidi 2 - Midisport 2x2' [type=kernel]
    0 'Midisport 2x2 Port 0'
    1 'Midisport 2x2 Port 1'

thanks again,
-jon

--------
Jonathan Kraut
NYC
jak76@columbia.edu


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
