From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000477]: Problem with esound-alsa
Date: Thu,  2 Sep 2004 17:32:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040902153251.BC3DE14028@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 12328192
	for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2004 17:32:52 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id D16C91EB65
	for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2004 17:32:51 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000477
======================================================================
Reported By:                zawadaa
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     477
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               PLD LINUX DISTRIBUTION
Kernel Version:             <=2.6.9-rc1
======================================================================
Date Submitted:             09-02-2004 17:32 CEST
Last Modified:              09-02-2004 17:32 CEST
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-02-04 17:32 zawadaa        New Bug                                      
09-02-04 17:32 zawadaa        File Added: esd_strace.gz                    
09-02-04 17:32 zawadaa        Distribution              => PLD LINUX DISTRIBUTION
09-02-04 17:32 zawadaa        Kernel Version            => <=2.6.9-rc1     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
