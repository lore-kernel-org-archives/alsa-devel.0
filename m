From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001025]: kernel panic when trying to load module snd-au8830
Date: Wed, 24 Aug 2005 11:04:08 +0200
Message-ID: <c1b772eb97b355c021ececfa066be8e9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B15324C
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 11:04:08 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1025> 
======================================================================
Reported By:                Osiris
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1025
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             03-30-2005 22:50 CEST
Last Modified:              08-24-2005 11:04 CEST
======================================================================
Summary:                    kernel panic when trying to load module snd-au8830
Description: 
kernel panic occurs on boot when system tries to load kernel module for
Aureal Vortex 2. The same thing happens when driver is compiled into
kernel, not module

======================================================================

----------------------------------------------------------------------
 alien999999999 - 04-04-05 11:00 
----------------------------------------------------------------------
I had similar issues on 64bit, there are a few changes i did in the above
files that make it work, but it's not yet cleaned up and some things just
have been commented out...

in a certain macro, some things are strictly for 32bit usage ( <<2 ), if
you change a few files like this, it'll work.

i can't make a patch yet, since i don't have alsa CVS, and further testing
is very uneasy, since i have only 1 64bit machine and it is this
server...

attached file

----------------------------------------------------------------------
 Raymond - 08-24-05 11:04 
----------------------------------------------------------------------
Have you try alien999999999 's alsa-changes.tar.bz2 ?

If not,  would you please try the patch diff11.diff (against
alsa-driver-1.0.9b) at

http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948 


void __iomem *mmio;

should be used instead of

unsigned long __iomem *mmio;

in snd_vortex_t for architecture independent (32-bits and 64-bits)

We need feedback from au8810/au8830 user in testing the Equalizer, MPU401,
Gameport, .... on 64 bits platform.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-05 22:50 Osiris         New Issue                                    
03-30-05 22:50 Osiris         Distribution              => Debian          
03-30-05 22:50 Osiris         Kernel Version            => 2.6.11.6        
03-31-05 11:34 mjander        Note Added: 0004278                          
04-03-05 21:16 Osiris         Note Added: 0004320                          
04-04-05 10:19 alien999999999 Issue Monitored: alien999999999                   

04-04-05 11:00 alien999999999 File Added: alsa-changes.tar.bz2                  
 
04-04-05 11:00 alien999999999 Note Added: 0004325                          
08-24-05 11:04 Raymond        Note Added: 0005927                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
