From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001023]: ens1371 pcm not work in 2.6.11 kernel
Date: Tue, 12 Apr 2005 16:29:04 +0200
Message-ID: <53b98f3f96ac3f17fd5381532dd712a7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0D3CF1CA
	for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2005 16:29:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1023> 
======================================================================
Reported By:                yafrank
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1023
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.8_FC3
======================================================================
Date Submitted:             03-30-2005 14:25 CEST
Last Modified:              04-12-2005 16:29 CEST
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
 yafrank - 04-12-05 06:02 
----------------------------------------------------------------------
Just came back from vacation. I've read tiwai's request of
/etc/asound.state and /proc/asound/card0/codec97#0/* files. Since someone
else had attached them already, I'll paste mine here avoiding overwritten.
The former customized 2.6.11-1.8_FC3 kernel had been removed and this time
I'm using 2.6.11-1.14_FC3 with similar behavior. 

[frank@twinhead ~]$ cd /proc/asound/card0/codec97#0/
[frank@twinhead codec97#0]$ ls
ac97#0-0  ac97#0-0+regs
[frank@twinhead codec97#0]$ cat ac97#0-0
0-0/0: 0x8a058384
?&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=65533;

Capabilities     : -dedicated MIC PCM IN channel- -bass & treble-
DAC resolution   : 16-bit
ADC resolution   : 20-bit
3D enhancement   : Reserved 29

Current setup
Mic gain         : +20dB [+0dB]
POP path         : post 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : on
Mono output      : Mic
Mic select       : Mic2
ADC/DAC loopback : off
Extended modem ID: codec=3 CID2 CID1 HSET LIN2 LIN1
Modem status     : GPIO MREF ADC1 DAC1 ADC2 DAC2 HADC HDAC PRA(GPIO)
PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2) PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 65535Hz
Line2 rate       : 65535Hz
Headset rate     : 65535Hz
[frank@twinhead codec97#0]$ cat ac97#0-0+regs
0:00 = ffff
0:02 = 0140
0:04 = 9f1f
0:06 = 8000
0:08 = ffff
0:0a = ffff
0:0c = 811f
0:0e = 8001
0:10 = 8001
0:12 = 8101
0:14 = 9f1f
0:16 = 9f1f
0:18 = 9f1f
0:1a = 8101
0:1c = 9818
0:1e = 0000
0:20 = ffff
0:22 = 0000
0:24 = 0000
0:26 = ffff
0:28 = 000f
0:2a = ffff
0:2c = ffff
0:2e = ffff
0:30 = ffff
0:32 = ffff
0:34 = ffff
0:36 = ffff
0:38 = ffff
0:3a = ffff
0:3c = ffff
0:3e = ffff
0:40 = ffff
0:42 = ffff
0:44 = ffff
0:46 = ffff
0:48 = ffff
0:4a = ffff
0:4c = ffff
0:4e = ffff
0:50 = ffff
0:52 = ffff
0:54 = ffff
0:56 = ffff
0:58 = ffff
0:5a = ffff
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = ffff
0:64 = ffff
0:66 = ffff
0:68 = ffff
0:6a = ffff
0:6c = ffff
0:6e = ffff
0:70 = ffff
0:72 = ffff
0:74 = ffff
0:76 = ffff
0:78 = ffff
0:7a = ffff
0:7c = ffff
0:7e = 8384

[frank@twinhead codec97#0]$ cat /etc/asound.state
state.AudioPCI {
        control.1 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Master Playback Switch'
                value true
        }
        control.2 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Master Playback Volume'
                value.0 29
                value.1 29
        }
        control.3 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Center Playback Switch'
                value false
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Center Playback Volume'
                value 0
        }
        control.5 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'LFE Playback Switch'
                value true
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'LFE Playback Volume'
                value 0
        }
        control.7 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Master Mono Playback Switch'
                value false
        }
        control.8 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Master Mono Playback Volume'
                value 0
        }
        control.9 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Tone Control - Bass'
                value 2
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Tone Control - Treble'
                value 0
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PC Speaker Playback Switch'
                value true
        }
        control.12 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'PC Speaker Playback Volume'
                value 0
        }
        control.13 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Phone Playback Switch'
                value false
        }
        control.14 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Phone Playback Volume'
                value 0
        }
        control.15 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Playback Switch'
                value false
        }
        control.16 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Mic Playback Volume'
                value 0
        }
        control.17 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Boost (+20dB)'
                value false
        }
        control.18 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Line Playback Switch'
                value false
        }
        control.19 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Line Playback Volume'
                value.0 0
                value.1 0
        }
        control.20 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'CD Playback Switch'
                value false
        }
        control.21 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'CD Playback Volume'
                value.0 0
                value.1 0
        }
        control.22 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Video Playback Switch'
                value false
        }
        control.23 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Video Playback Volume'
                value.0 0
                value.1 0
        }
        control.24 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Aux Playback Switch'
                value false
        }
        control.25 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 0
                value.1 0
        }
        control.26 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PCM Playback Switch'
                value true
        }
        control.27 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 10
                value.1 10
        }
        control.28 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 2
                comment.item.0 Mic
                comment.item.1 CD
                comment.item.2 Video
                comment.item.3 Aux
                comment.item.4 Line
                comment.item.5 Mix
                comment.item.6 'Mix Mono'
                comment.item.7 Phone
                iface MIXER
                name 'Capture Source'
                value.0 'Mix Mono'
                value.1 'Mix Mono'
        }
        control.29 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 0
                value.1 0
        }
        control.30 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Capture Switch'
                value false
        }
        control.31 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Mic Capture Volume'
                value 0
        }
}

----------------------------------------------------------------------
 tiwai - 04-12-05 16:29 
----------------------------------------------------------------------
I see "PCM" control in both /etc/asound.state files.
So I don't understand why PCM disappears on your mixer app.
Are you sure that /etc/asound.state you attached is the newest output from
alsactl?  Run "alsactl store" as root, and check whether "PCM Playback
Volume" and "PCM Playback Switch" exist on /etc/asound.state.

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
