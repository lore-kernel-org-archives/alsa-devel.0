From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001342]: SOund is not working
Date: Fri, 21 Jul 2006 09:49:33 +0200
Message-ID: <1715f60b52ae83fd331a150e8290e496@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D054417A
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 09:49:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1342> 
======================================================================
Reported By:                taya
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1342
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.10-5-386
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-16-2005 20:11 CEST
Last Modified:              07-21-2006 09:49 CEST
======================================================================
Summary:                    SOund is not working
Description: 
Hi, I have laptop: Asus w500
It has integrated sound card: Intel high definition audio.
It seems that alsa driver is working, but it does not.
Please correct this.
Thanks
======================================================================

----------------------------------------------------------------------
 taya - 03-22-06 06:27 
----------------------------------------------------------------------
In later alsa drivers, sound works visualy (I mean when I make sound up, or
down, or mute it shoes visualy, but still, no sound...)

It appears that it's maybe realtek soundcard..
Anyway, I have this laptop already 1 year, and on Linux sound is not
working :(
I have to still use windows for sound.....

The soundcard is: 	
Built-in Intel High Definition Audio chip, with 3D effect & full duplex
Built-in speaker and microphone

from:
http://www.asus.com/products4.aspx?modelmenu=2&model=414&l1=5&l2=75&l3=0

----------------------------------------------------------------------
 rlrevell - 03-22-06 06:36 
----------------------------------------------------------------------
In the latest ALSA CVS this should be fixed (I believe you have to use
"model=asus").  Search the bug tracker for asus + hda-intel

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-16-05 20:11 taya           New Issue                                    
08-16-05 20:11 taya           Kernel Version            => 2.6.10-5-386    
03-22-06 03:03 rlrevell       Note Added: 0008792                          
03-22-06 06:27 taya           Note Added: 0008846                          
03-22-06 06:36 rlrevell       Note Added: 0008847                          
07-21-06 09:49 Adrian Bunk    Status                   assigned => resolved
07-21-06 09:49 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
