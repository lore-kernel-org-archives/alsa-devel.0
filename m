From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001475]: Support for M Audio
	Audiophile 192
Date: Sun, 23 Jul 2006 00:46:17 +0200
Message-ID: <6a1d56d259aecd67d106ec7886fcb047@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B64A1154
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 00:46:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1475> 
======================================================================
Reported By:                Dazed
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1475
Category:                   PCI - ice1724
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               FC3
Kernel Version:             2.6.*
======================================================================
Date Submitted:             10-14-2005 13:41 CEST
Last Modified:              07-23-2006 00:46 CEST
======================================================================
Summary:                    Support for M Audio Audiophile 192
Description: 
Is it possible to add support for the M Audio Audiophile 192 sound card? It
looks to me like it's based on the ICE1724 chipset. I'd settle for simple
CD playback for starters. ;-)
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001646 Wish for M-Audio AudioPhile 192 (AP192K...
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-22-06 22:55 
----------------------------------------------------------------------
It seems that no one is working on it.  Probably no ALSA developers have
this hardware.  It would be great to get some help from the vendor.

----------------------------------------------------------------------
 cruiseoveride - 07-23-06 00:46 
----------------------------------------------------------------------
oss has full support for the card.
i downloaded oss and everything is working.

can i use oss to get info for u guys. i have done soo much for this card.
i have done everything but actually write the bl**dy driver.

1. I have photogtaphed the card
2. I have found a similicar card (ESI Juli@
   it has all the same AKM chips. only difference it is vts1721
3. I have provided links to the data-sheets of every AKM chip on the
M-Audio 192
4. I have uploaded as much information as possible taken from ALSA, /proc,
OSS

>From the ALSA website I found the following
#########################################################################3
What we need to write good drivers

ALSA developers need several things to write good drivers. We need:

    * good documentation
    * necessary firmware
    * a way to get additional information if needed
    * example source code is helpful
######################################################################


What else do u want?

Why isnt ALSA API documented properly. I would write the driver myself
otherwise.

Show us how to write a dummy driver with the code and Makefile or the
command to compile it with. How can the community help if they have no
idea wat is going on in this project.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-14-05 13:41 Dazed          New Issue                                    
10-14-05 13:41 Dazed          Distribution              => FC3             
10-14-05 13:41 Dazed          Kernel Version            => 2.6.*           
10-14-05 13:56 Dazed          Note Added: 0006480                          
10-14-05 15:05 Dazed          Note Edited: 0006480                         
11-14-05 23:00 jorx           Note Added: 0006728                          
11-14-05 23:02 jorx           Issue Monitored: jorx                        
01-10-06 15:25 Dazed          Issue Monitored: Dazed                       
03-14-06 17:30 rlrevell       Relationship added       related to 0001646  
03-19-06 18:53 paule          Note Added: 0008694                          
03-19-06 18:53 paule          Issue Monitored: paule                       
06-08-06 16:50 drycellbattery Issue Monitored: drycellbattery                   

07-20-06 15:56 cruiseoveride  Note Added: 0011128                          
07-21-06 05:12 cruiseoveride  Note Added: 0011144                          
07-21-06 05:15 cruiseoveride  Note Added: 0011146                          
07-21-06 05:18 cruiseoveride  Issue Monitored: cruiseoveride                    
07-21-06 20:12 cruiseoveride  Note Added: 0011154                          
07-22-06 22:55 rlrevell       Note Added: 0011172                          
07-23-06 00:46 cruiseoveride  Note Added: 0011176                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
