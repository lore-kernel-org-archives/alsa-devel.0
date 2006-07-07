From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001023]: ens1371 pcm not work in
	2.6.11 kernel
Date: Fri, 7 Jul 2006 10:13:00 +0200
Message-ID: <2948a8cd346b56e4c3cb05141e715285@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E3A6184
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 10:13:01 +0200 (MEST)
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
Last Modified:              07-07-2006 10:12 CEST
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
 Raymond - 07-07-06 09:58 
----------------------------------------------------------------------
May need to add AC97_SCAP_SKIP_MODEM to prevent probing modem registers

	ac97.scaps = AC97_SCAP_AUDIO | AC97_SCAP_SKIP_MODEM;

----------------------------------------------------------------------
 Raymond - 07-07-06 10:12 
----------------------------------------------------------------------
yafrank,

It seem snd_es1371_codec_read() seem always fail on your ens1371 and the
hack will not help.

The only hope is to revert patch to find out the cause, try
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1023#10556


codec read 7c : 807f0000
codec read 7e : 807c8384
codec write 00 = 0000
codec write 3c = 0000
codec read 00 : 807e7605
codec read 7c : 80000140
codec read 7e : 807c8384
codec read 7c : 807e7605
codec read 7e : 807c8384
codec read 00 : 807e7605
codec read 28 : 80000140
codec read 3c : 8028ffff
codec write 26 = 0000
codec write 00 = 0000
codec write 26 = 0000
codec write 20 = 0000
codec read 26 : 803cffff
codec read 2a : 8026000f

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
06-25-06 07:44 bobcat98       Note Added: 0010503                          
06-25-06 08:18 Raymond        Note Added: 0010504                          
06-25-06 18:13 bobcat98       Note Added: 0010517                          
06-26-06 02:10 Raymond        Note Added: 0010521                          
06-26-06 04:10 bobcat98       Note Added: 0010523                          
06-26-06 17:36 Raymond        Note Added: 0010551                          
06-26-06 17:40 rlrevell       Note Added: 0010553                          
06-26-06 17:51 Raymond        Note Edited: 0010551                         
06-26-06 18:01 Raymond        Note Added: 0010555                          
06-26-06 18:09 rlrevell       Note Added: 0010556                          
06-27-06 04:48 Raymond        Note Added: 0010564                          
06-28-06 04:36 Raymond        Note Added: 0010608                          
06-28-06 04:36 Raymond        Note Edited: 0010608                         
06-29-06 11:14 Raymond        Note Edited: 0010608                         
07-01-06 05:26 Raymond        Note Added: 0010758                          
07-07-06 07:59 yafrank        Note Added: 0010896                          
07-07-06 09:13 yafrank        Note Added: 0010898                          
07-07-06 09:15 yafrank        File Added: ens1371-hack-dmesg                    
07-07-06 09:21 Raymond        Note Added: 0010899                          
07-07-06 09:58 Raymond        Note Added: 0010900                          
07-07-06 10:12 Raymond        Note Added: 0010901                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
