From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001654]: Support for Midiman (M-audio)
	Biport 2x4s
Date: Fri, 4 Aug 2006 01:03:52 +0200
Message-ID: <c1ca661cbedeadc72bf0e7b575ac9cf4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 98236166
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Aug 2006 01:03:52 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1654> 
======================================================================
Reported By:                pumpkin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1654
Category:                   GENERIC - serialmidi
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               slackware 10.2
Kernel Version:             
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             12-15-2005 23:21 CET
Last Modified:              08-04-2006 01:03 CEST
======================================================================
Summary:                    Support for Midiman (M-audio) Biport 2x4s
Description: 
I have a Midiman Biport 2x4s (a midi-interface that connects to the
serial-port) that I cant get to work in Linux. I have seen that there is
support for many other midi-interfaces by Midiman (M-audio) in ALSA but I
havent seen support for my model. I have searched the internet and asked
around for drivers and stuff to get it to work but with no luck so far.
Is there support for my model that I havent found yet? and if not, will
there be any support for my model soon?
unfortunately I am pretty new to linux so I cant make my own driver so I
am happy for all the help I can get.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 12-16-05 09:12 
----------------------------------------------------------------------
Most serial MIDI interfaces use a Sound Canvas compatible protocol.
Does it work with the following commands?

setserial /dev/ttyS0 uart none
modprobe snd-serial-u16550 port=0x3f8 irq=4 outs=4 ins=2 adaptor=0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-15-05 23:21 pumpkin        New Issue                                    
12-15-05 23:21 pumpkin        Distribution              => slackware 10.2  
12-15-05 23:22 pumpkin        Issue Monitored: pumpkin                     
12-16-05 09:12 Clemens LadischNote Added: 0007057                          
08-04-06 01:03 Adrian Bunk    Status                   new => closed       
08-04-06 01:03 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
