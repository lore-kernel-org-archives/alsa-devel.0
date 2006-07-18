From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001767]: midi port (64:32 'Audigy
	MPU-401 #2') will not read/record
Date: Tue, 18 Jul 2006 14:40:25 +0200
Message-ID: <7c91facf11e44d5fe4eee24a9ba7f1f0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 178CB176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:40:26 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1767> 
======================================================================
Reported By:                bscipioni
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1767
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Redhat
Kernel Version:             2.6.12-smp
======================================================================
Date Submitted:             01-22-2006 03:23 CET
Last Modified:              07-18-2006 14:40 CEST
======================================================================
Summary:                    midi port (64:32 'Audigy MPU-401 #2') will not
read/record
Description: 
I have Audigy 2 Platinum.  The Audgiy "drive" midi input is not working. 
Previously I had been able to both play my midi keyboard and record from
it using Rosegarden, earlier versions of alsa and RedHat 9.  Now I can
only play
the keyboard (midi out 64:32) - record doesn't work.  Taking Rosegarden
out of the equation, I used both JACK and aconnect to connect 64:32
directly to 65:0 and I get nothing playing the keyboard.  Soundfonts are
loaded and working  
works just fine. So it seems just the 64:32 read port is not working
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-22-06 04:44 
----------------------------------------------------------------------
Please use ALSA CVS to do a binary search by date and identify the change
that broke it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-22-06 03:23 bscipioni      New Issue                                    
01-22-06 03:23 bscipioni      Distribution              => Redhat          
01-22-06 03:23 bscipioni      Kernel Version            => 2.6.12-smp      
01-22-06 04:44 rlrevell       Note Added: 0007743                          
07-18-06 14:40 jcdutton       Status                   new => assigned     
07-18-06 14:40 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
