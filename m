From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001023]: ens1371 pcm not work in
	2.6.11 kernel
Date: Sun, 25 Jun 2006 02:04:01 +0200
Message-ID: <13b07e7a722cd664bc4b23e437400f68@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E13B1A7
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Jun 2006 02:04:02 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1023> 
======================================================================
Reported By:                yafrank
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1023
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.8_FC3
======================================================================
Date Submitted:             03-30-2005 14:25 CEST
Last Modified:              06-25-2006 02:04 CEST
======================================================================
Summary:                    ens1371 pcm not work in 2.6.11 kernel
Description: 
I'm using FC3 and my Creative SB AudioPCI 64V sound card works fine in 
2.6.10-1.770_FC3 kernel. After I replaced the kernel to 2.6.11 from
kernel.org or 2.6.11-1.8_FC3 from redhat, there is no sound anymore. I
noticed that the 2.6.11 kernel uses alsa 1.0.8 driver, yet userspace
alsa-lib and utility in fc3 are 1.0.6. So I upgrade them to 1.0.8 too.
Still, there is no sound and alsamixer doesn't show any pcm option.
Fortunately, the 1.0.8 lib and utility backward compatible with 1.0.6
driver in 2.6.10 kernel, so they were kept. The sound card uses ens1371
kernel module. And my /etc/modprobe.conf is this:

alias snd-card-0 snd-ens1371
alias sound-slot-0 snd-ens1371
install snd-ens1371 /sbin/modprobe --ignore-install snd-ens1371 &&
/usr/sbin/alsactlrestore >/dev/null 2>&1 || :
remove snd-ens1371 { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-ens1371
alias usb-controller uhci-hcd
alias net-pf-10 off
alias ipv6 off
alias eth0 8139too


======================================================================

----------------------------------------------------------------------
 bobcat98 - 06-24-06 21:51 
----------------------------------------------------------------------
Still broken in FC5.

scsound.log:



------- System Config Soundcard --------
Sat Jun 24 14:11:33 CDT 2006

------- lspci --------
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South]
(rev 23)
00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 11)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev
30)
00:0e.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
08)
00:0f.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 74)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev
82)

------- lsmod --------
Module                  Size  Used by
mga                    62145  1
drm                    63701  2 mga
autofs4                19013  1
hidp                   15937  2
rfcomm                 34517  0
l2cap                  23617  10 hidp,rfcomm
bluetooth              44069  5 hidp,rfcomm,l2cap
sunrpc                136573  1
ip_conntrack_netbios_ns     3009  0
ipt_REJECT              5441  1
xt_state                2241  2
ip_conntrack           49261  2 ip_conntrack_netbios_ns,xt_state
nfnetlink               6489  1 ip_conntrack
xt_tcpudp               3265  4
iptable_filter          3137  1
ip_tables              11657  1 iptable_filter
x_tables               12613  4 ipt_REJECT,xt_state,xt_tcpudp,ip_tables
acpi_cpufreq            6729  0
vfat                   11969  2
fat                    47709  1 vfat
dm_mirror              19985  0
dm_multipath           18121  0
dm_mod                 50905  2 dm_mirror,dm_multipath
video                  14917  0
button                  6609  0
battery                 9285  0
ac                      4933  0
ipv6                  225697  14
lp                     12297  0
parport_pc             25445  1
parport                34313  2 lp,parport_pc
floppy                 57733  0
usblp                  13377  0
nvram                   8393  0
uhci_hcd               28881  0
matrox_w1               4033  0
wire                   24289  1 matrox_w1
matroxfb_base          29469  1
matroxfb_DAC1064       10561  1 matroxfb_base
matroxfb_accel          4417  1 matroxfb_base
matroxfb_Ti3026         5953  1 matroxfb_base
matroxfb_g450           7233  1 matroxfb_base
g450_pll                5953  2 matroxfb_DAC1064,matroxfb_g450
matroxfb_misc           8513  5
matroxfb_base,matroxfb_DAC1064,matroxfb_Ti3026,matroxfb_g450,g450_pll
snd_ens1371            24801  2
gameport               15177  1 snd_ens1371
snd_rawmidi            24001  1 snd_ens1371
snd_ac97_codec         83937  1 snd_ens1371
snd_ac97_bus            2497  1 snd_ac97_codec
snd_seq_dummy           3781  0
snd_seq_oss            28993  0
snd_seq_midi_event      7105  1 snd_seq_oss
snd_seq                47153  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          8909  4
snd_rawmidi,snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            45009  0
snd_mixer_oss          16449  1 snd_pcm_oss
snd_pcm                76869  4 snd_ens1371,snd_ac97_codec,snd_pcm_oss
3c59x                  41577  0
mii                     5313  1 3c59x
snd_timer              22597  2 snd_seq,snd_pcm
snd                    50501  13
snd_ens1371,snd_rawmidi,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
i2c_viapro              8277  0
soundcore               9377  1 snd
i2c_core               20673  1 i2c_viapro
snd_page_alloc         10441  1 snd_pcm
ext3                  116169  3
jbd                    52693  1 ext3

------- /etc/modprobe.conf --------
alias eth0 3c59x
alias snd-card-0 snd-ens1371
options snd-card-0 index=0
options snd-ens1371 index=0
remove snd-ens1371 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-ens1371

------- /etc/asound.conf --------
#Generated by system-config-soundcard, do not edit by hand
#SWCONF
#DEV 0
defaults.pcm.card 0
defaults.pcm.device 0
defaults.ctl.card 0

------- aplay -l --------
**** List of PLAYBACK Hardware Devices ****
card 0: AudioPCI [Ensoniq AudioPCI], device 0: ES1371/1 [ES1371 DAC2/ADC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: AudioPCI [Ensoniq AudioPCI], device 1: ES1371/2 [ES1371 DAC1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

------- amixer --------
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 18 [58%] [on]
  Front Right: Playback 18 [58%] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 18 [58%] [on]
  Front Right: Playback 18 [58%] [on]
Simple mixer control 'PCM Out Path & Mute',0
  Capabilities: enum
  Items: 'pre 3D' 'post 3D'
  Item0: 'post 3D'
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 26 [84%] [on] Capture [off]
  Front Right: Playback 26 [84%] [on] Capture [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 18 [58%] [on] Capture [on]
  Front Right: Playback 18 [58%] [on] Capture [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic Select',0
  Capabilities: enum
  Items: 'Mic1' 'Mic2'
  Item0: 'Mic1'
Simple mixer control 'Video',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 21 [68%] [on] Capture [off]
  Front Right: Playback 21 [68%] [on] Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 29 [94%] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 14 [93%] [on]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 24 [77%] [on] Capture [off]
  Front Right: Playback 24 [77%] [on] Capture [off]
Simple mixer control 'Mono Output Select',0
  Capabilities: enum
  Items: 'Mix' 'Mic'
  Item0: 'Mix'
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Caller ID',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Off-hook',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]

------- /proc/asound/version --------
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).

------- rpm -q alsa-lib --------
alsa-lib-1.0.11-3.rc2.2

------- rpm -q alsa-utils --------
alsa-utils-1.0.11-4.rc2

------- /proc/asound/modules --------
 0 snd_ens1371

------- /proc/asound/pcm --------
00-01: ES1371/2 : ES1371 DAC1 : playback 1
00-00: ES1371/1 : ES1371 DAC2/ADC : playback 1 : capture 1

------- system-config-soundcard --------

/usr/share/system-config-soundcard/soundcard.py:273: DeprecationWarning:
use gtk.ComboBox
  self.primarySubDeviceOptionMenu = gtk.OptionMenu()
/usr/share/system-config-soundcard/soundcard.py:308:
GtkDeprecationWarning: gtk.timeout_add is deprecated, use
gobject.timeout_add instead
  self.timer = gtk.timeout_add (100, self.checkStatus, self)
/usr/share/system-config-soundcard/soundcard.py:548:
GtkDeprecationWarning: gtk.TRUE is deprecated, use True instead
  gtk.main()
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' :
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' :
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' :
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' :
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' :
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Read config:
card 0
device 0
HW 0
----------- Kudzu -------------
Desc:           Ensoniq ES1371 [AudioPCI-97]
Driver:         snd-ens1371
Device:         None

----------- **** -------------



Per tiwai's suggestion, VU meter does work ...


bob]# aplay -vv /usr/share/system-config-soundcard/sound-sample.wav
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' :
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 15052
  period_size  : 940
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 940
  xfer_align   : 940
  start_threshold  : 15040
  stop_threshold   : 15052
  silence_threshold: 0
  silence_size : 0
  boundary     : 986447872
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (1572864000/32768)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tick_time    : 4000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 1
  stop_threshold   : 1073741824
  silence_threshold: 0
  silence_size : 1073741824
  boundary     : 1073741824
# +                                               | 05%

----------------------------------------------------------------------
 Raymond - 06-25-06 02:04 
----------------------------------------------------------------------
bobcat98,

please post output of

cat /proc/asound/cards

cat /proc/asound/card0/codec97#0/ac97#0-0+regs

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-05 14:25 yafrank        New Issue                                    
03-30-05 14:25 yafrank        Distribution              => Fedora Core 3   
03-30-05 14:25 yafrank        Kernel Version            => 2.6.11-1.8_FC3  
03-30-05 18:08 tiwai          Note Added: 0004266                          
03-31-05 10:49 yafrank        Note Added: 0004277                          
03-31-05 13:14 yafrank        Note Added: 0004279                          
03-31-05 13:23 perex          Note Added: 0004280                          
03-31-05 17:08 yafrank        Note Added: 0004282                          
04-06-05 18:41 mmadore        Note Added: 0004350                          
04-07-05 16:04 tiwai          Note Added: 0004357                          
04-07-05 18:32 mmadore        Note Added: 0004362                          
04-07-05 18:33 mmadore        File Added: asound.state                     
04-07-05 18:37 mmadore        File Added: ac97#0-0                         
04-07-05 18:38 mmadore        File Added: ac97#0-0+regs                    
04-12-05 05:47 yafrank        Issue Monitored: yafrank                     
04-12-05 06:02 yafrank        Note Added: 0004445                          
04-12-05 16:29 tiwai          Note Added: 0004447                          
04-12-05 19:46 yafrank        Note Added: 0004459                          
04-12-05 20:00 yafrank        Note Added: 0004460                          
04-12-05 21:11 mmadore        Note Added: 0004463                          
04-12-05 21:12 mmadore        File Added: asound.state.new                    
04-24-05 00:15 mycroft        Issue Monitored: mycroft                     
06-17-05 09:55 yafrank        Note Added: 0005065                          
06-17-05 11:45 yafrank        Note Added: 0005067                          
06-17-05 14:44 tiwai          Note Added: 0005073                          
06-18-05 04:26 yafrank        Note Added: 0005082                          
06-18-05 04:52 yafrank        File Added: alsa-ac97-test                    
06-18-05 05:19 yafrank        Note Added: 0005083                          
06-20-05 10:59 perex          File Added: ens1371-reset.patch                   

06-20-05 10:59 perex          Category                 CORE - pcm => PCI -
ens1371
06-20-05 11:00 perex          Note Added: 0005095                          
06-20-05 11:01 perex          Status                   new => assigned     
06-20-05 11:01 perex          Assigned To               => perex           
06-23-05 16:48 yafrank        Note Added: 0005191                          
07-08-05 10:24 perex          Note Added: 0005405                          
07-08-05 10:25 perex          Note Edited: 0005405                         
07-11-05 13:45 yafrank        Note Added: 0005444                          
07-11-05 16:47 yafrank        Note Added: 0005449                          
07-11-05 22:52 gwennou        Note Added: 0005451                          
09-01-05 10:25 yafrank        File Added: config-2.6.13-snd                    
09-01-05 10:51 yafrank        Note Added: 0005995                          
09-01-05 18:15 tiwai          Note Added: 0005997                          
09-04-05 02:09 bobcat98       Note Added: 0006034                          
09-04-05 02:12 bobcat98       Issue Monitored: bobcat98                    
10-25-05 13:55 rufusplant     Note Added: 0006539                          
10-25-05 15:12 tiwai          Note Added: 0006542                          
11-14-05 10:01 perex          Status                   assigned => feedback
11-15-05 16:21 yafrank        Note Added: 0006730                          
11-28-05 05:18 rufusplant     Note Added: 0006853                          
12-11-05 06:43 yafrank        Note Added: 0006975                          
02-02-06 12:58 pearma         Note Added: 0007876                          
02-02-06 17:38 yafrank        Note Deleted: 0006975                        
02-04-06 10:43 pearma         Note Added: 0007915                          
02-04-06 19:18 rlrevell       Status                   feedback => resolved
02-04-06 19:18 rlrevell       Resolution               open => fixed       
02-04-06 20:57 yafrank        Status                   resolved => feedback
02-04-06 20:57 yafrank        Resolution               fixed => reopened   
02-04-06 20:57 yafrank        Note Added: 0007925                          
02-13-06 00:16 ZEROplus       Issue Monitored: ZEROplus                    
06-06-06 09:07 Raymond        Note Added: 0010072                          
06-09-06 06:51 Raymond        Note Added: 0010132                          
06-14-06 15:01 Raymond        Note Deleted: 0010132                        
06-14-06 15:13 Raymond        Note Deleted: 0010072                        
06-24-06 04:14 Raymond        Note Added: 0010465                          
06-24-06 21:51 bobcat98       Note Added: 0010489                          
06-25-06 02:04 Raymond        Note Added: 0010497                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
