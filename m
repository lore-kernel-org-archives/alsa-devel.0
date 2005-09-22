From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000477]: Problem with esound-alsa
Date: Thu, 22 Sep 2005 15:18:58 +0200
Message-ID: <af821fa60e0438b3ca14504d45a5ca2e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1DF1112E
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 15:18:59 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=477> 
======================================================================
Reported By:                zawadaa
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   477
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               PLD LINUX DISTRIBUTION
Kernel Version:             <=2.6.9-rc1
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-02-2004 17:32 CEST
Last Modified:              09-22-2005 15:18 CEST
======================================================================
Summary:                    Problem with esound-alsa
Description: 
On kernel-2.4 was no problem. After I upgraded to kernel-2.6 (even newest
one) my sound record system does not work :-(
IMPORTANT: may be that's not ALSA problem just esound but...

I have 7 sound card (1 snd_via82xx and 6 snd_ens1371):
On boot I set up all cards by alsactl -f $i restore $j (i=conf,
j=cardid).
After that I run 7 times on diffrent ports:
esd -tcp -public -promiscuous -d hw:0 -port 16001 &
that's all.
On second computer, when I wont record some sound:

/usr/bin/esdrec -s 192.168.2.206:16001|/usr/bin/lame -x -b 64 --lowpass 8
- 1.mp3

And it works bur only with first card (snd_via82xx)
on snd_ens1371 I have nothing and on the sound server is just:
------------------------------------------------
[root@magazyn root]# esd -tcp -public -promiscuous -d hw:6 -port 16007
- using device hw:6
- accepting connections on port 16007
ALSA lib pcm_hw.c:846:(snd_pcm_hw_close) close failed
: Bad file descriptor
ALSA lib pcm_hw.c:846:(snd_pcm_hw_close) close failed
: Bad file descriptor
ALSA lib pcm_hw.c:846:(snd_pcm_hw_close) close failed
: Bad file descriptor
ALSA lib pcm_hw.c:804:(snd_pcm_hw_munmap_status) status munmap failed:
Invalid argument
ALSA lib pcm_hw.c:823:(snd_pcm_hw_munmap_control) control munmap failed:
Invalid argument
free(): invalid pointer 0x8060220!
Segmentation fault
--------------------------------------------------
after 4th connection.

I attached strace of that.

When I switch from esound-alsa to esound-oss - 
esd -tcp -public -promiscuous -d /dev/dsp6 -port 16007
everything is OK (on 2.6 of course)
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 10:10 
----------------------------------------------------------------------
Submitter: Did you submit a bug report to the EsoundD developers too?
Do you have reason to think that this is an ALSA bug?  If not then I
think that this report should be closed.  If so then I guess this
report should be reassigned to alsa-lib.

----------------------------------------------------------------------
 jdthood - 09-22-05 15:18 
----------------------------------------------------------------------
Presumably an eSound bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-02-04 17:32 zawadaa        New Issue                                    
09-02-04 17:32 zawadaa        File Added: esd_strace.gz                    
09-02-04 17:32 zawadaa        Distribution              => PLD LINUX
DISTRIBUTION
09-02-04 17:32 zawadaa        Kernel Version            => <=2.6.9-rc1     
09-02-04 17:35 zawadaa        Issue Monitored: zawadaa                     
03-19-05 10:10 jdthood        Note Added: 0004031                          
09-22-05 15:18 jdthood        Status                   new => closed       
09-22-05 15:18 jdthood        Note Added: 0006347                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
