From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001023]: ens1371 pcm not work in 2.6.11 kernel
Date: Tue, 12 Apr 2005 20:00:48 +0200
Message-ID: <c12d5332121698ea08e11a75bbb48329@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7F384225
	for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2005 20:00:48 +0200 (MEST)
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
Last Modified:              04-12-2005 20:00 CEST
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
 yafrank - 04-12-05 19:46 
----------------------------------------------------------------------
The /etc/asound.state I pasted is the one I'm currently using in
2.6.10-1.770_FC3 kernel and it works fine with it. I'll get the
correspondent in 2.6.11-1.14_FC3 after rebooting and running "alsactl
store" right away.

----------------------------------------------------------------------
 yafrank - 04-12-05 20:00 
----------------------------------------------------------------------
The former pasted /etc/asound.state and /proc/asound/card0/codec97#0/* are
actually both from 2.6.11-1.14_FC3 kernel. I only forgot to run a "alsactl
store" then. The latest /etc/asound.state should be as following:
 
[root@twinhead ~]# uname -r
2.6.11-1.14_FC3
[root@twinhead ~]# cp /etc/asound.state /tmp
[root@twinhead ~]# alsactl store
[root@twinhead ~]# cat /etc/asound.state
state.AudioPCI {
        control.1 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Master Playback Volume'
                value.0 0
                value.1 0
        }
        control.2 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Center Playback Switch'
                value false
        }
        control.3 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Center Playback Volume'
                value 31
        }
        control.4 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'LFE Playback Switch'
                value false
        }
        control.5 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'LFE Playback Volume'
                value 0
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Master Mono Playback Volume'
                value 0
        }
        control.7 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Tone Control - Bass'
                value 0
        }
        control.8 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Tone Control - Treble'
                value 0
        }
        control.9 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PC Speaker Playback Switch'
                value false
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'PC Speaker Playback Volume'
                value 0
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Boost (+20dB)'
                value false
        }
        control.12 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 0
                value.1 0
        }
        control.13 {
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
                value.0 Mic
                value.1 Mic
        }
        control.14 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 0
                value.1 0
        }
        control.15 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Capture Switch'
                value true
        }
        control.16 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'Mic Capture Volume'
                value 0
        }
        control.17 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic1
                comment.item.1 Mic2
                iface MIXER
                name 'Mic Select'
                value Mic1
        }
        control.18 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name '3D Control - Center'
                value 0
        }
        control.19 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name '3D Control - Depth'
                value 0
        }
}

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
