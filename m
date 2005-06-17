From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001023]: ens1371 pcm not work in 2.6.11 kernel
Date: Fri, 17 Jun 2005 14:44:44 +0200
Message-ID: <7f8456e012d4a1a5e677828a0604b62e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0916A13F
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2005 14:44:45 +0200 (MEST)
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
Last Modified:              06-17-2005 14:44 CEST
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
 yafrank - 06-17-05 11:45 
----------------------------------------------------------------------
Tired of waiting, I've tested downgrading alsa to 1.0.7 in kernel
2.6.12-rc6-git8 with success in my fc3. First build a customized kernel
without any alsa or oss option enabled in config, but only enable sound
support. Then goto extracted alsa-1.0.7 source directory, execute
following:
./configure --with-kernel=</path/to/kernel/source>
--with-build=</path/to/kernel/source> --with-cards=ens1371
--with-sequencer=yes; make; make install-modules

----------------------------------------------------------------------
 tiwai - 06-17-05 14:44 
----------------------------------------------------------------------
OK, then the problem is that the ac97 chip on your board cheats the
ac97_codec.c code as if there is no PCM control.
Please try the following with the latest ALSA code:
- compile with debug option
- as root
    # echo 18 8000 > /proc/asound/card0/codec97#0/ac97#0-0+regs
  and
    # cat /proc/asound/card0/codec97#0/ac97#0-0+regs
  and check the output of the register 0x18 again whether the value
  0x8000 is read.
  Then, try the value 0x000 instead of 0x8000 above, and check again.
- similarly, try values 0x2020, 0x1010 and 0x0101 and read/compare again.

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
