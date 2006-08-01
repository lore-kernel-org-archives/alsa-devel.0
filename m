From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001869]: Playing surround sound
	produces 100% CPU load
Date: Tue, 1 Aug 2006 10:46:34 +0200
Message-ID: <420c0e1861c1cc7b53187d4be80dc805@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7046B185
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 10:46:35 +0200 (MEST)
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
Last Modified:              08-01-2006 10:46 CEST
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
 Raymond - 08-01-06 09:36 
----------------------------------------------------------------------
>>BTW: I found one (probably unrelated) information about the rear channel
(on >>Hercules Game Theter XP7.1): The rear channels volume is regulated
by controls >>Surround.0 and PCM.1 - this is very strange, as PCM.1 is the
ONLY "index >>1"-device I found that is doing something useful.

The jacks at the back support 5.1 plus the phone jack at the front to have
8 speakers. 

Not sure it is 8 channels unless cs4624 support 8 channels.

----------------------------------------------------------------------
 Raymond - 08-01-06 10:46 
----------------------------------------------------------------------
For the bug reported in alsa-user mailing list,  

pcm.stereo41 {
       type route
       slave.pcm surround41
       slave.channels 5
       ttable.0.0 1 # 0 + 2 left channel
       ttable.0.2 1
       ttable.1.1 1 # 1 + 3 right channel
       ttable.1.3 1
       ttable.0.4 1 # 4 - subwoofer
}

AFAIK,  5 channels (surround41) is most likely not supported for most ALSA
drivers. If surround41 and surround50 is not defined in CS46xx.conf, it
usually mean unsupported(or not yet supported). Please correct me if I am
wrong 

http://hg-mirror.alsa-project.org/alsa-lib?f=8b52e1eece1b;file=src/conf/cards/CS46xx.conf;style=gitweb

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
07-25-06 03:03 Raymond        Note Edited: 0011223                         
07-25-06 03:05 Raymond        Note Edited: 0011223                         
07-25-06 10:05 Raymond        Note Edited: 0011223                         
07-25-06 10:13 Raymond        Note Edited: 0011223                         
07-25-06 21:53 bitmage2       Note Added: 0011232                          
07-26-06 02:03 Raymond        Note Added: 0011235                          
07-26-06 02:09 Raymond        Note Edited: 0011235                         
07-26-06 08:41 bitmage2       Note Added: 0011245                          
07-26-06 10:27 Raymond        Note Added: 0011247                          
07-29-06 03:01 Raymond        Note Added: 0011295                          
07-30-06 03:06 Raymond        Note Added: 0011312                          
07-31-06 23:16 bitmage2       Note Added: 0011353                          
08-01-06 02:40 Raymond        Note Added: 0011362                          
08-01-06 04:15 Raymond        Note Added: 0011368                          
08-01-06 08:15 Raymond        Note Added: 0011371                          
08-01-06 09:36 Raymond        Note Added: 0011372                          
08-01-06 10:46 Raymond        Note Added: 0011373                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
