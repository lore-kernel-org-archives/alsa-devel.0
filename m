From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001869]: Playing surround sound
	produces 100% CPU load
Date: Tue, 25 Jul 2006 03:00:32 +0200
Message-ID: <5329e554bc201a477c7940ef993581ec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 34B8823B
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Jul 2006 03:00:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1869> 
======================================================================
Reported By:                bitmage2
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1869
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux 10.0
Kernel Version:             Linux 2.6.13-15.8-default #1 Tue Feb 7 11:07:24 UTC
2006 i686 athlon i386 GNU/Linux
======================================================================
Date Submitted:             02-23-2006 00:48 CET
Last Modified:              07-25-2006 03:00 CEST
======================================================================
Summary:                    Playing surround sound produces 100% CPU load
Description: 
I am using the CS46xx with a Hercules Gametheater XP 5.1 . It plays back
stereo without problems.
I wanted to use the rest of my 5.1 speaker set, so for a test I ran the
speaker-test program. Running it without parameters or with 2 or 4.0
channels works also fine. So far so good.

But when I run it with 5.0 channels or 5.1 channels the CPU load of
speaker-test goes to 100%. I'll show the output of top along with the
command lines below (for the 2.0 and 5.1 case) in the "Additional
Information" box.



======================================================================

----------------------------------------------------------------------
 bitmage2 - 07-24-06 20:38 
----------------------------------------------------------------------
I just validated, that the problem is still there in 1.0.12rc1 . I did
install that version on a clean linux installation.

I also did a "strace speaker-test ...". While everything works fine, it
looks like this:

...
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) =
1
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) =
1
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) =
1
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) =
1
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
...


When the problem shows up, the strace output is this (not calling poll()
anymore):

ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
ioctl(4, 0x4122, 0xbfeb2ab8)            = 0
...

----------------------------------------------------------------------
 Raymond - 07-25-06 03:00 
----------------------------------------------------------------------
It is possible that you have many sound servers(e.g. esd, arts, ... )
running without notice since cs46xx support hardware mixing ( multiple
subdevices )

00-00: CS46xx : CS46xx : playback 31 : capture 1
00-01: CS46xx - Rear : CS46xx - Rear : playback 31
00-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
00-03: CS46xx - Center LFE : CS46xx - Center LFE : playback 31


The problem will be the lock in rear device if you have any sound
server(OSS emulation) which use more than 2 channels

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-06 00:48 bitmage2       New Issue                                    
02-23-06 00:48 bitmage2       Distribution              => SuSE Linux 10.0 
02-23-06 00:48 bitmage2       Kernel Version            => Linux
2.6.13-15.8-default #1 Tue Feb 7 11:07:24 UTC 2006 i686 athlon i386 GNU/Linux
02-23-06 00:54 bitmage2       Note Added: 0008164                          
02-23-06 00:55 bitmage2       Issue Monitored: bitmage2                    
07-11-06 05:58 Raymond        Note Added: 0010964                          
07-14-06 20:57 bitmage2       Note Added: 0011004                          
07-14-06 20:59 bitmage2       Note Added: 0011005                          
07-14-06 21:25 rlrevell       Note Added: 0011006                          
07-14-06 22:40 bitmage2       Note Added: 0011008                          
07-14-06 22:57 rlrevell       Note Added: 0011009                          
07-15-06 01:28 bitmage2       Note Added: 0011013                          
07-15-06 01:45 rlrevell       Note Added: 0011014                          
07-15-06 05:09 Raymond        Note Added: 0011017                          
07-15-06 07:17 Raymond        Note Edited: 0011017                         
07-23-06 11:34 bitmage2       Note Added: 0011183                          
07-23-06 13:49 Raymond        Note Added: 0011185                          
07-23-06 14:14 Raymond        Note Added: 0011186                          
07-23-06 14:16 Raymond        Note Deleted: 0011186                        
07-23-06 15:04 bitmage2       Note Added: 0011189                          
07-24-06 04:19 Raymond        Note Added: 0011209                          
07-24-06 05:04 Raymond        Note Edited: 0011209                         
07-24-06 20:38 bitmage2       Note Added: 0011214                          
07-25-06 03:00 Raymond        Note Added: 0011223                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
