From: Mark Knecht <markknecht@comcast.net>
Subject: After warm boot Alsa not detecting sound card
Date: Sun, 02 Nov 2003 20:13:42 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1067832822.2011.8.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-o3bF1imp+mwJkwd7dG/Z"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-o3bF1imp+mwJkwd7dG/Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
   This is not a new problem on my system, but I wanted to get up to
date with Alsa before I presented it here. If I do a cold boot then Alsa
is correctly installed and both my HDSP 9652 and my MidiSport 2x2 are
detected and work fine. However, after a warm boot Alsa never installs
for the HDSP 9652.

   A BIT IMPROVEMENT with 0.9.8 is that Alsa will now load if I stop and
start Alsa by hand after the warm boot, so thanks for that! I used to
have to completely power down with 0.9.6, so this is a big improvement!
However, I'd like to get this fixed so that even these by-hand steps are
not required.

   After a warm boot the card is visible as a PCI device, but it isn't
given an interrupt and the drivers aren't loaded:

Wizard asound # lspci
<SNIP>
00:0e.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP (rev 65)
<SNIP>
Wizard asound # 


Wizard asound # cat /proc/interrupts 
           CPU0       
  0:      86720    IO-APIC-edge  timer
  1:       1271    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
12:      12786    IO-APIC-edge  PS/2 Mouse
14:       6276    IO-APIC-edge  ide0
15:          5    IO-APIC-edge  ide1
16:      27066   IO-APIC-level  ohci1394, radeon@PCI:1:0:0
18:         62   IO-APIC-level  eth0
21:       1332   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
NMI:          0 
LOC:      86667 
ERR:          0
MIS:          0
Wizard asound # 

bash-2.05b$ su -
Password: 
Wizard root # lsmod
Module                  Size  Used by    Not tainted
radeon                103400   1 
usb-midi               17180   0  (unused)
audio                  41400   0  (unused)
snd-usb-audio          46336   0 
snd-rawmidi            15072   0  [snd-usb-audio]
snd-pcm                64804   0  [snd-usb-audio]
snd-page-alloc          6676   0  [snd-pcm]
hid                    15108   1 
snd-seq                39408   0  (unused)
snd-timer              15876   0  [snd-pcm snd-seq]
snd-seq-device          4416   0  [snd-rawmidi snd-seq]
snd                    35428   0  [snd-usb-audio snd-rawmidi snd-pcm
snd-seq snd-timer snd-seq-device]
sbp2                   17984   0  (unused)
raw1394                 8028   0  (unused)
ohci1394               18196   0  (unused)
ieee1394               35280   0  [sbp2 raw1394 ohci1394]
Wizard root # 


Wizard asound # pwd  
/proc/asound
Wizard asound # more version 
Advanced Linux Sound Architecture Driver Version 0.9.8.
Compiled on Nov  2 2003 for kernel 2.4.20-gentoo-r7 with versioned
symbols.
Wizard asound # 


  I can at this point stop and restart Alsa and everything works:

Wizard root # lsmod
Module                  Size  Used by    Not tainted
radeon                103400   1 
usb-midi               17180   0  (unused)
audio                  41400   0  (unused)
hid                    15108   1 
sbp2                   17984   0  (unused)
raw1394                 8028   0  (unused)
ohci1394               18196   0  (unused)
ieee1394               35280   0  [sbp2 raw1394 ohci1394]
Wizard root # /etc/init.d/alsasound start
 * Loading ALSA drivers...
 * Loading: snd-seq-oss
 * Loading: snd-pcm-oss
 * Loading: snd-mixer-oss
 * Loading: snd-hdsp
 * Loading: snd-usb-audio
 * Loading: snd-seq-midi
 * Loading: snd-seq-oss
 * Running card-dependent scripts
 * Restoring Mixer
Levels                                                                         [ ok ]
Wizard root # lsmod
Module                  Size  Used by    Not tainted
snd-pcm-oss            39492   0  (unused)
snd-mixer-oss          13648   0  [snd-pcm-oss]
snd-usb-audio          46336   0 
snd-seq-midi            4096   0  (autoclean) (unused)
snd-hdsp               39204   0 
snd-pcm                64804   0  (autoclean) [snd-pcm-oss snd-usb-audio
snd-hdsp]
snd-rawmidi            15072   0  (autoclean) [snd-usb-audio
snd-seq-midi snd-hdsp]
snd-page-alloc          6676   0  (autoclean) [snd-hdsp snd-pcm]
snd-hwdep               5344   0  (autoclean) [snd-hdsp]
snd-seq-oss            30368   0  (unused)
snd-seq-midi-event      3840   0  [snd-seq-midi snd-seq-oss]
snd-seq                39408   2  [snd-seq-midi snd-seq-oss
snd-seq-midi-event]
snd-timer              15876   0  [snd-pcm snd-seq]
snd-seq-device          4416   0  [snd-seq-midi snd-rawmidi snd-seq-oss
snd-seq]
snd                    35428   0  [snd-pcm-oss snd-mixer-oss
snd-usb-audio snd-seq-midi snd-hdsp snd-pcm snd-rawmidi snd-hwdep
snd-seq-oss snd-seq-midi-event snd-seq snd-timer snd-seq-device]
radeon                103400   1 
usb-midi               17180   0  (unused)
audio                  41400   0  (unused)
hid                    15108   1 
sbp2                   17984   0  (unused)
raw1394                 8028   0  (unused)
ohci1394               18196   0  (unused)
ieee1394               35280   0  [sbp2 raw1394 ohci1394]
Wizard root # 

Wizard root # cat /proc/interrupts 
           CPU0       
  0:     115711    IO-APIC-edge  timer
  1:       1673    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:      20211    IO-APIC-edge  PS/2 Mouse
 14:       6667    IO-APIC-edge  ide0
 15:          5    IO-APIC-edge  ide1
 16:      40297   IO-APIC-level  ohci1394, radeon@PCI:1:0:0
 17:          0   IO-APIC-level  hdsp
 18:         68   IO-APIC-level  eth0
 21:       1673   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
NMI:          0 
LOC:     115660 
ERR:          0
MIS:          0
Wizard root # 

At this point the card has an interrupt, the drivers are loaded, and
everything works.

My modules.conf file is attached. 

   Thanks in advance for any ideas.

Cheers,
Mark







--=-o3bF1imp+mwJkwd7dG/Z
Content-Disposition: attachment; filename=modules.conf
Content-Type: text/plain; name=modules.conf; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

### This file is automatically generated by modules-update
#
# Please do not edit this file directly. If you want to change or add
# anything please take a look at the files in /etc/modules.d and read
# the manpage for modules-update.
#
### modules-update: start processing /etc/modules.d/aliases
# Aliases to tell insmod/modprobe which modules to use 

# Uncomment the network protocols you don't want loaded:
# alias net-pf-1 off		# Unix
# alias net-pf-2 off		# IPv4
# alias net-pf-3 off		# Amateur Radio AX.25
# alias net-pf-4 off		# IPX
# alias net-pf-5 off		# DDP / appletalk
# alias net-pf-6 off		# Amateur Radio NET/ROM
# alias net-pf-9 off		# X.25
# alias net-pf-10 off		# IPv6
# alias net-pf-11 off		# ROSE / Amateur Radio X.25 PLP
# alias net-pf-19 off		# Acorn Econet

alias char-major-10-175	agpgart
alias char-major-10-200	tun
alias char-major-81	bttv
alias char-major-108	ppp_generic
alias /dev/ppp		ppp_generic
alias tty-ldisc-3	ppp_async
alias tty-ldisc-14	ppp_synctty
alias ppp-compress-21	bsd_comp
alias ppp-compress-24	ppp_deflate
alias ppp-compress-26	ppp_deflate

# Crypto modules (see http://www.kerneli.org/)
alias loop-xfer-gen-0	loop_gen
alias loop-xfer-3	loop_fish2
alias loop-xfer-gen-10	loop_gen
alias cipher-2		des
alias cipher-3		fish2
alias cipher-4		blowfish
alias cipher-6		idea
alias cipher-7		serp6f
alias cipher-8		mars6
alias cipher-11		rc62
alias cipher-15		dfc2
alias cipher-16		rijndael
alias cipher-17		rc5

# Support for i2c and lm_sensors
alias char-major-89    i2c-dev

# Old nvidia support ...
alias char-major-195 NVdriver 
alias /dev/nvidiactl char-major-195 

### modules-update: end processing /etc/modules.d/aliases

### modules-update: start processing /etc/modules.d/alsa
# Alsa 0.9.X kernel modules' configuration file.
# $Header: /home/cvsroot/gentoo-x86/media-sound/alsa-utils/files/alsa-modules.conf-rc,v 1.1 2003/08/05 21:07:55 johnm Exp $

# ALSA portion
alias char-major-116 snd
# OSS/Free portion
alias char-major-14 soundcore

##
## IMPORTANT:
## You need to customise this section for your specific sound card(s)
## and then run `update-modules' command.
## Read alsa-driver's INSTALL file in /usr/share/doc for more info.
##

##  ALSA portion
alias snd-card-0 snd-hdsp
alias snd-card-1 snd-usb-audio


##  OSS/Free portion
alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
##

# OSS/Free portion - card #1 (HDSP9652)
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

# OSS/Free portion - card #2 (MidiSport 2x2)
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss


alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss

# Set this to the correct number of cards.
options snd cards_limit=2
add options -k snd-card-0
add options -k snd-card-1

### modules-update: end processing /etc/modules.d/alsa

### modules-update: start processing /etc/modules.d/i386
alias parport_lowlevel parport_pc
alias char-major-10-144 nvram
alias binfmt-0064 binfmt_aout
alias char-major-10-135 rtc

### modules-update: end processing /etc/modules.d/i386

### modules-update: start processing /etc/modules.d/svgalib
probeall  /dev/svga  svgalib_helper

### modules-update: end processing /etc/modules.d/svgalib


--=-o3bF1imp+mwJkwd7dG/Z--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
