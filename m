From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000521]: Jack + Alsa not working in
	full duplex, works with OSS, griffin imic
Date: Tue, 1 Aug 2006 00:30:27 +0200
Message-ID: <53accac6c90a4f250eb506fc795e9b78@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E75A9192
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 00:30:27 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=521> 
======================================================================
Reported By:                LokiDavison
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   521
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Mandrake
Kernel Version:             2.4.22-28mm.2mdk
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-21-2004 21:06 CEST
Last Modified:              08-01-2006 00:30 CEST
======================================================================
Summary:                    Jack + Alsa not working in full duplex, works with
OSS, griffin imic
Description: 
Jack works with the OSS audio driver in full duplex but only works simplex
with alsa driver. The alsa driver works full duplex when used with alsa
apps. 100% reproducable. This is using a griffin imic with the
snd-usb-audio module tested on 2.6 and 2.4 kernels. All jack versions
including 0.99. I'm often on LAD irc if you want more info.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000758 Full duplex is not working in OSS emula...
======================================================================

----------------------------------------------------------------------
 LokiDavison - 11-28-05 11:17 
----------------------------------------------------------------------
I now have a new machine and no longer a laptop so don't use my usb card
any more. I've previously tried many different jack params, including low
buffer size and high number of interrupts per period. If you want more
info i can provide full details on lad irc irc.freenode.org #lad 

Loki

----------------------------------------------------------------------
 LokiDavison - 11-29-05 10:14 
----------------------------------------------------------------------
Just tested on my new machine with jack and my griffin imic, kernel
2.6.12-12.mm.2mdk (mandriva multimedia thing not sure what patches are
included) 
cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.10rc1

running jack with no probs full duplex. Frames/Period 128, periods/buffer
3. Overall latency, 8ms. Haven't tried with lower options. No x runs yet,
but i've only run it for half an hour.

This suggests either something has fixed or it was a problem with some
laptop hardware.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 21:06 LokiDavison    New Issue                                    
09-21-04 21:06 LokiDavison    Distribution              => Mandrake        
09-21-04 21:06 LokiDavison    Kernel Version            => 2.4.22-28mm.2mdk
10-08-04 18:32 ryanpg         Issue Monitored: ryanpg                      
10-08-04 18:40 ryanpg         Note Added: 0002055                          
09-14-05 15:49 jdthood        Note Added: 0006160                          
09-14-05 16:16 jdthood        Relationship added       related to 0000758  
11-28-05 09:54 croiset        Note Added: 0006854                          
11-28-05 10:24 Clemens LadischNote Added: 0006855                          
11-28-05 10:32 croiset        Note Added: 0006856                          
11-28-05 11:17 LokiDavison    Note Added: 0006858                          
11-29-05 10:14 LokiDavison    Note Added: 0006872                          
08-01-06 00:30 Adrian Bunk    Status                   assigned => resolved
08-01-06 00:30 Adrian Bunk    Resolution               open => fixed       
08-01-06 00:30 Adrian Bunk    Steps to Reproduce Updated                    
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
