From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001684]: no sound with SI7012
Date: Tue, 24 Jan 2006 13:54:00 +0100
Message-ID: <28e28d92265644f49a3f9679e1195ad3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E12A163
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2006 13:54:01 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1684> 
======================================================================
Reported By:                avant
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1684
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             kernel 2.6.14-1.1653_FC4
======================================================================
Date Submitted:             12-28-2005 08:39 CET
Last Modified:              01-24-2006 13:54 CET
======================================================================
Summary:                    no sound with SI7012
Description: 
I do have some problems with sound on my Asus P4S 533 MX which is based on
the SIS651 chipset with SI7012 (ADI AD1980 Codecs). Once it worked
perfectly fine with OSS and FC2.
OS: Fedora Core 4 fully updated with 
    kernel 2.6.14-1.1653_FC4 and 
    ALSA alsa-lib-1.0.10-2.FC4

The FC systemtool system-config-soundcard identifies the soundcard and
configures it apropriately, but - without playing any sound.
I've unmuted all channels ans set the volume to max with alsamixer - no
luck
I've played with the option ac97_quirk, but again - no luck.

Currently I don't know how to proceed

Currently I'm using the following configuration:

/etc/modprobe.conf
==========================
alias eth0 sis900
alias usb-controller ehci-hcd
alias usb-controller1 ohci-hcd

alias char-major-116 snd
alias snd-card-0 snd-intel8x0
options snd-card-0 index=0 ac97_quirk=disable

alias char-major-14 soundcore
alias sound-slot-0 snd-intel8x0

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
==========================
# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: SI7012 [SiS SI7012], device 0: Intel ICH [SiS SI7012]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
==========================
# lsmod
Module                  Size  Used by
parport_pc             27909  1
lp                     12937  0
parport                35593  2 parport_pc,lp
rfcomm                 38745  0
l2cap                  25921  5 rfcomm
bluetooth              48069  4 rfcomm,l2cap
ipt_REJECT              5953  1
ipt_state               1985  5
ip_conntrack           51953  1 ipt_state
nfnetlink               6617  1 ip_conntrack
iptable_filter          3137  1
ip_tables              20033  3 ipt_REJECT,ipt_state,iptable_filter
dm_mod                 57181  0
video                  16197  0
button                  6737  0
battery                 9541  0
ac                      4933  0
nvidia               4088432  12
ipv6                  249761  12
ohci_hcd               22497  0
ehci_hcd               34381  0
i2c_sis96x              5829  0
i2c_core               22081  1 i2c_sis96x
snd_intel8x0           32929  0
snd_ac97_codec         88637  1 snd_intel8x0
snd_ac97_bus            2497  1 snd_ac97_codec
snd_seq_dummy           3781  0
snd_seq_oss            31809  0
snd_seq_midi_event      7105  1 snd_seq_oss
snd_seq                49617  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          9037  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            50545  0
snd_mixer_oss          17985  1 snd_pcm_oss
snd_pcm                87493  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              25029  2 snd_seq,snd_pcm
snd                    54437  9
snd_intel8x0,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9889  1 snd
snd_page_alloc         10697  2 snd_intel8x0,snd_pcm
sis900                 21697  0
mii                     5313  1 sis900
floppy                 61957  0
ext3                  129993  3
jbd                    57813  1 ext3
==========================
# cat /proc/asound/pcm
00-00: Intel ICH : SiS SI7012 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : SiS SI7012 - MIC ADC : capture 1
==========================
cat /proc/asound/SI7012/intel8x0
Intel8x0

Global control        : 0x00000002
Global status         : 0x00300100
AC'97 codecs ready    : primary
==========================
cat /proc/asound/oss/sndstat
Sound Driver:3.8.1a-980706 (ALSA v1.0.10rc1 emulation code)
Kernel: Linux bietigheim 2.6.14-1.1653_FC4 #1 Tue Dec 13 21:32:09 EST 2005
i686
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
SiS SI7012 with AD1980 at 0x9400, irq 10

Audio devices:
0: SiS SI7012 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: Analog Devices AD1980
======================================================================

----------------------------------------------------------------------
 avant - 01-24-06 13:54 
----------------------------------------------------------------------
Hm are there some infos missing - still outstanding for now nearly a month

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-05 08:39 avant          New Issue                                    
12-28-05 08:39 avant          Distribution              => Fedora Core 4   
12-28-05 08:39 avant          Kernel Version            => kernel
2.6.14-1.1653_FC4
01-24-06 13:54 avant          Note Added: 0007774                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
