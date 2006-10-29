From: Bill McKie <mckie@sky.arc.nasa.gov>
Subject: No sound on Gateway MP6954 laptop under FC6
Date: Sat, 28 Oct 2006 20:21:29 -0700
Message-ID: <200610290321.k9T3LT1D026735@sky.arc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I've recently installed FC6 Linux on my Gateway MP6954
laptop.  The sound hardware on this machine is an 82801G
(ICH7), and although the sound hardware is detected at
system install time, there is no sound output (e.g. from
the installer's sound test gui).  [Sound functions ok
on this laptop when it runs Win-XP.]

Discussions with sound experts on www.linuxquestions.org
(laptops forum) indicated that there is currently no
support in the alsa driver bundled with FC6 for the sound
hardware as configured in the above laptop, and that this
list would be the place to request support.

Following is hopefully helpful system and sound related
info from the FC6 system running on the MP6954.

Thanks,
Bill McKie

-----

cat /etc/fedora-release

Fedora Core release 6 (Zod)

-----

uname -a

Linux localhost.localdomain 2.6.18-1.2798.fc6 #1 SMP Mon Oct 16 14:54:20 EDT 2006 i686 i686 i386 GNU/Linux

-----

cat /etc/modprobe.conf

alias eth0 sky2
alias scsi_hostadapter ahci
alias snd-card-0 snd-hda-intel
options snd-card-0 index=0
options snd-hda-intel index=0
remove snd-hda-intel { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; }; /sbin/modprobe -r --ignore-remove snd-hda-intel

-----

rpm -q -a | grep alsa

alsa-lib-1.0.12-2.fc6
alsa-utils-1.0.12-3.fc6
alsa-lib-devel-1.0.12-2.fc6

-----

lspci -s 0:1b -vn

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 107b:0366
	Flags: bus master, fast devsel, latency 0, IRQ 58
	Memory at d8240000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

-----

lsmod

Module                  Size  Used by
i915                   23360  2 
drm                    72789  3 i915
cisco_ipsec           561436  0 
autofs4                25413  2 
hidp                   24129  2 
rfcomm                 45912  0 
l2cap                  31681  10 hidp,rfcomm
bluetooth              58917  5 hidp,rfcomm,l2cap
ipv6                  267745  14 
ip_conntrack_netbios_ns     7105  0 
ipt_REJECT              9665  1 
xt_state                6337  1 
ip_conntrack           56993  2 ip_conntrack_netbios_ns,xt_state
nfnetlink              11353  1 ip_conntrack
iptable_filter          7233  1 
ip_tables              17669  1 iptable_filter
x_tables               18501  3 ipt_REJECT,xt_state,ip_tables
dm_mirror              32913  0 
dm_multipath           22601  0 
dm_mod                 61529  2 dm_mirror,dm_multipath
video                  21061  0 
sbs                    20225  0 
i2c_ec                  9281  1 sbs
button                 10961  0 
battery                14405  0 
ac                      9541  0 
parport_pc             31205  0 
lp                     17033  0 
parport                40841  2 parport_pc,lp
snd_hda_intel          22613  1 
snd_hda_codec         154049  1 snd_hda_intel
snd_seq_dummy           8133  0 
snd_seq_oss            37057  0 
snd_seq_midi_event     11841  1 snd_seq_oss
snd_seq                57137  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device         12621  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            46561  0 
joydev                 13697  0 
snd_mixer_oss          20673  1 snd_pcm_oss
snd_pcm                80453  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              27077  2 snd_seq,snd_pcm
sg                     38493  0 
snd                    57029  11 snd_hda_intel,snd_hda_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
ohci1394               38661  0 
soundcore              14113  1 snd
ieee1394              301081  1 ohci1394
pcspkr                  7361  0 
snd_page_alloc         14281  2 snd_hda_intel,snd_pcm
sky2                   44357  0 
serio_raw              11205  0 
i2c_i801               11853  0 
ide_cd                 42337  2 
i2c_core               25537  2 i2c_ec,i2c_i801
cdrom                  38625  1 ide_cd
ahci                   23365  3 
libata                102745  1 ahci
sd_mod                 24897  22 
scsi_mod              138601  4 sg,ahci,libata,sd_mod
ext3                  135369  2 
jbd                    63081  1 ext3
ehci_hcd               35533  0 
ohci_hcd               25181  0 
uhci_hcd               27725  0 

-----

cat /proc/asound/card0/codec*

Codec: SigmaTel ID 7634
Address: 0
Vendor Id: 0x83847634
Subsystem Id: 0x107b0461
Revision Id: 0x100101
Default PCM: rates 0x7e0, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
Node 0x02 [Audio Output] wcaps 0xd0401: Stereo
  Power: 0x0
Node 0x03 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x14
Node 0x04 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM: rates 0x160, bits 0x0e, types 0x5
  Connection: 1
     0x07
Node 0x05 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM: rates 0x1e0, bits 0x0e, types 0x5
Node 0x06 [Audio Selector] wcaps 0x300901: Stereo
  Connection: 3
     0x02* 0x07 0x14
Node 0x07 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  Pin Default 0x40c003f0: [N/A] SPDIF In at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x08 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x424503f2: [N/A] SPDIF Out at Ext Front
    Conn = Optical, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 2
     0x05* 0x14
Node 0x09 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x0f 0x0f]
  Connection: 1
     0x0f
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x01813022: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x00:
  Connection: 1
     0x0e
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x02a19021: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0e
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x90a70320: [Fixed] Mic at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0e
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x02214210: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x0e
Node 0x0e [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x17 0x17]
  Connection: 1
     0x06
Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 5
     0x0b* 0x0c 0x0d 0x0a 0x11
Node 0x10 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x400003f1: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x12
Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x9033032e: [Fixed] CD at Int N/A
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x12 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x06
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
Node 0x14 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x09
Codec: Generic 1057 ID 3057
Address: 1
Vendor Id: 0x10573057
Subsystem Id: 0x10001
Revision Id: 0x100100

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
