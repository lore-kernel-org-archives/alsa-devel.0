From: Thorsten Haas <thorsten.haas@gmx.de>
Subject: (no subject)
Date: Fri, 5 Jul 2002 18:51:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207051851.51562.thorsten.haas@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_F6CSPSBUQBOL7MHE4HYA"
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


--------------Boundary-00=_F6CSPSBUQBOL7MHE4HYA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit


Hi everyone,

I am using an usb quattro and this card as primary device:

Card: SiS SI7018
Chip: Avance Logic ALC200/200P rev 0
This Chip worked with alsa 0.5.2 and snd-card-trident


I compiled alsa from this day's cvs, set up modules.conf, depmod -a, rpobed 
the mosules, setup .asoundrc, and pushes every volume in alsamixer to the 
max.

thaas@linda:~> aplay bayalarm1.Phase.wav
Playing WAVE 'bayalarm1.Phase.wav' : Unsigned 8 bit, Rate 22050 Hz, Mono

But when playing some sample there's no output from the speakers! (The 
speakers are internal, so please don't ask me if I forgot to plug any cable.)

_The_strange_thing_:
When I let any application play some sound and initialize my soft-modem, there 
is sound, both from the modem and from the application. But if I touch any 
volume in alsamixer I am surrounded by silence, suddenly.


I attached a snippet of modules.conf, my .asoundrc, the output of lsmod and 
amixer.

Can anybody please give me a hint what I did wrong this time?


Regards,

Thorsten
--------------Boundary-00=_F6CSPSBUQBOL7MHE4HYA
Content-Type: text/plain;
  charset="us-ascii";
  name="amixer.dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="amixer.dump"

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [off] 
  Front Right: Playback 31 [100%] [off] 
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31 
  Mono: Playback 31 [100%] [off] 
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [off] 
  Front Right: Playback 31 [100%] [off] 
Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 15 [100%] 
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 15 [100%] 
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [on] 
  Front Right: Playback 31 [100%] [on] 
Simple mixer control 'PCM Chorus',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 127 
  Mono: Playback 127 [100%] 
Simple mixer control 'PCM Front',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 1023 
  Mono: Playback 1013 [99%] 
Simple mixer control 'PCM Pan Playback Control',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 127
  Mono: 127 [100%] 
Simple mixer control 'PCM Reverb',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 127 
  Mono: Playback 126 [99%] 
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [off] Capture [off] 
  Front Right: Playback 31 [100%] [off] Capture [off] 
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [off] Capture [off] 
  Front Right: Playback 31 [100%] [off] Capture [off] 
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Mono: Playback 31 [100%] [off] 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control 'Video',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [off] Capture [on] 
  Front Right: Playback 31 [100%] [off] Capture [on] 
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Mono: Playback 31 [100%] [off] 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15 
  Mono: Playback 15 [100%] [off] 
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [off] Capture [off] 
  Front Right: Playback 31 [100%] [off] Capture [off] 
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right 
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%] [off] 
  Front Right: Capture 15 [100%] [off] 
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'External Amplifier Power Down',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 

--------------Boundary-00=_F6CSPSBUQBOL7MHE4HYA
Content-Type: text/plain;
  charset="us-ascii";
  name="asoundrc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="asoundrc"

#
# ALSA - .asoundrc
#

pcm.Q4 {
	type hw
	card 1 

}
ctl.Q4 {
	type hw
	card 1
}

pcm.SiS {
	type hw
	card 0 

}
ctl.SiS {
	type hw
	card 0
}


pcm.quattro1 {
	type hw
	card 1
	device 0
}
ctl.quattro1 {
	type hw
	card 1
}

pcm.quattro2 {
	type hw
	card 1
	device 1
}
ctl.quattro2 {
	type hw
	card 1
}

pcm.quattro3 {
	type hw
	card 1
	device 2
}
ctl.quattro3 {
	type hw
	card 1
}



--------------Boundary-00=_F6CSPSBUQBOL7MHE4HYA
Content-Type: text/plain;
  charset="us-ascii";
  name="modules_snippet.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="modules_snippet.conf"

---------------------- snip -------------------------
### NEW ALSA 0.9 from CVS 2002-07-05

##       General
# ALSA portion
  alias char-major-116 snd
# OSS/Free portion
  alias char-major-14 soundcore

##      Native Devices: ALSA portion
# quattro usb
  alias snd-card-1 snd-usb-audio
  options snd-usb-audio snd_id="Q4"
# sis onboard (trident)
  alias snd-card-0 snd-trident
  options snd-trident snd_id="SiS"

##      Native Devices: OSS/Free portion
# OSS Free Portion - Card 1 - quattro usb
  alias sound-slot-1 snd-card-1
  alias sound-service-1-0 snd-mixer-oss
  alias sound-service-1-1 snd-seq-oss
  alias sound-service-1-3 snd-pcm-oss
  alias sound-service-1-8 snd-seq-oss
  alias sound-service-1-12 snd-pcm-oss
# OSS Free Portion - Card 0 - Trident
  alias sound-slot-0 snd-card-0
  alias sound-service-0-0 snd-mixer-oss
  alias sound-service-0-3 snd-pcm-oss
  alias sound-service-0-12 snd-pcm-oss
---------------------- snap -------------------------


--------------Boundary-00=_F6CSPSBUQBOL7MHE4HYA
Content-Type: text/plain;
  charset="us-ascii";
  name="lsmod.dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lsmod.dump"

Module                  Size  Used by
snd-pcm-oss            35568   1  (autoclean)
snd-mixer-oss           8720   0  (autoclean) [snd-pcm-oss]
slamrmo               202672   0  (unused)
slfax                 127136   0  (unused)
slv90                1426208   0  (unused)
slmdm                1758672   0  [slamrmo slfax slv90]
snd-trident-synth       7008   1 
snd-seq-instr           4160   0  [snd-trident-synth]
snd-ainstr-simple       1440   0  [snd-trident-synth]
snd-seq-midi-emul       4240   0  [snd-trident-synth]
snd-seq                34448   1  [snd-trident-synth snd-seq-instr snd-seq-midi-emul]
snd-trident            21376   1  [snd-trident-synth]
gameport                1328   0  [snd-trident]
snd-util-mem            1136   0  [snd-trident]
snd-mpu401-uart         2544   0  [snd-trident]
snd-rawmidi            11328   0  [snd-mpu401-uart]
snd-seq-device          3696   0  [snd-trident-synth snd-seq snd-trident snd-rawmidi]
snd-ac97-codec         23504   0  [snd-trident]
snd-usb-audio          23600   0  (unused)
snd-pcm                49792   0  [snd-pcm-oss snd-trident snd-usb-audio]
snd-timer               9424   0  [snd-seq snd-pcm]
snd                    23008   0  [snd-pcm-oss snd-mixer-oss snd-trident-synth snd-seq-instr snd-seq snd-trident snd-util-mem snd-mpu401-uart snd-rawmidi snd-seq-device snd-ac97-codec snd-usb-audio snd-pcm snd-timer]
soundcore               3280   5  [snd]
parport_pc             19280   1  (autoclean)
nfsd                   64880   4  (autoclean)
lp                      5248   0  (autoclean)
parport                22240   1  (autoclean) [parport_pc lp]
ds                      6832   1 
i82365                 23296   1 
pcmcia_core            43008   0  [ds i82365]
ipv6                  124736  -1  (autoclean)
evdev                   4160   0  (unused)
input                   3072   0  [evdev]
usb-ohci               17680   0  (unused)
usbcore                47264   1  [snd-usb-audio usb-ohci]
af_packet              11552   1  (autoclean)
sis900                 11232   1  (autoclean)
iptable_nat            12656   0  (autoclean) (unused)
ip_conntrack           12848   1  (autoclean) [iptable_nat]
iptable_filter          1728   0  (autoclean) (unused)
ip_tables              10496   4  [iptable_nat iptable_filter]
nls_cp437               4384   1  (autoclean)
nls_iso8859-1           2880   2  (autoclean)
ntfs                   47216   1  (autoclean)
reiserfs              147920   0  (unused)
ide-scsi                7552   0 

--------------Boundary-00=_F6CSPSBUQBOL7MHE4HYA--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
