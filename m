From: Thorsten Haas <thorsten.haas@gmx.de>
Subject: snd-trident - snd_ctl_open fails
Date: Fri, 23 Aug 2002 15:40:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <26868.3701790453$1030131717@news.gmane.org>
Reply-To: mail@thorstenhaas.de
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_VZTA76VQHN188MFB502J"
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


--------------Boundary-00=_VZTA76VQHN188MFB502J
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hello everyone,

I just installed a debian/woody and kernel 2.4.19 on my box and compiled alsa 
from cvs-snapshot 2002-08-22.tar.bz2.

I attached my configured .asoundrc, the output of lsmod and a snippet of 
modules conf.


trying to set volumes using alsamixer fails:
alsamixer: function snd_ctl_open failed for default: No such file or directory


Can anyone give me a hint, what I did wrong, please?

 
-- 
mailto:mail@thorstenhaas.de
http://www.thorstenhaas.de 
--------------Boundary-00=_VZTA76VQHN188MFB502J
Content-Type: text/plain;
  charset="us-ascii";
  name="lsmod.dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lsmod.dump"

Module                  Size  Used by    Not tainted
snd-pcm-oss            35428   0  (autoclean)
snd-mixer-oss           8704   0  (autoclean) [snd-pcm-oss]
sis                    45216  13 
parport_pc             21000   1  (autoclean)
lp                      6336   0  (autoclean)
pcmcia_core            34720   0 
parport                21888   1  (autoclean) [parport_pc lp]
tap0                    2528   1  (autoclean)
mousedev                3872   0  (unused)
input                   3072   0  [mousedev]
hid                     8736   0  (unused)
snd-trident            21380   0 
gameport                1324   0  [snd-trident]
snd-pcm                51232   0  [snd-pcm-oss snd-trident]
snd-timer               9024   0  [snd-pcm]
snd-util-mem            1072   0  [snd-trident]
snd-mpu401-uart         2544   0  [snd-trident]
snd-rawmidi            11072   0  [snd-mpu401-uart]
snd-seq-device          3632   0  [snd-trident snd-rawmidi]
snd-ac97-codec         23856   0  [snd-trident]
snd                    22920   0  [snd-pcm-oss snd-mixer-oss snd-trident snd-pcm snd-timer snd-util-mem snd-mpu401-uart snd-rawmidi snd-seq-device snd-ac97-codec]
usbcore                54272   1  [hid snd]
soundcore               3268   5  [snd]
ntfs                   49312   0  (unused)
sis900                 12068   1 
af_packet              11624   1 

--------------Boundary-00=_VZTA76VQHN188MFB502J
Content-Type: text/plain;
  charset="us-ascii";
  name="alsa"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="alsa"

## General
# ALSA portion
alias char-major-116 snd
# OSS/Free portion
alias char-major-14 soundcore

## Native Devices: ALSA portion
# quattro usb
alias snd-card-1 snd-usb-audio
options snd-usb-audio snd_id="Q4"
# sis onboard (trident)
alias snd-card-0 snd-trident
options snd-trident snd_id=SiS

## Native Devices: OSS/Free portion
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


--------------Boundary-00=_VZTA76VQHN188MFB502J
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



--------------Boundary-00=_VZTA76VQHN188MFB502J--




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
